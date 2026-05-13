import 'package:dalili_app/core/constant/app_colors.dart';
import 'package:dalili_app/features/institutions/model/institution_model.dart';
import 'package:dalili_app/features/institutions/view/widgets/info_section_card.dart';
import 'package:flutter/material.dart';

class InstitutionInfoTab extends StatelessWidget {
  final Institution institution;

  const InstitutionInfoTab({Key? key, required this.institution}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InfoSectionCard(
            title: 'نبذة عن المؤسسة',
            icon: Icons.article_outlined,
            content: Text(
              institution.shortDescription,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 16),
          InfoSectionCard(
            title: 'أوقات الدوام',
            icon: Icons.access_time,
            content: Text(
              institution.workingHours,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          const SizedBox(height: 16),
          InfoSectionCard(
            title: 'العنوان',
            icon: Icons.location_on_outlined,
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  institution.address,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  onPressed: () {
                    // Copy to clipboard functionality
                  },
                  icon: const Icon(Icons.copy, size: 16),
                  label: const Text('نسخ العنوان'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primary,
                    side: const BorderSide(color: AppColors.primary),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          InfoSectionCard(
            title: 'معلومات التواصل',
            icon: Icons.phone_in_talk_outlined,
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (institution.phone.isNotEmpty)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        institution.phone,
                        textDirection: TextDirection.ltr,
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.phone, size: 16, color: AppColors.textSecondary),
                    ],
                  ),
                if (institution.phone.isNotEmpty && institution.email.isNotEmpty)
                  const SizedBox(height: 8),
                if (institution.email.isNotEmpty)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        institution.email,
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.email_outlined, size: 16, color: AppColors.textSecondary),
                    ],
                  ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          InfoSectionCard(
            title: 'ملاحظات',
            icon: Icons.note_alt_outlined,
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 6),
                      child: Icon(Icons.circle, size: 6, color: AppColors.primary),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'يرجى إحضار الوثائق الأصلية عند مراجعة المديرية.',
                        style: const TextStyle(fontSize: 14, color: AppColors.textSecondary),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 6),
                      child: Icon(Icons.circle, size: 6, color: AppColors.primary),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'خدمة الاستعلام متاحة خلال أوقات الدوام الرسمي فقط.',
                        style: const TextStyle(fontSize: 14, color: AppColors.textSecondary),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          InfoSectionCard(
            title: 'الموقع على الخريطة',
            icon: Icons.map_outlined,
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.location_on,
                      size: 48,
                      color: AppColors.primary.withOpacity(0.5),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.near_me_outlined, size: 18),
                  label: const Text('عرض الموقع على الخريطة'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primary,
                    side: const BorderSide(color: AppColors.primary),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
