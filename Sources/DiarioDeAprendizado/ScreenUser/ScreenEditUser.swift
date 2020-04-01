//
//  ScreenEditUser.swift
//  
//
//  Created by Vinicius Mesquita on 31/03/20.
//

import Foundation

class ScreenEditUser {

    weak var delegate: UserOptionsDelegate?
    
    func show() {
        print("""

        EDITAR:

        1 - Nome de Usuário
        2 - Senha

        """)
    }

    func main() {
        delegate?.details()
        show()
        guard let input = readLine() else { return }
        print("Digite o novo valor:")
        guard let newValue = readLine() else {
            return
        }
        switch input {
        case "1":
            print("editar")
        case "2":
            print("editar")
        default:
            print("Opção invalida")
        }
    }
    
}
