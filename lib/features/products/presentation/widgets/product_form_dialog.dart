import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:point_sale/features/products/data/models/product_inventory.dart';
import 'package:point_sale/features/products/providers/product_inventory_provider.dart';

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
  bool _isCreatingNewCategory = false;

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
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF0A0A0A),
                      ),
                    ),
                    InkWell(
                      onTap: () => Navigator.of(context).pop(),
                      child: const Icon(Icons.close, size: 22, color: Color(0xFF0A0A0A)),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Product Name
                _buildLabel('Product Name *'),
                const SizedBox(height: 8),
                _buildTextField(
                  controller: _nameController,
                  hint: 'Enter product name',
                  validator: (val) => val == null || val.isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 16),

                // Category
                _buildLabel('Category *'),
                const SizedBox(height: 8),
                if (_isCreatingNewCategory) ...[
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _categoryController,
                          decoration: InputDecoration(
                            hintText: 'Enter category name',
                            hintStyle: TextStyle(color: Colors.black.withOpacity(0.5), fontSize: 16),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Color(0xFFD1D5DC), width: 1.15),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Color(0xFFD1D5DC), width: 1.15),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Color(0xFF00B8DB), width: 1.15),
                            ),
                          ),
                          validator: (val) => val == null || val.isEmpty ? 'Required' : null,
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {
                          if (_categoryController.text.isNotEmpty) {
                            setState(() {
                              _isCreatingNewCategory = false;
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF00B8DB),
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          elevation: 0,
                        ),
                        child: const Text('Create', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.normal)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _categoryController.clear();
                        _isCreatingNewCategory = false;
                      });
                    },
                    child: const Text(
                      '< Back to existing categories',
                      style: TextStyle(color: Color(0xFF2563EB), fontSize: 14),
                    ),
                  ),
                ] else ...[
                  LayoutBuilder(
                    builder: (context, constraints) => Autocomplete<String>(
                      optionsBuilder: (TextEditingValue textEditingValue) {
                        final provider = Provider.of<ProductInventoryProvider>(context, listen: false);
                        final existingCategories = provider.products.map((p) => p.category).toSet().toList()..sort();
                        if (textEditingValue.text.isEmpty) {
                          return existingCategories;
                        }
                        return existingCategories.where((cat) => cat.toLowerCase().contains(textEditingValue.text.toLowerCase()));
                      },
                      onSelected: (String selection) {
                        _categoryController.text = selection;
                      },
                      fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
                        // Keep controllers in sync
                        controller.addListener(() {
                          if (controller.text != _categoryController.text) {
                            _categoryController.text = controller.text;
                          }
                        });
                        if (_categoryController.text.isNotEmpty && controller.text.isEmpty) {
                          controller.text = _categoryController.text;
                        }
                        return TextFormField(
                          controller: controller,
                          focusNode: focusNode,
                          onFieldSubmitted: (String value) => onFieldSubmitted(),
                          decoration: InputDecoration(
                            hintText: 'Select a category',
                            hintStyle: TextStyle(color: Colors.black.withOpacity(0.5), fontSize: 16),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
                            suffixIcon: const Icon(Icons.keyboard_arrow_down, color: Color(0xFF9CA3AF)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Color(0xFFD1D5DC), width: 1.15),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Color(0xFFD1D5DC), width: 1.15),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Color(0xFF00B8DB), width: 1.15),
                            ),
                          ),
                          validator: (val) => val == null || val.isEmpty ? 'Required' : null,
                        );
                      },
                      optionsViewBuilder: (context, onSelected, options) {
                        return Align(
                          alignment: Alignment.topLeft,
                          child: Material(
                            elevation: 4.0,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            child: ConstrainedBox(
                              constraints: BoxConstraints(maxHeight: 200, maxWidth: constraints.maxWidth),
                              child: ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                itemCount: options.length,
                                itemBuilder: (context, index) {
                                  final option = options.elementAt(index);
                                  return InkWell(
                                    onTap: () => onSelected(option),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
                                      child: Text(option, style: TextStyle(fontSize: 16, color: Colors.black.withOpacity(0.8))),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 12),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _categoryController.clear();
                        _isCreatingNewCategory = true;
                      });
                    },
                    child: const Text(
                      'Go to create new a category >',
                      style: TextStyle(color: Color(0xFF2563EB), fontSize: 14),
                    ),
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
                          side: const BorderSide(color: Color(0xFFD1D5DC), width: 1.15),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        child: const Text('Cancel', style: TextStyle(color: Color(0xFF0A0A0A), fontSize: 16, fontWeight: FontWeight.normal)),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _saveProduct,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF00B8DB),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          elevation: 0,
                        ),
                        child: Text(widget.productToEdit == null ? 'Add Product' : 'Save Changes', style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.normal)),
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
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: Color(0xFF364153),
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
        hintStyle: TextStyle(color: Colors.black.withOpacity(0.5), fontSize: 16),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFFD1D5DC), width: 1.15),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFFD1D5DC), width: 1.15),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFF00B8DB), width: 1.15),
        ),
      ),
    );
  }
}
