import 'package:flutter/material.dart';

class ShoeEssentialView extends StatefulWidget {
  const ShoeEssentialView({super.key});

  @override
  State<ShoeEssentialView> createState() => _ShoeEssentialViewState();
}

class _ShoeEssentialViewState extends State<ShoeEssentialView> {
  int quantity = 1;
  bool addedToCart = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Shoe Essentials',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image Section
              Center(
                child: Image.asset(
                  'assets/sh_b.jpg',
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16),

              // Product Info
              const Text(
                'Shoe Carrying Bag – Hajj/Umrah Essential',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Durable, zippered, and water-resistant shoe carrying bag, ideal for keeping your footwear safe during holy travel.',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 16),

              // Price & Quantity
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'PKR 750',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          if (quantity > 1) {
                            setState(() => quantity--);
                          }
                        },
                        icon: const Icon(Icons.remove_circle_outline),
                      ),
                      Text('$quantity', style: const TextStyle(fontSize: 16)),
                      IconButton(
                        onPressed: () => setState(() => quantity++),
                        icon: const Icon(Icons.add_circle_outline),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Add to Cart
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    addedToCart = true;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      addedToCart ? Colors.grey : Colors.deepPurple,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                icon: Icon(
                  addedToCart ? Icons.check_circle : Icons.add_shopping_cart,
                  color: Colors.white,
                ),
                label: Text(
                  addedToCart ? 'ADDED TO CART' : 'ADD TO CART',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Buy Now
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    // Navigate to checkout or payment screen
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    side: const BorderSide(color: Colors.deepPurple),
                  ),
                  child: const Text('BUY NOW'),
                ),
              ),
              const SizedBox(height: 24),

              // Features
              const Text(
                'Why You Need This:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),
              const BulletPoint(
                text: 'Avoid misplacing shoes in crowded areas',
              ),
              const BulletPoint(
                text: 'Keep shoes dry and clean in Masjid compartments',
              ),
              const BulletPoint(text: 'Easy to carry with a handle'),
              const BulletPoint(text: 'Lightweight & foldable design'),

              const SizedBox(height: 24),
              const Text(
                'Customer Reviews:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 12),
              _buildReview(
                'Ahmed',
                'Very helpful during my Umrah! Quality is good.',
              ),
              _buildReview(
                'Fatima',
                'Must-have item. I even used it in airports.',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReview(String name, String comment) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Icon(Icons.person, color: Colors.grey),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(comment),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BulletPoint extends StatelessWidget {
  final String text;
  const BulletPoint({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          const Icon(Icons.check, color: Colors.green, size: 18),
          const SizedBox(width: 8),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}
