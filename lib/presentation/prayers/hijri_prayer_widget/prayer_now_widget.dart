import 'dart:developer';
import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:salaty_app/presentation/calendar/events.dart';
import 'package:salaty_app/presentation/splash/splash.dart';

import '/core/utils/constants/extensions/bottom_sheet_extension.dart';
import '/core/utils/constants/svg_constants.dart';
import '/core/widgets/custom_button.dart';
import '../../../core/widgets/reactive_number_text.dart';
import '../prayers.dart';

class PrayerNowWidget extends StatefulWidget {
  const PrayerNowWidget({super.key});

  @override
  State<PrayerNowWidget> createState() => _PrayerNowWidgetState();
}

class _PrayerNowWidgetState extends State<PrayerNowWidget>
    with TickerProviderStateMixin {
  late AnimationController _arcController;
  late AnimationController _pulseController;
  late AnimationController _entranceController;

  final adhanCtrl = AdhanController.instance;
  final eventCtrl = EventController.instance;

  late Animation<double> _arcAnim;
  late Animation<double> _pulseAnim;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();

    _arcController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    )..forward();

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    )..repeat(reverse: true);

    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..forward();

    _arcAnim = CurvedAnimation(
      parent: _arcController,
      curve: Curves.easeOutCubic,
    );

    _pulseAnim = Tween<double>(begin: 0.96, end: 1.04).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _fadeAnim = CurvedAnimation(
      parent: _entranceController,
      curve: Curves.easeOut,
    );

    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.12),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _entranceController, curve: Curves.easeOutCubic),
    );
  }

  @override
  void dispose() {
    _arcController.dispose();
    _pulseController.dispose();
    _entranceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdhanController>(
      id: 'init_athan',
      builder: (adhanCtrl) {
        return FadeTransition(
          opacity: _fadeAnim,
          child: SlideTransition(
            position: _slideAnim,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Obx(() {
                final int idx = adhanCtrl.currentPrayerIndex;
                final double progress =
                    (adhanCtrl.getPrayerDayProgress.value / 100)
                        .clamp(0.0, 1.0);

                return Column(
                  children: [
                    updateLocationBuild(context),
                    SizedBox(height: 10.h),
                    _PrayerCard(
                      idx: idx,
                      progress: progress,
                      arcAnim: _arcAnim,
                      pulseAnim: _pulseAnim,
                      adhanCtrl: adhanCtrl,
                    ),
                  ],
                );
              }),
            ),
          ),
        );
      },
    );
  }

  Padding updateLocationBuild(BuildContext context) {
    final accent = Theme.of(context).colorScheme.surface; // gold
    final textColor = Theme.of(context).colorScheme.inversePrimary;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: GestureDetector(
        onTap: () async {
          final success = await generalCtrl.updateLocationAndPrayerTimes();
          if (success) {
            Get.forceAppUpdate();
            log('Location updated', name: 'PrayerScreen');
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: 64,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: isDark
                ? accent.withValues(alpha: .08)
                : accent.withValues(alpha: .07),
            border: Border.all(
              color: accent.withValues(alpha: .35),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: accent.withValues(alpha: .10),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              children: [
                // Icon container
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: accent.withValues(alpha: .15),
                    border: Border.all(
                      color: accent.withValues(alpha: .40),
                      width: 1,
                    ),
                  ),
                  child: Icon(
                    Icons.location_on_outlined,
                    size: 24,
                    color: accent,
                  ),
                ),

                SizedBox(width: 12.w),

                // Location text
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'موقعك الحالي'.tr,
                        style: TextStyle(
                          fontFamily: 'cairo',
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w400,
                          color: textColor.withValues(alpha: .50),
                          height: 2,
                        ),
                      ),
                      Text(
                        adhanCtrl.state.location,
                        style: TextStyle(
                          fontFamily: 'cairo',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          color: textColor,
                          height: 1.3,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Palette ──────────────────────────────────────────────────────────────────

class _PrayerPalette {
  const _PrayerPalette({
    required this.bg1,
    required this.bg2,
    required this.accent,
    required this.accent2,
  });
  final Color bg1, bg2, accent, accent2;
}

const _palettes = [
  _PrayerPalette(
      bg1: Color(0xFF0D0B2B),
      bg2: Color(0xFF1A1550),
      accent: Color(0xFF9B8FFF),
      accent2: Color(0xFF6C5CE7)), // Fajr
  _PrayerPalette(
      bg1: Color(0xFF180800),
      bg2: Color(0xFF5C2200),
      accent: Color(0xFFFFB347),
      accent2: Color(0xFFFF7200)), // Sunrise
  _PrayerPalette(
      bg1: Color(0xFF001428),
      bg2: Color(0xFF00377A),
      accent: Color(0xFF48C6FF),
      accent2: Color(0xFF0099CC)), // Dhuhr
  _PrayerPalette(
      bg1: Color(0xFF120E00),
      bg2: Color(0xFF4A3200),
      accent: Color(0xFFFFD060),
      accent2: Color(0xFFE6A800)), // Asr
  _PrayerPalette(
      bg1: Color(0xFF1A000D),
      bg2: Color(0xFF5C0020),
      accent: Color(0xFFFF70A0),
      accent2: Color(0xFFCC003C)), // Maghrib
  _PrayerPalette(
      bg1: Color(0xFF04060F),
      bg2: Color(0xFF0B1638),
      accent: Color(0xFF7EB8FF),
      accent2: Color(0xFF2979CC)), // Isha
];

// ignore: library_private_types_in_public_api
_PrayerPalette paletteOf(int idx) => _palettes[idx.clamp(0, 5)];

// ─── Card ─────────────────────────────────────────────────────────────────────

class _PrayerCard extends StatelessWidget {
  const _PrayerCard({
    required this.idx,
    required this.progress,
    required this.arcAnim,
    required this.pulseAnim,
    required this.adhanCtrl,
  });

  final int idx;
  final double progress;
  final Animation<double> arcAnim;
  final Animation<double> pulseAnim;
  final AdhanController adhanCtrl;

  @override
  Widget build(BuildContext context) {
    final p = paletteOf(idx);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [p.bg1, p.bg2],
        ),
        boxShadow: [
          BoxShadow(
            color: p.accent.withValues(alpha: .28),
            blurRadius: 36,
            spreadRadius: -6,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24.r),
        child: Stack(
          children: [
            // Star field
            // Positioned.fill(child: CustomPaint(painter: _StarPainter())),

            // Subtle top glow
            Positioned(
              top: -100,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  width: 240,
                  height: 180,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: p.accent.withValues(alpha: .07),
                  ),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.fromLTRB(18.w, 14.h, 18.w, 20.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Share button top-end
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      HijriDateWidget(
                        svgColor: context.theme.colorScheme.surface,
                      ),
                      Align(
                        alignment: AlignmentDirectional.topEnd,
                        child:
                            _ShareBtn(adhanCtrl: adhanCtrl, accent: p.accent),
                      ),
                    ],
                  ),

                  SizedBox(height: 24.h),

                  // Ring (centered)
                  Center(
                    child: _Ring(
                      idx: idx,
                      progress: progress,
                      palette: p,
                      arcAnim: arcAnim,
                      pulseAnim: pulseAnim,
                      adhanCtrl: adhanCtrl,
                    ),
                  ),

                  SizedBox(height: 24.h),

                  // Countdown
                  _CountdownChip(
                      idx: idx, accent: p.accent, adhanCtrl: adhanCtrl),

                  SizedBox(height: 12.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Ring ─────────────────────────────────────────────────────────────────────

class _Ring extends StatelessWidget {
  const _Ring({
    required this.idx,
    required this.progress,
    required this.palette,
    required this.arcAnim,
    required this.pulseAnim,
    required this.adhanCtrl,
  });

  final int idx;
  final double progress;
  final _PrayerPalette palette;
  final Animation<double> arcAnim;
  final Animation<double> pulseAnim;
  final AdhanController adhanCtrl;

  @override
  Widget build(BuildContext context) {
    const double size = 250.0;

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center, // <— everything centred here
        children: [
          // Pulsing halo
          AnimatedBuilder(
            animation: pulseAnim,
            builder: (_, __) => Transform.scale(
              scale: pulseAnim.value,
              child: Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: palette.accent.withValues(alpha: .12),
                      blurRadius: 55,
                      spreadRadius: 12,
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Arc
          AnimatedBuilder(
            animation: arcAnim,
            builder: (_, __) => CustomPaint(
              size: const Size(size, size),
              painter: _ArcPainter(
                progress: progress * arcAnim.value,
                accent: palette.accent,
                accent2: palette.accent2,
              ),
            ),
          ),

          // Centre text — pinned exactly in the middle by Stack alignment
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                adhanCtrl.prayerNameList[idx]['icon'] as IconData,
                size: 48,
                color: palette.accent,
              ),
              const SizedBox(height: 8),
              Text(
                ('${adhanCtrl.prayerNameList[idx]['title']}').tr,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'cairo',
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  height: 1.15,
                ),
              ),
              const SizedBox(height: 8),
              ReactiveNumberText(
                text: adhanCtrl.prayerNameList[idx]['time'],
                style: TextStyle(
                  fontFamily: 'cairo',
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: palette.accent,
                  height: 1.2,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─── Arc Painter ──────────────────────────────────────────────────────────────

class _ArcPainter extends CustomPainter {
  const _ArcPainter({
    required this.progress,
    required this.accent,
    required this.accent2,
  });

  final double progress;
  final Color accent;
  final Color accent2;

  static const double _stroke = 12.0;
  static const double _inset = _stroke / 2 + 3;

  @override
  void paint(Canvas canvas, Size size) {
    final c = Offset(size.width / 2, size.height / 2);
    final r = size.shortestSide / 2 - _inset;
    final rect = Rect.fromCircle(center: c, radius: r);

    // Track
    canvas.drawCircle(
      c,
      r,
      Paint()
        ..color = Colors.white.withValues(alpha: .10)
        ..style = PaintingStyle.stroke
        ..strokeWidth = _stroke,
    );

    if (progress < 0.005) return;

    final sweep = 2 * math.pi * progress;

    // Soft glow behind arc
    canvas.drawArc(
      rect,
      -math.pi / 2,
      sweep,
      false,
      Paint()
        ..color = accent.withValues(alpha: .30)
        ..style = PaintingStyle.stroke
        ..strokeWidth = _stroke + 12
        ..strokeCap = StrokeCap.round
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10),
    );

    // Gradient arc
    canvas.drawArc(
      rect,
      -math.pi / 2,
      sweep,
      false,
      Paint()
        ..shader = SweepGradient(
          startAngle: -math.pi / 2,
          endAngle: -math.pi / 2 + sweep,
          colors: [accent2, accent],
          tileMode: TileMode.clamp,
        ).createShader(rect)
        ..style = PaintingStyle.stroke
        ..strokeWidth = _stroke
        ..strokeCap = StrokeCap.round,
    );

    // End dot
    final dotAngle = -math.pi / 2 + sweep;
    final dot =
        Offset(c.dx + r * math.cos(dotAngle), c.dy + r * math.sin(dotAngle));

    canvas.drawCircle(
        dot,
        8,
        Paint()
          ..color = accent.withValues(alpha: .45)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6));
    canvas.drawCircle(dot, 6, Paint()..color = Colors.white);
    canvas.drawCircle(dot, 4, Paint()..color = accent);
  }

  @override
  bool shouldRepaint(_ArcPainter old) =>
      old.progress != progress || old.accent != accent;
}

// ─── Countdown chip ───────────────────────────────────────────────────────────

class _CountdownChip extends StatelessWidget {
  const _CountdownChip({
    required this.idx,
    required this.accent,
    required this.adhanCtrl,
  });

  final int idx;
  final Color accent;
  final AdhanController adhanCtrl;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14.r),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 18.w),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: .08),
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(color: accent.withValues(alpha: .22)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.timer_outlined,
                  size: 24.sp, color: accent.withValues(alpha: .8)),
              SizedBox(width: 4.w),
              const Text(
                'الوقت المتبقي',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'cairo',
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 4.w),
              SlideCountdownWidget(
                key: ValueKey<int>(idx),
                fontSize: 24.sp,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Share button ─────────────────────────────────────────────────────────────

class _ShareBtn extends StatelessWidget {
  const _ShareBtn({required this.adhanCtrl, required this.accent});
  final AdhanController adhanCtrl;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          width: 38.w,
          height: 38.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withValues(alpha: .08),
            border: Border.all(color: accent.withValues(alpha: .30)),
          ),
          child: CustomButton(
            onPressed: () => context.customBottomSheet(
              containerColor: context.theme.colorScheme.primaryContainer,
              textTitle: 'sharePrayerTime',
              child: ShareOptionsWidget(),
            ),
            width: 38,
            iconSize: 20,
            isCustomSvgColor: true,
            svgPath: SvgPath.svgShareShare,
            svgColor: Colors.white70,
            borderColor: Colors.transparent,
          ),
        ),
      ),
    );
  }
}

// ─── Stars ────────────────────────────────────────────────────────────────────

// ignore: unused_element
class _StarPainter extends CustomPainter {
  final _rng = math.Random(77);

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < 60; i++) {
      final x = _rng.nextDouble() * size.width;
      final y = _rng.nextDouble() * size.height;
      final r = _rng.nextDouble() * 1.2 + 0.2;
      final a = _rng.nextDouble() * 0.5 + 0.05;
      canvas.drawCircle(
          Offset(x, y), r, Paint()..color = Colors.white.withValues(alpha: a));
    }
  }

  @override
  bool shouldRepaint(_StarPainter old) => false;
}
