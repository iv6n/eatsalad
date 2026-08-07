import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

class StoreLocation {
  const StoreLocation({
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
  });

  final String name;
  final String address;
  final double latitude;
  final double longitude;
}

// Sucursales de ejemplo — reemplazar por las ubicaciones reales del negocio
// (nombre, dirección y coordenadas de cada sucursal).
const List<StoreLocation> _storeLocations = [
  StoreLocation(
    name: 'Eatsalad Centro',
    address: 'Dirección pendiente de configurar',
    latitude: 29.0729,
    longitude: -110.9559,
  ),
  StoreLocation(
    name: 'Eatsalad Norte',
    address: 'Dirección pendiente de configurar',
    latitude: 29.1026,
    longitude: -110.9773,
  ),
];

enum _LocationStatus { loading, success, permissionDenied, serviceDisabled, error }

class Locations extends StatefulWidget {
  const Locations({super.key});
  static const String id = 'pag1';

  @override
  State<Locations> createState() => _LocationsState();
}

class _LocationsState extends State<Locations> {
  _LocationStatus _status = _LocationStatus.loading;
  List<MapEntry<StoreLocation, double?>> _sortedLocations =
      _storeLocations.map((location) => MapEntry(location, null)).toList();

  @override
  void initState() {
    super.initState();
    _loadNearbyLocations();
  }

  Future<void> _loadNearbyLocations() async {
    setState(() => _status = _LocationStatus.loading);
    try {
      if (!await Geolocator.isLocationServiceEnabled()) {
        if (!mounted) return;
        setState(() => _status = _LocationStatus.serviceDisabled);
        return;
      }

      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        if (!mounted) return;
        setState(() => _status = _LocationStatus.permissionDenied);
        return;
      }

      final position = await Geolocator.getCurrentPosition();
      final withDistance = _storeLocations
          .map(
            (location) => MapEntry(
              location,
              Geolocator.distanceBetween(
                position.latitude,
                position.longitude,
                location.latitude,
                location.longitude,
              ),
            ),
          )
          .toList()
        ..sort((a, b) => a.value.compareTo(b.value));

      if (!mounted) return;
      setState(() {
        _sortedLocations = withDistance;
        _status = _LocationStatus.success;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() => _status = _LocationStatus.error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: const Text(
          'Sucursales',
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Container(color: Colors.grey[300], height: .45),
        ),
      ),
      body: SafeArea(child: _buildBody()),
    );
  }

  Widget _buildBody() {
    switch (_status) {
      case _LocationStatus.loading:
        return const Center(child: CircularProgressIndicator());
      case _LocationStatus.permissionDenied:
        return _StatusMessage(
          message:
              'Necesitamos tu ubicación para recomendarte la sucursal más '
              'cercana.',
          onRetry: _loadNearbyLocations,
        );
      case _LocationStatus.serviceDisabled:
        return _StatusMessage(
          message: 'Activa el GPS de tu dispositivo para ver las sucursales '
              'más cercanas.',
          onRetry: _loadNearbyLocations,
        );
      case _LocationStatus.error:
        return _StatusMessage(
          message: 'No pudimos obtener tu ubicación. Intenta de nuevo.',
          onRetry: _loadNearbyLocations,
        );
      case _LocationStatus.success:
        return ListView.separated(
          padding: const EdgeInsets.all(12),
          itemCount: _sortedLocations.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final entry = _sortedLocations[index];
            return _LocationCard(
              location: entry.key,
              distanceInMeters: entry.value,
            );
          },
        );
    }
  }
}

class _StatusMessage extends StatelessWidget {
  const _StatusMessage({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.location_off, size: 40, color: Colors.black26),
            const SizedBox(height: 12),
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: 12),
            ElevatedButton(onPressed: onRetry, child: const Text('Reintentar')),
          ],
        ),
      ),
    );
  }
}

class _LocationCard extends StatelessWidget {
  const _LocationCard({required this.location, required this.distanceInMeters});

  final StoreLocation location;
  final double? distanceInMeters;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: const Icon(Icons.storefront, color: Colors.green),
        title: Text(location.name, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(
          distanceInMeters == null
              ? location.address
              : '${location.address}\n${_formatDistance(distanceInMeters!)}',
        ),
        isThreeLine: distanceInMeters != null,
        trailing: IconButton(
          icon: const Icon(Icons.directions),
          onPressed: () => _openDirections(location),
        ),
      ),
    );
  }

  String _formatDistance(double meters) {
    if (meters < 1000) return '${meters.round()} m';
    return '${(meters / 1000).toStringAsFixed(1)} km';
  }

  Future<void> _openDirections(StoreLocation location) async {
    final uri = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=${location.latitude},${location.longitude}',
    );
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}
