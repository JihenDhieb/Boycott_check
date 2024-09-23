import 'dart:convert';
import 'dart:typed_data';

class Produit {
  final String nom;
  final String codeBarre;
  final bool estBoycotter;
  final String image;

  Produit({
    required this.nom,
    required this.codeBarre,
    required this.estBoycotter,
    required this.image,
  });

  factory Produit.fromJson(Map<String, dynamic> json) {
    // Use a default empty string if 'codeBarre' is null
    final codeBarre = json['codeBarre'] ?? '';

    return Produit(
      nom: json['nom'] ?? 'Unknown', // Use 'Unknown' if 'nom' is missing
      codeBarre: codeBarre,
      estBoycotter: json['estBoycotter'] ?? false, // Default to false
      image:
          json['image'] ?? '', // Default to empty string if 'image' is missing
    );
  }

  Uint8List get imageBytes {
    try {
      return base64Decode(image);
    } catch (e) {
      print('Error decoding image: $e');
      return Uint8List(0); // Return an empty list in case of error
    }
  }
}
