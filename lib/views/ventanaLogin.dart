import 'package:flutter/material.dart';

class MyHomePageVentanaLogin extends StatefulWidget {
  const MyHomePageVentanaLogin({super.key, required this.title});

  final String title;

  @override
  State<MyHomePageVentanaLogin> createState() => _MyHomePageStateVentanaLogin();
}

class _MyHomePageStateVentanaLogin extends State<MyHomePageVentanaLogin> {
  final TextEditingController _correoController = TextEditingController();
  final TextEditingController _claveController = TextEditingController();

  final String usuarioValido = "admin@fifa.com";
  final String claveValida = "fifa2026";

  void validarInicioSesion() {
    String correo = _correoController.text.trim();
    String clave = _claveController.text.trim();

    if (correo.isEmpty || clave.isEmpty) {
      print("Acceso Negado - Campos vacios");
      _mostrarMensaje("Error", "Por favor complete todos los campos");
    } else if (correo == usuarioValido && clave == claveValida) {
      print("Acceso concedido");
      Navigator.pushNamed(context, "principal");
    } else {
      print("Acceso Negado - Credenciales incorrectas");
      _mostrarMensaje("Error", "Correo o clave incorrectos");
    }
  }

  void _mostrarMensaje(String titulo, String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensaje),
        backgroundColor: titulo == "Error" ? Colors.red : Colors.green,
      ),
    );
  }

  void irARegistro() {
    print("Va a registrar un nuevo usuario");
    Navigator.pushNamed(context, "registro");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              "https://images.unsplash.com/photo-1506744038136-46273834b3fb?w=600&h=800&fit=crop",
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
                Text(
                  "CASTILLO MEREJILDO JOSHÚA JAVIER, ESPINOZA GOMEZ JENNIFFER MARISOL, GABINO VILLAO JOEL FABIAN, PARRA AGUAYO KEVIN JOEL, VERA CHUQUIMARCA LESLIE ARIANNA",
                  style: TextStyle(fontSize: 16, color: Colors.grey[700], fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Text(
                  "FIFA World Cup",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blueGrey),
                ),
                const SizedBox(height: 25),
                TextField(
                  controller: _correoController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Correo Electronico",
                    hintText: "admin@fifa.com",
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: _claveController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Clave",
                    hintText: "fifa2026",
                  ),
                ),
                const SizedBox(height: 25),
                ElevatedButton(
                  onPressed: () {
                    validarInicioSesion();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.limeAccent,
                    foregroundColor: Colors.black,
                    minimumSize: const Size(double.infinity, 45),
                  ),
                  child: const Text("Ingresar", style: TextStyle(fontSize: 16)),
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () {
                    irARegistro();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amberAccent,
                    foregroundColor: Colors.black,
                    minimumSize: const Size(double.infinity, 45),
                  ),
                  child: const Text("Registrarse", style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}