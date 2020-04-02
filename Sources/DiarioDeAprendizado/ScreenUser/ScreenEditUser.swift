//
//  ScreenEditUser.swift
//  
//
//  Created by Vinicius Mesquita on 31/03/20.
//

import Foundation

class ScreenEditUser {

    weak var delegate: UserOptionsDelegate?
    let utils = Utils()
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
        
        while let input = readLine() {
            
            guard input != "0" else {
                break
            }
  
            switch input {
            case "1":
                print("Digite o novo valor:")
                guard let newValue = readLine() else { return }
                delegate?.editInformation(edit: .name, newValue: newValue)
            case "2":
                print("Digite o novo valor:")
                guard let newValue = readLine() else { return }
                delegate?.editInformation(edit: .password, newValue: newValue)
            default:
                print("Opção invalida")
            }
            utils.system("clear")
            print("usuario alterado")
            show()
        }
        
    }
    
        
         
    
}
