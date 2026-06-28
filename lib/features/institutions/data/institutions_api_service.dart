import 'package:dalili_app/features/institutions/data/model/institution_model.dart';

class InstitutionsApiService {
  // This service is designed for future API integration
  // Currently returns mock data, but structure is ready for real API

  Future<List<Institution>> getInstitutions({
    String? searchQuery,
    String? location,
    int page = 1,
    int pageSize = 20,
  }) async {
    // Simulating API call delay
    await Future.delayed(const Duration(milliseconds: 800));

    // In a real scenario, this would make an HTTP request:
    // final response = await http.get(
    //   Uri.parse('$_baseUrl/institutions').replace(
    //     queryParameters: {
    //       'search': searchQuery,
    //       'location': location,
    //       'page': page.toString(),
    //       'pageSize': pageSize.toString(),
    //     },
    //   ),
    // );
    // return _handleResponse(response);

    // For now, return mock data
    throw UnimplementedError('Use InstitutionsRepository instead');
  }

  Future<List<String>> getLocations() async {
    // Simulating API call delay
    await Future.delayed(const Duration(milliseconds: 500));

    // In a real scenario: final response = await http.get(...);
    throw UnimplementedError('Use InstitutionsRepository instead');
  }
}
