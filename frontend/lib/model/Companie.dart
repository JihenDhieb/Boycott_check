import 'dart:convert';
import 'dart:typed_data';

class Companie {
  final String nom;
  final bool estBoycotter;
  final String image;

  Companie({
    required this.nom,
    required this.estBoycotter,
    required this.image,
  });
  factory Companie.formJson(Map<String, dynamic> json) {
    return Companie(
        nom: json['nom'] ?? 'Unknown',
        estBoycotter: json['estBoycotter'] ?? false,
        image: json['image'] ?? '');
  }
  Uint8List get imageBytes {
    try {
      return base64Decode(image);
    } catch (e) {
      print('Error decode image $e');
      return Uint8List(0);
    }
  }
}
