import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class TicketService {
  // A "chave" onde os dados serão guardados na memória local
  static const String _key = 'meus_ingressos';

  // 1. CRIAR E ARMAZENAR (Create)
  static Future<void> salvarIngresso(Map<String, dynamic> ingresso) async {
    final prefs = await SharedPreferences.getInstance();
    // Recupera a lista atual ou cria uma vazia
    List<String> ingressos = prefs.getStringList(_key) ?? [];
    // Adiciona o novo ingresso transformado em texto (JSON)
    ingressos.add(jsonEncode(ingresso));
    // Salva a lista atualizada no dispositivo
    await prefs.setStringList(_key, ingressos);
  }

  // 2. RECUPERAR (Read)
  static Future<List<Map<String, dynamic>>> obterIngressos() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> ingressosString = prefs.getStringList(_key) ?? [];
    // Transforma os textos de volta para formato de mapa (dados do Flutter)
    return ingressosString
        .map((item) => jsonDecode(item) as Map<String, dynamic>)
        .toList();
  }

  // 3. REMOVER (Delete)
  static Future<void> removerIngresso(String id) async {
    final prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> ingressos = await obterIngressos();
    // Remove o ingresso que tiver o ID correspondente
    ingressos.removeWhere((ingresso) => ingresso['id'] == id);
    // Salva a lista atualizada
    List<String> ingressosAtualizados = ingressos.map((item) => jsonEncode(item)).toList();
    await prefs.setStringList(_key, ingressosAtualizados);
  }

  // 4. ATUALIZAR (Update) - Exemplo: Alterar a poltrona comprada
  static Future<void> atualizarIngresso(String id, String novaPoltrona) async {
    final prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> ingressos = await obterIngressos();
    
    // Procura o ingresso e atualiza a poltrona
    for (var ingresso in ingressos) {
      if (ingresso['id'] == id) {
        ingresso['seat'] = novaPoltrona;
      }
    }
    
    List<String> ingressosAtualizados = ingressos.map((item) => jsonEncode(item)).toList();
    await prefs.setStringList(_key, ingressosAtualizados);
  }
}