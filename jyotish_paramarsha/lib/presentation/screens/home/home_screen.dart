import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../core/constants.dart';
import '../../../state_management/auth_provider.dart';
import '../../common/custom_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  int? _hoveredIndex;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _navigateToKundali(BuildContext context) {
    context.pushNamed(
      'kundali',
      extra: {
        'name': '',
        'date': DateTime.now(),
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final items = [
      (
        icon: Icons.auto_graph,
        title: 'Kundali',
        onTap: () => _navigateToKundali(context),
      ),
      (
        icon: Icons.stars,
        title: 'Horoscope',
        onTap: () => context.pushNamed('horoscope'),
      ),
      (
        icon: Icons.chat_bubble,
        title: 'Chat',
        onTap: () => context.pushNamed('chat'),
      ),
      (
        icon: Icons.video_call,
        title: 'Video Call',
        onTap: () => context.pushNamed('videoCall'),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appName),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<AuthProvider>().logout();
              context.goNamed('login');
            },
          ),
        ],
      ),
      body: ScaleTransition(
        scale: _scaleAnimation,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return MouseRegion(
                onEnter: (_) => setState(() => _hoveredIndex = index),
                onExit: (_) => setState(() => _hoveredIndex = null),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  transform: Matrix4.identity()
                    ..scale(_hoveredIndex == index ? 1.05 : 1.0),
                  child: CustomCard(
                    title: item.title,
                    icon: item.icon,
                    onTap: item.onTap,
                    backgroundColor: _hoveredIndex == index
                        ? Theme.of(context).colorScheme.primaryContainer
                        : null,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
