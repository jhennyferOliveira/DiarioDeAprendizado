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

    var handlerCount = 0
    let folderPath = FileManager.default.currentDirectoryPath + "/json"
    let completePathDisciplinas = FileManager.default.currentDirectoryPath + "/json/disciplina.txt"
    let completePathAluno = FileManager.default.currentDirectoryPath + "/json/aluno.txt"
    
    func createNewGrade() {
        
        let service = Service<Disciplina>()
        
        var disciplina = Disciplina()
        print("digite o nome da disciplina:")
        guard let nome = readLine() else {
            return
        }
        print("ja possui nota ? (s/n)")
        guard let response = readLine() else { return }
        if response == "s" {
            print("digite sua n1:")
            guard let n1 = readLine() else { return }
            disciplina.nota1 = n1
            
            print("digite sua n2:")
            guard let n2 = readLine() else { return }
            disciplina.nota2 = n2
        }
        disciplina.nome = nome
        print(completePathDisciplinas)
        service.override(object: disciplina, folderPath: folderPath, fileName: "disciplina.txt")
        clearScreen()
        print("sua disciplina foi salva no arquivo disciplina.txt")
    }
    
    
    func searchDiary() {
        let searchScreen = ScreenSearchDiary()
        let options = DiaryOptions()
        searchScreen.delegate = options
        clearScreen()
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
        diario.data = "22/03/2020"
        diario.disciplina = disciplina
        service.override(object: diario, folderPath: folderPath, fileName: "diario.txt")
        print("Diario foi criado")
    }
    
    
    func showGrades() {
        let service = Service<Disciplina>()
        let disciplinas = service.read(filePath: completePathDisciplinas)
        clearScreen()
        print("--------------------------------------")
        print("estas sao as disciplinas cadastradas: \n")
        disciplinas.enumerated().forEach { (index, disciplina) in
            print("\(index) - \(disciplina.nome)")
           
        }
        print("--------------------------------------\n\n")
        
    }
    
    func clearScreen() {
             let clear = Process()
             clear.launchPath = "/usr/bin/clear"
             clear.arguments = []
             clear.launch()
             clear.waitUntilExit()
     }
    
    func handler(_ input: String) {
        handlerCount += 1
        if Int(input) != nil {
            print("cara, não existe essa opção ainda.")
            return
        }
        if input.count == 1 {
            print("'-', aqui não é soletrando não, escolha alguma opção pelo *numero*")
        }
        
        if input.contains("oi") || input.contains("eae") {
            clearScreen()
            print("olá")
        }
        if input.contains("como vai?") {
            print("to bem!")
        }
        if input.contains("tudo bem?") {
            print("tudo sim e você?")
        }
        if input.contains("help") {
            print("i need somebody.. hellp 🎶")
        }
        if handlerCount == 5 {
            print("você lavou suas mãos antes de usar o seu mac?")
        }
    }
}
