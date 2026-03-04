part of '../prayers.dart';

class PrayerBuild extends StatefulWidget {
  const PrayerBuild({super.key});

  @override
  State<PrayerBuild> createState() => _PrayerBuildState();
}

class _PrayerBuildState extends State<PrayerBuild>
    with SingleTickerProviderStateMixin {
  late AnimationController _staggerController;
  final List<Animation<double>> _itemAnims = [];

  @override
  void initState() {
    super.initState();
    _staggerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    for (int i = 0; i < 8; i++) {
      final start = (i * 0.09).clamp(0.0, 1.0);
      final end = (start + 0.45).clamp(0.0, 1.0);
      _itemAnims.add(
        CurvedAnimation(
          parent: _staggerController,
          curve: Interval(start, end, curve: Curves.easeOutCubic),
        ),
      );
    }

    _staggerController.forward();
  }

  @override
  void dispose() {
    _staggerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          right: 12.0, left: 12.0, top: 8.0, bottom: 120.0),
      child: GetBuilder<AdhanController>(
        id: 'init_athan',
        builder: (adhanCtrl) => Column(
          children: List.generate(
            adhanCtrl.prayerNameList.length,
            (index) {
              final prayerList = adhanCtrl.prayerNameList.toList();
              final String prayerTitle = prayerList[index]['title'];
              final String prayerTime = prayerList[index]['time'];
              final anim = index < _itemAnims.length
                  ? _itemAnims[index]
                  : _itemAnims.last;

              return _AnimatedRow(
                animation: anim,
                child: _PrayerRow(
                  index: index,
                  prayerTitle: prayerTitle,
                  prayerTime: prayerTime,
                  adhanCtrl: adhanCtrl,
                  isLast: index == adhanCtrl.prayerNameList.length - 1,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

// ─── Animated wrapper ─────────────────────────────────────────────────────────

class _AnimatedRow extends AnimatedWidget {
  const _AnimatedRow({
    required Animation<double> animation,
    required this.child,
  }) : super(listenable: animation);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final anim = listenable as Animation<double>;
    return FadeTransition(
      opacity: anim,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0.05, 0),
          end: Offset.zero,
        ).animate(anim),
        child: child,
      ),
    );
  }
}

// ─── Accent colours (same palette as PrayerNowWidget) ─────────────────────────

Color _prayerAccent(int index) {
  const accents = [
    Color(0xFF6C5CE7), // Fajr
    Color(0xFFE67E22), // Sunrise
    Color(0xFF0984E3), // Dhuhr
    Color(0xFFE6A800), // Asr
    Color(0xFFE84393), // Maghrib
    Color(0xFF2979CC), // Isha
    Color(0xFF6C5CE7), // Midnight
    Color(0xFF2979CC), // Last third
  ];
  return accents[index.clamp(0, accents.length - 1)];
}

// ─── Single row ───────────────────────────────────────────────────────────────

class _PrayerRow extends StatelessWidget {
  const _PrayerRow({
    required this.index,
    required this.prayerTitle,
    required this.prayerTime,
    required this.adhanCtrl,
    required this.isLast,
  });

  final int index;
  final String prayerTitle;
  final String prayerTime;
  final AdhanController adhanCtrl;
  final bool isLast;

  bool get _isCurrent => adhanCtrl.currentPrayerIndex == index;
  bool get _isPast => index < adhanCtrl.currentPrayerIndex;

  @override
  Widget build(BuildContext context) {
    final accent = _prayerAccent(index);
    final colorScheme = Theme.of(context).colorScheme;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ── LEFT: Timeline
          SizedBox(
            width: 52,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Vertical connector line
                Positioned.fill(
                  child: Center(
                    child: Container(
                      width: 2,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: _isCurrent
                              ? [
                                  accent.withValues(alpha: .9),
                                  accent.withValues(alpha: .25),
                                ]
                              : _isPast
                                  ? [
                                      accent.withValues(alpha: .40),
                                      accent.withValues(alpha: .40),
                                    ]
                                  : [
                                      colorScheme.surface.withValues(alpha: .4),
                                      colorScheme.surface.withValues(alpha: .4),
                                    ],
                        ),
                      ),
                    ),
                  ),
                ),

                // Dot
                _TimelineDot(
                  index: index,
                  isCurrent: _isCurrent,
                  isPast: _isPast,
                  accent: accent,
                  adhanCtrl: adhanCtrl,
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          // ── RIGHT: Tile
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                right: 4,
                bottom: isLast ? 0 : 6,
              ),
              child: _PrayerTile(
                index: index,
                prayerTitle: prayerTitle,
                prayerTime: prayerTime,
                isCurrent: _isCurrent,
                isPast: _isPast,
                accent: accent,
                adhanCtrl: adhanCtrl,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Timeline dot ─────────────────────────────────────────────────────────────

class _TimelineDot extends StatelessWidget {
  const _TimelineDot({
    required this.index,
    required this.isCurrent,
    required this.isPast,
    required this.accent,
    required this.adhanCtrl,
  });

  final int index;
  final bool isCurrent;
  final bool isPast;
  final Color accent;
  final AdhanController adhanCtrl;

  @override
  Widget build(BuildContext context) {
    final double size = isCurrent ? 44 : 30;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isCurrent
            ? accent
            : isPast
                ? accent.withValues(alpha: .18)
                : Theme.of(context).colorScheme.surface.withValues(alpha: .35),
        border: Border.all(
          color: isCurrent
              ? accent
              : isPast
                  ? accent.withValues(alpha: .45)
                  : Theme.of(context)
                      .colorScheme
                      .surface
                      .withValues(alpha: .50),
          width: isCurrent ? 0 : 1.5,
        ),
        boxShadow: isCurrent
            ? [
                BoxShadow(
                  color: accent.withValues(alpha: .35),
                  blurRadius: 12,
                  spreadRadius: 1,
                  offset: const Offset(0, 3),
                ),
              ]
            : null,
      ),
      child: Center(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: Icon(
            adhanCtrl.prayerNameList[index]['icon'] as IconData,
            key: ValueKey(isCurrent),
            size: isCurrent ? 22 : 14,
            color: isCurrent
                ? Colors.white
                : isPast
                    ? accent.withValues(alpha: .75)
                    : Theme.of(context)
                        .colorScheme
                        .surface
                        .withValues(alpha: .70),
          ),
        ),
      ),
    );
  }
}

// ─── Prayer tile ──────────────────────────────────────────────────────────────

class _PrayerTile extends StatelessWidget {
  const _PrayerTile({
    required this.index,
    required this.prayerTitle,
    required this.prayerTime,
    required this.isCurrent,
    required this.isPast,
    required this.accent,
    required this.adhanCtrl,
  });

  final int index;
  final String prayerTitle;
  final String prayerTime;
  final bool isCurrent;
  final bool isPast;
  final Color accent;
  final AdhanController adhanCtrl;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textBase = colorScheme.inversePrimary;

    return GetBuilder<AdhanController>(
      id: 'change_notification',
      builder: (_) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => context.customBottomSheet(
          textTitle: 'prayerDetails'.tr,
          containerColor: colorScheme.primaryContainer,
          child: PrayerDetails(prayerName: prayerTitle),
        ),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeInOut,
          height: isCurrent ? 64 : 48,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: isCurrent
                ? accent.withValues(alpha: .12)
                : isPast
                    ? colorScheme.surface.withValues(alpha: .12)
                    : colorScheme.surface.withValues(alpha: .08),
            border: Border.all(
              color: isCurrent
                  ? accent.withValues(alpha: .40)
                  : colorScheme.surface.withValues(alpha: .25),
              width: isCurrent ? 1.2 : 0.8,
            ),
            boxShadow: isCurrent
                ? [
                    BoxShadow(
                      color: accent.withValues(alpha: .12),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Stack(
              children: [
                // Left accent bar (current only)
                if (isCurrent)
                  Positioned(
                    left: 0,
                    top: 8,
                    bottom: 8,
                    child: Container(
                      width: 3,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [accent, accent.withValues(alpha: .30)],
                        ),
                      ),
                    ),
                  ),

                // Row content
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                    start: 14,
                    end: 14,
                  ),
                  child: Row(
                    children: [
                      // Name
                      Expanded(
                        flex: 5,
                        child: Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              prayerTitle.tr,
                              style: TextStyle(
                                fontFamily: 'cairo',
                                fontSize: isCurrent ? 18.sp : 14.sp,
                                fontWeight: isCurrent
                                    ? FontWeight.w700
                                    : FontWeight.w500,
                                color: isCurrent
                                    ? textBase
                                    : textBase.withValues(
                                        alpha: isPast ? 0.50 : 0.75),
                                height: 1.2,
                              ),
                            ),
                          ),
                        ),
                      ),

                      // Time
                      Expanded(
                        flex: 5,
                        child: Align(
                          alignment: AlignmentDirectional.centerEnd,
                          child: ReactiveNumberText(
                            text: prayerTime,
                            style: TextStyle(
                              fontFamily: 'cairo',
                              fontSize: isCurrent ? 20.sp : 16.sp,
                              fontWeight:
                                  isCurrent ? FontWeight.w700 : FontWeight.w400,
                              color: isCurrent
                                  ? accent
                                  : textBase.withValues(
                                      alpha: isPast ? 0.40 : 0.65),
                              height: 1.2,
                            ),
                          ),
                        ),
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
