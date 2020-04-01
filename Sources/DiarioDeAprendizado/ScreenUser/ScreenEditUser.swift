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

        0 - voltar

        """)
    }

    func main() {
        delegate?.details()
        show()
        
        let currentUser = CurrentUser.instance
        
        guard let input = readLine() else { return }
        print("Digite o novo valor:")
        guard let newValue = readLine() else {
            return
        }
        switch input {
        case "1":
            delegate?.editInformation(user: currentUser, edit: .name, newValue: newValue)
        case "2":
            delegate?.editInformation(user: currentUser, edit: .password, newValue: newValue)
        default:
            print("Opção invalida")
        }
    }
    
}
