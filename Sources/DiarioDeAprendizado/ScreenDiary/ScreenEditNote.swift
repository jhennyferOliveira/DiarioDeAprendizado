//
//  File.swift
//  
//
//  Created by Jhennyfer Rodrigues de Oliveira on 30/03/20.
//

import Foundation

class ScreenEditNote {
    
    let utils = Utils()
    weak var delegate: DiaryOptionsDelegate?
    
    func showSubmenuEdit() {
        print("""

        O que você deseja editar?:

        1 - Título
        2 - Texto
        3 - Nome da disciplina
        4 - Categoria

        0 - Voltar

        """)
    }

    func main() {
        
         delegate?.showAnotations()
         guard let anotation = delegate?.selectAnotationById() else {
            return
        }
        
        showSubmenuEdit()
        while let input = readLine() {
            
            guard input != "0" else {
                break
            }
            
            switch input {
            case "1":
                print("Digite o novo valor:")
                guard let newValue = readLine() else { return }
                delegate?.editAnotation(anotation: anotation, edit: .title, newValue: newValue)
                utils.system("clear")
            case "2":
                print("Digite o novo valor:")
                guard let newValue = readLine() else { return }
                delegate?.editAnotation(anotation: anotation, edit: .note, newValue: newValue)
                utils.system("clear")
            case "3":
                print("Digite o novo valor:")
                guard let newValue = readLine() else { return }
                delegate?.editAnotation(anotation: anotation, edit: .grade, newValue: newValue)
                utils.system("clear")
            case "4":
                print("Digite o novo valor:")
                guard let newValue = readLine() else { return }
                delegate?.editAnotation(anotation: anotation, edit: .category, newValue: newValue)
                utils.system("clear")
            default:
                utils.system("clear")
                print("Opção inválida")
            }
            
            print("Sua anotação foi alterada com sucesso!")
            showSubmenuEdit()
        }
    }

}
    
    
    
    
    
    
    
    
    
    

