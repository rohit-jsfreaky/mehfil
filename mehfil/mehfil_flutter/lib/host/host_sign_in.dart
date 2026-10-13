import 'package:flutter/material.dart';
import 'package:mehfil_client/mehfil_client.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

import '../client.dart';
import '../guest/join_screen.dart';
import '../ui/theme.dart';
import '../ui/widgets.dart';

enum _Step { signIn, register, code }

/// The host's front door: sign in or create a host account (email + a code
/// the server sends), and a box for guests who typed the link by hand.
class HostSignIn extends StatefulWidget {
  const HostSignIn({super.key});

  @override
  State<HostSignIn> createState() => _HostSignInState();
}

class _HostSignInState extends State<HostSignIn> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _code = TextEditingController();
  final _guestCode = TextEditingController();
  _Step _step = _Step.signIn;
  UuidValue? _requestId;
  bool _busy = false;
  String? _error;

  Future<void> _run(Future<void> Function() action) async {
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await action();
    } catch (e) {
      if (mounted) setState(() => _error = friendlyError(e));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _signedIn(AuthSuccess ok) async {
    await client.auth.updateSignedInUser(ok);
    await setHostMode(true);
  }

  Future<void> _signIn() => _run(() async {
    final ok = await client.emailIdp.login(
      email: _email.text.trim(),
      password: _password.text,
    );
    await _signedIn(ok);
  });

  Future<void> _startRegistration() => _run(() async {
    if (_password.text.length < 8) {
      throw MehfilException(
        code: 'weak',
        message: 'Use at least 8 characters for the password.',
      );
    }
    _requestId = await client.emailIdp.startRegistration(
      email: _email.text.trim(),
    );
    setState(() => _step = _Step.code);
  });

  Future<void> _finishRegistration() => _run(() async {
    final token = await client.emailIdp.verifyRegistrationCode(
      accountRequestId: _requestId!,
      verificationCode: _code.text.trim(),
    );
    final ok = await client.emailIdp.finishRegistration(
      registrationToken: token,
      password: _password.text,
    );
    await _signedIn(ok);
  });

  void _joinAsGuest() {
    final code = _guestCode.text.trim().toUpperCase();
    if (code.isEmpty) return;
    Navigator.of(
      context,
    ).push(MaterialPageRoute<void>(builder: (_) => JoinScreen(code: code)));
  }

  @override
  Widget build(BuildContext context) {
    final (title, action, primary) = switch (_step) {
      _Step.signIn => ('Sign in', _signIn, 'Sign in'),
      _Step.register => (
        'Create a host account',
        _startRegistration,
        'Send me a code',
      ),
      _Step.code => ('Check your email', _finishRegistration, 'Create account'),
    };
    return MPage(
      child: ListView(
        children: [
          const SizedBox(
            height: 40,
            child: Align(alignment: Alignment.centerLeft, child: Wordmark()),
          ),
          const SizedBox(height: 32),
          Text(
            "The wedding's camera, on every guest's phone",
            style: M.largeTitle,
          ),
          const SizedBox(height: 10),
          Text(
            'Guests scan one QR and shoot, even with no signal. The album opens for everyone the next morning.',
            style: M.body.copyWith(color: M.ink2),
          ),
          const SizedBox(height: 32),
          Caps(_step == _Step.signIn ? 'Hosting an event' : title),
          const SizedBox(height: 10),
          if (_step != _Step.code) ...[
            TextField(
              controller: _email,
              keyboardType: TextInputType.emailAddress,
              autofillHints: const [AutofillHints.email],
              style: M.body,
              decoration: const InputDecoration(hintText: 'Email'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _password,
              obscureText: true,
              autofillHints: const [AutofillHints.password],
              style: M.body,
              decoration: InputDecoration(
                hintText: _step == _Step.register
                    ? 'Choose a password (8+ characters)'
                    : 'Password',
              ),
              onSubmitted: (_) => action(),
            ),
          ] else ...[
            Text('We sent a code to ${_email.text.trim()}.', style: M.subhead),
            const SizedBox(height: 10),
            TextField(
              controller: _code,
              autofocus: true,
              style: M.number(20),
              decoration: const InputDecoration(hintText: 'Code'),
              onSubmitted: (_) => action(),
            ),
          ],
          if (_error != null) ...[const SizedBox(height: 10), Note(_error!)],
          const SizedBox(height: 12),
          Button(label: primary, busy: _busy, onTap: action),
          const SizedBox(height: 14),
          Row(
            children: [
              GestureDetector(
                onTap: () => setState(() {
                  _error = null;
                  _step = _step == _Step.signIn ? _Step.register : _Step.signIn;
                }),
                child: Text(
                  _step == _Step.signIn
                      ? 'Create a host account'
                      : 'I already have an account',
                  style: M.subhead.copyWith(
                    color: M.accent,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: M.surface,
              borderRadius: BorderRadius.circular(M.rCard),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Have a guest code?', style: M.headline),
                Text(
                  "It's on the card at your table, under the QR",
                  style: M.footnote,
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _guestCode,
                        textCapitalization: TextCapitalization.characters,
                        style: M.number(17),
                        decoration: const InputDecoration(
                          hintText: 'D8JK8J',
                          fillColor: M.bg,
                        ),
                        onSubmitted: (_) => _joinAsGuest(),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Button(label: 'Join', expand: false, onTap: _joinAsGuest),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
