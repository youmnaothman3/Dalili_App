import 'package:dalili_app/features/feedback/bindings/feedback_binding.dart';
import 'package:dalili_app/features/feedback/view/feedback_view.dart';
import 'package:dalili_app/features/home/view/home_view.dart';
import 'package:dalili_app/features/institutions/bindings/institution_details_binding.dart';
import 'package:dalili_app/features/institutions/view/institution_details_view.dart';
import 'package:dalili_app/features/institutions/view/institutions_view.dart';
import 'package:dalili_app/features/my_transactions/bindings/my_transactions_binding.dart';
import 'package:dalili_app/features/my_transactions/view/my_transactions_view.dart';
import 'package:dalili_app/features/offices/bindings/office_binding.dart';
import 'package:dalili_app/features/offices/view/office_details_view.dart';
import 'package:dalili_app/features/sign_in/view/sign_in_view.dart';
import 'package:dalili_app/features/sign_up/view/sign_up_view.dart';
import 'package:dalili_app/features/stages/bindings/stage_binding.dart';
import 'package:dalili_app/features/stages/view/stage_details_view.dart';
import 'package:dalili_app/features/transactions/bindings/transactions_binding.dart';
import 'package:dalili_app/features/transactions/data/model/transaction_model.dart';
import 'package:dalili_app/features/transactions/view/transaction_details_view.dart';
import 'package:dalili_app/features/transactions/view/transactions_view.dart';
import 'package:get/get.dart';

abstract class Routes {
  static const signup = '/signup';
  static const signIn = '/signin';
  static const home = '/home';
  static const institutions = '/institutions';
  static const institutionDetails = '/institutions/details';
  static const transactions = '/transactions';
  static const transactionDetails = '/transactions/details';
  static const stageDetails = '/transactions/stage';
  static const officeDetails = '/transactions/office';
  static const myTransactions = '/my-transactions';
  static const feedback = '/feedback';
}

class AppPages {
  static final pages = <GetPage>[
    GetPage(
      name: '/signin',
      page: () => const SignInView(),
      // binding: SignInBinding(),
    ),
    GetPage(
      name: '/signup',
      page: () => const RegisterView(),
      // binding: SignUpBinding(),
    ),
    GetPage(
      name: Routes.home,
      page: () => const HomeView(),
      // binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.institutions,
      page: () => const InstitutionsView(),
      // binding: InstitutionsBinding(),
    ),
    GetPage(
      name: Routes.institutionDetails,
      page: () => const InstitutionDetailsView(),
      binding: InstitutionDetailsBinding(),
    ),
    GetPage(
      name: Routes.transactions,
      page: () => const TransactionsView(),
      binding: TransactionsBinding(),
    ),
    GetPage(
      name: Routes.transactionDetails,
      page: () {
        final transaction = Get.arguments as TransactionModel;
        return TransactionDetailsView(transaction: transaction);
      },
    ),
    GetPage(
      name: Routes.stageDetails,
      page: () => const StageDetailsView(),
      binding: StageBinding(),
    ),
    GetPage(
      name: Routes.officeDetails,
      page: () => const OfficeDetailsView(),
      binding: OfficeBinding(),
    ),
    GetPage(
      name: Routes.myTransactions,
      page: () => const MyTransactionsView(),
      binding: MyTransactionsBinding(),
    ),
    GetPage(
      name: Routes.feedback,
      page: () => const FeedbackView(),
      binding: FeedbackBinding(),
    ),

    // GetPage(
    //   name: Routes.roleSelection,
    //   page: () => const RoleSelectionView(),
    //   binding: RoleSelectionBinding(),
    // TODO: StaffLogin,
  ];
}
