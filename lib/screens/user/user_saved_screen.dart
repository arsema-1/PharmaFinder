import 'package:flutter/material.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({super.key});

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  // false = Medicines
  // true = Pharmacies
  bool showPharmacies = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FC),

      body: SafeArea(
        child: Column(
          children: [

            // ============================================================
            // TOP HEADER
            // ============================================================

            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: SizedBox(
                height: 27,
                child: Row(
                  children: [

                    const Text(
                      'Saved',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF00845A),
                      ),
                    ),

                    const Spacer(),

                    IconButton(
                      onPressed: () {},
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(
                        minWidth: 30,
                        minHeight: 30,
                      ),
                      icon: const Icon(
                        Icons.shopping_cart_outlined,
                        size: 20,
                        color: Color(0xFF394440),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 8),

            // ============================================================
            // MEDICINES / PHARMACIES SWITCH
            // ============================================================

            Container(
              height: 35,
              width: double.infinity,

              decoration: const BoxDecoration(
                color: Color(0xFFF8F9FC),
              ),

              child: Row(
                children: [

                  // ------------------------------------------------------
                  // MEDICINES
                  // ------------------------------------------------------

                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          showPharmacies = false;
                        });
                      },

                      child: Container(
                        alignment: Alignment.center,

                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: !showPharmacies
                                  ? const Color(0xFF00845A)
                                  : Colors.transparent,
                              width: 1.5,
                            ),
                          ),
                        ),

                        child: Text(
                          'Medicines',
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w600,
                            color: !showPharmacies
                                ? const Color(0xFF00845A)
                                : const Color(0xFF7B817F),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // ------------------------------------------------------
                  // PHARMACIES
                  // ------------------------------------------------------

                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          showPharmacies = true;
                        });
                      },

                      child: Container(
                        alignment: Alignment.center,

                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: showPharmacies
                                  ? const Color(0xFF00845A)
                                  : Colors.transparent,
                              width: 1.5,
                            ),
                          ),
                        ),

                        child: Text(
                          'Pharmacies',
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w600,
                            color: showPharmacies
                                ? const Color(0xFF00845A)
                                : const Color(0xFF7B817F),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ============================================================
            // CONTENT
            // ============================================================

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                  9,
                  9,
                  9,
                  12,
                ),

                child: showPharmacies
                    ? _pharmacyContent()
                    : _medicineContent(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ======================================================================
  // SAVED MEDICINES
  // ======================================================================

  Widget _medicineContent() {
    return Column(
      children: [

        // AMOXICILLIN
        _medicineCard(
          image: 'assets/images/paracetamol.jpg',
          name: 'Amoxicillin 500mg',
          type: 'Antibiotic • 20 Capsules',
          price: '350 ETB',
          inStock: true,
        ),

        const SizedBox(height: 9),

        // PARACETAMOL
        _medicineCard(
          image: 'assets/images/paracetamol.jpg',
          name: 'Paracetamol Syrup',
          type: 'Pain Relief • 100ml',
          price: '120 ETB',
          inStock: false,
        ),
      ],
    );
  }

  // ======================================================================
  // MEDICINE CARD
  // ======================================================================

  Widget _medicineCard({
    required String image,
    required String name,
    required String type,
    required String price,
    required bool inStock,
  }) {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(10),

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // ==========================================================
          // IMAGE + INFORMATION + HEART
          // ==========================================================

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // IMAGE
              ClipRRect(
                borderRadius: BorderRadius.circular(5),

                child: Image.asset(
                  image,
                  width: 45,
                  height: 45,
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(width: 8),

              // INFORMATION
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(
                      name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,

                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF202838),
                      ),
                    ),

                    const SizedBox(height: 2),

                    Text(
                      type,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,

                      style: const TextStyle(
                        fontSize: 8,
                        color: Color(0xFF69726F),
                      ),
                    ),

                    const SizedBox(height: 3),

                    Row(
                      children: [

                        Icon(
                          Icons.circle,
                          size: 6,
                          color: inStock
                              ? const Color(0xFF00A875)
                              : const Color(0xFFD32F2F),
                        ),

                        const SizedBox(width: 3),

                        Text(
                          inStock ? 'In Stock' : 'Out of Stock',

                          style: TextStyle(
                            fontSize: 8,
                            color: inStock
                                ? const Color(0xFF00845A)
                                : const Color(0xFFD32F2F),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 5),

              // HEART
              const Icon(
                Icons.favorite,
                size: 17,
                color: Color(0xFF00845A),
              ),
            ],
          ),

          const SizedBox(height: 7),

          // ==========================================================
          // DIVIDER
          // ==========================================================

          const Divider(
            height: 1,
            color: Color(0xFFE5E8E7),
          ),

          const SizedBox(height: 7),

          // ==========================================================
          // PRICE + ADD BUTTON
          // ==========================================================

          Row(
            children: [

              // PRICE
              Expanded(
                child: Text(
                  price,

                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF202838),
                  ),
                ),
              ),

              // BUTTON
              SizedBox(
                height: 29,
                width: inStock ? 58 : 78,

                child: ElevatedButton(
                  onPressed: inStock
                      ? () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('$name added to cart'),
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  }
                      : null,

                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF007A59),

                    disabledBackgroundColor:
                    const Color(0xFFE8ECF7),

                    foregroundColor: Colors.white,

                    disabledForegroundColor:
                    const Color(0xFF777F8C),

                    elevation: 0,

                    padding: EdgeInsets.zero,

                    minimumSize: Size.zero,

                    tapTargetSize:
                    MaterialTapTargetSize.shrinkWrap,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),

                  child: inStock
                      ? const Row(
                    mainAxisAlignment:
                    MainAxisAlignment.center,
                    children: [

                      Icon(
                        Icons.shopping_cart_outlined,
                        size: 11,
                      ),

                      SizedBox(width: 3),

                      Text(
                        'Add',
                        style: TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  )
                      : const Text(
                    'Unavailable',
                    style: TextStyle(
                      fontSize: 7,
                      fontWeight: FontWeight.w500,
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

  // ======================================================================
  // SAVED PHARMACIES
  // ======================================================================

  Widget _pharmacyContent() {
    return Column(
      children: [

        _pharmacyCard(
          image: 'assets/images/pharmacy1.jpg',
          name: 'ABC Pharmacy',
          address: 'Bole Road, Addis Ababa',
          distance: '0.8 km',
          rating: '4.8',
        ),

        const SizedBox(height: 9),

        _pharmacyCard(
          image: 'assets/images/pharmacy1.jpg',
          name: 'HealthFirst Pharmacy',
          address: 'Mexico Square, Addis Ababa',
          distance: '1.2 km',
          rating: '4.5',
        ),
      ],
    );
  }

  // ======================================================================
  // PHARMACY CARD
  // ======================================================================

  Widget _pharmacyCard({
    required String image,
    required String name,
    required String address,
    required String distance,
    required String rating,
  }) {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(9),

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

      child: Row(
        children: [

          // PHARMACY IMAGE
          ClipRRect(
            borderRadius: BorderRadius.circular(6),

            child: Image.asset(
              image,
              width: 55,
              height: 55,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(width: 8),

          // INFORMATION
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Row(
                  children: [

                    Expanded(
                      child: Text(
                        name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,

                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF202838),
                        ),
                      ),
                    ),

                    const Icon(
                      Icons.favorite,
                      size: 17,
                      color: Color(0xFF00845A),
                    ),
                  ],
                ),

                const SizedBox(height: 4),

                Text(
                  address,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,

                  style: const TextStyle(
                    fontSize: 8,
                    color: Color(0xFF69726F),
                  ),
                ),

                const SizedBox(height: 4),

                Row(
                  children: [

                    const Icon(
                      Icons.star,
                      size: 10,
                      color: Color(0xFFFFB400),
                    ),

                    const SizedBox(width: 2),

                    Text(
                      rating,
                      style: const TextStyle(
                        fontSize: 8,
                        color: Color(0xFF53605C),
                      ),
                    ),

                    const SizedBox(width: 7),

                    const Icon(
                      Icons.location_on_outlined,
                      size: 10,
                      color: Color(0xFF53605C),
                    ),

                    const SizedBox(width: 2),

                    Text(
                      distance,
                      style: const TextStyle(
                        fontSize: 8,
                        color: Color(0xFF53605C),
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