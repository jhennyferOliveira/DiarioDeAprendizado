//
//  ScreenUser.swift
//  
//
//  Created by Vinicius Mesquita on 24/03/20.
//

import Foundation

import Foundation

enum UserOptionEnum {
    case showInformation
    case editInformation
    case saveInformation
    case login
}

public class ScreenUser {
    
    weak var delegate: UserOptionsDelegate?
    var options = UserOptionEnum.editInformation
    let utils = Utils()
    
    /* Função responsavel por rodar as opções do menu escolhidas pelo usuário */
    func run() {
        switch options {
        case .showInformation:
            delegate?.details()
        case .editInformation:
            startEditUser()
        case .saveInformation:
            register()
        case .login:
            login()
        }
    }
    
    /* Responsavel por mostrar o menu na tela do terminal */
    func show() {
        print("""

        MENU USUARIO:

        1 - visualizar dados
        2 - editar dados
        3 - cadastrar
        4 - login

        0 - voltar
        """)
    }
    
    /* Função utiliziada para inicializar as opoções e o loop de menu na tela */
    func main() {
        show()
        while let input = readLine() {
         
         guard input != "0" else {
             break
         }
        switch input {
            case "1":
                options = .showInformation
                utils.system("clear")
                run()
            case "2":
                options = .editInformation
                utils.system("clear")
                run()
            case "3":
                options = .saveInformation
                utils.system("clear")
                run()
            case "4":
                options = .login
                run()
            default:
                print("?")
        }
        show()
        }
    }
    
    /* inicializa uma chamada para edição de dados do usuário */
    private func startEditUser() {
        let screen = ScreenEditUser()
        let options = UserOptions()
        screen.delegate = options
        screen.main()
    }
    
    /* Realiza o registro de um novo usuário */
    private func register() {
        
        print("digite o seu nome")
        guard let nome = readLine() else {
            return
        }
        
        print("digite um username, será usado para o login")
        guard let username = readLine() else {
            return
        }
        
        print("digite a matricula")
        guard let matricula = readLine() else {
            return
        }
        print("digite a senha")
        guard let password = readLine() else {
            return
        }
        let hash = password.md5()
        delegate?.saveInformation(nome: nome, username: username, matricula: matricula, password: hash)
        
    }
    
    /* Solicita username e senha para realizar a autenticação */
    private func login() {
        print("digite o username")
        guard let username = readLine() else {
            return
        }
        print("digite a senha")
        guard let password = readLine() else {
            return
        }
        // gera um codigo hash para salvar a senha
        let hash = password.md5()
        let result = delegate?.checkInformation(username: username, password: hash)
        utils.system("clear")
        
        if result == true {
            CurrentUser.instance.isLogged = true
            print("Sucesso em login!")
        } else {
            print("login erro!")
        }
    }
}
