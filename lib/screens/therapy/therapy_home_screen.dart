import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../core/theme/app_theme.dart';
import '../../models/therapy/therapy_vocabulary_bs.dart';
import '../../services/therapy/child_therapy_config.dart';
import '../../services/reward_service.dart';
import 'speech_therapy_screen.dart';

/// =================================================================
/// THERAPY HOME SCREEN
/// =================================================================
/// 
/// Hauptbildschirm für die Therapie-App.
/// Zeigt Kategorien, Fortschritt und tägliche Herausforderungen.
/// 
/// Optimiert für Kinder mit Hörverlust:
/// - Große, bunte Karten
/// - Einfache Navigation
/// - Motivierende Elemente
/// =================================================================

class TherapyHomeScreen extends ConsumerStatefulWidget {
  const TherapyHomeScreen({super.key});

  @override
  ConsumerState<TherapyHomeScreen> createState() => _TherapyHomeScreenState();
}

class _TherapyHomeScreenState extends ConsumerState<TherapyHomeScreen> {
  @override
  void initState() {
    super.initState();
    // Haptic Feedback beim Start
    HapticFeedback.lightImpact();
  }

  @override
  Widget build(BuildContext context) {
    final config = ref.watch(childTherapyConfigProvider);
    final rewardState = ref.watch(rewardServiceProvider);
    final categories = TherapyVocabularyBS.getForLevel(config.therapyLevel);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE8F4FD),
              Color(0xFFF5F7FA),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header mit Begrüßung
              _buildHeader(config, rewardState),
              
              // Tägliche Herausforderung
              _buildDailyChallenge(),
              
              const SizedBox(height: 16),
              
              // Kategorien
              Expanded(
                child: _buildCategoriesGrid(categories, config.therapyLevel),
              ),
              
              // Starter-Wörter Button (Stufe 1)
              if (config.therapyLevel <= 1)
                _buildStarterWordsButton(),
              
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(ChildTherapyConfig config, RewardState rewardState) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          // Lianko Avatar
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              gradient: AppTheme.alanGradient,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppTheme.primaryColor.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Center(
              child: Text(
                'L',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ).animate().scale(curve: Curves.elasticOut),
          
          const SizedBox(width: 16),
          
          // Begrüßung
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Zdravo, ${config.childName}! 👋',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textPrimary,
                  ),
                ),
                Text(
                  'Hajmo učiti!',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          
          // Sterne
          GestureDetector(
            onTap: () => _showRewardsSheet(rewardState),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.amber.shade100,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.amber.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 28),
                  const SizedBox(width: 6),
                  Text(
                    '${rewardState.totalStars}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.amber,
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn(delay: 200.ms).slideX(begin: 0.2),
          ),
        ],
      ),
    );
  }

  Widget _buildDailyChallenge() {
    final rewardState = ref.watch(rewardServiceProvider);
    final streak = rewardState.currentStreak;
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppTheme.primaryColor,
              AppTheme.primaryColor.withOpacity(0.8),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: AppTheme.primaryColor.withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            // Flamme / Streak Icon
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  streak > 0 ? '🔥' : '🎯',
                  style: const TextStyle(fontSize: 28),
                ),
              ),
            ),
            
            const SizedBox(width: 16),
            
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    streak > 0 ? '$streak dana zaredom!' : 'Započni niz!',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    streak > 0 
                        ? 'Nastavi vježbati danas!'
                        : 'Vježbaj svaki dan za nagrade!',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                ],
              ),
            ),
            
            // Streak Flammen
            if (streak > 0)
              Row(
                children: List.generate(
                  streak.clamp(0, 5),
                  (i) => const Text('🔥', style: TextStyle(fontSize: 20)),
                ),
              ),
          ],
        ),
      ),
    ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.2);
  }

  Widget _buildCategoriesGrid(List<TherapyCategory> categories, int level) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Kategorije',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimary,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Nivo $level',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryColor,
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.1,
              ),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                final isLocked = category.unlockLevel > level;
                
                return _CategoryCard(
                  category: category,
                  isLocked: isLocked,
                  onTap: isLocked 
                      ? null 
                      : () => _openCategory(category),
                ).animate(delay: (100 * index).ms)
                    .fadeIn()
                    .scale(begin: const Offset(0.8, 0.8));
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStarterWordsButton() {
    final starterWords = TherapyVocabularyBS.getStarterWords();
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GestureDetector(
        onTap: () => _openStarterWords(starterWords),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.green, Colors.green.shade700],
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.green.withOpacity(0.4),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.play_circle_fill,
                color: Colors.white,
                size: 32,
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Početak: 10 Prvih Riječi',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Najvažnije riječi za početak',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              const Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(delay: 500.ms).slideY(begin: 0.3);
  }

  void _openCategory(TherapyCategory category) {
    HapticFeedback.mediumImpact();
    
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SpeechTherapyScreen(
          words: category.words,
          categoryName: category.name,
        ),
      ),
    );
  }

  void _openStarterWords(List<TherapyWord> words) {
    HapticFeedback.mediumImpact();
    
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SpeechTherapyScreen(
          words: words,
          categoryName: 'Početak',
        ),
      ),
    );
  }

  void _showRewardsSheet(RewardState rewardState) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.4,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) => _RewardsSheet(
          rewardState: rewardState,
          scrollController: scrollController,
        ),
      ),
    );
  }
}

