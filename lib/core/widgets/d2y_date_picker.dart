
import 'package:flutter/material.dart' as material;
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import '../config/app_color.dart';
import '../config/app_constants.dart';
import 'd2y_bottom_sheet.dart';
import 'd2y_button.dart';

class D2YDatePicker {
  // Show date picker
  static Future<DateTime?> showDatePicker({
    required BuildContext context,
    DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
    bool adaptive = true,
  }) async {
    final now = DateTime.now();
    final effectiveInitialDate = initialDate ?? now;
    final effectiveFirstDate = firstDate ?? DateTime(now.year - 100);
    final effectiveLastDate = lastDate ?? DateTime(now.year + 100);

    if (adaptive && Platform.isIOS) {
      return await _showCupertinoDatePicker(
        context: context,
        initialDate: effectiveInitialDate,
        firstDate: effectiveFirstDate,
        lastDate: effectiveLastDate,
        mode: CupertinoDatePickerMode.date,
      );
    }

    return await material.showDatePicker(
  context: context,
  initialDate: effectiveInitialDate,
  firstDate: effectiveFirstDate,
  lastDate: effectiveLastDate,
  builder: (context, child) {
    return material.Theme(
      data: material.Theme.of(context).copyWith(
        colorScheme: const material.ColorScheme.light(
          primary: AppColor.primary,
          onPrimary: AppColor.white,
          surface: AppColor.white,
          onSurface: AppColor.textPrimary,
        ),
      ),
      child: child!,
    );
  },
);
  }

  // Show time picker
  static Future<material.TimeOfDay?> showTimePicker({
    required BuildContext context,
    material.TimeOfDay? initialTime,
    bool adaptive = true,
  }) async {
    final effectiveInitialTime = initialTime ?? material.TimeOfDay.now();

    if (adaptive && Platform.isIOS) {
      final now = DateTime.now();
      final initialDateTime = DateTime(
        now.year,
        now.month,
        now.day,
        effectiveInitialTime.hour,
        effectiveInitialTime.minute,
      );

      final result = await _showCupertinoDatePicker(
        context: context,
        initialDate: initialDateTime,
        mode: CupertinoDatePickerMode.time,
      );

      if (result != null) {
        return material.TimeOfDay(hour: result.hour, minute: result.minute);
      }
      return null;
    }

   return await material.showTimePicker(
  context: context,
  initialTime: effectiveInitialTime,
  builder: (context, child) {
    return material.Theme(
      data: material.Theme.of(context).copyWith(
        colorScheme: const material.ColorScheme.light(
          primary: AppColor.primary,
          onPrimary: AppColor.white,
          surface: AppColor.white,
          onSurface: AppColor.textPrimary,
        ),
      ),
      child: child!,
    );
  },
);
  }

  // Show date time picker
  static Future<DateTime?> showDateTimePicker({
    required BuildContext context,
    DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
    bool adaptive = true,
  }) async {
    if (adaptive && Platform.isIOS) {
      return await _showCupertinoDatePicker(
        context: context,
        initialDate: initialDate ?? DateTime.now(),
        firstDate: firstDate,
        lastDate: lastDate,
        mode: CupertinoDatePickerMode.dateAndTime,
      );
    }

    // Material date time picker
    final date = await D2YDatePicker.showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
      adaptive: false,
    );

    if (date == null) return null;

    if (context.mounted) {
      final time = await D2YDatePicker.showTimePicker(
        context: context,
        initialTime: material.TimeOfDay.fromDateTime(initialDate ?? DateTime.now()),
        adaptive: false,
      );

      if (time != null) {
        return DateTime(
          date.year,
          date.month,
          date.day,
          time.hour,
          time.minute,
        );
      }
    }

