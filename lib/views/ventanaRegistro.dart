import 'package:flutter/material.dart';

class MyHomePageVentanaRegistro extends StatefulWidget {
  const MyHomePageVentanaRegistro({super.key});

  @override
  State<MyHomePageVentanaRegistro> createState() => _MyHomePageVentanaRegistroState();
}

class _MyHomePageVentanaRegistroState extends State<MyHomePageVentanaRegistro> {
  // Controladores para campos de texto
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _apellidoController = TextEditingController();
  final TextEditingController _correoController = TextEditingController();
  final TextEditingController _claveController = TextEditingController();
  final TextEditingController _confirmarClaveController = TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();

  // Variables para Calendario (DatePicker)
  DateTime _fechaNacimiento = DateTime.now();
  String _fechaSeleccionada = "";

  // Variables para ComboBox (Dropdown)
  String _paisSeleccionado = "Ecuador";
  final List<String> _paises = [
    "Ecuador",
    "Argentina",
    "Brasil",
    "Chile",
    "Colombia",
    "Peru",
    "Uruguay",
    "Paraguay",
    "Bolivia",
    "Venezuela",
  ];

  // Variables para RadioButton
  String _generoSeleccionado = "Masculino";

  // Metodo para seleccionar fecha
  Future<void> _seleccionarFecha() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _fechaNacimiento,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.blueGrey,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _fechaNacimiento) {
      setState(() {
        _fechaNacimiento = picked;
        _fechaSeleccionada =
            "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  void registrarUsuario() {
    String nombre = _nombreController.text.trim();
    String apellido = _apellidoController.text.trim();
    String correo = _correoController.text.trim();
    String clave = _claveController.text.trim();
    String confirmarClave = _confirmarClaveController.text.trim();
    String telefono = _telefonoController.text.trim();

    // Validacion de campos vacios
    if (nombre.isEmpty ||
        apellido.isEmpty ||
        correo.isEmpty ||
        clave.isEmpty ||
        confirmarClave.isEmpty ||
        telefono.isEmpty ||
        _fechaSeleccionada.isEmpty) {
      print("Registro fallido - Campos vacios");
      _mostrarMensaje("Error", "Por favor complete todos los campos");
      return;
    }

    // Validacion de correo
    if (!correo.contains("@") || !correo.contains(".")) {
      print("Registro fallido - Correo invalido");
      _mostrarMensaje("Error", "Ingrese un correo electronico valido");
      return;
    }

    // Validacion de claves
    if (clave != confirmarClave) {
      print("Registro fallido - Las claves no coinciden");
      _mostrarMensaje("Error", "Las claves no coinciden");
      return;
    }

    // Validacion de longitud de clave
    if (clave.length < 6) {
      print("Registro fallido - Clave muy corta");
      _mostrarMensaje("Error", "La clave debe tener al menos 6 caracteres");
      return;
    }

    // Registro exitoso
    print("Registro exitoso - Nuevo usuario:");
    print("Nombre: $nombre $apellido");
    print("Correo: $correo");
    print("Telefono: $telefono");
    print("Fecha de Nacimiento: $_fechaSeleccionada");
    print("Pais: $_paisSeleccionado");
    print("Genero: $_generoSeleccionado");

    _mostrarMensaje("Exito", "Usuario registrado correctamente");

    // Regresar al login despues de 2 segundos
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pop(context);
    });
  }

  void _mostrarMensaje(String titulo, String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensaje),
        backgroundColor: titulo == "Error" ? Colors.red : Colors.green,
        duration: const Duration(seconds: 2),
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
              "https://images.unsplash.com/photo-1506744038136-46273834b3fb?w=600&h=800&fit=crop",
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Container(
              width: 380,
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.92),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Nombre del estudiante
                  const Text(
                    "CASTILLO MEREJILDO JOSHUA JAVIER, ESPINOZA GOMEZ JENNIFFER MARISOL, GABINO VILLAO JOEL FABIAN, PARRA AGUAYO KEVIN JOEL, VERA CHUQUIMARCA LESLIE ARIANNA",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    "Registro de Usuario",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Campo 1: Nombre
                  TextField(
                    controller: _nombreController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Nombre",
                      prefixIcon: Icon(Icons.person),
                      hintText: "Ingrese su nombre",
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Campo 2: Apellido
                  TextField(
                    controller: _apellidoController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Apellido",
                      prefixIcon: Icon(Icons.person_outline),
                      hintText: "Ingrese su apellido",
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Campo 3: Correo Electronico
                  TextField(
                    controller: _correoController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Correo Electronico",
                      prefixIcon: Icon(Icons.email),
                      hintText: "ejemplo@correo.com",
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Campo 4: Telefono
                  TextField(
                    controller: _telefonoController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Telefono",
                      prefixIcon: Icon(Icons.phone),
                      hintText: "0999999999",
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Campo 5: Calendario (DatePicker)
                  GestureDetector(
                    onTap: _seleccionarFecha,
                    child: AbsorbPointer(
                      child: TextField(
                        controller: TextEditingController(
                          text: _fechaSeleccionada.isEmpty
                              ? "Seleccione fecha de nacimiento"
                              : _fechaSeleccionada,
                        ),
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: "Fecha de Nacimiento",
                          prefixIcon: const Icon(Icons.calendar_today),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.arrow_drop_down),
                            onPressed: _seleccionarFecha,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Campo 6: ComboBox (Dropdown)
                  DropdownButtonFormField<String>(
                    value: _paisSeleccionado,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Pais de Residencia",
                      prefixIcon: Icon(Icons.public),
                    ),
                    items: _paises.map((String pais) {
                      return DropdownMenuItem<String>(
                        value: pais,
                        child: Text(pais),
                      );
                    }).toList(),
                    onChanged: (String? nuevoPais) {
                      setState(() {
                        _paisSeleccionado = nuevoPais!;
                      });
                    },
                  ),
                  const SizedBox(height: 12),

                  // Campo 7: RadioButton (Genero)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Genero",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: RadioListTile<String>(
                                title: const Text("Masculino"),
                                value: "Masculino",
                                groupValue: _generoSeleccionado,
                                onChanged: (String? value) {
                                  setState(() {
                                    _generoSeleccionado = value!;
                                  });
                                },
                                contentPadding: EdgeInsets.zero,
                                dense: true,
                              ),
                            ),
                            Expanded(
                              child: RadioListTile<String>(
                                title: const Text("Femenino"),
                                value: "Femenino",
                                groupValue: _generoSeleccionado,
                                onChanged: (String? value) {
                                  setState(() {
                                    _generoSeleccionado = value!;
                                  });
                                },
                                contentPadding: EdgeInsets.zero,
                                dense: true,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: RadioListTile<String>(
                                title: const Text("Otro"),
                                value: "Otro",
                                groupValue: _generoSeleccionado,
                                onChanged: (String? value) {
                                  setState(() {
                                    _generoSeleccionado = value!;
                                  });
                                },
                                contentPadding: EdgeInsets.zero,
                                dense: true,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Campo 8: Clave
                  TextField(
                    controller: _claveController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Clave",
                      prefixIcon: Icon(Icons.lock),
                      hintText: "Minimo 6 caracteres",
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Campo 9: Confirmar Clave
                  TextField(
                    controller: _confirmarClaveController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Confirmar Clave",
                      prefixIcon: Icon(Icons.lock_outline),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Boton Registrar
                  ElevatedButton(
                    onPressed: () {
                      registrarUsuario();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.greenAccent.shade700,
                      foregroundColor: Colors.black,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Registrarse",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Boton Volver al Login
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Volver al Login",
                      style: TextStyle(fontSize: 16),
                    ),
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