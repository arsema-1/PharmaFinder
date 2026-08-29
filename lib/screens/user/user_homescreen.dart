import 'package:flutter/material.dart';
import 'user_shell.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool showPharmacies = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FC),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // LOCATION HEADER
              Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    color: Color(0xFF00845A),
                    size: 18,
                  ),
                  const SizedBox(width: 5),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Delivering to',
                          style: TextStyle(
                            fontSize: 8,
                            color: Color(0xFF6B7472),
                          ),
                        ),
                        Text(
                          'Bole, Addis Ababa  ˅',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF202838),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Stack(
                    children: [
                      const Icon(
                        Icons.shopping_cart_outlined,
                        size: 21,
                        color: Color(0xFF394440),
                      ),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // SEARCH
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 36,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
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
                  const SizedBox(width: 8),
                  Container(
                    height: 36,
                    width: 36,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3F5FF),
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: const Icon(
                      Icons.tune,
                      color: Color(0xFF00845A),
                      size: 19,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              // TOGGLE
              Center(
                child: Container(
                  height: 25,
                  width: 160,
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE2E7FA),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: _toggleButton(
                          'Medicines',
                          !showPharmacies,
                          () => setState(() => showPharmacies = false),
                        ),
                      ),
                      Expanded(
                        child: _toggleButton(
                          'Pharmacies',
                          showPharmacies,
                          () => setState(() => showPharmacies = true),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 18),

              // HEADER
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Available Near You',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF202838),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: const Text(
                      'View Map',
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF00845A),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 9),

              // CONTENT
              if (showPharmacies) ...[
                _pharmacyCard(
                  name: 'ABC Pharmacy',
                  rating: '4.8',
                  distance: '0.8 km away',
                  status: 'Open Now',
                  statusColor: const Color(0xFF00845A),
                ),
                const SizedBox(height: 9),
                _pharmacyCard(
                  name: 'HealthFirst Pharmacy',
                  rating: '4.5',
                  distance: '1.2 km away',
                  status: 'Closes at 10:00 PM',
                  statusColor: const Color(0xFF555F5C),
                ),
                const SizedBox(height: 9),
                _pharmacyCard(
                  name: 'LifeCare Pharmacy',
                  rating: '4.9',
                  distance: '2.5 km away',
                  status: '24 Hours',
                  statusColor: const Color(0xFF00845A),
                ),
              ] else ...[
                Container(
                  width: double.infinity,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Text(
                      'Medicine view',
                      style: TextStyle(color: Color(0xFF00845A)),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

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

  Widget _pharmacyCard({
    required String name,
    required String rating,
    required String distance,
    required String status,
    required Color statusColor,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // IMAGE PLACEHOLDER
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
            child: Container(
              height: 115,
              color: const Color(0xFFE8ECFA),
              child: const Center(
                child: Icon(
                  Icons.local_pharmacy_outlined,
                  size: 45,
                  color: Color(0xFF9BAEDB),
                ),
              ),
            ),
          ),

          // INFO
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 8, 10, 9),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF202838),
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.verified,
                      size: 13,
                      color: Color(0xFF00845A),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      size: 11,
                      color: Color(0xFF53605C),
                    ),
                    const SizedBox(width: 3),
                    Text(
                      distance,
                      style: const TextStyle(
                        fontSize: 8,
                        color: Color(0xFF53605C),
                      ),
                    ),
                    const SizedBox(width: 9),
                    Container(
                      width: 1,
                      height: 12,
                      color: const Color(0xFFD8DDDB),
                    ),
                    const SizedBox(width: 9),
                    Icon(Icons.access_time, size: 11, color: statusColor),
                    const SizedBox(width: 3),
                    Text(
                      status,
                      style: TextStyle(
                        fontSize: 8,
                        color: statusColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Divider(height: 1, color: Color(0xFFE5E8E7)),
                const SizedBox(height: 9),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 27,
                        child: OutlinedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.phone_outlined, size: 12),
                          label: const Text(
                            'Call',
                            style: TextStyle(fontSize: 9),
                          ),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: const Color(0xFF00845A),
                            side: const BorderSide(color: Color(0xFF00845A)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            padding: EdgeInsets.zero,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 7),
                    Expanded(
                      child: SizedBox(
                        height: 27,
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.directions_outlined, size: 12),
                          label: const Text(
                            'Directions',
                            style: TextStyle(fontSize: 9),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF007A59),
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            padding: EdgeInsets.zero,
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
}
