import 'package:flutter/material.dart';
import 'package:grocery_app/core/constants/app_colors.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  final Map<String, bool> categories = {
    "ពងមាន់": true, // Eggs
    "នូដែល និង បាស្តា": false, // Noodles & Pasta
    "ចីប និង ក្រេស": false, // Chips & Crisps
    "អាហារលឿន": false, // Fast Food
  };

  final Map<String, bool> brands = {
    "Individual Collection": false,
    "Cocola": true,
    "Ifad": false,
    "Kazi Farmas": false,
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: const BoxDecoration(
        color: Color(0xFFF2F3F2),
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Column(
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
                const Expanded(
                  child: Center(
                    child: Text(
                      "ជ្រើសរើសតំរៀប", // Filters in Khmer
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'KhmerOS',
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 48),
              ],
            ),
          ),

          // Filter Options
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: ListView(
                children: [
                  const Text(
                    "ប្រភេទ", // Categories in Khmer
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'KhmerOS',
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildOptionGrid(categories),
                  const SizedBox(height: 30),
                  const Text(
                    "ម៉ាក", // Brands in Khmer
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'KhmerOS',
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildOptionGrid(brands),
                ],
              ),
            ),
          ),

          // Apply Button
          SafeArea(
            top: false, // only care about bottom inset
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    padding: EdgeInsets.zero,
                    backgroundColor: Colors.transparent,
                  ).copyWith(
                    shadowColor: MaterialStateProperty.all(Colors.transparent),
                  ),
                  child: Ink(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          AppColors.primaryAppColor,
                          Color(0xFF4A90E2),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: const Center(
                      child: Text(
                        "អនុវត្តតំរៀប", // Apply Filter in Khmer
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'KhmerOS',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionGrid(Map<String, bool> source) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: source.keys.map((key) {
        bool isSelected = source[key]!;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: isSelected
                ? const LinearGradient(
              colors: [AppColors.primaryAppColor, Color(0xFF4A90E2)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )
                : null,
            color: isSelected ? null : Colors.white,
            border: Border.all(
              color: isSelected ? Colors.transparent : Colors.grey.shade300,
            ),
            boxShadow: isSelected
                ? [
              BoxShadow(
                color: AppColors.primaryAppColor.withOpacity(0.3),
                blurRadius: 6,
                offset: const Offset(0, 3),
              )
            ]
                : [],
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () {
              setState(() {
                source[key] = !isSelected;
              });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              child: Text(
                key,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black87,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'KhmerOS',
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
