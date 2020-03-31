//
//  File.swift
//
//
//  Created by Jhennyfer Rodrigues de Oliveira on 31/03/20.
//

import Foundation

class ScreenEditSubject{

    weak var delegate: SubjectOptionsDelegate?
    
    func showSubmenuEdit() {
        print("""

        EDITAR:

        1 - nome disciplina
        2 - nota 1
        3 - nota 2

        """)
    }

    func main() {
        delegate?.details()
        guard let subject = delegate?.selectSubjectById()else{
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
            delegate?.edit(subject: subject, edit: .name, newValue: newValue)
         case "2":
            delegate?.edit(subject: subject, edit: .grade1, newValue: newValue)
         case "3":
            delegate?.edit(subject: subject, edit: .grade2, newValue: newValue)
         default:
             print("opcao invalida")
         }
     }

}
    
    
    
    
    
    
    
    
    
    

