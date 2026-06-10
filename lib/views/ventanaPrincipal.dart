import 'package:flutter/material.dart';

class MyHomePageVentanaPrincipal extends StatefulWidget {
  const MyHomePageVentanaPrincipal({super.key});

  @override
  State<MyHomePageVentanaPrincipal> createState() => _MyHomePageVentanaPrincipalState();
}

class _MyHomePageVentanaPrincipalState extends State<MyHomePageVentanaPrincipal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              "https://images.unsplash.com/photo-1522778119026-d647f0596b68?w=600&h=800&fit=crop",
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Container(
            width: 370,
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text( "CASTILLO MEREJILDO JOSHÚA JAVIER, ESPINOZA GOMEZ JENNIFFER MARISOL, GABINO VILLAO JOEL FABIAN, PARRA AGUAYO KEVIN JOEL, VERA CHUQUIMARCA LESLIE ARIANNA",

                  style: TextStyle(fontSize: 16, color: Colors.grey[700], fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Text(
                  "Matricula: 20240001",
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
                const SizedBox(height: 20),
                const Icon(Icons.sports_soccer, size: 80, color: Colors.blueGrey),
                const SizedBox(height: 20),
                const Text(
                  "Bienvenido al Sistema",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.blueGrey),
                ),
                const SizedBox(height: 15),
                const Text(
                  "FIFA World Cup 2026",
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 45),
                  ),
                  child: const Text("Cerrar Sesion", style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}