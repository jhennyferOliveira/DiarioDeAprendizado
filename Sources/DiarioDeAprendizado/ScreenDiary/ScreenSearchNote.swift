//
//  SearchScreenDiary.swift
//  
//
//  Created by Vinicius Mesquita on 24/03/20.
//

import Foundation

public class ScreenSearchNote {
    
    weak var delegate: DiaryOptionsDelegate?
    var options = searchBy.title
    
    func run(chosenOption : String) {
        print("Digite \(chosenOption): ")
        guard let input = readLine() else  {
            return
        }
        
        switch options {
        case .title:
            delegate?.search(parameter: input, search: .title)
        case .date:
            delegate?.search(parameter: input, search: .date)
        case .category:
            delegate?.search(parameter: input, search: .category)
        }
        guard let anotation = delegate?.selectAnotationById() else{
            return
        }
        delegate?.showFormattedAnotation(anotation: anotation)
    }
    
    func show() {
        print("""

        PESQUISAR DIARIO:

        1 - por titulo
        2 - por data
        3 - por categoria

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
    
    private func clearScreen() {
        let clear = Process()
        clear.launchPath = "/usr/bin/clear"
        clear.arguments = []
        clear.launch()
        clear.waitUntilExit()
    }
}
