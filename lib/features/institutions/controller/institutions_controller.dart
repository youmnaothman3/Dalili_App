import 'package:dalili_app/core/routes/route_class.dart';
import 'package:dalili_app/features/institutions/data/institutions_repository.dart';
import 'package:dalili_app/features/institutions/data/model/institution_model.dart';
import 'package:get/get.dart';

class InstitutionsController extends GetxController {
  final _repository = InstitutionsRepository();

  // State Management
  final institutions = RxList<Institution>([]);
  final locations = RxList<String>([]);
  final isLoading = RxBool(false);
  final hasError = RxBool(false);
  final errorMessage = RxString('');

  // Filters
  final selectedLocation = Rx<String?>('');
  final searchQuery = RxString('');

  @override
  void onInit() {
    super.onInit();
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    await Future.wait([_fetchInstitutions(), _fetchLocations()]);
  }

  Future<void> _fetchInstitutions() async {
    try {
      isLoading.value = true;
      hasError.value = false;

      final data = await _repository.getInstitutions(
        searchQuery: searchQuery.value.isNotEmpty ? searchQuery.value : null,
        location: selectedLocation.value?.isNotEmpty == true
            ? selectedLocation.value
            : null,
      );

      institutions.value = data;
    } catch (e) {
      hasError.value = true;
      errorMessage.value = 'حدث خطأ في تحميل البيانات: ${e.toString()}';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _fetchLocations() async {
    try {
      final data = await _repository.getLocations();
      locations.value = ['كل المحافظات', ...data];
    } catch (e) {
      errorMessage.value = 'خطأ في تحميل المحافظات';
    }
  }

  Future<void> onSearch(String query) async {
    searchQuery.value = query;
    await _fetchInstitutions();
  }

  Future<void> onLocationChanged(String? location) async {
    selectedLocation.value = location == 'كل المحافظات' ? '' : location;
    await _fetchInstitutions();
  }

  void onInstitutionTap(Institution institution) {
    Get.toNamed(Routes.institutionDetails, arguments: institution);
  }

  void clearFilters() async {
    searchQuery.value = '';
    selectedLocation.value = '';
    await _fetchInstitutions();
  }

  void retry() async {
    await _loadInitialData();
  }
}
