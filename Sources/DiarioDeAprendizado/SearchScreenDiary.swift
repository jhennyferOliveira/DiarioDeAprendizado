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
                run()
            case "2":
                options = .date
                run()
            case "3":
                options = .category
                run()
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
