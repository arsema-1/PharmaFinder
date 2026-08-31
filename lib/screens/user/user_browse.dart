import 'package:flutter/material.dart';

class BrowseScreen extends StatefulWidget {
  const BrowseScreen({super.key});

  @override
  State<BrowseScreen> createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen> {
  int selectedCategory = 0;

  final TextEditingController searchController =
  TextEditingController();

  // =========================================================
  // CATEGORIES
  // =========================================================

  final List<Map<String, dynamic>> categories = [
    {
      'icon': '💊',
      'name': 'Pain Relief',
    },
    {
      'icon': '🤧',
      'name': 'Cold & Flu',
    },
    {
      'icon': '🦠',
      'name': 'Antibiotics',
    },
    {
      'icon': '🩺',
      'name': 'Vitamins',
    },
    {
      'icon': '❤️',
      'name': 'Chronic Care',
    },
    {
      'icon': '👶',
      'name': 'Baby Care',
    },
  ];

  // =========================================================
  // MEDICINES
  // =========================================================

  final List<Map<String, dynamic>> medicines = [
    {
      'name': 'Paracetamol 500mg',
      'description': 'Tablet • 10 per pack',
      'price': '35 ETB',
      'pharmacies': 'Avail. at 12 pharmacies',
      'icon': Icons.medication,
    },
    {
      'name': 'Amoxicillin 250mg',
      'description': 'Capsule • 15 per pack',
      'price': '80 ETB',
      'pharmacies': 'Avail. at 8 pharmacies',
      'icon': Icons.medication_liquid,
    },
    {
      'name': 'Vitamin C 1000mg',
      'description': 'Effervescent • 20 pack',
      'price': 'From 120 ETB',
      'pharmacies': 'Avail. at 15 pharmacies',
      'icon': Icons.health_and_safety,
    },
    {
      'name': 'Ibuprofen 400mg',
      'description': 'Tablet • 20 per pack',
      'price': '45 ETB',
      'pharmacies': 'Avail. at 10 pharmacies',
      'icon': Icons.medication,
    },
  ];

  // =========================================================
  // PHARMACIES
  // =========================================================

  final List<Map<String, dynamic>> pharmacies = [
    {
      'name': 'Bole Medhanealem Pharmacy',
      'rating': '4.8',
      'location': 'Bole, 1.2km',
      'status': 'Open now • Closes at 9 PM',
    },
    {
      'name': 'Piassa Central Drugstore',
      'rating': '4.5',
      'location': 'Piassa, 3.5km',
      'status': 'Open 24/7',
    },
  ];

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  // =========================================================
  // MAIN BUILD
  // =========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FF),

      // =====================================================
      // TOP APP BAR
      // =====================================================

      appBar: AppBar(
        backgroundColor: const Color(0xFFF9F9FF),
        elevation: 1,
        automaticallyImplyLeading: false,
        titleSpacing: 16,
        title: Row(
          children: [
            const Icon(
              Icons.location_on,
              color: Color(0xFF006C49),
            ),
            const SizedBox(width: 8),
            const Text(
              'PharmaFinder',
              style: TextStyle(
                color: Color(0xFF006C49),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              // Cart action
            },
            icon: const Icon(
              Icons.shopping_cart_outlined,
              color: Color(0xFF006C49),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),

      // =====================================================
      // BODY
      // =====================================================

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            16,
            20,
            16,
            100,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // =================================================
              // BROWSE TITLE
              // =================================================

              const Text(
                'Browse',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF141B2B),
                ),
              ),

              const SizedBox(height: 16),

              // =================================================
              // SEARCH BAR
              // =================================================

              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                        BorderRadius.circular(10),
                        border: Border.all(
                          color: const Color(0xFFBBCABF),
                        ),
                      ),
                      child: TextField(
                        controller: searchController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.search,
                            color: Color(0xFF6C7A71),
                          ),
                          hintText:
                          'Search medicines or pharmacies...',
                          hintStyle: TextStyle(
                            color: Color(0xFF6C7A71),
                            fontSize: 14,
                          ),
                          contentPadding:
                          EdgeInsets.symmetric(
                            vertical: 14,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 8),

                  // Filter button
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE9EDFF),
                      borderRadius:
                      BorderRadius.circular(10),
                      border: Border.all(
                        color: const Color(0xFFBBCABF),
                      ),
                    ),
                    child: IconButton(
                      onPressed: () {
                        // Filter action
                      },
                      icon: const Icon(
                        Icons.tune,
                        color: Color(0xFF141B2B),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // =================================================
              // BROWSE BY CATEGORY
              // =================================================

              const Text(
                'Browse by Category',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF141B2B),
                ),
              ),

