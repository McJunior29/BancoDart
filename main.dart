import 'dart:io';

import 'Conta.dart';
import 'Titular.dart';

class Banco {
  static int _proximoId = 1;
  final int id;
  final List<Titular> titulares = [];
  final List<Conta> contas = [];

  Banco() : id = _proximoId++;

  void cadastrarTitular(String nome, String cpf) {
    final titular = Titular(nome, cpf);
    titulares.add(titular);
    print("Titular cadastrado com sucesso. ID: ${titular.id}");
  }

  void listarTitulares() {
    print("\nLista de Titulares:");
    for (var titular in titulares) {
      print("ID: ${titular.id}, Nome: ${titular.nome}, CPF: ${titular.cpf}");
    }
  }

  void cadastrarConta(int titularId) {
    final titular = encontrarTitular(titularId);
    if (titular != null) {
      final conta = Conta(titular);
      contas.add(conta);
      print("Conta cadastrada com sucesso. Número: ${conta.numero}");
    } else {
      print("Titular não encontrado.");
    }
  }

  Titular? encontrarTitular(int id) {
    return titulares.firstWhere((titular) => titular.id == id);
  }

  void listarContas() {
    print("\nLista de Contas:");
    for (var conta in contas) {
      print("Número: ${conta.numero}, Titular: ${conta.titular.nome}");
    }
  }

  void operarConta(int numeroConta) {
    final conta = encontrarConta(numeroConta);
    if (conta != null) {
      while (true) {
        print("\nMenu de Operações para Conta ${conta.numero}:");
        print("1) Sacar");
        print("2) Depositar");
        print("3) Transferir");
        print("4) Mostrar Saldo");
        print("5) Voltar ao Menu Principal");

        var opcao = int.parse(stdin.readLineSync()!);

        switch (opcao) {
          case 1:
            print("Digite o valor para sacar:");
            var valor = double.parse(stdin.readLineSync()!);
            conta.sacar(valor);
            break;
          case 2:
            print("Digite o valor para depositar:");
            var valor = double.parse(stdin.readLineSync()!);
            conta.depositar(valor);
            break;
          case 3:
            print("Digite o número da conta para transferir:");
            var numeroDestino = int.parse(stdin.readLineSync()!);
            var contaDestino = encontrarConta(numeroDestino);
            if (contaDestino != null) {
              print("Digite o valor para transferir:");
              var valor = double.parse(stdin.readLineSync()!);
              conta.transferir(contaDestino, valor);
            } else {
              print("Conta de destino não encontrada.");
            }
            break;
          case 4:
            print("Saldo atual: ${conta.mostrarSaldo()}");
            break;
          case 5:
            return;
          default:
            print("Opção inválida.");
        }
      }
    } else {
      print("Conta não encontrada.");
    }
  }

  Conta? encontrarConta(int numero) {
    return contas.firstWhere((conta) => conta.numero == numero);
  }
}


void main() {
  final banco = Banco();

  while (true) {
    print("\nMenu Principal:");
    print("1) Cadastro de Titular");
    print("2) Cadastro de Conta");
    print("3) Operar Conta");
    print("4) Listar Titulares");
    print("5) Listar Contas");
    print("6) Sair");

    var opcao = int.parse(stdin.readLineSync()!);

    switch (opcao) {
      case 1:
        print("Digite o nome do titular:");
        var nome = stdin.readLineSync()!;
        print("Digite o CPF do titular:");
        var cpf = stdin.readLineSync()!;
        banco.cadastrarTitular(nome, cpf);
        break;
      case 2:
        banco.listarTitulares();
        print("Digite o ID do titular para associar a conta:");
        var titularId = int.parse(stdin.readLineSync()!);
        banco.cadastrarConta(titularId);
        break;
      case 3:
        banco.listarContas();
        print("Digite o número da conta para operar:");
        var numeroConta = int.parse(stdin.readLineSync()!);
        banco.operarConta(numeroConta);
        break;
      case 4:
        banco.listarTitulares();
        break;
      case 5:
        banco.listarContas();
        break;
      case 6:
        exit(0);
      default:
        print("Opção inválida.");
    }
  }
}
