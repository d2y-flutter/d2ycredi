import 'package:d2ycredi/core/routes/app_routes.dart';
import 'package:d2ycredi/core/widgets/d2y_modal.dart';
import 'package:d2ycredi/features/debt/presentation/widgets/detail_debt/debt_info_card.dart';
import 'package:d2ycredi/features/debt/presentation/widgets/detail_debt/detail_note_card.dart';
import 'package:d2ycredi/features/debt/presentation/widgets/detail_debt/detail_section_title.dart';
import 'package:d2ycredi/features/debt/presentation/widgets/detail_debt/payment_info_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/config/app_color.dart';
import '../../../../core/config/app_constants.dart';
import '../../../../core/config/app_text_styles.dart';
import '../../../../core/widgets/d2y_button.dart';
import '../../../../core/widgets/d2y_loading.dart';
import '../../../../core/widgets/d2y_toast.dart';
import '../../../../injection_container.dart';
import '../../domain/entities/debt.dart';
import '../bloc/debt/debt_bloc.dart';
import '../bloc/debt/debt_event.dart';
import '../bloc/detail_debt/detail_debt_bloc.dart';
import '../bloc/detail_debt/detail_debt_event.dart';
import '../bloc/detail_debt/detail_debt_state.dart';

class DebtDetailPage extends StatelessWidget {
  final String debtId;

  const DebtDetailPage({
    super.key,
    required this.debtId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DetailDebtBloc(
        getDebtDetailUseCase: getIt(),
        markAsPaidUseCase: getIt(),
      )..add(LoadDebtDetailEvent(debtId)),
      child: const DebtDetailView(),
    );
  }
}

class DebtDetailView extends StatelessWidget {
  const DebtDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        backgroundColor: AppColor.white,
        elevation: 0,
        title: Text(
          'Detail Utang',
          style: AppTextStyles.h5.copyWith(
            color: AppColor.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          BlocBuilder<DetailDebtBloc, DetailDebtState>(
            builder: (context, state) {
              if (state is! DetailDebtLoaded) return const SizedBox();

              return IconButton(
                icon: const Icon(Icons.edit_outlined, color: AppColor.textPrimary),
                onPressed: () {
                  context.push('${AppRoutes.editDebt}/${state.debt.id}');
                },
              );
            },
          ),
        ],
      ),
      body: BlocConsumer<DetailDebtBloc, DetailDebtState>(
        listener: (context, state) {
          if (state is DetailDebtActionSuccess) {
            D2YToast.success(context, state.message);
            context.read<DebtBloc>().add(LoadDebts());
          } else if (state is DetailDebtError) {
            D2YToast.error(context, state.message);
          }
        },
        builder: (context, state) {
          if (state is DetailDebtLoading) {
            return D2YLoading.center(message: 'Memuat detail...');
          }

          if (state is DetailDebtError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 64,
                    color: AppColor.error,
                  ),
                  const SizedBox(height: AppConstants.spaceLG),
                  Text(
                    state.message,
                    style: AppTextStyles.bodyLarge,
                  ),
                ],
              ),
            );
          }

          if (state is DetailDebtLoaded) {
            return _buildContent(context, state.debt);
          }

          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context, Debt debt) {
    final isLunas = debt.status == DebtStatus.lunas;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Payment Info Card
          PaymentInfoCard(debt: debt),

          DetailSectionTitle("Informasi Utang"),
          DebtInfoCard(debt:debt),

          const SizedBox(height: AppConstants.spaceLG),

          DetailSectionTitle("Catatan"),
          DetailNoteCard(note: debt.note),

          const SizedBox(height: AppConstants.spaceXXXL),

          // Action Buttons
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.paddingLG,
            ),
            child: Column(
              children: [
                if (!isLunas)
                  D2YButton(
                    label: 'Tandai Lunas',
                    icon: Icons.check_circle_outline,
                    onPressed: () {
                      _showMarkAsPaidConfirmation(context, debt.id);
                    },
                    fullWidth: true,
                    type: D2YButtonType.elevated,
                  ),

                const SizedBox(height: AppConstants.spaceMD),

                D2YButton(
                  label: 'Set Reminder',
                  icon: Icons.notifications_active,
                  onPressed: () {
                    context.push('/set/reminder/${debt.id}');
                  },
                  fullWidth: true,
                  type: D2YButtonType.outlined,
                ),
                const SizedBox(height: AppConstants.spaceXXL),
              ],
            )
          ),

          const SizedBox(height: AppConstants.spaceXXL),
        ],
      ),
    );
  }

  Future<void> _showMarkAsPaidConfirmation(
    BuildContext context,
    String debtId,
  ) async {
    final confirmed = await D2YModal.confirm(
      context: context,
      title: 'Tandai Sebagai Lunas',
      message: 'Apakah Anda yakin utang ini sudah dilunasi?',
      confirmText: 'Ya, Lunas',
      cancelText: 'Batal',
    );

    if (confirmed == true) {
      // ignore: use_build_context_synchronously
      context.read<DetailDebtBloc>().add(
            MarkDebtAsPaid(debtId),
          );
    }
  }
}