import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zakkiyah_app/constants/images/images.dart';
import 'package:zakkiyah_app/widgets/app_menu_drawer.dart';
import 'package:zakkiyah_app/widgets/app_screen_header.dart';
import 'package:zakkiyah_app/widgets/responsive_frame.dart';
import 'package:zakkiyah_app/widgets/voice_tap.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  late DateTime _now;
  late DateTime _visibleMonth;
  Timer? _clockTimer;

  @override
  void initState() {
    super.initState();
    _now = DateTime.now();
    _visibleMonth = DateTime(_now.year, _now.month);
    _clockTimer = Timer.periodic(const Duration(seconds: 30), (_) {
      if (!mounted) return;
      setState(() => _now = DateTime.now());
    });
  }

  @override
  void dispose() {
    _clockTimer?.cancel();
    super.dispose();
  }

  Future<void> _openGoogleCalendar({DateTime? date}) async {
    final DateTime target = date ?? _now;
    final Uri webUri = Uri.parse(
      'https://calendar.google.com/calendar/r/day/${target.year}/${target.month}/${target.day}',
    );

    if (await launchUrl(webUri, mode: LaunchMode.externalApplication)) {
      return;
    }

    final Uri fallbackUri = Uri.parse('https://calendar.google.com/calendar/r');
    if (!await launchUrl(fallbackUri, mode: LaunchMode.externalApplication)) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not open Google Calendar.')),
      );
    }
  }

  void _changeMonth(int delta) {
    setState(() {
      _visibleMonth = DateTime(_visibleMonth.year, _visibleMonth.month + delta);
    });
  }

  bool _useSideBySideLayout(double width, double height) {
    return width >= 640 && width > height * 1.15;
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color panelColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final Color borderColor = isDark ? const Color(0xFF3A3A3A) : const Color(0xFFE0E0E0);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      endDrawer: const AppMenuDrawer(),
      body: SafeArea(
        child: ResponsiveFrame(
          tabletMaxWidth: 1200,
          child: Column(
            children: <Widget>[
              AppScreenHeader(
                topBarHeight: 56,
                topBarPadding: EdgeInsets.symmetric(horizontal: 8.w),
                greetingText: 'Good Morning Zakkiyah',
                titleContent: AppHeaderTitle.breadcrumbs(
                  titles: const <String>['Home', 'Schedule'],
                  assetForTitle: (String title) =>
                      title.toLowerCase() == 'schedule' ? AppImages.schedule : null,
                ),
              ),
              Expanded(
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    final bool sideBySide =
                        _useSideBySideLayout(constraints.maxWidth, constraints.maxHeight);

                    return Padding(
                      padding: EdgeInsets.all(12.w),
                      child: sideBySide
                          ? Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Expanded(
                                  child: _dateTimePanel(
                                    panelColor,
                                    borderColor,
                                    isDark,
                                    compact: constraints.maxWidth < 900,
                                  ),
                                ),
                                SizedBox(width: 12.w),
                                Expanded(
                                  flex: 2,
                                  child: _calendarPanel(panelColor, borderColor, isDark),
                                ),
                              ],
                            )
                          : Column(
                              children: <Widget>[
                                _dateTimePanel(
                                  panelColor,
                                  borderColor,
                                  isDark,
                                  compact: constraints.maxWidth < 400,
                                ),
                                SizedBox(height: 12.h),
                                Expanded(
                                  child: _calendarPanel(panelColor, borderColor, isDark),
                                ),
                              ],
                            ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _dateTimePanel(
    Color panelColor,
    Color borderColor,
    bool isDark, {
    required bool compact,
  }) {
    final String dateText = DateFormat('EEEE, MMMM d, yyyy').format(_now);
    final String timeText = DateFormat('h:mm a').format(_now);

    return Container(
      padding: EdgeInsets.all(compact ? 12.w : 16.w),
      decoration: BoxDecoration(
        color: panelColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            'Today',
            style: TextStyle(
              fontSize: compact ? 12.sp : 14.sp,
              color: isDark ? Colors.white70 : Colors.black54,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8.h),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              dateText,
              style: TextStyle(
                fontSize: compact ? 16.sp : 20.sp,
                fontWeight: FontWeight.w700,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
          ),
          SizedBox(height: 12.h),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              timeText,
              style: TextStyle(
                fontSize: compact ? 32.sp : 42.sp,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF1A73E8),
                height: 1.1,
              ),
            ),
          ),
          SizedBox(height: 16.h),
          VoiceTap(
            announceText: 'Open Google Calendar',
            onTap: () async => _openGoogleCalendar(),
            borderRadius: BorderRadius.circular(12.r),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                vertical: compact ? 10.h : 14.h,
                horizontal: 8.w,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFF1A73E8),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.calendar_month, color: Colors.white, size: compact ? 18.w : 22.w),
                    SizedBox(width: 8.w),
                    Text(
                      'Open Google Calendar',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: compact ? 13.sp : 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _calendarPanel(Color panelColor, Color borderColor, bool isDark) {
    final String monthLabel = DateFormat('MMMM yyyy').format(_visibleMonth);
    final List<DateTime?> days = _monthDays(_visibleMonth);

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double cellWidth = (constraints.maxWidth - 6 * 4) / 7;
        final int rowCount = days.length ~/ 7;
        final double cellHeight =
            (constraints.maxHeight - 72.h - (rowCount - 1) * 4) / rowCount;
        final double aspectRatio = cellWidth / cellHeight.clamp(0.5, double.infinity);
        final bool compact = constraints.maxWidth < 360;
        final List<String> weekdayLabels = compact
            ? <String>['S', 'M', 'T', 'W', 'T', 'F', 'S']
            : <String>['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

        return Container(
          padding: EdgeInsets.all(compact ? 8.w : 14.w),
          decoration: BoxDecoration(
            color: panelColor,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: borderColor),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
                      onPressed: () => _changeMonth(-1),
                      icon: const Icon(Icons.chevron_left),
                    ),
                    Expanded(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          monthLabel,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: compact ? 15.sp : 18.sp,
                            fontWeight: FontWeight.w700,
                            color: isDark ? Colors.white : Colors.black87,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
                      onPressed: () => _changeMonth(1),
                      icon: const Icon(Icons.chevron_right),
                    ),
                  ],
                ),
                SizedBox(height: 6.h),
                Row(
                  children: <Widget>[
                    for (final String day in weekdayLabels)
                      Expanded(
                        child: Center(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              day,
                              style: TextStyle(
                                fontSize: compact ? 10.sp : 12.sp,
                                fontWeight: FontWeight.w600,
                                color: isDark ? Colors.white54 : Colors.black54,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 6.h),
                // Fixed height for calendar grid - enough for all dates even in long months
                SizedBox(
                  height: (rowCount * 70.0) + ((rowCount - 1) * 4) + 40, // Even more height
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: days.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 7,
                      mainAxisSpacing: 4,
                      crossAxisSpacing: 4,
                      childAspectRatio: 1.0, // Square cells
                    ),
                    itemBuilder: (_, int index) {
                      final DateTime? day = days[index];
                      if (day == null) return const SizedBox.shrink();

                      final bool isToday = _isSameDay(day, _now);

                      return VoiceTap(
                        announceText: DateFormat('MMMM d').format(day),
                        onTap: () async => _openGoogleCalendar(date: day),
                        borderRadius: BorderRadius.circular(8.r),
                        child: Container(
                          padding: const EdgeInsets.all(4.0), // Add padding inside cell
                          decoration: BoxDecoration(
                            color: isToday ? const Color(0xFF1A73E8) : Colors.transparent,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          alignment: Alignment.center,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              '${day.day}',
                              style: TextStyle(
                                fontSize: compact ? 13.sp : 15.sp,
                                fontWeight: isToday ? FontWeight.w700 : FontWeight.w500,
                                color: isToday
                                    ? Colors.white
                                    : (isDark ? Colors.white : Colors.black87),
                                height: 1.4, // Add line height for proper spacing
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 16.h), // More bottom padding for scroll
              ],
            ),
          ),
        );
      },
    );
  }

  List<DateTime?> _monthDays(DateTime month) {
    final DateTime firstDay = DateTime(month.year, month.month, 1);
    final int leadingEmpty = firstDay.weekday % 7;
    final int daysInMonth = DateTime(month.year, month.month + 1, 0).day;
    final List<DateTime?> result = <DateTime?>[
      for (int i = 0; i < leadingEmpty; i++) null,
      for (int i = 1; i <= daysInMonth; i++) DateTime(month.year, month.month, i),
    ];
    while (result.length % 7 != 0) {
      result.add(null);
    }
    return result;
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}
