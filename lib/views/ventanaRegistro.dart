import 'package:flutter/material.dart';

class MyHomePageVentanaRegistro extends StatefulWidget {
  const MyHomePageVentanaRegistro({super.key});

  @override
  State<MyHomePageVentanaRegistro> createState() => _MyHomePageVentanaRegistroState();
}

class _MyHomePageVentanaRegistroState extends State<MyHomePageVentanaRegistro> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _correoController = TextEditingController();
  final TextEditingController _claveController = TextEditingController();
  final TextEditingController _confirmarClaveController = TextEditingController();

  void registrarUsuario() {
    String nombre = _nombreController.text.trim();
    String correo = _correoController.text.trim();
    String clave = _claveController.text.trim();
    String confirmarClave = _confirmarClaveController.text.trim();

    if (nombre.isEmpty || correo.isEmpty || clave.isEmpty || confirmarClave.isEmpty) {
      print("Registro fallido - Campos vacios");
      _mostrarMensaje("Error", "Por favor complete todos los campos");
    } else if (clave != confirmarClave) {
      print("Registro fallido - Las claves no coinciden");
      _mostrarMensaje("Error", "Las claves no coinciden");
    } else {
      print("Registro exitoso - Nuevo usuario: $nombre, $correo");
      _mostrarMensaje("Exito", "Usuario registrado correctamente");
      Navigator.pop(context);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              "https://images.unsplash.com/photo-1533473359331-840569607314?w=600&h=800&fit=crop",
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
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
                  const Text(
                    "Registro de Usuario",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blueGrey),
                  ),
                  const SizedBox(height: 25),
                  TextField(
                    controller: _nombreController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Nombre Completo",
                      prefixIcon: Icon(Icons.person),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: _correoController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Correo Electronico",
                      prefixIcon: Icon(Icons.email),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: _claveController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Clave",
                      prefixIcon: Icon(Icons.lock),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: _confirmarClaveController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Confirmar Clave",
                      prefixIcon: Icon(Icons.lock_outline),
                    ),
                  ),
                  const SizedBox(height: 25),
                  ElevatedButton(
                    onPressed: () {
                      registrarUsuario();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.greenAccent,
                      foregroundColor: Colors.black,
                      minimumSize: const Size(double.infinity, 45),
                    ),
                    child: const Text("Registrarse", style: TextStyle(fontSize: 16)),
                  ),
                  const SizedBox(height: 15),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Volver al Login"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}