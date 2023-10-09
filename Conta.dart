

import 'Titular.dart';

class Conta {
  static int _proximoNumero = 1;
  final int numero;
  final Titular titular;
  double saldo = 0.0;

  Conta(this.titular) : numero = _proximoNumero++;

  void sacar(double valor) {
    if (valor > 0 && valor <= saldo) {
      saldo -= valor;
      print("Saque de $valor realizado com sucesso.");
    } else {
      print("Saque inválido.");
    }
  }

  void depositar(double valor) {
    if (valor > 0) {
      saldo += valor;
      print("Depósito de $valor realizado com sucesso.");
    } else {
      print("Depósito inválido.");
    }
  }

  void transferir(Conta contaDestino, double valor) {
    if (valor > 0 && valor <= saldo) {
      saldo -= valor;
      contaDestino.saldo += valor;
      print("Transferência de $valor para a Conta ${contaDestino.numero} realizada com sucesso.");
    } else {
      print("Transferência inválida.");
    }
  }

  double mostrarSaldo() {
    return saldo;
  }
}