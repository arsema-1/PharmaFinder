import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FC),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ------------------------------------------------
                    // TOP HEADER
                    // ------------------------------------------------
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          color: Color(0xFF00845A),
                          size: 18,
                        ),

                        const SizedBox(width: 5),

                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Current Location',
                                style: TextStyle(
                                  fontSize: 8,
                                  color: Color(0xFF66706E),
                                ),
                              ),
                              Text(
                                'Bole, Addis Ababa',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF202838),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const Text(
                          'PharmaFinder',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF00845A),
                          ),
                        ),

                        const Spacer(),

                        IconButton(
                          onPressed: () {},
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          icon: const Icon(
                            Icons.shopping_cart_outlined,
                            size: 20,
                            color: Color(0xFF394440),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // ------------------------------------------------
                    // SEARCH BAR
                    // ------------------------------------------------
                    Container(
                      height: 38,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color(0xFFD9DEDF),
                        ),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 12),

                          const Icon(
                            Icons.search,
                            size: 19,
                            color: Color(0xFF6C7674),
                          ),

                          const SizedBox(width: 8),

                          const Expanded(
                            child: Text(
                              'Search medicines, pharmacies...',
                              style: TextStyle(
                                fontSize: 10,
                                color: Color(0xFF858D8C),
                              ),
                            ),
                          ),

                          Container(
                            margin: const EdgeInsets.all(3),
                            width: 32,
                            height: 32,
                            decoration: const BoxDecoration(
                              color: Color(0xFF00845A),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.tune,
                              size: 17,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 10),

                    // ------------------------------------------------
                    // MEDICINE / PHARMACY SWITCH
                    // ------------------------------------------------
                    Center(
                      child: Container(
                        width: 135,
                        height: 25,
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE5EAF8),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xFF00AA73),
                                  borderRadius:
                                  BorderRadius.circular(13),
                                ),
                                child: const Center(
                                  child: Text(
                                    'Medicines',
                                    style: TextStyle(
                                      fontSize: 9,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            Expanded(
                              child: GestureDetector(
                                onTap: () {},
                                child: const Center(
                                  child: Text(
                                    'Pharmacies',
                                    style: TextStyle(
                                      fontSize: 9,
                                      color: Color(0xFF283347),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 18),

                    // ------------------------------------------------
                    // AVAILABLE NEAR YOU
                    // ------------------------------------------------
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Expanded(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Available Near You',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1D2637),
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                'In stock at pharmacies within 2km',
                                style: TextStyle(
                                  fontSize: 9,
                                  color: Color(0xFF69716F),
                                ),
                              ),
                            ],
                          ),
                        ),

                        GestureDetector(
                          onTap: () {},
                          child: const Text(
                            'View All',
                            style: TextStyle(
                              fontSize: 9,
                              color: Color(0xFF00845A),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 9),

                    // ------------------------------------------------
                    // MEDICINE CARDS
                    // ------------------------------------------------
                    _medicineCard(
                      image: 'assets/images/paracetamol.png',
                      name: 'Paracetamol 500mg',
                      description: 'Tablets • 10 per pack',
                      price: '35 ETB',
                      distance: '0.8 km',
                      updated: 'Updated 20m ago',
                      stock: 'In stock',
                      stockColor: const Color(0xFF00845A),
                      stockBackground: const Color(0xFFD9F5E9),
                    ),

                    const SizedBox(height: 8),

                    _medicineCard(
                      image: 'assets/images/ibuprofen.png',
                      name: 'Ibuprofen Syrup',
                      description: 'Liquid • 100ml',
                      price: '85 ETB',
                      distance: '1.2 km',
                      updated: 'Updated 1h ago',
                      stock: 'In stock',
                      stockColor: const Color(0xFF00845A),
                      stockBackground: const Color(0xFFD9F5E9),
                    ),

                    const SizedBox(height: 8),

                    _medicineCard(
                      image: 'assets/images/vitamin_c.png',
                      name: 'Vitamin C 1000mg',
                      description: 'Effervescent • 20 tabs',
                      price: '150 ETB',
                      distance: '0.5 km',
                      updated: 'Updated 5m ago',
                      stock: 'Low stock',
                      stockColor: const Color(0xFF566E9C),
                      stockBackground: const Color(0xFFE8EEFC),
                    ),

                    const SizedBox(height: 18),

                    // ------------------------------------------------
                    // CATEGORIES
                    // ------------------------------------------------
                    const Text(
                      'Browse Categories',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1D2637),
                      ),
                    ),

                    const SizedBox(height: 9),

                    SizedBox(
                      height: 72,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          _categoryCard(
                            Icons.medical_services_outlined,
                            'Pain Relief',
                            const Color(0xFF00B77B),
                          ),

                          _categoryCard(
                            Icons.coronavirus_outlined,
                            'Cold & Flu',
                            const Color(0xFF62DCD3),
                          ),

                          _categoryCard(
                            Icons.medication_outlined,
                            'Vitamins',
                            const Color(0xFF79A8F5),
                          ),

                          _categoryCard(
                            Icons.spa_outlined,
                            'Digestive',
                            const Color(0xFFA98BEA),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ------------------------------------------------
            // BOTTOM NAVIGATION
            // ------------------------------------------------
            Container(
              height: 62,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(
                    color: Colors.grey.shade200,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceAround,
                children: [
                  _bottomItem(
                    Icons.home,
                    'Home',
                    true,
                  ),
                  _bottomItem(
                    Icons.grid_view_outlined,
                    'Browse',
                    false,
                  ),
                  _bottomItem(
                    Icons.favorite_border,
                    'Saved',
                    false,
                  ),
                  _bottomItem(
                    Icons.person_outline,
                    'Profile',
                    false,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==============================================================
  // MEDICINE CARD
  // ==============================================================

  static Widget _medicineCard({
    required String image,
    required String name,
    required String description,
    required String price,
    required String distance,
    required String updated,
    required String stock,
    required Color stockColor,
    required Color stockBackground,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(9),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(9),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Medicine image
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFFF0F2F1),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Image.asset(
                  image,
                  fit: BoxFit.contain,
                  errorBuilder:
                      (context, error, stackTrace) {
                    return const Icon(
                      Icons.medication_outlined,
                      color: Color(0xFF9AA29F),
                      size: 27,
                    );
                  },
                ),
              ),

              const SizedBox(width: 9),

              // Medicine information
              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E2737),
                      ),
                    ),

                    const SizedBox(height: 3),

                    Text(
                      description,
                      style: const TextStyle(
                        fontSize: 8,
                        color: Color(0xFF6E7775),
                      ),
                    ),

                    const SizedBox(height: 5),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: stockBackground,
                        borderRadius:
                        BorderRadius.circular(4),
                      ),
                      child: Text(
                        stock,
                        style: TextStyle(
                          fontSize: 7,
                          color: stockColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const Icon(
                Icons.favorite_border,
                size: 18,
                color: Color(0xFF71807B),
              ),
            ],
          ),

          const SizedBox(height: 7),

          const Divider(
            height: 1,
            color: Color(0xFFE9ECEC),
          ),

          const SizedBox(height: 6),

          Row(
            children: [
              Text(
                price,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF202A3A),
                ),
              ),

              const Spacer(),

              const Icon(
                Icons.location_on_outlined,
                size: 9,
                color: Color(0xFF66716E),
              ),

              const SizedBox(width: 2),

              Text(
                distance,
                style: const TextStyle(
                  fontSize: 7,
                  color: Color(0xFF69726F),
                ),
              ),

              const SizedBox(width: 4),

              const Text(
                '•',
                style: TextStyle(
                  fontSize: 7,
                  color: Color(0xFF69726F),
                ),
              ),

              const SizedBox(width: 4),

              Text(
                updated,
                style: const TextStyle(
                  fontSize: 7,
                  color: Color(0xFF69726F),
                ),
              ),

              const SizedBox(width: 7),

              Container(
                width: 18,
                height: 18,
                decoration: const BoxDecoration(
                  color: Color(0xFF00845A),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.add,
                  size: 13,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ==============================================================
  // CATEGORY CARD
  // ==============================================================

  static Widget _categoryCard(
      IconData icon,
      String title,
      Color iconColor,
      ) {
    return Container(
      width: 70,
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(7),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.18),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 15,
              color: const Color(0xFF007A59),
            ),
          ),

          const SizedBox(height: 5),

          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 7,
              color: Color(0xFF35403E),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // ==============================================================
  // BOTTOM NAVIGATION ITEM
  // ==============================================================

  static Widget _bottomItem(
      IconData icon,
      String title,
      bool selected,
      ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 19,
          color: selected
              ? const Color(0xFF00A874)
              : const Color(0xFF66706D),
        ),

        const SizedBox(height: 3),

        Text(
          title,
          style: TextStyle(
            fontSize: 8,
            color: selected
                ? const Color(0xFF00A874)
                : const Color(0xFF66706D),
            fontWeight:
            selected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}