import 'package:dalili_app/features/institutions/data/institution_details_mock_data.dart';
import 'package:dalili_app/features/institutions/data/model/institution_branch_model.dart';
import 'package:dalili_app/features/institutions/data/model/institution_transaction_model.dart';

class InstitutionDetailsRepository {
  final bool _useMockData = true;

  Future<List<InstitutionBranch>> getInstitutionBranches(String institutionId) async {
    // In a real app, you would fetch branches using API service based on institutionId
    // await _apiService.getBranches(institutionId);
    
    // Simulating network delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    if (_useMockData) {
      return InstitutionDetailsMockData.branches;
    } else {
      throw UnimplementedError('API not implemented yet');
    }
  }

  Future<List<InstitutionTransaction>> getInstitutionTransactions(String institutionId) async {
    // In a real app, you would fetch transactions using API service based on institutionId
    // await _apiService.getTransactions(institutionId);
    
    // Simulating network delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    if (_useMockData) {
      return InstitutionDetailsMockData.transactions;
    } else {
      throw UnimplementedError('API not implemented yet');
    }
  }
}
