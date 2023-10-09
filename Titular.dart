class Titular {
  static int _proximoId = 1;
  final int id;
  final String nome;
  final String cpf;

  Titular(this.nome, this.cpf) : id = _proximoId++;
}