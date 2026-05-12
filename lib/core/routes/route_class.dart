import 'package:dalili_app/features/home/view/home_view.dart';
import 'package:dalili_app/features/institutions/view/institutions_view.dart';
import 'package:dalili_app/features/sign_in/data/sign_in_data.dart';
import 'package:dalili_app/features/sign_in/view/sign_in_view.dart';
import 'package:dalili_app/features/sign_up/data/sign_up_data.dart';
import 'package:dalili_app/features/sign_up/view/sign_up_view.dart';
import 'package:get/get.dart';

abstract class Routes {
  static const signup = '/signup';
  static const signIn = '/signin';
  static const home = '/home';
  static const institutions = '/institutions';
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

    // GetPage(
    //   name: Routes.roleSelection,
    //   page: () => const RoleSelectionView(),
    //   binding: RoleSelectionBinding(),
    // TODO: StaffLogin,
  ];
}
