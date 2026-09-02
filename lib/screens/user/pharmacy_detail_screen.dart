import 'package:flutter/material.dart';

class PharmacyDetailScreen extends StatefulWidget {
  final String name;
  final String image;
  final String rating;
  final String reviewCount;
  final String address;
  final String distance;
  final String status;
  final String closingTime;

  const PharmacyDetailScreen({
    super.key,
    required this.name,
    required this.image,
    required this.rating,
    required this.reviewCount,
    required this.address,
    required this.distance,
    required this.status,
    required this.closingTime,
  });

  @override
  State<PharmacyDetailScreen> createState() => _PharmacyDetailScreenState();
}

class _PharmacyDetailScreenState extends State<PharmacyDetailScreen> {
  String _selectedCategory = 'All';
  final TextEditingController _searchController = TextEditingController();

  final List<String> _categories = [
    'All',
    'Pain Relief',
    'Antibiotics',
    'Vitamin',
  ];

  // Mock medicine data
  final List<Map<String, dynamic>> _medicines = [
    {
      'image': 'assets/images/paracetamol.jpg',
      'category': 'Antibiotics',
      'name': 'Amoxicillin 500mg Capsules',
      'price': '145 ETB',
      'tag': null,
    },
    {
      'image': 'assets/images/ibuprofen.jpg',
      'category': 'Pain Relief',
      'name': 'Ibuprofen 400mg Tablets',
      'price': '85 ETB',
      'tag': null,
    },
    {
      'image': 'assets/images/paracetamol.jpg',
      'category': 'Pain Relief',
      'name': 'Paracetamol 500mg',
      'price': '45 ETB',
      'tag': 'LOW STOCK',
    },
    {
      'image': 'assets/images/ibuprofen.jpg',
      'category': 'Antibiotics',
      'name': 'Azithromycin 250mg',
      'price': '210 ETB',
      'tag': 'RX REQUIRED',
    },
  ];

