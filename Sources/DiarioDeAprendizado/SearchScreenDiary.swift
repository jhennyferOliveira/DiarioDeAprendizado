//
//  SearchScreenDiary.swift
//  
//
//  Created by Vinicius Mesquita on 24/03/20.
//

import Foundation

public class SearchScreenDiary {
    
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
            selectAnotationById()
        case .date:
            delegate?.search(parameter: input, search: .date)
            selectAnotationById()
        case .category:
            delegate?.search(parameter: input, search: .category)
            selectAnotationById()
        }
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
    
    func showFormattedAnotation(anotation : Anotation) {
        
        print("""
            
            TÍTULO: \(anotation.titulo)
            DATA: \(anotation.data)
            DISCIPLINA: \(anotation.disciplina.nome)
            
            ANOTAÇÃO: \(anotation.texto)
            
            """)
    }

    func selectAnotationById(){
        let completePathDiary = FileManager.default.currentDirectoryPath + "/json/diario.txt"
        let service = Service<Anotation>()
        let anotations : [Anotation] = service.read(filePath: completePathDiary)
        if(!anotations.isEmpty){
            print("Digite o id da anotação para visualizá-la: ")
            guard let input = readLine() else  {
                return
            }
            for anotation in anotations{
                if (String(anotation.id) == input){
                    showFormattedAnotation(anotation: anotation)
                }
            }
        }
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
