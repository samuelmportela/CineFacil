import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationService {
  static Future<String> obterCidadeAtual() async {
    try {
      // 1. Verifica se o hardware de GPS está ligado
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return 'GPS desativado';
      }

      // 2. Verifica e solicita permissão em tempo de execução (Runtime)
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return 'Permissão negada';
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return 'Localização bloqueada nos ajustes';
      }

      // 3. Captura as coordenadas via Platform Channel
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low, // Economiza bateria (Aula 20)
      );

      // 4. Converte latitude/longitude em nome de cidade (Reverse Geocoding)
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        final cidade = place.subAdministrativeArea ?? place.locality ?? 'Sua Região';
        return cidade;
      }

      return 'Localização obtida';
    } catch (e) {
      // Fallback gracioso caso rode em navegador sem suporte ou ocorra falha de hardware
      return 'Goiânia (Padrão)';
    }
  }
}