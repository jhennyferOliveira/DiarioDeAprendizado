//
//  File.swift
//
//
//  Created by Jhennyfer Rodrigues de Oliveira on 31/03/20.
//

import Foundation

class ScreenEditSubject{
    let utils = Utils()
    weak var delegate: SubjectOptionsDelegate?
    
    func showSubmenuEdit() {
        print("""

        EDITAR:

        1 - Nome disciplina
        2 - Nota 1
        3 - Nota 2

        0 - Voltar

        """)
    }
    
    
    func main() {
        delegate?.details()
        
        print("Digite o id para selecionar a disciplina: ")
        guard let input = readLine() else {
            return
        }
        guard let id = Int(input) else {
            print("digite um id válido")
            return
        }
        
        showSubmenuEdit()
        while let input = readLine() {
            guard input != "0" else {
                break
            }
            guard let subject = delegate?.selectSubject(id: id) else {
                return
            }
            
            print("Digite o novo valor:")
            guard let newValue = readLine() else {
                return
            }
            switch input {
            case "1":
                delegate?.edit(subject: subject, edit: .name, newValue: newValue)
            case "2":
                delegate?.edit(subject: subject, edit: .grade1, newValue: newValue)
            case "3":
                delegate?.edit(subject: subject, edit: .grade2, newValue: newValue)
            default:
                print("Opção inválida")
            }
            utils.system("clear")
            print("A disciplina foi alterada")
            showSubmenuEdit()
        }
    }
    
}











