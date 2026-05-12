import 'package:dalili_app/features/institutions/data/institutions_api_service.dart';
import 'package:dalili_app/features/institutions/data/institutions_mock_data.dart';
import 'package:dalili_app/features/institutions/model/institution_model.dart';

class InstitutionsRepository {
  final InstitutionsApiService _apiService = InstitutionsApiService();
  final bool _useMockData = true; // Switch to false when API is ready

  Future<List<Institution>> getInstitutions({
    String? searchQuery,
    String? location,
    int page = 1,
    int pageSize = 20,
  }) async {
    if (_useMockData) {
      return _getFilteredMockData(searchQuery, location);
    } else {
      return _apiService.getInstitutions(
        searchQuery: searchQuery,
        location: location,
        page: page,
        pageSize: pageSize,
      );
    }
  }

  Future<List<String>> getLocations() async {
    if (_useMockData) {
      return InstitutionsMockData.getLocations();
    } else {
      return _apiService.getLocations();
    }
  }

  List<Institution> _getFilteredMockData(
    String? searchQuery,
    String? location,
  ) {
    var institutions = InstitutionsMockData.getInstitutions();

    // Filter by search query
    if (searchQuery != null && searchQuery.isNotEmpty) {
      institutions = institutions
          .where(
            (inst) =>
                inst.name.contains(searchQuery) ||
                inst.ministry.contains(searchQuery) ||
                inst.description.contains(searchQuery),
          )
          .toList();
    }

    // Filter by location
    if (location != null && location.isNotEmpty) {
      institutions = institutions
          .where((inst) => inst.location == location)
          .toList();
    }

    return institutions;
  }
}
