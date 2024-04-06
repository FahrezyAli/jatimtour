import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jatimtour/firebase_options.dart';
import 'package:jatimtour/widgets/mobile/pages/start_page_mobile.dart';
import 'package:jatimtour/models/user_model.dart';
import 'package:jatimtour/widgets/web/pages/start_page_web.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

extension Responsive on BuildContext {
  T responsive<T>(
    T defaultVal, {
    T? sm,
    T? md,
    T? lg,
    T? xl,
  }) {
    final wd = MediaQuery.of(this).size.width;
    return wd >= 1280
        ? (xl ?? lg ?? md ?? sm ?? defaultVal)
        : wd >= 1024
            ? (lg ?? md ?? sm ?? defaultVal)
            : wd >= 768
                ? (md ?? sm ?? defaultVal)
                : wd >= 640
                    ? (sm ?? defaultVal)
                    : defaultVal;
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserModel>(
          create: (context) => UserModel(),
        ),
      ],
      child: const MaterialApp(
        home: kIsWeb ? StartPageWeb() : StartPageMobile(),
      ),
    );
  }
}
