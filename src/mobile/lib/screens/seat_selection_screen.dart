import 'package:flutter/material.dart';
import 'checkout_screen.dart';

class SeatSelectionScreen extends StatefulWidget {
  final String movieTitle;

  const SeatSelectionScreen({super.key, required this.movieTitle});

  @override
  State<SeatSelectionScreen> createState() => _SeatSelectionScreenState();
}

class _SeatSelectionScreenState extends State<SeatSelectionScreen> {
  String? selectedSeat;
  final List<String> seats = ['A1', 'A2', 'A3', 'B1', 'B2', 'B3', 'C1', 'C2', 'C3'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Escolha seu Assento'),
        backgroundColor: Colors.blue[900],
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Semantics(
              label: 'Ilustração da tela do cinema',
              child: Container(
                padding: const EdgeInsets.all(12),
                width: double.infinity,
                color: Colors.grey[300],
                child: const Text('TELA DO CINEMA', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 60, // A poltrona terá no máximo 60 pixels de largura
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1.0, // Mantém os botões quadrados
                ),
                itemCount: seats.length,
                itemBuilder: (context, index) {
                  final seat = seats[index];
                  final isSelected = selectedSeat == seat;

                  return Semantics(
                    button: true,
                    label: 'Assento $seat',
                    hint: isSelected ? 'Selecionado' : 'Disponível para seleção',
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedSeat = seat;
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.green : Colors.blue[200],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          seat,
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            if (selectedSeat != null)
              Semantics(
                liveRegion: true,
                child: Text('Assento selecionado: $selectedSeat', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green)),
              ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[900],
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 54),
                ),
                onPressed: selectedSeat == null ? null : () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CheckoutScreen(movieTitle: widget.movieTitle, seat: selectedSeat!),
                    ),
                  );
                },
                child: const Text('Avançar para o Pagamento', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}