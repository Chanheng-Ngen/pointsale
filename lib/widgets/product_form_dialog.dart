import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:point_sale/models/product_inventory.dart';
import 'package:point_sale/providers/product_inventory_provider.dart';

class ProductFormDialog extends StatefulWidget {
  final ProductInventory? productToEdit;

  const ProductFormDialog({super.key, this.productToEdit});

  @override
  State<ProductFormDialog> createState() => _ProductFormDialogState();
}

class _ProductFormDialogState extends State<ProductFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _categoryController;
  late TextEditingController _skuController;
  late TextEditingController _priceController;
  late TextEditingController _stockController;
  
  bool _isCreatingCategory = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.productToEdit?.name ?? '');
    _categoryController = TextEditingController(text: widget.productToEdit?.category ?? '');
    _skuController = TextEditingController(text: widget.productToEdit?.sku ?? '');
    _priceController = TextEditingController(text: widget.productToEdit != null ? widget.productToEdit!.price.toString() : '');
    _stockController = TextEditingController(text: widget.productToEdit != null ? widget.productToEdit!.stock.toString() : '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _categoryController.dispose();
    _skuController.dispose();
    _priceController.dispose();
    _stockController.dispose();
    super.dispose();
  }

  void _saveProduct() {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text.trim();
      final category = _categoryController.text.trim();
      final sku = _skuController.text.trim().isEmpty ? 'AUTO-${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}' : _skuController.text.trim();
      final price = double.tryParse(_priceController.text.trim()) ?? 0.0;
      final stock = int.tryParse(_stockController.text.trim()) ?? 0;
      
      String status = 'in stock';
      if (stock == 0) {
        status = 'out of-stock';
      } else if (stock < 10) {
        status = 'low stock';
      }

      final provider = Provider.of<ProductInventoryProvider>(context, listen: false);

      if (widget.productToEdit != null) {
        final updated = ProductInventory(
          id: widget.productToEdit!.id,
          name: name,
          sku: sku,
          category: category,
          price: price,
          stock: stock,
          status: status,
        );
        provider.updateProduct(updated);
      } else {
        final newProduct = ProductInventory(
          id: DateTime.now().toString(),
          name: name,
          sku: sku,
          category: category,
          price: price,
          stock: stock,
          status: status,
        );
        provider.addProduct(newProduct);
      }

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: Colors.white,
      child: Container(
        padding: const EdgeInsets.all(24),
        width: MediaQuery.of(context).size.width * 0.9,
        constraints: const BoxConstraints(maxWidth: 500),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.productToEdit == null ? 'Add New Product' : 'Edit Product',
                      style: const TextStyle(
                        fontFamily: 'Arimo',
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF111827),
                      ),
                    ),
                    InkWell(
                      onTap: () => Navigator.of(context).pop(),
                      child: const Icon(Icons.close, size: 20, color: Color(0xFF4B5563)),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Product Name
                _buildLabel('Product Name *'),
                const SizedBox(height: 8),
                _buildTextField(
                  controller: _nameController,
                  hint: '',
                  validator: (val) => val == null || val.isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 16),

                // Category
                _buildLabel('Category *'),
                const SizedBox(height: 8),
                if (_isCreatingCategory) ...[
                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField(
                          controller: _categoryController,
                          hint: 'New category name',
                          validator: (val) => val == null || val.isEmpty ? 'Required' : null,
                        ),
                      ),
                      const SizedBox(width: 12),
                      SizedBox(
                        height: 48,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF00B8D0), // Cyan Primary
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            elevation: 0,
                          ),
                          onPressed: () {
                            // Validating and creating it would visually just keep it in the textfield
                            // We can just switch back the view.
                            if (_categoryController.text.isNotEmpty) {
                              setState(() {
                                _isCreatingCategory = false;
                              });
                            }
                          },
                          child: const Text('Create', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () => setState(() => _isCreatingCategory = false),
                    child: const Text('< Back to existing categories', style: TextStyle(color: Color(0xFF3B82F6), fontSize: 13)),
                  ),
                ] else ...[
                  // If picking existing category... Let's just use a normal text field or dropdown. 
                  // The prompt image shows a textfield with placeholder "Toy" and a Create button next to it. 
                  // We'll mimic the picture strictly: 
                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField(
                          controller: _categoryController,
                          hint: 'Toy',
                          validator: (val) => val == null || val.isEmpty ? 'Required' : null,
                        ),
                      ),
                      const SizedBox(width: 12),
                      SizedBox(
                        height: 48,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF00B8D0),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            elevation: 0,
                          ),
                          onPressed: () {},
                          child: const Text('Create', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () {},
                    child: const Text('< Back to existing categories', style: TextStyle(color: Color(0xFF3B82F6), fontSize: 13)),
                  ),
                ],
                const SizedBox(height: 16),

                // SKU
                _buildLabel('SKU'),
                const SizedBox(height: 8),
                _buildTextField(
                  controller: _skuController,
                  hint: 'Auto-generated if empty',
                ),
                const SizedBox(height: 16),

                // Price & Stock
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildLabel('Price *'),
                          const SizedBox(height: 8),
                          _buildTextField(
                            controller: _priceController,
                            hint: '0',
                            keyboardType: TextInputType.number,
                            validator: (val) => val == null || val.isEmpty ? 'Required' : null,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildLabel('Stock *'),
                          const SizedBox(height: 8),
                          _buildTextField(
                            controller: _stockController,
                            hint: '0',
                            keyboardType: TextInputType.number,
                            validator: (val) => val == null || val.isEmpty ? 'Required' : null,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                // Footer Buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          side: BorderSide(color: Colors.grey.shade300),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: const Text('Cancel', style: TextStyle(color: Color(0xFF374151), fontWeight: FontWeight.w500)),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _saveProduct,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF00B8D0),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          elevation: 0,
                        ),
                        child: Text(widget.productToEdit == null ? 'Add Product' : 'Save Changes', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        color: Color(0xFF4B5563),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    FormFieldValidator<String>? validator,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF00B8D0)),
        ),
      ),
    );
  }
}
