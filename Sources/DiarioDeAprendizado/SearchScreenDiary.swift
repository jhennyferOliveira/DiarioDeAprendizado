//
//  SearchScreenDiary.swift
//  
//
//  Created by Vinicius Mesquita on 24/03/20.
//

import Foundation

enum SearchDiaryOptions {
    case title
    case date
    case category
}

public class SearchScreenDiary {
    
    weak var delegate: DiaryOptionsDelegate?
    var options = SearchDiaryOptions.title
    
    func run() {
        switch options {
        case .title:
            delegate?.searchByTitle()
        case .date:
            delegate?.searchByDate()
        case .category:
            delegate?.searchByCategory()
        }
    }
    
    func show() {
        print("""
        0 - voltar
        1 - pesquisar por data
        2 - pesquisar por nome
        3 - pesquisar por disciplina
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
                run()
            case "2":
                options = .date
                run()
            case "3":
                options = .category
                run()
            default:
                print(input)
            }
        show()
        }
    }
}
