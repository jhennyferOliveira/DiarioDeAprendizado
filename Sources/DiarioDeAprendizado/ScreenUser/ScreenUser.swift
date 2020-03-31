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
    let util = Utils()
    
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
    
    func main() {
        show()
        while let input = readLine() {
         
         guard input != "0" else {
             break
         }
        switch input {
            case "1":
                options = .showInformation
                util.system("clear")
                run()
            case "2":
                options = .editInformation
                util.system("clear")
                run()
            case "3":
                options = .saveInformation
                util.system("clear")
                run()
            case "4":
                options = .login
                run()
            default:
                print("?")
        }
        // util.system("clear")
        show()
        }
    }
    
    private func startEditUser() {
        let screen = ScreenEditUser()
        let options = UserOptions()
        screen.delegate = options
        screen.main()
    }
    
    /* criar um menu para esta funcao */
    private func register() {
        print("digite a matricula")
        guard let matricula = readLine() else {
            return
        }
        print("digite a senha")
        guard let password = readLine() else {
            return
        }
        let hash = password.md5() // hashing pssword
        delegate?.saveInformation(matricula: matricula, password: hash)
        
    }
    
    /* criar um menu para esta funcao */
    private func login() {
        print("digite o username")
        guard let username = readLine() else {
            return
        }
        print("digite a senha")
        guard let password = readLine() else {
            return
        }
        let hash = password.md5() // hashing password
        let result = delegate?.checkInformation(username: username, password: hash)
        util.system("clear")
        
        if result == true {
            print("Sucesso em login!")
        } else {
            print("login erro!")
        }
    }
}