  List<Map<String, dynamic>> get _filteredMedicines {
    final query = _searchController.text.toLowerCase();
    return _medicines.where((m) {
      final matchesCategory =
          _selectedCategory == 'All' || m['category'] == _selectedCategory;
      final matchesSearch =
          query.isEmpty || m['name'].toLowerCase().contains(query);
      return matchesCategory && matchesSearch;
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FC),
      body: SafeArea(
        child: Column(
          children: [
            // ================================================================
            // APP BAR
            // ================================================================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: const Color(0xFFE0E4E3)),
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        size: 14,
                        color: Color(0xFF202838),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      widget.name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF202838),
                      ),
                    ),
                  ),
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFFE0E4E3)),
                    ),
                    child: const Icon(
                      Icons.share_outlined,
                      size: 16,
                      color: Color(0xFF202838),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(14, 0, 14, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ============================================================
                    // HERO IMAGE
                    // ============================================================
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        widget.image,
                        width: double.infinity,
                        height: 160,
                        fit: BoxFit.cover,
                      ),
                    ),

                    const SizedBox(height: 14),

                    // ============================================================
                    // NAME + VERIFIED BADGE
                    // ============================================================
                    Row(
                      children: [
                        Text(
                          widget.name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF202838),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 7,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFD9F6EA),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.verified,
                                size: 10,
                                color: Color(0xFF00845A),
                              ),
                              SizedBox(width: 3),
                              Text(
                                'Verified',
                                style: TextStyle(
                                  fontSize: 9,
                                  color: Color(0xFF00845A),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 4),

                    // RATING
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          size: 13,
                          color: Color(0xFFFFB400),
                        ),
                        const SizedBox(width: 3),
                        Text(
                          '${widget.rating} ',
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF202838),
                          ),
                        ),
                        Text(
                          '(${widget.reviewCount} reviews)',
                          style: const TextStyle(
                            fontSize: 10,
                            color: Color(0xFF69726F),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // ============================================================
                    // INFO ROWS
                    // ============================================================
                    _infoRow(
                      icon: Icons.location_on_outlined,
                      title: widget.address,
                      subtitle: '${widget.distance} away',
                    ),

                    const SizedBox(height: 8),

                    _infoRow(
                      icon: Icons.access_time_outlined,
                      title: widget.status,
                      subtitle: 'Closes at ${widget.closingTime}',
                    ),

                    const SizedBox(height: 14),

                    // ============================================================
                    // ACTION BUTTONS
                    // ============================================================
                    Row(
                      children: [
                        Expanded(
                          child: _actionButton(
                            icon: Icons.phone_outlined,
                            label: 'Call',
                            filled: true,
                            onTap: () {},
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _actionButton(
                            icon: Icons.directions_outlined,
                            label: 'Directions',
                            filled: false,
                            onTap: () {},
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _actionButton(
                            icon: Icons.message_outlined,
                            label: 'Message',
                            filled: false,
                            onTap: () {},
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // ============================================================
                    // MEDICINES SECTION HEADER
                    // ============================================================
                    Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'Medicines available here',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF202838),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        // SEARCH
                        Expanded(
                          child: Container(
                            height: 32,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: const Color(0xFFD1D8D6),
                              ),
                            ),
                            child: Row(
                              children: [
                                const SizedBox(width: 8),
                                const Icon(
                                  Icons.search,
                                  size: 14,
                                  color: Color(0xFF68736F),
                                ),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: TextField(
                                    controller: _searchController,
                                    onChanged: (_) => setState(() {}),
                                    style: const TextStyle(fontSize: 10),
                                    decoration: const InputDecoration(
                                      hintText: 'Search in pharmacy...',
                                      hintStyle: TextStyle(
                                        fontSize: 10,
                                        color: Color(0xFF9AA09D),
                                      ),
                                      border: InputBorder.none,
                                      isDense: true,
                                      contentPadding: EdgeInsets.zero,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    // ============================================================
                    // CATEGORY CHIPS
                    // ============================================================
                    SizedBox(
                      height: 28,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: _categories.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 6),
                        itemBuilder: (context, index) {
                          final cat = _categories[index];
                          final selected = _selectedCategory == cat;
                          return GestureDetector(
                            onTap:
                                () => setState(() => _selectedCategory = cat),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color:
                                    selected
                                        ? const Color(0xFF00845A)
                                        : Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color:
                                      selected
                                          ? const Color(0xFF00845A)
                                          : const Color(0xFFD1D8D6),
                                ),
                              ),
                              child: Text(
                                cat,
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  color:
                                      selected
                                          ? Colors.white
                                          : const Color(0xFF3D4A46),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 12),

                    // ============================================================
                    // MEDICINE GRID
                    // ============================================================
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 0.75,
                          ),
                      itemCount: _filteredMedicines.length,
                      itemBuilder: (context, index) {
                        return _medicineGridCard(_filteredMedicines[index]);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // INFO ROW
  // ============================================================
  Widget _infoRow({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: const Color(0xFFEDF7F3),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 15, color: const Color(0xFF00845A)),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: Color(0xFF202838),
              ),
            ),
            Text(
              subtitle,
              style: const TextStyle(fontSize: 9, color: Color(0xFF69726F)),
            ),
          ],
        ),
      ],
    );
  }

  // ============================================================
  // ACTION BUTTON
  // ============================================================
  Widget _actionButton({
    required IconData icon,
    required String label,
    required bool filled,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 38,
        decoration: BoxDecoration(
          color: filled ? const Color(0xFF007A59) : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: filled ? const Color(0xFF007A59) : const Color(0xFFD1D8D6),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 13,
              color: filled ? Colors.white : const Color(0xFF202838),
            ),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: filled ? Colors.white : const Color(0xFF202838),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // MEDICINE GRID CARD
  // ============================================================
  Widget _medicineGridCard(Map<String, dynamic> medicine) {
    final tag = medicine['tag'] as String?;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // IMAGE + TAG
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(10),
                ),
                child: Image.asset(
                  medicine['image'],
                  width: double.infinity,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              if (tag != null)
                Positioned(
                  top: 7,
                  left: 7,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color:
                          tag == 'LOW STOCK'
                              ? const Color(0xFFFF5A1A)
                              : const Color(0xFF1A6BFF),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      tag,
                      style: const TextStyle(
                        fontSize: 7,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  medicine['category'],
                  style: const TextStyle(fontSize: 8, color: Color(0xFF69726F)),
                ),
                const SizedBox(height: 2),
                Text(
                  medicine['name'],
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF202838),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  medicine['price'],
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF00845A),
                  ),
                ),
                const SizedBox(height: 6),
                SizedBox(
                  height: 28,
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.shopping_cart_outlined, size: 11),
                    label: const Text('Add', style: TextStyle(fontSize: 10)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFEDF7F3),
                      foregroundColor: const Color(0xFF007A59),
                      elevation: 0,
                      minimumSize: const Size(double.infinity, 28),
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
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
