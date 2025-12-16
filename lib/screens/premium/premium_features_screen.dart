import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_theme.dart';
import '../../services/premium/premium_module.dart';

/// Premium Features Übersicht
///
/// Zentrale Verwaltung aller Premium-Features:
/// - Batterie-Erinnerung
/// - Audiogramm-Import
/// - Logopädie-Modus
/// - Export für Ärzte
class PremiumFeaturesScreen extends ConsumerStatefulWidget {
  const PremiumFeaturesScreen({super.key});

  @override
  ConsumerState<PremiumFeaturesScreen> createState() => _PremiumFeaturesScreenState();
}

class _PremiumFeaturesScreenState extends ConsumerState<PremiumFeaturesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Premium Features'),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Header
          _buildHeader(),
          const SizedBox(height: 24),

          // Batterie-Erinnerung
          _buildFeatureCard(
            icon: Icons.battery_charging_full,
            iconColor: Colors.amber,
            title: 'Batterie-Erinnerung',
            subtitle: 'Nie wieder leere Hörgeräte-Batterien',
            description: 'Automatische Erinnerung an den Batteriewechsel basierend auf deinem eingestellten Intervall.',
            onTap: () => _openBatterySettings(context),
            statusWidget: _buildBatteryStatus(),
          ),
          const SizedBox(height: 16),

          // Audiogramm-Import
          _buildFeatureCard(
            icon: Icons.hearing,
            iconColor: Colors.blue,
            title: 'Audiogramm-Import',
            subtitle: 'Individuelle Frequenz-Anpassung',
            description: 'Lade das Audiogramm deines Kindes hoch und die App passt die Frequenzen automatisch an.',
            onTap: () => _openAudiogramImport(context),
            statusWidget: _buildAudiogramStatus(),
          ),
          const SizedBox(height: 16),

          // Logopädie-Modus
          _buildFeatureCard(
            icon: Icons.record_voice_over,
            iconColor: Colors.purple,
            title: 'Logopädie-Modus',
            subtitle: 'Übungen vom Logopäden',
            description: 'Verbinde dich mit dem Logopäden deines Kindes für spezielle Übungen.',
            onTap: () => _openSpeechTherapy(context),
            statusWidget: _buildTherapistStatus(),
          ),
          const SizedBox(height: 16),

          // Export für Ärzte
          _buildFeatureCard(
            icon: Icons.picture_as_pdf,
            iconColor: Colors.red,
            title: 'Fortschritts-Export',
            subtitle: 'PDF-Reports für HNO & Logopäden',
            description: 'Erstelle professionelle Fortschritts-Reports zum Teilen mit Ärzten.',
            onTap: () => _openExportDialog(context),
            statusWidget: null,
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.primaryColor.withOpacity(0.8),
            AppTheme.primaryColor,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 32,
                ),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Premium Features',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Erweiterte Funktionen für optimales Hörtraining',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required String description,
    required VoidCallback onTap,
    Widget? statusWidget,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: iconColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(icon, color: iconColor, size: 28),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          subtitle,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.chevron_right, color: Colors.grey),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                description,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade700,
                ),
              ),
              if (statusWidget != null) ...[
                const SizedBox(height: 12),
                statusWidget,
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBatteryStatus() {
    return Consumer(
      builder: (context, ref, _) {
        final statusAsync = ref.watch(batteryStatusProvider);

        return statusAsync.when(
          data: (status) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: status.needsReminder ? Colors.amber.shade100 : Colors.green.shade100,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  status.needsReminder ? Icons.warning : Icons.check_circle,
                  size: 16,
                  color: status.needsReminder ? Colors.amber.shade700 : Colors.green.shade700,
                ),
                const SizedBox(width: 6),
                Text(
                  status.message,
                  style: TextStyle(
                    fontSize: 12,
                    color: status.needsReminder ? Colors.amber.shade700 : Colors.green.shade700,
                  ),
                ),
              ],
            ),
          ),
          loading: () => const SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
          error: (_, __) => const Text('Status nicht verfügbar', style: TextStyle(fontSize: 12)),
        );
      },
    );
  }

  Widget _buildAudiogramStatus() {
    return Consumer(
      builder: (context, ref, _) {
        final audiogramAsync = ref.watch(currentAudiogramProvider);

        return audiogramAsync.when(
          data: (audiogram) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: audiogram != null ? Colors.green.shade100 : Colors.grey.shade100,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  audiogram != null ? Icons.check_circle : Icons.upload_file,
                  size: 16,
                  color: audiogram != null ? Colors.green.shade700 : Colors.grey.shade700,
                ),
                const SizedBox(width: 6),
                Text(
                  audiogram != null ? 'Audiogramm vorhanden' : 'Noch kein Audiogramm',
                  style: TextStyle(
                    fontSize: 12,
                    color: audiogram != null ? Colors.green.shade700 : Colors.grey.shade700,
                  ),
                ),
              ],
            ),
          ),
          loading: () => const SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
          error: (_, __) => const SizedBox(),
        );
      },
    );
  }

  Widget _buildTherapistStatus() {
    return Consumer(
      builder: (context, ref, _) {
        final therapistAsync = ref.watch(linkedTherapistProvider);

        return therapistAsync.when(
          data: (therapist) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: therapist != null ? Colors.purple.shade100 : Colors.grey.shade100,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  therapist != null ? Icons.link : Icons.link_off,
                  size: 16,
                  color: therapist != null ? Colors.purple.shade700 : Colors.grey.shade700,
                ),
                const SizedBox(width: 6),
                Text(
                  therapist != null ? 'Verbunden: ${therapist.name}' : 'Nicht verbunden',
                  style: TextStyle(
                    fontSize: 12,
                    color: therapist != null ? Colors.purple.shade700 : Colors.grey.shade700,
                  ),
                ),
              ],
            ),
          ),
          loading: () => const SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
          error: (_, __) => const SizedBox(),
        );
      },
    );
  }

  // ============================================================
  // NAVIGATION
  // ============================================================

  void _openBatterySettings(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => const BatterySettingsSheet(),
    );
  }

  void _openAudiogramImport(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AudiogramImportScreen()),
    );
  }

  void _openSpeechTherapy(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const SpeechTherapyScreen()),
    );
  }

  void _openExportDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => const ExportOptionsSheet(),
    );
  }
}

