//
//  File.swift
//  
//
//  Created by Jhennyfer Rodrigues de Oliveira on 30/03/20.
//

import Foundation


class ScreenEditAnotation(){

    weak var delegate: DiaryOptionsDelegate?
    var options = edit.category
    
    func showSubmenuEdit() {
        print("""

        EDITAR:

        1 - título
        2 - texto
        3 - nome da disciplina
        4 - categoria

        """)
    }

    func edit() {
         delegate?.showAnotations()
         guard let anotation = delegate?.selectAnotationById()else{
             return
         }
         showSubmenuEdit()
         
         guard let input = readLine() else{ return
         }
         print("Digite o novo valor:")
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
             print("opcao invalida")
         }
     }

}
    
    
    
    
    
    
    
    
    
    
    
}
