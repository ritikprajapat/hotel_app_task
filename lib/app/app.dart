import 'app.dart';

export 'package:flutter/material.dart';
export 'package:provider/provider.dart';

export '../app/app.dart';
export '../data/data.dart';
export '../main.dart';
export '../modules/modules.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoginViewModel()),
        ChangeNotifierProvider(create: (context) => HomeViewModel()),
        ChangeNotifierProvider(create: (context) => SearchResultsViewModel())
      ],
      child: MaterialApp(
        title: 'Hotel Booking App',
        theme: ThemeData(
          primaryColor: const Color(0xFFE5E5E5),
          scaffoldBackgroundColor: const Color(0xFF0A0A0A),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: 'Poppins',
          appBarTheme: const AppBarTheme(
            elevation: 0,
            backgroundColor: Colors.transparent,
            foregroundColor: Color(0xFFE5E5E5),
          ),
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const LoginView(),
          '/home': (context) => const HomeView(),
          '/search': (context) => const SearchResultsView(),
        },
      ),
    );
  }
}
