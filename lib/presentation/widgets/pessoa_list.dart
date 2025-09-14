import 'package:flutter/material.dart';
import '../../domain/entities/pessoa.dart';
import 'pessoa_item.dart';

class PessoaList extends StatelessWidget {
  final List<Pessoa> pessoas;
  final void Function(Pessoa) onEditar;
  final void Function(Pessoa) onApagar;

  const PessoaList({
    super.key,
    required this.pessoas,
    required this.onEditar,
    required this.onApagar,
  });

  @override
  Widget build(BuildContext context) {
    if (pessoas.isEmpty) {
      return const Center(
        child: Text('Nenhuma pessoa cadastrada.'),
      );
    }
    return ListView.separated(
      padding: const EdgeInsets.all(12),
      itemCount: pessoas.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final p = pessoas[index];
        return PessoaItem(
          pessoa: p,
          onEditar: () => onEditar(p),
          onApagar: () => onApagar(p),
        );
      },
    );
  }
}
