import 'package:d2ycredi/features/debt/presentation/bloc/debt/debt_bloc.dart';
import 'package:d2ycredi/features/debt/presentation/bloc/debt/debt_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/config/app_color.dart';
import '../../../../core/config/app_constants.dart';
import '../../../../core/config/app_text_styles.dart';
import '../../../../core/widgets/d2y_button.dart';
import '../../../../core/widgets/d2y_date_picker.dart';
import '../../../../core/widgets/d2y_textfield.dart';
import '../../../../core/widgets/d2y_toast.dart';
import '../../../../injection_container.dart';
import '../bloc/add_debt/add_debt_bloc.dart';
import '../bloc/add_debt/add_debt_event.dart';
import '../bloc/add_debt/add_debt_state.dart';
import '../widgets/add_debt/amount_input_formatter.dart';

class AddDebtPage extends StatelessWidget {
  const AddDebtPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddDebtBloc(addDebtUseCase: getIt()),
      child: const AddDebtView(),
    );
  }
}

class AddDebtView extends StatefulWidget {
  const AddDebtView({super.key});

  @override
  State<AddDebtView> createState() => _AddDebtViewState();
}

class _AddDebtViewState extends State<AddDebtView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        backgroundColor: AppColor.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColor.textPrimary),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Tambah Utang',
          style: AppTextStyles.h5.copyWith(
            color: AppColor.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocListener<AddDebtBloc, AddDebtState>(
        listener: (context, state) {
          if (state.status.isSuccess) {
            D2YToast.success(context, 'Utang berhasil ditambahkan');
            context.read<DebtBloc>().add(LoadDebts());
            context.pop();
          } else if (state.status.isFailure) {
            D2YToast.error(context, state.errorMessage ?? 'Gagal menambahkan utang');
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppConstants.paddingXL),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nama Peminjam
                  Text(
                    'Nama Peminjam',
                    style: AppTextStyles.labelLarge.copyWith(
                      color: AppColor.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: AppConstants.spaceSM),
                  BlocBuilder<AddDebtBloc, AddDebtState>(
                    buildWhen: (previous, current) =>
                        previous.borrowerName != current.borrowerName,
                    builder: (context, state) {
                      return D2YTextField(
                        controller: _nameController,
                        hint: 'Masukkan nama lengkap',
                        prefixIcon: Icons.person_outline,
                        onChanged: (value) {
                          context
                              .read<AddDebtBloc>()
                              .add(BorrowerNameChanged(value));
                        },
                        errorText: state.borrowerName.displayError != null
                            ? 'Nama minimal 3 karakter'
                            : null,
                      );
                    },
                  ),

                  const SizedBox(height: AppConstants.spaceXL),

                  // Nominal
                  Text(
                    'Nominal',
                    style: AppTextStyles.labelLarge.copyWith(
                      color: AppColor.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: AppConstants.spaceSM),
                  BlocBuilder<AddDebtBloc, AddDebtState>(
                    buildWhen: (previous, current) =>
                        previous.amount != current.amount,
                    builder: (context, state) {
                      return D2YTextField(
                        controller: _amountController,
                        hint: 'Rp 0',
                        prefixIcon: Icons.payments_outlined,
                        suffixIcon: Icons.camera_alt_outlined,
                        onSuffixTap: () {
                          D2YToast.info(context, 'Fitur scan akan segera hadir');
                        },
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          AmountInputFormatter(),
                        ],
                        onChanged: (value) {
                          context.read<AddDebtBloc>().add(AmountChanged(value));
                        },
                        errorText: state.amount.displayError != null
                            ? 'Masukkan nominal yang valid'
                            : null,
                      );
                    },
                  ),

                  const SizedBox(height: AppConstants.spaceXL),

                  // Tanggal Pinjam
                  Text(
                    'Tanggal Pinjam',
                    style: AppTextStyles.labelLarge.copyWith(
                      color: AppColor.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: AppConstants.spaceSM),
                  BlocBuilder<AddDebtBloc, AddDebtState>(
                    buildWhen: (previous, current) =>
                        previous.dueDate != current.dueDate,
                    builder: (context, state) {
                      return D2YDatePickerField(
                        initialDate: state.dueDate,
                        hint: 'Pilih tanggal',
                        mode: D2YDatePickerMode.date,
                        dateFormat: 'dd MMMM yyyy',
                        onChanged: (date) {
                          if (date != null) {
                            context
                                .read<AddDebtBloc>()
                                .add(DueDateChanged(date));
                          }
                        },
                      );
                    },
                  ),

                  const SizedBox(height: AppConstants.spaceXL),

                  // Tenggat Waktu (Reminder)
                  Text(
                    'Tenggat Waktu',
                    style: AppTextStyles.labelLarge.copyWith(
                      color: AppColor.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: AppConstants.spaceSM),
                  BlocBuilder<AddDebtBloc, AddDebtState>(
                    buildWhen: (previous, current) =>
                        previous.reminderDate != current.reminderDate,
                    builder: (context, state) {
                      return D2YDatePickerField(
                        initialDate: state.reminderDate,
                        hint: 'Pilih tanggal jatuh tempo',
                        mode: D2YDatePickerMode.date,
                        dateFormat: 'dd MMMM yyyy',
                        onChanged: (date) {
                          context
                              .read<AddDebtBloc>()
                              .add(ReminderDateChanged(date));
                        },
                      );
                    },
                  ),

                  const SizedBox(height: AppConstants.spaceXL),

                  // Catatan (Optional)
                  Text(
                    'Catatan (Opsional)',
                    style: AppTextStyles.labelLarge.copyWith(
                      color: AppColor.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: AppConstants.spaceSM),
                  D2YTextField.multiline(
                    controller: _noteController,
                    hint: 'Tambahkan keterangan tambahan...',
                    maxLines: 4,
                    maxLength: 200,
                    showCounter: true,
                    onChanged: (value) {
                      context.read<AddDebtBloc>().add(NoteChanged(value));
                    },
                  ),

                  const SizedBox(height: AppConstants.spaceXXXL),

                  // Submit Button
                  BlocBuilder<AddDebtBloc, AddDebtState>(
                    builder: (context, state) {
                      return D2YButton(
                        label: 'Simpan Utang',
                        icon: Icons.save_outlined,
                        onPressed: state.isValid
                            ? () {
                                context
                                    .read<AddDebtBloc>()
                                    .add(SubmitDebt());
                              }
                            : null,
                        fullWidth: true,
                        loading: state.status.isInProgress,
                        disabled: !state.isValid,
                      );
                    },
                  ),

                  const SizedBox(height: AppConstants.spaceXL),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}