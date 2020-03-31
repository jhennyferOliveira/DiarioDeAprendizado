//
//  SearchScreenDiary.swift
//  
//
//  Created by Vinicius Mesquita on 24/03/20.
//

import Foundation

public class ScreenSearchNote {
    weak var delegate: DiaryOptionsDelegate?
    var options = DiarySearchBy.title
    
    func run(chosenOption : String) {
        print("Digite \(chosenOption): ")
        guard let input = readLine() else  {
            return
        }
        let boolean: Bool
        switch options {
        case .title:
            boolean = delegate?.search(parameter: input, search: .title) ?? false
        case .date:
            boolean = delegate?.search(parameter: input, search: .date) ?? false
        case .category:
            boolean = delegate?.search(parameter: input, search: .category) ?? false
        }
        if boolean{
            guard let anotation = delegate?.selectAnotationById() else{
                return
            }
            delegate?.showFormattedAnotation(anotation: anotation)
        }
    }
    
    func show() {
        print("""

        PESQUISAR DIARIO POR:

        1 - Título
        2 - Data
        3 - Categoria

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
                options = .title
                run(chosenOption: "o título")
            case "2":
                options = .date
                run(chosenOption: "a data(formato: dd-MM-YYYY)")
            case "3":
                options = .category
                run(chosenOption: "a categoria")
            default:
                print("?")
            }
            show()
        }
    }
}
