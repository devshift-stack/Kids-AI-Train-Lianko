import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../core/theme/app_theme.dart';
import '../../models/therapy/therapy_vocabulary_bs.dart';
import '../../services/therapy/speech_therapy_service.dart';
import '../../services/therapy/child_therapy_config.dart';
import '../../services/reward_service.dart';

/// =================================================================
/// SPEECH THERAPY SCREEN
/// =================================================================
/// 
/// Hauptscreen für das Sprachtraining.
/// Optimiert für 4-jährige Kinder mit schwerem Hörverlust.
/// 
/// Features:
/// - Große, bunte Bilder
/// - Synchrone Untertitel
/// - Silben-Hervorhebung
/// - Animiertes Feedback
/// - Motivierende Belohnungen
/// =================================================================

class SpeechTherapyScreen extends ConsumerStatefulWidget {
  final List<TherapyWord> words;
  final String categoryName;

  const SpeechTherapyScreen({
    super.key,
    required this.words,
    required this.categoryName,
  });

  @override
  ConsumerState<SpeechTherapyScreen> createState() => _SpeechTherapyScreenState();
}

class _SpeechTherapyScreenState extends ConsumerState<SpeechTherapyScreen>
    with TickerProviderStateMixin {
  
  int _currentIndex = 0;
  int _totalStars = 0;
  bool _showCelebration = false;
  late AnimationController _pulseController;
  late AnimationController _bounceController;
  TherapyResult? _lastResult;

  @override
  void initState() {
    super.initState();
    
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat(reverse: true);
    
    _bounceController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    // Session starten
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startSession();
    });
  }

  void _startSession() {
    // Neue Session starten
    ref.read(activeTherapySessionProvider.notifier).state = TherapySession();
    
    // Erste Übung starten
    _startCurrentExercise();
  }

  void _startCurrentExercise() {
    if (_currentIndex < widget.words.length) {
      final service = ref.read(speechTherapyServiceProvider);
      service.startExercise(widget.words[_currentIndex]);
    }
  }

  void _onResult(TherapyResult result) {
    setState(() {
      _lastResult = result;
      _totalStars += result.starsEarned;
      
      if (result.isCorrect) {
        _showCelebration = true;
        _bounceController.forward().then((_) => _bounceController.reverse());
        HapticFeedback.mediumImpact();
      }
    });

    // Belohnungen aktualisieren
    ref.read(rewardServiceProvider.notifier).addStars(result.starsEarned);
    ref.read(rewardServiceProvider.notifier).recordActivity('words_practiced');
  }

  void _nextWord() {
    setState(() {
      _showCelebration = false;
      _lastResult = null;
    });

    if (_currentIndex < widget.words.length - 1) {
      setState(() => _currentIndex++);
      _startCurrentExercise();
    } else {
      _showCompletionDialog();
    }
  }

  void _repeatWord() {
    final service = ref.read(speechTherapyServiceProvider);
    service.repeatCurrentWord();
    HapticFeedback.lightImpact();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _bounceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final therapyState = ref.watch(therapyStateProvider);
    final settings = ref.watch(therapySettingsProvider);

    // Result Stream abonnieren
    ref.listen(therapyResultProvider, (previous, next) {
      next.whenData((result) {
        _onResult(result);
      });
    });

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE8F4FD),
              Color(0xFFF8F9FF),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              _buildHeader(),
              
              // Fortschrittsbalken
              _buildProgressBar(),
              
              const SizedBox(height: 16),
              
              // Hauptbereich
              Expanded(
                child: _buildMainContent(therapyState, settings),
              ),
              
              // Untertitel
              _buildSubtitle(),
              
              const SizedBox(height: 16),
              
              // Steuerung
              _buildControls(therapyState),
              
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          // Zurück-Button
          GestureDetector(
            onTap: () => _confirmExit(),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: AppTheme.cardShadow,
              ),
              child: const Icon(Icons.close, color: AppTheme.primaryColor),
            ),
          ),
          
          const SizedBox(width: 16),
          
          // Titel
          Expanded(
            child: Text(
              widget.categoryName,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryColor,
              ),
            ),
          ),
          
          // Sterne
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.amber.shade100,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 24),
                const SizedBox(width: 4),
                Text(
                  '$_totalStars',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.amber,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBar() {
    final progress = ((_currentIndex + 1) / widget.words.length);
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${_currentIndex + 1} / ${widget.words.length}',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${(progress * 100).round()}%',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 12,
              backgroundColor: Colors.grey.shade200,
              valueColor: AlwaysStoppedAnimation(AppTheme.primaryColor),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainContent(AsyncValue<TherapyState> stateAsync, TherapySettings settings) {
    final word = widget.words[_currentIndex];
    
    return stateAsync.when(
      loading: () => _buildWordCard(word, TherapyState.idle),
      error: (_, __) => _buildWordCard(word, TherapyState.idle),
      data: (state) => _buildWordCard(word, state),
    );
  }

  Widget _buildWordCard(TherapyWord word, TherapyState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          // Bild
          Expanded(
            flex: 3,
            child: GestureDetector(
              onTap: _repeatWord,
              child: AnimatedBuilder(
                listenable: _bounceController,
                builder: (context, _) {
                  return Transform.scale(
                    scale: 1.0 + (_bounceController.value * 0.1),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                        border: _showCelebration 
                            ? Border.all(color: Colors.green, width: 4)
                            : null,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: Stack(
                          children: [
                            // Bild
                            Positioned.fill(
                              child: Image.asset(
                                word.imageAsset,
                                fit: BoxFit.contain,
                                errorBuilder: (_, __, ___) => _buildPlaceholder(word),
                              ),
                            ),
                            
                            // Feier-Overlay
                            if (_showCelebration)
                              Positioned.fill(
                                child: Container(
                                  color: Colors.green.withOpacity(0.2),
                                  child: const Center(
                                    child: Text(
                                      '⭐',
                                      style: TextStyle(fontSize: 80),
                                    ),
                                  ),
                                ).animate().scale(
                                  begin: const Offset(0.5, 0.5),
                                  curve: Curves.elasticOut,
                                ),
                              ),
                            
                            // Lautsprecher-Icon (tippen zum Wiederholen)
                            Positioned(
                              bottom: 12,
                              right: 12,
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: AppTheme.primaryColor.withOpacity(0.9),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.volume_up,
                                  color: Colors.white,
                                  size: 28,
                                ),
                              ).animate(
                                onPlay: (c) => c.repeat(reverse: true),
                              ).scale(
                                begin: const Offset(1, 1),
                                end: const Offset(1.1, 1.1),
                                duration: 1000.ms,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Silben-Anzeige
          Expanded(
            flex: 1,
            child: _buildSyllableDisplay(word),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholder(TherapyWord word) {
    return Container(
      color: AppTheme.primaryColor.withOpacity(0.1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.image,
            size: 64,
            color: AppTheme.primaryColor.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          Text(
            word.word,
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: AppTheme.primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSyllableDisplay(TherapyWord word) {
    return Consumer(builder: (context, ref, _) {
      final syllableIndex = ref.watch(currentSyllableIndexProvider);
      
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: AppTheme.cardShadow,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: word.syllables.asMap().entries.map((entry) {
            final index = entry.key;
            final syllable = entry.value;
            final isActive = syllableIndex.maybeWhen(
              data: (i) => i == index,
              orElse: () => false,
            );
            
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: GestureDetector(
                onTap: () {
                  final service = ref.read(speechTherapyServiceProvider);
                  service.speakSyllable(syllable, index);
                  HapticFeedback.lightImpact();
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    color: isActive 
                        ? AppTheme.primaryColor 
                        : AppTheme.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                    border: isActive
                        ? Border.all(color: AppTheme.primaryColor, width: 3)
                        : null,
                  ),
                  child: Text(
                    syllable.toUpperCase(),
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: isActive ? Colors.white : AppTheme.primaryColor,
                    ),
                  ),
                ).animate(target: isActive ? 1 : 0).scale(
                  begin: const Offset(1, 1),
                  end: const Offset(1.15, 1.15),
                  duration: 200.ms,
                ),
              ),
            );
          }).toList(),
        ),
      );
    });
  }

  Widget _buildSubtitle() {
    return Consumer(builder: (context, ref, _) {
      final subtitle = ref.watch(therapySubtitleProvider);
      final settings = ref.watch(therapySettingsProvider);
      
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 24),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.black87,
          borderRadius: BorderRadius.circular(16),
        ),
        child: subtitle.when(
          loading: () => _buildSubtitleText('...', settings.textScale),
          error: (_, __) => _buildSubtitleText('', settings.textScale),
          data: (text) => _buildSubtitleText(text, settings.textScale),
        ),
      );
    });
  }

  Widget _buildSubtitleText(String text, double scale) {
    return Text(
      text.isEmpty ? '...' : text.toUpperCase(),
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 28 * scale,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        letterSpacing: 2,
      ),
    );
  }

  Widget _buildControls(AsyncValue<TherapyState> stateAsync) {
    final state = stateAsync.valueOrNull ?? TherapyState.idle;
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Wiederholen
          _ControlButton(
            icon: Icons.replay,
            label: 'Ponovi',
            color: Colors.blue,
            onTap: _repeatWord,
            enabled: state != TherapyState.listening,
          ),
          
          // Mikrofon / Weiter
          if (state == TherapyState.waiting || state == TherapyState.listening)
            _MicrophoneButton(
              isListening: state == TherapyState.listening,
              pulseController: _pulseController,
            )
          else if (_lastResult != null)
            _ControlButton(
              icon: Icons.arrow_forward,
              label: 'Dalje',
              color: Colors.green,
              isLarge: true,
              onTap: _nextWord,
            )
          else
            _ControlButton(
              icon: Icons.mic,
              label: 'Čekaj...',
              color: Colors.grey,
              isLarge: true,
              onTap: null,
            ),
          
          // Hilfe / Tipp
          _ControlButton(
            icon: Icons.lightbulb_outline,
            label: 'Pomoć',
            color: Colors.orange,
            onTap: () => _showHelpTip(),
          ),
        ],
      ),
    );
  }

  void _showHelpTip() {
    final word = widget.words[_currentIndex];
    
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Pomoć: ${word.word}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            if (word.audioTip != null)
              Text(
                word.audioTip!,
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            if (word.lipMovement != null) ...[
              const SizedBox(height: 12),
              Text(
                '👄 ${word.lipMovement}',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade600,
                ),
                textAlign: TextAlign.center,
              ),
            ],
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _repeatWord();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryColor,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text(
                'Ponovi riječ',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmExit() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Zaustaviti vježbu?'),
        content: Text(
          'Osvojio/la si $_totalStars ⭐\n\nŽeliš li izaći?',
          style: const TextStyle(fontSize: 16),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Nastavi'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('Izađi', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showCompletionDialog() {
    final session = ref.read(activeTherapySessionProvider);
    final result = session?.end();
    
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Celebration
            const Text(
              '🎉',
              style: TextStyle(fontSize: 64),
            ).animate().scale(
              begin: const Offset(0.5, 0.5),
              curve: Curves.elasticOut,
            ),
            
            const SizedBox(height: 16),
            
            const Text(
              'BRAVO!',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryColor,
              ),
            ),
            
            const SizedBox(height: 8),
            
            Text(
              'Završio/la si sve riječi!',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey.shade600,
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Statistiken
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  _StatRow(
                    icon: Icons.star,
                    label: 'Zvjezdice',
                    value: '$_totalStars',
                    color: Colors.amber,
                  ),
                  const SizedBox(height: 12),
                  _StatRow(
                    icon: Icons.check_circle,
                    label: 'Tačno',
                    value: '${result?.wordsCorrect ?? 0}/${widget.words.length}',
                    color: Colors.green,
                  ),
                  const SizedBox(height: 12),
                  _StatRow(
                    icon: Icons.timer,
                    label: 'Vrijeme',
                    value: '${result?.durationMinutes ?? 0} min',
                    color: Colors.blue,
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Sterne anzeigen
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index) {
                final earned = (result?.successRatePercent ?? 0) > (index + 1) * 30;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Icon(
                    Icons.star,
                    size: 40,
                    color: earned ? Colors.amber : Colors.grey.shade300,
                  ),
                ).animate(delay: (index * 200).ms).scale();
              }),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _currentIndex = 0;
                _totalStars = 0;
                _lastResult = null;
              });
              _startSession();
            },
            child: const Text('Ponovi'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryColor,
            ),
            child: const Text('Gotovo', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}

/// Control Button Widget
class _ControlButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback? onTap;
  final bool isLarge;
  final bool enabled;

  const _ControlButton({
    required this.icon,
    required this.label,
    required this.color,
    this.onTap,
    this.isLarge = false,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final size = isLarge ? 72.0 : 56.0;

    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Opacity(
        opacity: enabled && onTap != null ? 1.0 : 0.5,
        child: Column(
          children: [
            Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
                border: Border.all(color: color, width: 2),
              ),
              child: Icon(icon, color: color, size: isLarge ? 36 : 28),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Microphone Button Widget
class _MicrophoneButton extends StatelessWidget {
  final bool isListening;
  final AnimationController pulseController;

  const _MicrophoneButton({
    required this.isListening,
    required this.pulseController,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      listenable: pulseController,
      builder: (context, _) {
        return Transform.scale(
          scale: isListening ? 1.0 + (pulseController.value * 0.15) : 1.0,
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isListening
                    ? [Colors.red, Colors.red.shade700]
                    : [Colors.grey.shade400, Colors.grey.shade600],
              ),
              shape: BoxShape.circle,
              boxShadow: isListening
                  ? [
                      BoxShadow(
                        color: Colors.red.withOpacity(0.4),
                        blurRadius: 20,
                        spreadRadius: 5,
                      ),
                    ]
                  : null,
            ),
            child: Icon(
              isListening ? Icons.mic : Icons.mic_none,
              color: Colors.white,
              size: 40,
            ),
          ),
        );
      },
    );
  }
}

/// Stat Row Widget
class _StatRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _StatRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}

/// AnimatedBuilder Helper
class AnimatedBuilder extends AnimatedWidget {
  final Widget Function(BuildContext context, Widget? child) builder;
  final Widget? child;

  const AnimatedBuilder({
    super.key,
    required super.listenable,
    required this.builder,
    this.child,
  });

  @override
  Widget build(BuildContext context) => builder(context, child);
}
