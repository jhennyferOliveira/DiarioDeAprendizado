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

        1 - Nome
        2 - Senha
        3 - Matricula

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
                print("Digite um novo nome:")
                guard let newValue = readLine() else { return }
                delegate?.editInformation(edit: .name, newValue: newValue)
            case "2":
                print("Digite uma nova senha:")
                guard let newValue = readLine() else { return }
                delegate?.editInformation(edit: .password, newValue: newValue)
            case "3":
                print("Digite uma nova matricula:")
                guard let newValue = readLine() else { return }
                delegate?.editInformation(edit: .studentcode, newValue: newValue)
            default:
                print("Opção invalida")
            }
            utils.system("clear")
            print("usuario alterado")
            break
        }
        
    }
    
        
         
    
}
