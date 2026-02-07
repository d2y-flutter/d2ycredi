import 'package:d2ycredi/core/widgets/d2y_calendar_picker.dart';
import 'package:d2ycredi/features/debt/presentation/bloc/debt/debt_bloc.dart';
import 'package:d2ycredi/features/debt/presentation/bloc/debt/debt_event.dart';
import 'package:d2ycredi/features/debt/presentation/widgets/add_debt/amount_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/config/app_color.dart';
import '../../../../core/config/app_constants.dart';
import '../../../../core/config/app_text_styles.dart';
import '../../../../core/widgets/d2y_button.dart';
import '../../../../core/widgets/d2y_loading.dart';
import '../../../../core/widgets/d2y_textfield.dart';
import '../../../../core/widgets/d2y_toast.dart';
import '../../../../injection_container.dart';
import '../bloc/edit_debt/edit_debt_bloc.dart';
import '../bloc/edit_debt/edit_debt_event.dart';
import '../bloc/edit_debt/edit_debt_state.dart';

class EditDebtPage extends StatelessWidget {
  final String debtId;

  const EditDebtPage({
    super.key,
    required this.debtId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditDebtBloc(
        getDebtDetailUseCase: getIt(),
        updateDebtUseCase: getIt(),
        deleteDebtUseCase: getIt(),
      )..add(LoadDebtDetail(debtId)),
      child: const EditDebtView(),
    );
  }
}

class EditDebtView extends StatefulWidget {
  const EditDebtView({super.key});

  @override
  State<EditDebtView> createState() => _EditDebtViewState();
}

class _EditDebtViewState extends State<EditDebtView> {
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
        title: Text(
          'Edit Utang',
          style: AppTextStyles.h5.copyWith(
            color: AppColor.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
       
      ),
      body: BlocConsumer<EditDebtBloc, EditDebtState>(
        listener: (context, state) {
          if (state.submitStatus.isSuccess) {
            D2YToast.success(context, 'Perubahan berhasil disimpan');
            context.read<DebtBloc>().add(LoadDebts());
            context.pop();
          } else if (state.submitStatus.isFailure) {
            D2YToast.error(context, state.errorMessage ?? 'Gagal menyimpan perubahan');
          }

          // Update controllers when debt is loaded
          if (state.originalDebt != null && _nameController.text.isEmpty) {
            _nameController.text = state.borrowerName.value;
            _amountController.text = NumberFormat('#,###', 'id_ID')
                .format(state.originalDebt!.amount);
            _noteController.text = state.note;
          }
        },
        builder: (context, state) {
          if (state.isLoading) {
            return D2YLoading.center(message: 'Memuat data...');
          }

          if (state.originalDebt == null) {
            return Center(
              child: Text(
                'Data tidak ditemukan',
                style: AppTextStyles.bodyLarge,
              ),
            );
          }

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const SizedBox(height: AppConstants.spaceLG),

                // Form Section
                Padding(
                  padding: const EdgeInsets.all(AppConstants.paddingXL),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Rincian Transaksi
                        Text(
                          'Rincian Transaksi',
                          style: AppTextStyles.h3.copyWith(
                            color: AppColor.textPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Perbarui informasi pinjaman atau piutang Anda.',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColor.textSecondary,
                          ),
                        ),

                        const SizedBox(height: AppConstants.spaceXL),

                        // Nama Kontak
                        _buildFieldLabel('Nama Kontak'),
                        const SizedBox(height: AppConstants.spaceSM),
                        D2YTextField(
                          controller: _nameController,
                          hint: 'Masukkan nama kontak',
                          prefixIcon: Icons.person_outline,
                          onChanged: (value) {
                            context
                                .read<EditDebtBloc>()
                                .add(EditBorrowerNameChanged(value));
                          },
                          errorText: state.borrowerName.displayError != null
                              ? 'Nama minimal 3 karakter'
                              : null,
                        ),

                        const SizedBox(height: AppConstants.spaceXL),

                        // Jumlah Utang
                        _buildFieldLabel('Jumlah Utang (Rp)'),
                        const SizedBox(height: AppConstants.spaceSM),
                        D2YTextField(
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
                            context
                                .read<EditDebtBloc>()
                                .add(EditAmountChanged(value));
                          },
                          errorText: state.amount.displayError != null
                              ? 'Masukkan nominal yang valid'
                              : null,
                        ),

                        const SizedBox(height: AppConstants.spaceXL),

                        // Catatan / Keterangan
                        _buildFieldLabel('Catatan / Keterangan'),
                        const SizedBox(height: AppConstants.spaceSM),
                        D2YTextField.multiline(
                          controller: _noteController,
                          hint: 'Pinjaman untuk modal usaha martabak',
                          maxLines: 3,
                          maxLength: 200,
                          showCounter: true,
                          onChanged: (value) {
                            context
                                .read<EditDebtBloc>()
                                .add(EditNoteChanged(value));
                          },
                        ),

                        const SizedBox(height: AppConstants.spaceXL),

                        // Jatuh Tempo
                        _buildFieldLabel('Jatuh Tempo'),
                        const SizedBox(height: AppConstants.spaceSM),
                        _buildCalendarPicker(state),

                        const SizedBox(height: AppConstants.spaceXXXL),

                        // Submit Button
                        D2YButton(
                          label: 'Simpan Perubahan',
                          icon: Icons.save_outlined,
                          onPressed: state.isValid
                              ? () {
                                  context
                                      .read<EditDebtBloc>()
                                      .add(SubmitEditDebt());
                                }
                              : null,
                          fullWidth: true,
                          loading: state.submitStatus.isInProgress,
                          disabled: !state.isValid,
                        ),

                        const SizedBox(height: AppConstants.spaceXXXL),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildFieldLabel(String label) {
    return Text(
      label,
      style: AppTextStyles.labelLarge.copyWith(
        color: AppColor.textPrimary,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildCalendarPicker(EditDebtState state) {
    return D2yCalendarPicker(
      selectedDate: state.dueDate,
      onDateSelected: (date) {
        context.read<EditDebtBloc>().add(EditDueDateChanged(date));
      },
    );
  }

}