// ============================================================
// SUB-SCREENS & SHEETS
// ============================================================

/// Batterie-Einstellungen Sheet
class BatterySettingsSheet extends ConsumerStatefulWidget {
  const BatterySettingsSheet({super.key});

  @override
  ConsumerState<BatterySettingsSheet> createState() => _BatterySettingsSheetState();
}

class _BatterySettingsSheetState extends ConsumerState<BatterySettingsSheet> {
  bool _isEnabled = true;
  int _intervalDays = 7;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final settings = await ref.read(batteryReminderServiceProvider).loadSettings();
    setState(() {
      _isEnabled = settings.isEnabled;
      _intervalDays = settings.intervalDays;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.4,
      maxChildSize: 0.9,
      expand: false,
      builder: (context, scrollController) => SingleChildScrollView(
        controller: scrollController,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            const SizedBox(height: 20),
            const Text(
              '🔋 Batterie-Erinnerung',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Aktivierung
            SwitchListTile(
              title: const Text('Erinnerung aktiviert'),
              subtitle: const Text('Benachrichtigung vor leerem Akku'),
              value: _isEnabled,
              onChanged: (value) => setState(() => _isEnabled = value),
            ),
            const Divider(),

            // Intervall
            ListTile(
              title: const Text('Wechsel-Intervall'),
              subtitle: Text('Alle $_intervalDays Tage'),
            ),
            Slider(
              value: _intervalDays.toDouble(),
              min: 3,
              max: 14,
              divisions: 11,
              label: '$_intervalDays Tage',
              onChanged: (value) => setState(() => _intervalDays = value.round()),
            ),
            const SizedBox(height: 20),

            // Batterie jetzt gewechselt
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () async {
                  await ref.read(batteryReminderServiceProvider).markBatteryChanged();
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Batteriewechsel gespeichert!')),
                    );
                    Navigator.pop(context);
                  }
                },
                icon: const Icon(Icons.check),
                label: const Text('Batterien gerade gewechselt'),
              ),
            ),
            const SizedBox(height: 12),