/// Category Card Widget
class _CategoryCard extends StatelessWidget {
  final TherapyCategory category;
  final bool isLocked;
  final VoidCallback? onTap;

  const _CategoryCard({
    required this.category,
    required this.isLocked,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: category.color.withOpacity(0.2),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Hauptinhalt
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Icon
                  Text(
                    category.icon,
                    style: TextStyle(
                      fontSize: 40,
                      color: isLocked ? Colors.grey : null,
                    ),
                  ),
                  
                  const SizedBox(height: 12),
                  
                  // Name
                  Text(
                    category.name,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isLocked ? Colors.grey : category.color,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  
                  const SizedBox(height: 8),
                  
                  // Wörteranzahl
                  Text(
                    '${category.words.length} riječi',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            
            // Lock Overlay
            if (isLocked)
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.lock,
                      size: 40,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            
            // Farb-Balken oben
            if (!isLocked)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 6,
                  decoration: BoxDecoration(
                    color: category.color,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// Rewards Sheet Widget
class _RewardsSheet extends StatelessWidget {
  final RewardState rewardState;
  final ScrollController scrollController;

  const _RewardsSheet({
    required this.rewardState,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Titel
          const Text(
            'Moje Nagrade 🏆',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Statistiken
          Row(
            children: [
              _StatCard(
                icon: '⭐',
                value: '${rewardState.totalStars}',
                label: 'Zvjezdice',
                color: Colors.amber,
              ),
              const SizedBox(width: 16),
              _StatCard(
                icon: '🔥',
                value: '${rewardState.currentStreak}',
                label: 'Dana',
                color: Colors.orange,
              ),
              const SizedBox(width: 16),
              _StatCard(
                icon: '🏅',
                value: '${rewardState.earnedRewards.length}',
                label: 'Značke',
                color: Colors.blue,
              ),
            ],
          ),
          
          const SizedBox(height: 24),
          
          // Abzeichen
          const Text(
            'Osvojene Značke',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          
          const SizedBox(height: 16),
          
          Expanded(
            child: ListView(
              controller: scrollController,
              children: [
                if (rewardState.earnedRewards.isEmpty)
                  Center(
                    child: Column(
                      children: [
                        const SizedBox(height: 40),
                        Text(
                          '🎯',
                          style: TextStyle(
                            fontSize: 64,
                            color: Colors.grey.shade400,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Vježbaj da osvojiš značke!',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  ...rewardState.earnedRewards.map((reward) => ListTile(
                    leading: Text(
                      reward.emoji,
                      style: const TextStyle(fontSize: 32),
                    ),
                    title: Text(
                      reward.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(reward.description),
                  )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Stat Card Widget
class _StatCard extends StatelessWidget {
  final String icon;
  final String value;
  final String label;
  final Color color;

  const _StatCard({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Text(icon, style: const TextStyle(fontSize: 28)),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
