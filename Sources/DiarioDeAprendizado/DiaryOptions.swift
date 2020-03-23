//
//  File.swift
//  
//
//  Created by Vinicius Mesquita on 22/03/20.
//

import Foundation

protocol DiaryOptionsDelegate: class {
    func searchByDate()
    func searchByName()
    func searchByGrade()
}

public class DiaryOptions: DiaryOptionsDelegate {
    let service = Service<Diario>()
    let completePathDiary = FileManager.default.currentDirectoryPath + "/json/diario.txt"
    
    func searchByDate() {
        let diarios = service.read(filePath: completePathDiary)
        let diariosByDate = diarios.filter { diario -> Bool in
            if diario.data == "22/03/2020" {
                return true
            }
            return false
        }
        
        if !diariosByDate.isEmpty {
            print("--------------------------------------")
            print("diarios do dia 22/03/2020: \n")
            diariosByDate.enumerated().forEach { (index, diario) in
                print("\(index) - \(diario.titulo)")
            }
            print("--------------------------------------\n\n")
        } else {
            print("não foi registrado nenhuma anotacão na data informada")
        }
        
    }
    
    func searchByName() {
        
    }
    
    func searchByGrade() {
        
    }
    
    
}
