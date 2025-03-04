import 'package:flutter/material.dart';
import 'horoscope_result.dart';
import '../../../services/notification_service.dart';

class HoroscopeScreen extends StatefulWidget {
  const HoroscopeScreen({super.key});

  @override
  State<HoroscopeScreen> createState() => _HoroscopeScreenState();
}

class _HoroscopeScreenState extends State<HoroscopeScreen> with SingleTickerProviderStateMixin {
  String? _selectedSign;
  final _zodiacSigns = [
    ('Aries', '♈', 'March 21 - April 19'),
    ('Taurus', '♉', 'April 20 - May 20'),
    ('Gemini', '♊', 'May 21 - June 20'),
    ('Cancer', '♋', 'June 21 - July 22'),
    ('Leo', '♌', 'July 23 - August 22'),
    ('Virgo', '♍', 'August 23 - September 22'),
    ('Libra', '♎', 'September 23 - October 22'),
    ('Scorpio', '♏', 'October 23 - November 21'),
    ('Sagittarius', '♐', 'November 22 - December 21'),
    ('Capricorn', '♑', 'December 22 - January 19'),
    ('Aquarius', '♒', 'January 20 - February 18'),
    ('Pisces', '♓', 'February 19 - March 20'),
  ];

  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _scheduleHoroscopeNotification(String sign) async {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    final scheduledTime = DateTime(
      tomorrow.year,
      tomorrow.month,
      tomorrow.day,
      8, // 8 AM
      0,
    );

    await NotificationService.instance.scheduleDailyHoroscope(
      title: 'Daily Horoscope for $sign',
      body: 'Your daily horoscope reading is ready! Tap to view your cosmic guidance for today.',
      scheduledDate: scheduledTime,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Daily horoscope notifications enabled!'),
      ),
    );
  }

  void _showHoroscope(String sign) {
    _controller.reset();
    setState(() => _selectedSign = sign);
    showModalBottomSheet(
      context: context,
      builder: (context) {
        _controller.forward();
        return HoroscopeResult(
          sign: sign,
          prediction: 'Your horoscope for today:\n\n'
              'The stars align in your favor today. You may encounter unexpected opportunities. '
              'Stay focused on your goals and trust your intuition.',
          animation: _fadeAnimation,
        );
      },
    );
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Enable Daily Notifications?'),
        content: Text('Would you like to receive daily horoscope notifications for $sign?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('No Thanks'),
          ),
          TextButton(
            onPressed: () {
              _scheduleHoroscopeNotification(sign);
              Navigator.pop(context);
            },
            child: const Text('Enable'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Horoscope'),
        centerTitle: true,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: _zodiacSigns.length,
        itemBuilder: (context, index) {
          final (name, symbol, date) = _zodiacSigns[index];
          return Card(
            elevation: _selectedSign == name ? 8 : 2,
            child: InkWell(
              onTap: () => _showHoroscope(name),
              borderRadius: BorderRadius.circular(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    symbol,
                    style: const TextStyle(fontSize: 32),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    name,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    date,
                    style: Theme.of(context).textTheme.bodySmall,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
