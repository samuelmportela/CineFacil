import 'package:flutter/material.dart';
import '../services/ticket_service.dart';

class TicketProvider extends ChangeNotifier {
  List> _ingressos = [];
  bool _carregando = false;

  List> get ingressos => _ingressos;
  bool get carregando => _carregando;
  int get totalIngressos => _ingressos.length; // Dado compartilhado com a Home!

  TicketProvider() {
    carregarIngressos();
  }

  Future<void> carregarIngressos() async {
    _carregando = true;
    notifyListeners();

    _ingressos = await TicketService.obterIngressos();
    
    _carregando = false;
    notifyListeners(); // Avisa todas as telas que os dados chegaram
  }

  Future<void> adicionarIngresso(Map<String, dynamic> novoIngresso) async {
    await TicketService.salvarIngresso(novoIngresso);
    await carregarIngressos(); // Atualiza a lista global e notifica a UI
  }

  Future<void> removerIngresso(String id) async {
    await TicketService.removerIngresso(id);
    await carregarIngressos(); // Atualiza a lista global e notifica a UI
  }
}