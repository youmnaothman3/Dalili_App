import 'package:dalili_app/core/constant/app_colors.dart';
import 'package:dalili_app/features/institutions/data/model/institution_branch_model.dart';
import 'package:flutter/material.dart';

class InstitutionBranchesTab extends StatefulWidget {
  final List<InstitutionBranch> branches;

  const InstitutionBranchesTab({
    Key? key,
    required this.branches,
  }) : super(key: key);

  @override
  State<InstitutionBranchesTab> createState() => _InstitutionBranchesTabState();
}

class _InstitutionBranchesTabState extends State<InstitutionBranchesTab> {
  String _searchQuery = '';
  String? _selectedLocation;
  List<String> _locations = [];

  @override
  void initState() {
    super.initState();
    _updateLocations();
  }

  void _updateLocations() {
    _locations = ['كل المحافظات'];
    _locations.addAll(widget.branches.map((e) => e.location).toSet().toList());
  }

  List<InstitutionBranch> get _filteredBranches {
    return widget.branches.where((branch) {
      final matchesSearch = branch.name.contains(_searchQuery) ||
          branch.address.contains(_searchQuery) ||
          branch.location.contains(_searchQuery);
      
      final matchesLocation = _selectedLocation == null ||
          _selectedLocation == 'كل المحافظات' ||
          branch.location == _selectedLocation;

      return matchesSearch && matchesLocation;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filteredList = _filteredBranches;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        children: [
          // Search Bar
          _buildSearchBar(),
          const SizedBox(height: 12),
          
          // Location Filter
          _buildLocationFilter(),
          const SizedBox(height: 20),
          
          // Branches List
          if (filteredList.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 32),
              child: Center(
                child: Text(
                  'لم يتم العثور على أفرع',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 14,
                  ),
                ),
              ),
            )
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: filteredList.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                return _buildBranchCard(filteredList[index]);
              },
            ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 14,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: TextField(
        onChanged: (value) => setState(() => _searchQuery = value),
        textDirection: TextDirection.rtl,
        decoration: InputDecoration(
          hintText: 'ابحث عن فرع',
          hintTextDirection: TextDirection.rtl,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 14,
          ),
          suffixIcon: Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Icon(Icons.search, color: AppColors.primary, size: 20),
          ),
          suffixIconConstraints: const BoxConstraints(
            minWidth: 48,
            minHeight: 48,
          ),
        ),
        style: const TextStyle(fontSize: 14, color: AppColors.textPrimary),
      ),
    );
  }

  Widget _buildLocationFilter() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 14,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: DropdownButton<String>(
          underline: const SizedBox(),
          isExpanded: true,
          borderRadius: BorderRadius.circular(28),
          value: _selectedLocation ?? 'كل المحافظات',
          items: _locations
              .map(
                (location) => DropdownMenuItem<String>(
                  value: location,
                  child: Row(
                    children: [
                      const Icon(
                        Icons.filter_alt_outlined,
                        size: 18,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        location,
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
          onChanged: (value) => setState(() => _selectedLocation = value),
          selectedItemBuilder: (BuildContext context) {
            return _locations
                .map<Widget>(
                  (item) => Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Text(
                          item,
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.textPrimary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Icon(
                        Icons.filter_alt_outlined,
                        size: 18,
                        color: AppColors.textSecondary,
                      ),
                    ],
                  ),
                )
                .toList();
          },
        ),
      ),
    );
  }

  Widget _buildBranchCard(InstitutionBranch branch) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Left side (Arrow icon)
          const Icon(
            Icons.arrow_back_ios_new,
            size: 16,
            color: AppColors.textSecondary,
          ),
          
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      branch.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${branch.transactionsCount} معاملات',
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(
                          Icons.article_outlined,
                          size: 14,
                          color: AppColors.textSecondary,
                        ),
                        const SizedBox(width: 16),
                        Text(
                          branch.location,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(
                          Icons.location_on_outlined,
                          size: 14,
                          color: AppColors.textSecondary,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(width: 16),
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    Icons.account_balance,
                    size: 28,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
