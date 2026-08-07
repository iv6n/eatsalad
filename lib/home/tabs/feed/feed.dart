import 'package:flutter/material.dart';

class FeedItem {
  const FeedItem({
    required this.tag,
    required this.title,
    required this.description,
    required this.date,
  });

  final String tag;
  final String title;
  final String description;
  final DateTime date;
}

// Contenido de ejemplo — reemplazar por una fuente de contenido real
// (Cloud Functions / CMS) cuando exista backend para administrarlo.
final List<FeedItem> _sampleFeedItems = [
  FeedItem(
    tag: 'Promoción',
    title: '2x1 en ensaladas los martes',
    description:
        'Todos los martes, lleva 2 ensaladas grandes por el precio de 1. '
        'Válido en pedidos dentro de la app.',
    date: DateTime(2026, 8, 4),
  ),
  FeedItem(
    tag: 'Novedad',
    title: 'Nuevo aderezo de la casa',
    description:
        'Prueba nuestro nuevo aderezo de mango habanero, disponible por '
        'tiempo limitado.',
    date: DateTime(2026, 7, 28),
  ),
  FeedItem(
    tag: 'Noticia',
    title: 'Eatsalad sigue creciendo',
    description:
        'Cuéntanos qué te gustaría ver en el menú a través de la sección '
        'de contacto.',
    date: DateTime(2026, 7, 15),
  ),
];

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  static const String id = 'pag0';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: const Text(
          'Novedades',
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Container(color: Colors.grey[300], height: .45),
        ),
      ),
      body: SafeArea(
        child: _sampleFeedItems.isEmpty
            ? const Center(child: Text('No hay novedades por ahora.'))
            : ListView.separated(
                padding: const EdgeInsets.all(12),
                itemCount: _sampleFeedItems.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 12),
                itemBuilder: (context, index) =>
                    _FeedCard(item: _sampleFeedItems[index]),
              ),
      ),
    );
  }
}

class _FeedCard extends StatelessWidget {
  const _FeedCard({required this.item});

  final FeedItem item;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: Colors.green[50],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                item.tag,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: Colors.green[800],
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              item.title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 4),
            Text(item.description, style: const TextStyle(fontSize: 13, height: 1.3)),
            const SizedBox(height: 8),
            Text(
              _formatDate(item.date),
              style: TextStyle(fontSize: 11, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    const months = [
      'ene', 'feb', 'mar', 'abr', 'may', 'jun', //
      'jul', 'ago', 'sep', 'oct', 'nov', 'dic',
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }
}
