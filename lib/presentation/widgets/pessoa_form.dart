import 'package:flutter/material.dart';
import '../../domain/entities/pessoa.dart';

class PessoaForm extends StatefulWidget {
  const PessoaForm({
    super.key,
    required this.onSave,
    this.initial,
    this.onCancel, // opcional
    this.editingPessoa, // Pessoa? para edição
    this.isLoading = false, // bool para spinner
  });

  final Future<bool> Function(String nome, int idade) onSave;
  final VoidCallback? onCancel;
  final Pessoa? editingPessoa;
  final bool isLoading;

  final Pessoa? initial;

  @override
  State<PessoaForm> createState() => _PessoaFormState();
}

class _PessoaFormState extends State<PessoaForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nomeCtrl;
  late final TextEditingController _idadeCtrl;

  @override
  void initState() {
    super.initState();
    _nomeCtrl = TextEditingController(text: widget.initial?.nome ?? '');
    _idadeCtrl = TextEditingController(
      text: widget.initial?.idade != null
          ? widget.initial!.idade.toString()
          : '',
    );
  }

  @override
  void dispose() {
    _nomeCtrl.dispose();
    _idadeCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() != true) return;
    final nome = _nomeCtrl.text.trim();
    final idade = int.parse(_idadeCtrl.text.trim());
    widget.onSave(nome, idade); // ← usa o callback (nada além disso)
    Navigator.of(context).maybePop();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.initial != null;

    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        top: 16,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              isEditing ? 'Editar pessoa' : 'Nova pessoa',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _nomeCtrl,
              decoration: const InputDecoration(
                labelText: 'Nome',
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.next,
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Informe o nome' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _idadeCtrl,
              decoration: const InputDecoration(
                labelText: 'Idade',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'Informe a idade';
                final n = int.tryParse(v.trim());
                if (n == null || n < 0) return 'Idade inválida';
                return null;
              },
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).maybePop(),
                    child: const Text('Cancelar'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton(
                    onPressed: _submit,
                    child: Text(isEditing ? 'Salvar alterações' : 'Salvar'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
