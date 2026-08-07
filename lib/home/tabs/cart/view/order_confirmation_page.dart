import 'package:eatsalad/home/tabs/cart/models/order.dart';
import 'package:eatsalad/home/tabs/catalog/models/item.dart';
import 'package:flutter/material.dart';

class OrderConfirmationPage extends StatelessWidget {
  const OrderConfirmationPage({super.key, required this.order});

  final Order order;

  @override
  Widget build(BuildContext context) {
    final isDelivery = order.fulfillmentType == FulfillmentType.delivery;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pedido confirmado'),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 72),
            const SizedBox(height: 16),
            const Text(
              '¡Gracias por tu pedido!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 4),
            Text(
              'Pedido #${order.id.substring(order.id.length - 6)}',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 24),
            Card(
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          isDelivery ? Icons.delivery_dining : Icons.store,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          isDelivery ? 'Entrega a domicilio' : 'Recolección en tienda',
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    if (isDelivery && order.address != null) ...[
                      const SizedBox(height: 8),
                      Text(order.address!),
                    ],
                    const Divider(height: 24),
                    Text('${order.customerName} · ${order.customerPhone}'),
                    if (order.notes != null) ...[
                      const SizedBox(height: 8),
                      Text(
                        'Notas: ${order.notes!}',
                        style: const TextStyle(color: Colors.black54),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Resumen', style: TextStyle(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    ..._groupedSummary(order.items),
                    const Divider(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                        ),
                        Text(
                          '\$${order.total.toStringAsFixed(2)}',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Text(
                'Pagas en efectivo o tarjeta al recoger/recibir tu pedido.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black54, fontSize: 13),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () =>
                  Navigator.popUntil(context, (route) => route.isFirst),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                minimumSize: const Size.fromHeight(48),
              ),
              child: const Text('Volver al inicio'),
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
              ],
            ),
          ),
        )
        .toList();
  }
}
