import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Modelo de noticia
class Noticia {
  final String titulo;
  final String descripcion;
  final String fuente;

  Noticia({
    required this.titulo,
    required this.descripcion,
    required this.fuente,
  });
}

// Descarga noticias vía HTTP desde RSS de dos periódicos ecuatorianos
Future<List<Noticia>> descargarNoticias(String periodico) async {
  final urls = {
    'El Universo':
        'https://api.rss2json.com/v1/api.json?rss_url=https://www.eluniverso.com/feed/',
    'El Comercio':
        'https://api.rss2json.com/v1/api.json?rss_url=https://www.elcomercio.com/feed/',
  };

  try {
    final response = await http
        .get(Uri.parse(urls[periodico]!))
        .timeout(const Duration(seconds: 10));

    if (response.statusCode != 200) return _sinConexion(periodico);

    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final items = (data['items'] as List<dynamic>?) ?? [];

    return items.take(10).map((item) {
      final titulo = (item['title'] as String? ?? '').trim();
      final descripcion = (item['description'] as String? ?? '')
          .replaceAll(RegExp(r'<[^>]*>'), '')
          .trim();
      return Noticia(titulo: titulo, descripcion: descripcion, fuente: periodico);
    }).toList();
  } catch (_) {
    return _sinConexion(periodico);
  }
}

List<Noticia> _sinConexion(String fuente) => [
      Noticia(
        titulo: 'Sin conexión',
        descripcion: 'No se pudieron cargar las noticias. Verifica tu internet.',
        fuente: fuente,
      ),
    ];

// Pantalla de noticias con botones de menú para cambiar periódico
class VentanaNoticias extends StatefulWidget {
  const VentanaNoticias({super.key});

  @override
  State<VentanaNoticias> createState() => _VentanaNoticiasState();
}

class _VentanaNoticiasState extends State<VentanaNoticias> {
  static const _periodicos = ['El Universo', 'El Comercio'];
  int _seleccionado = 0;
  late Future<List<Noticia>> _futuro;

  @override
  void initState() {
    super.initState();
    _futuro = descargarNoticias(_periodicos[_seleccionado]);
  }

  void _cambiar(int indice) {
    setState(() {
      _seleccionado = indice;
      _futuro = descargarNoticias(_periodicos[_seleccionado]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          // Botones de menú para seleccionar periódico
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: List.generate(_periodicos.length, (i) {
                final activo = i == _seleccionado;
                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: i > 0 ? 8 : 0),
                    child: FilledButton(
                      onPressed: () => _cambiar(i),
                      style: FilledButton.styleFrom(
                        backgroundColor: activo
                            ? const Color(0xFF1565C0)
                            : const Color(0xFFE3F2FD),
                        foregroundColor:
                            activo ? Colors.white : const Color(0xFF1565C0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        _periodicos[i],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          const Divider(height: 1),
          // Lista de noticias descargadas
          Expanded(
            child: FutureBuilder<List<Noticia>>(
              future: _futuro,
              builder: (context, snap) {
                if (snap.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                final noticias = snap.data ?? [];
                return RefreshIndicator(
                  onRefresh: () async => setState(() {
                    _futuro = descargarNoticias(_periodicos[_seleccionado]);
                  }),
                  child: ListView.separated(
                    padding: const EdgeInsets.all(12),
                    itemCount: noticias.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (_, i) => _NoticiaCard(noticia: noticias[i]),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _NoticiaCard extends StatelessWidget {
  const _NoticiaCard({required this.noticia});
  final Noticia noticia;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: const BorderSide(color: Color(0xFFE1E6ED)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Etiqueta del periódico
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: const Color(0xFF1565C0).withOpacity(0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                noticia.fuente,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1565C0),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              noticia.titulo,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                height: 1.3,
              ),
            ),
            if (noticia.descripcion.isNotEmpty) ...[
              const SizedBox(height: 6),
              Text(
                noticia.descripcion,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Color(0xFF667085), height: 1.4),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
