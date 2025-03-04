import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF673AB7);
  static const Color secondary = Color(0xFF9C27B0);
  static const Color accent = Color(0xFFE1BEE7);
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
}

class AppStrings {
  static const String appName = 'Jyotish Paramarsha';
  static const String welcome = 'Welcome to Jyotish Paramarsha';
  static const String home = 'Home';
  static const String profile = 'Profile';
  static const String settings = 'Settings';
}

class AppRoutes {
  static const String login = '/login';
  static const String home = '/home';
  static const String kundali = '/kundali';
  static const String horoscope = '/horoscope';
  static const String chat = '/chat';
  static const String videoCall = '/video-call';
}

class AppAssets {
  static const String _zodiacPath = 'assets/images/zodiac';
  static const Map<String, String> zodiacIcons = {
    'Aries': '$_zodiacPath/aries.png',
    'Taurus': '$_zodiacPath/taurus.png',
    'Gemini': '$_zodiacPath/gemini.png',
    'Cancer': '$_zodiacPath/cancer.png',
    'Leo': '$_zodiacPath/leo.png',
    'Virgo': '$_zodiacPath/virgo.png',
    'Libra': '$_zodiacPath/libra.png',
    'Scorpio': '$_zodiacPath/scorpio.png',
    'Sagittarius': '$_zodiacPath/sagittarius.png',
    'Capricorn': '$_zodiacPath/capricorn.png',
    'Aquarius': '$_zodiacPath/aquarius.png',
    'Pisces': '$_zodiacPath/pisces.png',
  };

  static const String appLogo = 'assets/images/logos/app_logo.png';
  static const String backgroundImage = 'assets/images/backgrounds/stars.jpg';
}

class AppFonts {
  static const String sanskrit = 'Sanskrit';
  static const String astro = 'Astro';
}
