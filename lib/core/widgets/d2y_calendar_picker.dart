import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/config/app_color.dart';
import '../../../../core/config/app_constants.dart';
import '../../../../core/config/app_text_styles.dart';

class D2yCalendarPicker extends StatefulWidget {
  final DateTime? selectedDate;
  final ValueChanged<DateTime> onDateSelected;

  const D2yCalendarPicker({
    super.key,
    this.selectedDate,
    required this.onDateSelected,
  });

  @override
  State<D2yCalendarPicker> createState() => _D2yCalendarPickerState();
}

class _D2yCalendarPickerState extends State<D2yCalendarPicker> {
  late DateTime _displayedMonth;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.selectedDate;
    _displayedMonth = widget.selectedDate ?? DateTime.now();
  }

  void _previousMonth() {
    setState(() {
      _displayedMonth = DateTime(
        _displayedMonth.year,
        _displayedMonth.month - 1,
      );
    });
  }

  void _nextMonth() {
    setState(() {
      _displayedMonth = DateTime(
        _displayedMonth.year,
        _displayedMonth.month + 1,
      );
    });
  }

  void _selectDate(DateTime date) {
    setState(() {
      _selectedDate = date;
    });
    widget.onDateSelected(date);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.paddingLG),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(AppConstants.radiusLG),
        border: Border.all(color: AppColor.border, width: 1),
      ),
      child: Column(
        children: [
          // Month Year Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: _previousMonth,
                icon: const Icon(Icons.chevron_left),
                color: AppColor.textPrimary,
              ),
              Text(
                DateFormat('MMMM yyyy', 'id').format(_displayedMonth),
                style: AppTextStyles.h6.copyWith(
                  color: AppColor.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              IconButton(
                onPressed: _nextMonth,
                icon: const Icon(Icons.chevron_right),
                color: AppColor.textPrimary,
              ),
            ],
          ),

          const SizedBox(height: AppConstants.spaceMD),

          // Day Labels
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: ['MIN', 'SEN', 'SEL', 'RAB', 'KAM', 'JUM', 'SAB']
                .map((day) => SizedBox(
                      width: 40,
                      child: Center(
                        child: Text(
                          day,
                          style: AppTextStyles.labelSmall.copyWith(
                            color: AppColor.textSecondary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ))
                .toList(),
          ),

          const SizedBox(height: AppConstants.spaceSM),

          // Calendar Grid
          _buildCalendarGrid(),
        ],
      ),
    );
  }

  Widget _buildCalendarGrid() {
    final firstDayOfMonth = DateTime(_displayedMonth.year, _displayedMonth.month, 1);
    final lastDayOfMonth = DateTime(_displayedMonth.year, _displayedMonth.month + 1, 0);
    final daysInMonth = lastDayOfMonth.day;
    final startWeekday = firstDayOfMonth.weekday % 7; // 0 = Sunday

    final List<Widget> dayWidgets = [];

    // Add empty cells for days before the first day of month
    for (int i = 0; i < startWeekday; i++) {
      dayWidgets.add(const SizedBox(width: 40, height: 40));
    }

    // Add day cells
    for (int day = 1; day <= daysInMonth; day++) {
      final date = DateTime(_displayedMonth.year, _displayedMonth.month, day);
      final isSelected = _selectedDate != null &&
          date.year == _selectedDate!.year &&
          date.month == _selectedDate!.month &&
          date.day == _selectedDate!.day;
      final isToday = date.year == DateTime.now().year &&
          date.month == DateTime.now().month &&
          date.day == DateTime.now().day;

      dayWidgets.add(
        GestureDetector(
          onTap: () => _selectDate(date),
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColor.primary
                  : (isToday ? AppColor.primarySurface : Colors.transparent),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '$day',
                style: TextStyle(
                  color: isSelected
                      ? AppColor.white
                      : (isToday ? AppColor.primary : AppColor.textPrimary),
                  fontSize: 14,
                  fontWeight: isSelected || isToday
                      ? FontWeight.w600
                      : FontWeight.normal,
                ),
              ),
            ),
          ),
        ),
      );
    }

    // Create rows
    final List<Widget> rows = [];
    for (int i = 0; i < dayWidgets.length; i += 7) {
      final rowChildren = dayWidgets.skip(i).take(7).toList();
      rows.add(
        Padding(
          padding: const EdgeInsets.only(bottom: AppConstants.spaceSM),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: rowChildren,
          ),
        ),
      );
    }

    return Column(children: rows);
  }
}