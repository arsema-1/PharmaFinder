import 'package:flutter/material.dart';

class MedicineDetailsScreen extends StatelessWidget {
  const MedicineDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8FF),

      // ---------------- APP BAR ----------------

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,

        leading: const Icon(
          Icons.arrow_back,
          color: Colors.grey,
        ),

        title: const Text(
          'PharmaFinder',
          style: TextStyle(
            color: Color(0xFF00845A),
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),

        centerTitle: true,

        actions: const [
          Icon(
            Icons.shopping_cart_outlined,
            color: Colors.grey,
          ),
          SizedBox(width: 12),
        ],
      ),

      // ---------------- BODY ----------------

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              // -------- MEDICINE IMAGE --------

              Container(
                width: double.infinity,
                height: 168,

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),

                child: Center(
                  child: Image.asset(
                    'assets/images/paracetamol.jpg',
                    width: 180,
                    height: 120,
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // -------- TAGS --------

              Row(
                children: [

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),

                    decoration: BoxDecoration(
                      color: const Color(0xFFE8E8F2),
                      borderRadius: BorderRadius.circular(10),
                    ),

                    child: const Text(
                      'Tablets',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey,
                      ),
                    ),
                  ),

                  const SizedBox(width: 6),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),

                    decoration: BoxDecoration(
                      color: const Color(0xFFB8F0D5),
                      borderRadius: BorderRadius.circular(10),
                    ),

                    child: const Row(
                      children: [
                        Icon(
                          Icons.circle,
                          size: 6,
                          color: Color(0xFF00845A),
                        ),

                        SizedBox(width: 4),

                        Text(
                          'In Stock',
                          style: TextStyle(
                            fontSize: 10,
                            color: Color(0xFF00845A),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 5),

              // -------- MEDICINE NAME --------

              const Text(
                'Paracetamol 500mg',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF30303A),
                ),
              ),

              const Text(
                '35 ETB',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF00845A),
                ),
              ),

              const SizedBox(height: 5),

              // -------- PRESCRIPTION / OTC --------

              Row(
                children: [

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),

                    decoration: BoxDecoration(
                      color: const Color(0xFFE5E5E5),
                      borderRadius: BorderRadius.circular(12),
                    ),

                    child: const Text(
                      'prescription',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey,
                      ),
                    ),
                  ),

                  const SizedBox(width: 8),

                  Container(
                    width: 60,
                    padding: const EdgeInsets.symmetric(
                      vertical: 4,
                    ),

                    decoration: BoxDecoration(
                      color: const Color(0xFFB8E3A8),
                      borderRadius: BorderRadius.circular(12),
                    ),

                    alignment: Alignment.center,

                    child: const Text(
                      'OTC',
                      style: TextStyle(
                        fontSize: 10,
                        color: Color(0xFF4C9740),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 7),

              // -------- FILTERS --------

              Row(
                children: [

                  _filterButton('Form', 48),

                  const SizedBox(width: 6),

                  _filterButton('Strength', 65),

                  const SizedBox(width: 6),

                  _filterButton('Size', 65),
                ],
              ),

              const SizedBox(height: 12),

              // -------- DESCRIPTION --------

              const Text(
                'Commonly used for the relief of mild to\n'
                    'moderate pain and fever.',
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey,
                  height: 1.4,
                ),
              ),

              const SizedBox(height: 8),

              // -------- ADD TO CART --------

              SizedBox(
                width: double.infinity,
                height: 34,

                child: ElevatedButton.icon(
                  onPressed: () {},

                  icon: const Icon(
                    Icons.shopping_cart_outlined,
                    size: 15,
                  ),

                  label: const Text(
                    'Add to Cart',
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),

                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00845A),
                    foregroundColor: Colors.white,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),

                    elevation: 0,
                  ),
                ),
              ),

              const SizedBox(height: 8),

              // -------- PHARMACIES TITLE --------

              const Text(
                'Available at nearby\npharmacies',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF30303A),
                  height: 1.2,
                ),
              ),

              const SizedBox(height: 10),

              // -------- PHARMACY 1 --------

              const PharmacyCard(
                name: 'ABC Pharmacy',
                price: '35 ETB',
                distance: '0.8 km',
                updated: '15 min',
              ),

              const SizedBox(height: 8),

              // -------- PHARMACY 2 --------

              const PharmacyCard(
                name: 'Health Pharmacy',
                price: '38 ETB',
                distance: '1.2 km',
                updated: '2 hours',
              ),

              const SizedBox(height: 10),
            ],
          ),
        ),
      ),

      // ---------------- BOTTOM NAVIGATION ----------------

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,

        selectedItemColor: const Color(0xFF00845A),
        unselectedItemColor: Colors.grey,

        type: BottomNavigationBarType.fixed,

        items: const [

          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Browse',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'Saved',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  // ---------------- FILTER BUTTON ----------------

  Widget _filterButton(String text, double width) {
    return Container(
      width: width,

      padding: const EdgeInsets.symmetric(
        vertical: 5,
      ),

      decoration: BoxDecoration(
        color: const Color(0xFFAFC2FF),
        borderRadius: BorderRadius.circular(10),
      ),

      alignment: Alignment.center,

      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
        ),
      ),
    );
  }
}

// ======================================================
// PHARMACY CARD
// ======================================================

class PharmacyCard extends StatelessWidget {
  final String name;
  final String price;
  final String distance;
  final String updated;

  const PharmacyCard({
    super.key,
    required this.name,
    required this.price,
    required this.distance,
    required this.updated,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(10),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          // Pharmacy name

          Row(
            children: [

              Text(
                name,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(width: 4),

              const Icon(
                Icons.verified,
                color: Color(0xFF00845A),
                size: 13,
              ),
            ],
          ),

          const SizedBox(height: 2),

          // Stock + distance

          Row(
            children: [

              const Icon(
                Icons.circle,
                size: 7,
                color: Color(0xFF00A86B),
              ),

              const SizedBox(width: 4),

              const Text(
                'In stock',
                style: TextStyle(
                  fontSize: 9,
                  color: Color(0xFF00845A),
                ),
              ),

              const SizedBox(width: 6),

              const Icon(
                Icons.location_on_outlined,
                size: 11,
                color: Colors.grey,
              ),

              Text(
                distance,
                style: const TextStyle(
                  fontSize: 9,
                  color: Colors.grey,
                ),
              ),
            ],
          ),

          const SizedBox(height: 3),

          Text(
            'Updated $updated ago',
            style: const TextStyle(
              fontSize: 8,
              color: Colors.grey,
            ),
          ),

          const SizedBox(height: 2),

          // Price

          Text(
            price,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 7),

          // Buttons

          Row(
            children: [

              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},

                  icon: const Icon(
                    Icons.phone,
                    size: 13,
                  ),

                  label: const Text(
                    'Call',
                    style: TextStyle(
                      fontSize: 9,
                    ),
                  ),

                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF00845A),

                    side: const BorderSide(
                      color: Color(0xFF00845A),
                    ),

                    minimumSize: const Size(0, 30),

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 6),

              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},

                  icon: const Icon(
                    Icons.directions,
                    size: 13,
                  ),

                  label: const Text(
                    'Directions',
                    style: TextStyle(
                      fontSize: 9,
                    ),
                  ),

                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF00845A),

                    side: const BorderSide(
                      color: Color(0xFF00845A),
                    ),

                    minimumSize: const Size(0, 30),

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}