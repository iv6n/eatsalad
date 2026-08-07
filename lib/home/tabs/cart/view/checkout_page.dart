import 'package:eatsalad/app/app.dart';
import 'package:eatsalad/home/tabs/cart/bloc/cart_bloc.dart';
import 'package:eatsalad/home/tabs/cart/models/cart.dart';
import 'package:eatsalad/home/tabs/cart/models/order.dart';
import 'package:eatsalad/home/tabs/cart/order_repository.dart';
import 'package:eatsalad/home/tabs/cart/view/order_confirmation_page.dart';
import 'package:eatsalad/home/tabs/catalog/models/item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _notesController = TextEditingController();
  FulfillmentType _fulfillmentType = FulfillmentType.pickup;
  bool _submitting = false;

  @override
  void initState() {
    super.initState();
    final user = context.read<AppBloc>().state.user;
    if (user.name != null && user.name!.isNotEmpty) {
      _nameController.text = user.name!;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cartState = context.watch<CartBloc>().state;
    final cart = cartState is CartLoaded ? cartState.cart : const Cart();

    return Scaffold(
      appBar: AppBar(title: const Text('Confirmar pedido')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              '¿Cómo quieres tu pedido?',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            SegmentedButton<FulfillmentType>(
              segments: const [
                ButtonSegment(
                  value: FulfillmentType.pickup,
                  label: Text('Recolección'),
                  icon: Icon(Icons.store),
                ),
                ButtonSegment(
                  value: FulfillmentType.delivery,
                  label: Text('Entrega'),
                  icon: Icon(Icons.delivery_dining),
                ),
              ],
              selected: {_fulfillmentType},
              onSelectionChanged: (selection) =>
                  setState(() => _fulfillmentType = selection.first),
            ),
            const SizedBox(height: 24),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Nombre'),
              textCapitalization: TextCapitalization.words,
              validator: (value) => (value == null || value.trim().isEmpty)
                  ? 'Ingresa tu nombre'
                  : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _phoneController,
              decoration: const InputDecoration(labelText: 'Teléfono'),
              keyboardType: TextInputType.phone,
              validator: (value) => (value == null || value.trim().isEmpty)
                  ? 'Ingresa un teléfono de contacto'
                  : null,
            ),
            if (_fulfillmentType == FulfillmentType.delivery) ...[
              const SizedBox(height: 12),
              TextFormField(
                controller: _addressController,
                decoration:
                    const InputDecoration(labelText: 'Dirección de entrega'),
                maxLines: 2,
                validator: (value) =>
                    (value == null || value.trim().isEmpty)
                        ? 'Ingresa la dirección de entrega'
                        : null,
              ),
            ],
            const SizedBox(height: 12),
            TextFormField(
              controller: _notesController,
              decoration: const InputDecoration(
                labelText: 'Notas para tu pedido (opcional)',
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 8),
            const Text('Resumen', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            ..._groupedSummary(cart.items),
            const Divider(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
                Text(
                  '\$${cart.totalPrice.toStringAsFixed(2)}',
                  style:
                      const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                children: [
                  Icon(Icons.payments_outlined, color: Colors.black54),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Pagas en efectivo o tarjeta al recoger/recibir tu pedido.',
                      style: TextStyle(color: Colors.black54, fontSize: 13),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _submitting ? null : () => _submit(cart),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                minimumSize: const Size.fromHeight(48),
              ),
              child: _submitting
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Text('Confirmar pedido'),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _groupedSummary(List<Item> items) {
    final grouped = <Item, int>{};
    for (final item in items) {
      grouped[item] = (grouped[item] ?? 0) + 1;
    }
    return grouped.entries
        .map(
          (entry) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                Text('${entry.value}x  '),
                Expanded(child: Text(entry.key.itemName ?? '')),
                Text(
                  '\$${((entry.key.variants?.price ?? 0) * entry.value).toStringAsFixed(2)}',
                ),
              ],
            ),
          ),
        )
        .toList();
  }

  Future<void> _submit(Cart cart) async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() => _submitting = true);

    final order = Order(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      items: cart.items,
      total: cart.totalPrice,
      fulfillmentType: _fulfillmentType,
      customerName: _nameController.text.trim(),
      customerPhone: _phoneController.text.trim(),
      createdAt: DateTime.now(),
      address: _fulfillmentType == FulfillmentType.delivery
          ? _addressController.text.trim()
          : null,
      notes: _notesController.text.trim().isEmpty
          ? null
          : _notesController.text.trim(),
    );

    try {
      await OrderRepository().saveOrder(order);
    } catch (_) {
      // El pedido se sigue confirmando aunque no se pueda guardar el
      // historial local: eso no debe bloquear al cliente.
    }

    if (!mounted) return;
    context.read<CartBloc>().add(CartCleared());

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => OrderConfirmationPage(order: order)),
    );
  }
}
