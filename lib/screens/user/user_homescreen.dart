import 'package:flutter/material.dart';
import 'package:pharmfinderr/screens/user/pharmacy_detail_screen.dart';
import 'medicine_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // false = Medicines
  // true = Pharmacies
  bool showPharmacies = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FC),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(9, 8, 9, 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ============================================================
              // LOCATION HEADER
              // ============================================================
              Row(
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    color: Color(0xFF00845A),
                    size: 18,
                  ),

                  const SizedBox(width: 4),

                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Current Location',
                          style: TextStyle(
                            fontSize: 8,
                            color: Color(0xFF6B7472),
                          ),
                        ),

                        Text(
                          'Bole, Addis Ababa',
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF202838),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Text(
                    'PharmaFinder',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF007A59),
                    ),
                  ),

                  const SizedBox(width: 15),

                  const Icon(
                    Icons.shopping_cart_outlined,
                    size: 20,
                    color: Color(0xFF394440),
                  ),
                ],
              ),

              const SizedBox(height: 13),

              // ============================================================
              // SEARCH BAR
              // ============================================================
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 36,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: const Color(0xFFD1D8D6)),
                      ),

                      child: const Row(
                        children: [
                          SizedBox(width: 10),

                          Icon(
                            Icons.search,
                            size: 17,
                            color: Color(0xFF68736F),
                          ),

                          SizedBox(width: 7),

                          Expanded(
                            child: Text(
                              'Search medicines, pharmacies...',
                              style: TextStyle(
                                fontSize: 10,
                                color: Color(0xFF7A8381),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(width: 7),

                  Container(
                    height: 36,
                    width: 36,
                    decoration: BoxDecoration(
                      color: const Color(0xFF007A59),
                      borderRadius: BorderRadius.circular(18),
                    ),

                    child: const Icon(
                      Icons.tune,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              // ============================================================
              // MEDICINES / PHARMACIES SWITCH
              // ============================================================
              Center(
                child: Container(
                  height: 25,
                  width: 153,
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE2E7FA),
                    borderRadius: BorderRadius.circular(15),
                  ),

                  child: Row(
                    children: [
                      Expanded(
                        child: _toggleButton('Medicines', !showPharmacies, () {
                          setState(() {
                            showPharmacies = false;
                          });
                        }),
                      ),

                      Expanded(
                        child: _toggleButton('Pharmacies', showPharmacies, () {
                          setState(() {
                            showPharmacies = true;
                          });
                        }),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 18),

              // ============================================================
              // HEADER
              // ============================================================
              Row(
                children: [
                  Expanded(
                    child: Text(
                      showPharmacies
                          ? 'Pharmacies Near You'
                          : 'Available Near You',

                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF202838),
                      ),
                    ),
                  ),

                  GestureDetector(
                    onTap: () {},
                    child: const Text(
                      'View All',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF00845A),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 2),

              Text(
                showPharmacies
                    ? 'Pharmacies available within 2km'
                    : 'In stock at pharmacies within 2km',

                style: const TextStyle(fontSize: 12, color: Color(0xFF59625F)),
              ),

              const SizedBox(height: 9),

              // ============================================================
              // CONTENT
              // ============================================================
              if (!showPharmacies) ...[
                _medicineCard(
                  image: 'assets/images/paracetamol.jpg',
                  name: 'Paracetamol 500mg',
                  type: 'Tablets • 10 per pack',
                  stock: 'In stock',
                  price: '35 ETB',
                  distance: '0.8 km',
                  updated: '20m ago',
                ),

                const SizedBox(height: 5),

                _medicineCard(
                  image: 'assets/images/ibuprofen.jpg',
                  name: 'Ibuprofen Syrup',
                  type: 'Liquid • 100ml',
                  stock: 'In stock',
                  price: '85 ETB',
                  distance: '1.2 km',
                  updated: '1h ago',
                ),

                const SizedBox(height: 9),

                _browseCategories(),
              ] else ...[
                GestureDetector(
                  onTap:
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (_) => const PharmacyDetailScreen(
                                name: 'ABC Pharmacy',
                                image: 'assets/images/pharmacy1.jpg',
                                rating: '4.8',
                                reviewCount: '124',
                                address: 'Bole Road, Addis Ababa',
                                distance: '0.8 km',
                                status: 'Open now',
                                closingTime: '10:00 PM',
                              ),
                        ),
                      ),
                  child: _pharmacyCard(
                    image: 'assets/images/pharmacy1.jpg',
                    name: 'ABC Pharmacy',
                    rating: '4.8',
                    distance: '0.8 km',
                    status: 'Open Now',
                  ),
                ),

                const SizedBox(height: 9),

                GestureDetector(
                  onTap:
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (_) => const PharmacyDetailScreen(
                                name: 'HealthFirst Pharmacy',
                                image: 'assets/images/pharmacy1.jpg',
                                rating: '4.5',
                                reviewCount: '87',
                                address: 'Mexico Square, Addis Ababa',
                                distance: '1.2 km',
                                status: 'Open now',
                                closingTime: '9:00 PM',
                              ),
                        ),
                      ),
                  child: _pharmacyCard(
                    image: 'assets/images/pharmacy1.jpg',
                    name: 'HealthFirst Pharmacy',
                    rating: '4.5',
                    distance: '1.2 km',
                    status: 'Open Now',
                  ),
                ),

                const SizedBox(height: 9),
              ],
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // TOGGLE BUTTON
  // ============================================================

  Widget _toggleButton(String label, bool selected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,

      child: Container(
        height: double.infinity,
        alignment: Alignment.center,

        decoration: BoxDecoration(
          color: selected ? const Color(0xFF00A875) : Colors.transparent,

          borderRadius: BorderRadius.circular(13),
        ),

        child: Text(
          label,
          style: TextStyle(
            fontSize: 9,
            fontWeight: FontWeight.w600,
            color: selected ? Colors.white : const Color(0xFF24303B),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // MEDICINE CARD
  // ============================================================

  Widget _medicineCard({
    required String image,
    required String name,
    required String type,
    required String stock,
    required String price,
    required String distance,
    required String updated,
    bool lowStock = false,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const MedicineDetailsScreen(),
          ),
        );
      },

      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // IMAGE + FAVORITE
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    image,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),

                const Spacer(),

                const Icon(
                  Icons.favorite_border,
                  size: 22,
                  color: Color(0xFF66716D),
                ),
              ],
            ),

            const SizedBox(height: 10),

            Text(
              name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF202838),
              ),
            ),

            const SizedBox(height: 3),

            Text(
              type,
              style: const TextStyle(fontSize: 12, color: Color(0xFF69726F)),
            ),

            const SizedBox(height: 8),

            // STOCK
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color:
                    lowStock
                        ? const Color(0xFFE7EBF5)
                        : const Color(0xFFD9F6EA),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    lowStock
                        ? Icons.warning_amber_rounded
                        : Icons.check_circle_outline,
                    size: 12,
                    color:
                        lowStock
                            ? const Color(0xFF59616A)
                            : const Color(0xFF00845A),
                  ),

                  const SizedBox(width: 4),

                  Text(
                    stock,
                    style: TextStyle(
                      fontSize: 11,
                      color:
                          lowStock
                              ? const Color(0xFF59616A)
                              : const Color(0xFF00845A),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            const Divider(height: 1, color: Color(0xFFE5E8E7)),

            const SizedBox(height: 10),

            // PRICE + ADD
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        price,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF202838),
                        ),
                      ),

                      const SizedBox(height: 2),

                      Row(
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
                            size: 11,
                            color: Color(0xFF68736F),
                          ),

                          const SizedBox(width: 3),

                          Text(
                            '$distance • Updated $updated',
                            style: const TextStyle(
                              fontSize: 11,
                              color: Color(0xFF68736F),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                Container(
                  width: 32,
                  height: 32,
                  decoration: const BoxDecoration(
                    color: Color(0xFF00845A),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.add, size: 20, color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // PHARMACY CARD
  // ============================================================

  Widget _pharmacyCard({
    required String image,
    required String name,
    required String rating,
    required String distance,
    required String status,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ============================================================
          // PHARMACY IMAGE
          // ============================================================
          ClipRRect(
            borderRadius: BorderRadius.circular(8),

            child: Image.asset(image, width: 88, height: 88, fit: BoxFit.cover),
          ),

          const SizedBox(width: 12),
          // ============================================================
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // NAME + HEART
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,

                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF202838),
                        ),
                      ),
                    ),

                    const SizedBox(width: 4),

                    const Icon(
                      Icons.favorite_border,
                      size: 22,
                      color: Color(0xFF66716D),
                    ),
                  ],
                ),

                const SizedBox(height: 5),

                // RATING + DISTANCE
                Row(
                  children: [
                    const Icon(Icons.star, size: 14, color: Color(0xFFFFB400)),

                    const SizedBox(width: 3),

                    Text(
                      rating,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF53605C),
                      ),
                    ),

                    const SizedBox(width: 8),

                    const Icon(
                      Icons.location_on_outlined,
                      size: 14,
                      color: Color(0xFF53605C),
                    ),

                    const SizedBox(width: 3),

                    Flexible(
                      child: Text(
                        distance,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF53605C),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 4),

                // STATUS
                Text(
                  status,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF00845A),
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 8),

                // ========================================================
                // BUTTONS
                // ========================================================
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 32,

                        child: OutlinedButton.icon(
                          onPressed: () {},

                          icon: const Icon(Icons.phone_outlined, size: 13),

                          label: const Text(
                            'Call',
                            style: TextStyle(fontSize: 11),
                          ),

                          style: OutlinedButton.styleFrom(
                            foregroundColor: const Color(0xFF00845A),

                            side: const BorderSide(color: Color(0xFF00845A)),

                            padding: EdgeInsets.zero,

                            minimumSize: Size.zero,

                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7),
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 6),

                    Expanded(
                      child: SizedBox(
                        height: 32,

                        child: ElevatedButton.icon(
                          onPressed: () {},

                          icon: const Icon(Icons.directions_outlined, size: 13),

                          label: const Text(
                            'Directions',
                            style: TextStyle(fontSize: 11),
                          ),

                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF007A59),

                            foregroundColor: Colors.white,

                            elevation: 0,

                            padding: EdgeInsets.zero,

                            minimumSize: Size.zero,

                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // BROWSE CATEGORIES
  // ============================================================

  Widget _browseCategories() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Browse Categories',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF202838),
          ),
        ),

        const SizedBox(height: 9),

        SizedBox(
          height: 88,

          child: ListView(
            scrollDirection: Axis.horizontal,

            children: [
              _category(Icons.medical_services_outlined, 'Pain Relief'),

              _category(Icons.air, 'Cold & Flu'),

              _category(Icons.local_pharmacy_outlined, 'Vitamins'),

              _category(Icons.favorite_border, 'Heart'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _category(IconData icon, String title) {
    return Container(
      width: 95,
      margin: const EdgeInsets.only(right: 10),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 36,
            height: 36,

            decoration: const BoxDecoration(
              color: Color(0xFFD9F6EA),
              shape: BoxShape.circle,
            ),

            child: Icon(icon, size: 20, color: Color(0xFF00845A)),
          ),

          const SizedBox(height: 6),

          Text(
            title,
            style: const TextStyle(fontSize: 11, color: Color(0xFF36413D)),
          ),
        ],
      ),
    );
  }
}
