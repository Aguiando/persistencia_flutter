import 'package:flutter/material.dart';
import '../../domain/entities/pessoa.dart';

class PessoaItem extends StatelessWidget {
  final Pessoa pessoa;
  final VoidCallback onEditar;
  final VoidCallback onApagar;

  const PessoaItem({
    super.key,
    required this.pessoa,
    required this.onEditar,
    required this.onApagar,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(pessoa.id ?? '${pessoa.nome}-${pessoa.idade}'),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        color: Colors.red,
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      confirmDismiss: (_) async {
        return await showDialog<bool>(
              context: context,
              builder: (ctx) => AlertDialog(
                title: const Text('Remover registro'),
                content: Text('Deseja remover ${pessoa.nome}?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(ctx, false),
                    child: const Text('Cancelar'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(ctx, true),
                    child: const Text('Remover'),
                  ),
                ],
              ),
            ) ??
            false;
      },
      onDismissed: (_) => onApagar(),
      child: ListTile(
        tileColor: Colors.grey.withValues(alpha: 0.06),
        title: Text('${pessoa.nome} (${pessoa.idade})'),
        subtitle: Text('ID: ${pessoa.id ?? '-'}'),
        onTap: onEditar,
        trailing: IconButton(
          tooltip: 'Editar',
          icon: const Icon(Icons.edit),
          onPressed: onEditar,
        ),
      ),
    );
  }
}
