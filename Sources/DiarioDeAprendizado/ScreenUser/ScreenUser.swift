//
//  ScreenUser.swift
//  
//
//  Created by Vinicius Mesquita on 24/03/20.
//

import Foundation

enum UserOptionEnum {
    case showInformation
    case editInformation
}

public class ScreenUser {
    
    let service = Service<Anotation>()
    weak var delegate: UserOptionsDelegate?
    var options = UserOptionEnum.editInformation
    
    func run() {
        
    }
    
    func show() {
        print("""

        MENU USUARIO:

        1 - visualizar dados
        2 - editar dados

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
                run()
            case "2":
                options = .editInformation
                run()
            default:
                print("?")
        }
        service.clearScreen()
        show()
        }
    }
}
