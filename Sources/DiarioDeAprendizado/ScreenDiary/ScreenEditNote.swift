//
//  File.swift
//  
//
//  Created by Jhennyfer Rodrigues de Oliveira on 30/03/20.
//

import Foundation

class ScreenEditNote{

    weak var delegate: DiaryOptionsDelegate?
    
    func showSubmenuEdit() {
        print("""

        EDITAR:

        1 - Título
        2 - Texto
        3 - Nome da disciplina
        4 - Categoria

        0 - Voltar

        """)
    }

    func main() {
         delegate?.showAnotations()
         guard let anotation = delegate?.selectAnotationById()else{
             return
         }
         showSubmenuEdit()
         
        while let input = readLine() {
         print("Digite o novo valor:")
            guard input != "0" else{
                break
            }
         guard let newValue = readLine() else{
             return
         }
         switch input {
         case "1":
             delegate?.editAnotation(anotation: anotation, edit: .title, newValue: newValue)
         case "2":
             delegate?.editAnotation(anotation: anotation, edit: .note, newValue: newValue)
         case "3":
             delegate?.editAnotation(anotation: anotation, edit: .grade, newValue: newValue)
         case "4":
             delegate?.editAnotation(anotation: anotation, edit: .grade, newValue: newValue)
         default:
             print("Opção inválida")
         }
     }
    }

}
    
    
    
    
    
    
    
    
    
    