            // Speichern
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isSaving ? null : () async {
                  setState(() => _isSaving = true);
                  await ref.read(batteryReminderServiceProvider).saveSettings(
                    BatteryReminderSettings(
                      isEnabled: _isEnabled,
                      intervalDays: _intervalDays,
                    ),
                  );
                  if (mounted) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Einstellungen gespeichert!')),
                    );
                  }
                },
                child: _isSaving
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                      )
                    : const Text('Speichern'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Audiogramm Import Screen (Placeholder)
class AudiogramImportScreen extends StatelessWidget {
  const AudiogramImportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Audiogramm Import')),
      body: const Center(
        child: Text('Audiogramm Import Screen - Coming Soon'),
      ),
    );
  }
}

/// Speech Therapy Screen (Placeholder)
class SpeechTherapyScreen extends StatelessWidget {
  const SpeechTherapyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Logopädie-Modus')),
      body: const Center(
        child: Text('Logopädie-Modus Screen - Coming Soon'),
      ),
    );
  }
}

/// Export Options Sheet
class ExportOptionsSheet extends ConsumerStatefulWidget {
  const ExportOptionsSheet({super.key});

  @override
  ConsumerState<ExportOptionsSheet> createState() => _ExportOptionsSheetState();
}

class _ExportOptionsSheetState extends ConsumerState<ExportOptionsSheet> {
  ReportType _selectedType = ReportType.parent;
  bool _isGenerating = false;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      minChildSize: 0.3,
      maxChildSize: 0.8,
      expand: false,
      builder: (context, scrollController) => SingleChildScrollView(
        controller: scrollController,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            const SizedBox(height: 20),
            const Text(
              '📄 Report erstellen',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Wähle den Report-Typ für den Empfänger',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),

            // Report Type Selection
            _buildReportTypeOption(
              ReportType.audiologist,
              'HNO / Audiologe',
              'Fokus auf Audiogramm und Hörgeräte-Nutzung',
              Icons.medical_services,
            ),
            _buildReportTypeOption(
              ReportType.speechTherapist,
              'Logopäde',
              'Fokus auf Sprachentwicklung und Phoneme',
              Icons.record_voice_over,
            ),
            _buildReportTypeOption(
              ReportType.parent,
              'Eltern',
              'Übersichtlicher Gesamtbericht',
              Icons.family_restroom,
            ),

            const SizedBox(height: 20),

            // Generate Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _isGenerating ? null : _generateReport,
                icon: _isGenerating
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                      )
                    : const Icon(Icons.picture_as_pdf),
                label: Text(_isGenerating ? 'Wird erstellt...' : 'PDF erstellen'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReportTypeOption(
    ReportType type,
    String title,
    String subtitle,
    IconData icon,
  ) {
    final isSelected = _selectedType == type;
    return Card(
      elevation: isSelected ? 2 : 0,
      color: isSelected ? AppTheme.primaryColor.withOpacity(0.1) : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isSelected ? AppTheme.primaryColor : Colors.grey.shade300,
          width: isSelected ? 2 : 1,
        ),
      ),
      child: ListTile(
        leading: Icon(icon, color: isSelected ? AppTheme.primaryColor : Colors.grey),
        title: Text(title),
        subtitle: Text(subtitle, style: const TextStyle(fontSize: 12)),
        trailing: isSelected ? const Icon(Icons.check_circle, color: AppTheme.primaryColor) : null,
        onTap: () => setState(() => _selectedType = type),
      ),
    );
  }

  Future<void> _generateReport() async {
    setState(() => _isGenerating = true);

    try {
      final now = DateTime.now();
      final thirtyDaysAgo = now.subtract(const Duration(days: 30));

      final file = await ref.read(progressExportServiceProvider).generateProgressReport(
        type: _selectedType,
        dateRange: DateTimeRange(start: thirtyDaysAgo, end: now),
      );

      if (file != null && mounted) {
        await ref.read(progressExportServiceProvider).shareReport(file);
        Navigator.pop(context);
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Report konnte nicht erstellt werden')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Fehler: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isGenerating = false);
    }
  }
}
