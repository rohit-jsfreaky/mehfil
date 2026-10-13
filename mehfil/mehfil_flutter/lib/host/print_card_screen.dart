import 'package:flutter/material.dart';
import 'package:mehfil_client/mehfil_client.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../client.dart';
import '../ui/icons.dart';
import '../ui/theme.dart';
import '../ui/widgets.dart';
import 'print_stub.dart' if (dart.library.js_interop) 'print_web.dart';

/// The card for the tables: the couple's names, one big QR, the code, and the
/// promise in plain words. On the web it prints straight from the browser.
class PrintCardScreen extends StatelessWidget {
  const PrintCardScreen({super.key, required this.event});
  final Event event;

  @override
  Widget build(BuildContext context) {
    final link = joinLink(event.joinCode).toString();
    return MPage(
      child: Column(
        children: [
          SizedBox(
            height: 40,
            child: Row(
              children: [
                IconBtn(
                  icon: Ph.caretLeft,
                  label: 'Back',
                  onTap: () => Navigator.of(context).maybePop(),
                ),
                const Spacer(),
                if (canPrint)
                  Button(
                    label: 'Print',
                    icon: Ph.printer,
                    small: true,
                    expand: false,
                    onTap: printPage,
                  ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Center(
              child: Container(
                width: 360,
                padding: const EdgeInsets.fromLTRB(28, 32, 28, 28),
                decoration: BoxDecoration(
                  color: M.bg,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: M.line),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Caps('Be our camera tonight'),
                    const SizedBox(height: 8),
                    Text(
                      event.name,
                      textAlign: TextAlign.center,
                      style: M.display.copyWith(fontSize: 38),
                    ),
                    const SizedBox(height: 22),
                    QrImageView(
                      data: link,
                      size: 220,
                      padding: EdgeInsets.zero,
                      eyeStyle: const QrEyeStyle(
                        color: M.ink,
                        eyeShape: QrEyeShape.square,
                      ),
                      dataModuleStyle: const QrDataModuleStyle(
                        color: M.ink,
                        dataModuleShape: QrDataModuleShape.square,
                      ),
                    ),
                    const SizedBox(height: 18),
                    Text('Scan with your phone camera', style: M.headline),
                    const SizedBox(height: 4),
                    Text(
                      'No app. Works with no signal. Photos open for everyone the next morning.',
                      textAlign: TextAlign.center,
                      style: M.footnote,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      event.joinCode,
                      style: M.number(22).copyWith(letterSpacing: 2),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
