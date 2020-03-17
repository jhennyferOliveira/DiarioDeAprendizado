//
//  DisciplinaScreen.swift
//  DiarioDeAprendizado
//
//  Created by Vinicius Mesquita on 15/03/20.
//  Copyright © 2020 Vinicius Mesquita. All rights reserved.
//

import Foundation



protocol MenuOptionsDelegate: class {
    func showGrades()
    func showUserInformation()
    func createNewDiary()
    func createNewGrade()
    func showDiaries()
    func searchDiary()
}

public class MenuOptions: MenuOptionsDelegate {

    let folderPath = FileManager.default.currentDirectoryPath + "/json"
    let completePathDisciplinas = FileManager.default.currentDirectoryPath + "/json/disciplina.txt"
    
    func createNewGrade() {
        
        let service = Service<Disciplina>()
        
        var disciplina = Disciplina()
        disciplina.nome = "Algebra Linear"
        disciplina.nota1 = "10"
        print(completePathDisciplinas)
        service.override(object: disciplina, folderPath: folderPath, fileName: "disciplina.txt")
        print("sua disciplina foi salva no arquivo disciplina.txt")
    }
    
    
    func searchDiary() {
        let formatter = DateFormatter()
        let searchScreen = ScreenSearchDiary()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        let myStringDate = formatter.string(from: date)
        print("\u{001B}[2J") // clear terminal standalone
        searchScreen.show()
        while let input = readLine() {
            
            guard input != "0" else {
                break
            }
            switch input {
            case "1":
                searchScreen.options = .data
                searchScreen.run()
            case "2":
                searchScreen.options = .disciplina
                searchScreen.run()
            case "3":
                searchScreen.options = .nome
                searchScreen.run()
            default:
                print(input)
            }
        searchScreen.show()
        }
    }
    
    
    func showDiaries() {
        let service = Service<Diario>()
        let diarios = service.read(filePath: completePathDisciplinas)
        diarios.enumerated().forEach { (index, diario) in
            print("\(index) \(diario.titulo)")
        }
    }
    
   
    func showUserInformation() {
        
    }
    
    func createNewDiary() {

        let service = Service<Diario>()
        var diario = Diario()
        var disciplina = Disciplina()
        disciplina.nome = "matematica"
        diario.titulo = "Programação Orientada a Objetos"
        diario.anotacao = "hoje aprendi bla bla bla"
        diario.disciplina = disciplina
        service.override(object: diario, folderPath: folderPath, fileName: "diario.txt")
        print("Diario foi criado")
    }
    
    
    func showGrades() {
        let service = Service<Disciplina>()
        let disciplinas = service.read(filePath: completePathDisciplinas)
        disciplinas.enumerated().forEach { (index, disciplina) in
            print("\(index) \(disciplina.nome)")
        }
    }
    
}