              const SizedBox(height: 16),

              SizedBox(
                height: 45,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  separatorBuilder: (_, __) =>
                  const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    final category =
                    categories[index];

                    final isSelected =
                        selectedCategory == index;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedCategory = index;
                        });
                      },
                      child: Container(
                        padding:
                        const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFFE9EDFF)
                              : Colors.white,
                          borderRadius:
                          BorderRadius.circular(30),
                          border: Border.all(
                            color: isSelected
                                ? const Color(0xFF006C49)
                                : const Color(0xFFBBCABF),
                          ),
                        ),
                        child: Row(
                          children: [
                            Text(
                              category['icon'],
                              style:
                              const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              category['name'],
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight:
                                FontWeight.w500,
                                color: isSelected
                                    ? const Color(
                                  0xFF006C49,
                                )
                                    : const Color(
                                  0xFF141B2B,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 32),

              // =================================================
              // POPULAR MEDICINES
              // =================================================

              const Text(
                'Popular Medicines',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF141B2B),
                ),
              ),

              const SizedBox(height: 16),

              GridView.builder(
                shrinkWrap: true,
                physics:
                const NeverScrollableScrollPhysics(),
                itemCount: medicines.length,
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.68,
                ),
                itemBuilder: (context, index) {
                  return _medicineCard(
                    medicines[index],
                  );
                },
              ),

              const SizedBox(height: 32),

              // =================================================
              // BROWSE PHARMACIES
              // =================================================

              const Text(
                'Browse Pharmacies',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF141B2B),
                ),
              ),

              const SizedBox(height: 16),

              Column(
                children: pharmacies.map((pharmacy) {
                  return _pharmacyCard(pharmacy);
                }).toList(),
              ),

              const SizedBox(height: 32),

              // =================================================
              // RECENTLY UPDATED
              // =================================================

              const Text(
                'Recently Updated Availability',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF141B2B),
                ),
              ),

              const SizedBox(height: 16),

              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                  BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xFFE1E8FD),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color:
                      Colors.black.withOpacity(0.04),
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _updateItem(
                      medicine: 'Paracetamol 500mg',
                      pharmacy:
                      'Bole Medhanealem Pharmacy',
                      time: 'Updated 10 min ago',
                      isInStock: true,
                    ),

                    const Divider(
                      height: 1,
                      color: Color(0xFFE1E8FD),
                    ),

                    _updateItem(
                      medicine: 'Ibuprofen 400mg',
                      pharmacy:
                      'Kazanchis Pharmacy',
                      time: 'Updated 45 min ago',
                      isInStock: false,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      // =====================================================
      // BOTTOM NAVIGATION
      // =====================================================


    );
  }

  // =========================================================
  // MEDICINE CARD
  // =========================================================

  Widget _medicineCard(
      Map<String, dynamic> medicine) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.transparent,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [

          // Medicine image
          Expanded(
            flex: 5,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFE1E8FD),
                borderRadius:
                BorderRadius.circular(9),
              ),
              child: Icon(
                medicine['icon'],
                size: 65,
                color: const Color(0xFF006C49),
              ),
            ),
          ),

          const SizedBox(height: 10),

          Text(
            medicine['name'],
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF141B2B),
            ),
          ),

          const SizedBox(height: 3),

          Text(
            medicine['description'],
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF6C7A71),
            ),
          ),

          const SizedBox(height: 8),

          Text(
            medicine['price'],
            style: const TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: Color(0xFF006C49),
            ),
          ),

          const SizedBox(height: 3),

          Row(
            children: [
              const Icon(
                Icons.store_outlined,
                size: 14,
                color: Color(0xFF6C7A71),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  medicine['pharmacies'],
                  maxLines: 1,
                  overflow:
                  TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF6C7A71),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // Add button
          SizedBox(
            width: double.infinity,
            height: 40,
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context)
                    .showSnackBar(
                  SnackBar(
                    content: Text(
                      '${medicine['name']} added',
                    ),
                    duration:
                    const Duration(seconds: 1),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                const Color(0xFFE9EDFF),
                foregroundColor:
                const Color(0xFF006C49),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(9),
                ),
              ),
              child: const Text(
                'Add',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // PHARMACY CARD
  // =========================================================

  Widget _pharmacyCard(
      Map<String, dynamic> pharmacy) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [

          // Pharmacy icon
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: const Color(0xFFE1E8FD),
              borderRadius:
              BorderRadius.circular(9),
            ),
            child: const Icon(
              Icons.local_pharmacy,
              color: Color(0xFF006C49),
              size: 32,
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [

                Text(
                  pharmacy['name'],
                  maxLines: 1,
                  overflow:
                  TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF141B2B),
                  ),
                ),

                const SizedBox(height: 5),

                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      size: 16,
                      color: Color(0xFF006C49),
                    ),

                    const SizedBox(width: 3),

                    Text(
                      pharmacy['rating'],
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight:
                        FontWeight.w600,
                        color:
                        Color(0xFF006C49),
                      ),
                    ),

                    const SizedBox(width: 8),

                    Container(
                      width: 4,
                      height: 4,
                      decoration:
                      const BoxDecoration(
                        shape: BoxShape.circle,
                        color:
                        Color(0xFFBBCABF),
                      ),
                    ),

                    const SizedBox(width: 8),

                    Expanded(
                      child: Text(
                        pharmacy['location'],
                        style: const TextStyle(
                          fontSize: 12,
                          color:
                          Color(0xFF6C7A71),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 5),

                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration:
                      const BoxDecoration(
                        shape: BoxShape.circle,
                        color:
                        Color(0xFF10B981),
                      ),
                    ),

                    const SizedBox(width: 5),

                    Expanded(
                      child: Text(
                        pharmacy['status'],
                        style: const TextStyle(
                          fontSize: 12,
                          color:
                          Color(0xFF3C4A42),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          Container(
            width: 40,
            height: 40,
            decoration:
            const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFE9EDFF),
            ),
            child: const Icon(
              Icons.chevron_right,
              color: Color(0xFF006C49),
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // RECENTLY UPDATED ITEM
  // =========================================================

  Widget _updateItem({
    required String medicine,
    required String pharmacy,
    required String time,
    required bool isInStock,
  }) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [

          Container(
            width: 32,
            height: 32,
            decoration: const BoxDecoration(
              color: Color(0xFF86F2E4),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isInStock
                  ? Icons.check
                  : Icons.remove,
              size: 18,
              color: const Color(0xFF006A61),
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [

                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.4,
                      color: Color(0xFF141B2B),
                    ),
                    children: [
                      TextSpan(
                        text: medicine,
                        style:
                        const TextStyle(
                          fontWeight:
                          FontWeight.w600,
                        ),
                      ),

                      TextSpan(
                        text: isInStock
                            ? ' is now in stock at '
                            : ' is out of stock at ',
                      ),

                      TextSpan(
                        text: pharmacy,
                        style:
                        const TextStyle(
                          fontWeight:
                          FontWeight.w600,
                          color:
                          Color(0xFF006C49),
                        ),
                      ),

                      const TextSpan(
                        text: '.',
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  time,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF6C7A71),
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