    return null;
  }

  // Show date range picker
  static Future<material.DateTimeRange?> showDateRangePicker({
    required BuildContext context,
    material.DateTimeRange? initialDateRange,
    DateTime? firstDate,
    DateTime? lastDate,
  }) async {
    final now = DateTime.now();
    final effectiveFirstDate = firstDate ?? DateTime(now.year - 100);
    final effectiveLastDate = lastDate ?? DateTime(now.year + 100);

    return await material.showDateRangePicker(
      context: context,
      initialDateRange: initialDateRange,
      firstDate: effectiveFirstDate,
      lastDate: effectiveLastDate,
      builder: (context, child) {
        return material.Theme(
          data: material.Theme.of(context).copyWith(
            colorScheme: const material.ColorScheme.light(
              primary: AppColor.primary,
              onPrimary: AppColor.white,
              surface: AppColor.white,
              onSurface: AppColor.textPrimary,
            ),
          ),
          child: child!,
        );
      },
    );
  }

  // Cupertino date picker helper
  static Future<DateTime?> _showCupertinoDatePicker({
    required BuildContext context,
    required DateTime initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
    required CupertinoDatePickerMode mode,
  }) async {
    DateTime? selectedDate = initialDate;

    return await D2YBottomSheet.show<DateTime>(
      context: context,
      title: _getPickerTitle(mode),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 216,
              child: CupertinoDatePicker(
                mode: mode,
                initialDateTime: initialDate,
                minimumDate: firstDate,
                maximumDate: lastDate,
                onDateTimeChanged: (DateTime value) {
                  selectedDate = value;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppConstants.paddingLG),
              child: Row(
                children: [
                  Expanded(
                    child: D2YButton(
                      label: 'Cancel',
                      onPressed: () => Navigator.pop(context),
                      type: D2YButtonType.outlined,
                    ),
                  ),
                  const SizedBox(width: AppConstants.spaceMD),
                  Expanded(
                    child: D2YButton(
                      label: 'Done',
                      onPressed: () => Navigator.pop(context, selectedDate),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static String _getPickerTitle(CupertinoDatePickerMode mode) {
    switch (mode) {
      case CupertinoDatePickerMode.date:
        return 'Select Date';
      case CupertinoDatePickerMode.time:
        return 'Select Time';
      case CupertinoDatePickerMode.dateAndTime:
        return 'Select Date & Time';
      default:
        return 'Select';
    }
  }
}

// Date picker text field
class D2YDatePickerField extends StatefulWidget {
  final DateTime? initialDate;
  final ValueChanged<DateTime?> onChanged;
  final String? label;
  final String? hint;
  final IconData? prefixIcon;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final String dateFormat;
  final bool adaptive;
  final D2YDatePickerMode mode;

  const D2YDatePickerField({
    super.key,
    this.initialDate,
    required this.onChanged,
    this.label,
    this.hint,
    this.prefixIcon,
    this.firstDate,
    this.lastDate,
    this.dateFormat = 'yyyy-MM-dd',
    this.adaptive = true,
    this.mode = D2YDatePickerMode.date,
  });

  @override
  State<D2YDatePickerField> createState() => _D2YDatePickerFieldState();
}

class _D2YDatePickerFieldState extends State<D2YDatePickerField> {
  late TextEditingController _controller;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
    _controller = TextEditingController(
      text: _selectedDate != null ? _formatDate(_selectedDate!) : '',
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _formatDate(DateTime date) {
    switch (widget.mode) {
      case D2YDatePickerMode.date:
        return DateFormat(widget.dateFormat).format(date);
      case D2YDatePickerMode.time:
        return DateFormat('HH:mm').format(date);
      case D2YDatePickerMode.dateTime:
        return DateFormat('${widget.dateFormat} HH:mm').format(date);
    }
  }

  Future<void> _showPicker() async {
    DateTime? result;

    switch (widget.mode) {
      case D2YDatePickerMode.date:
        result = await D2YDatePicker.showDatePicker(
          context: context,
          initialDate: _selectedDate,
          firstDate: widget.firstDate,
          lastDate: widget.lastDate,
          adaptive: widget.adaptive,
        );
        break;
      case D2YDatePickerMode.time:
        final time = await D2YDatePicker.showTimePicker(
          context: context,
          initialTime: _selectedDate != null
              ? material.TimeOfDay.fromDateTime(_selectedDate!)
              : null,
          adaptive: widget.adaptive,
        );
        if (time != null) {
          final now = DateTime.now();
          result = DateTime(now.year, now.month, now.day, time.hour, time.minute);
        }
        break;
      case D2YDatePickerMode.dateTime:
        result = await D2YDatePicker.showDateTimePicker(
          context: context,
          initialDate: _selectedDate,
          firstDate: widget.firstDate,
          lastDate: widget.lastDate,
          adaptive: widget.adaptive,
        );
        break;
    }

    if (result != null) {
      setState(() {
        _selectedDate = result;
        _controller.text = _formatDate(result!);
      });
      widget.onChanged(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return material.TextField(
      controller: _controller,
      readOnly: true,
      onTap: _showPicker,
      decoration: material.InputDecoration(
        labelText: widget.label,
        hintText: widget.hint,
        prefixIcon: widget.prefixIcon != null ? Icon(widget.prefixIcon) : null,
        suffixIcon: const Icon(material.Icons.calendar_today),
        border: material.OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusMD),
        ),
      ),
    );
  }
}

enum D2YDatePickerMode {
  date,
  time,
  dateTime,
}