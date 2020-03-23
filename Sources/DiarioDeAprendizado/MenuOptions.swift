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
        print("sua disciplina foi salva no arquivo disciplina.txt")
    }
    
    
    func searchDiary() {
        let formatter = DateFormatter()
        let searchScreen = ScreenSearchDiary()
        formatter.dateFormat = "dd-MM-yyyy"
        let myStringDate = formatter.string(from: Date())
//        print("\u{001B}[2J") // clear terminal standalone
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

//    func searchGrade(){
//
//    }
    
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

        print("Digite o nome da disciplina: ")
        guard let nomeDisciplina = readLine() else {
            return
        }

        print("Digite o título da Anotação: ")
        guard let tituloAnotacao = readLine() else {
            return
        }

        print("Digite a anotação: ")
        guard let anotacao = readLine() else {
            return
        }

        print("Digite a categoria(Faculdade, Trabalho): ")
        guard let categoria = readLine() else {
            return
        }

        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let stringData = formatter.string(from: Date())

        diario.data = stringData
        diario.titulo = tituloAnotacao
        diario.categoria = categoria
        diario.anotacao = anotacao
        if let disciplinaProcurada = searchGradeByName(nome: nomeDisciplina){
            diario.disciplina = disciplinaProcurada
        } else{
            diario.disciplina = disciplina
        }

        service.override(object: diario, folderPath: folderPath, fileName: "diario.txt")
        print("Diario foi criado")
    }

    func searchGradeByName(nome : String) -> Disciplina?{
        let service = Service<Disciplina>()
        let arrayDisciplinas : [Disciplina] = service.read(filePath: completePathDisciplinas)
        for disciplina in arrayDisciplinas{
            if(disciplina.nome == nome){
                return disciplina
            }
        }
        return nil
    }
    
    
    func showGrades() {
        let service = Service<Disciplina>()
        let disciplinas = service.read(filePath: completePathDisciplinas)
        print("--------------------------------------")
        print("estas sao as disciplinas cadastradas: \n")
        disciplinas.enumerated().forEach { (index, disciplina) in
            print("\(index) - \(disciplina.nome)")
           
        }
        print("--------------------------------------\n\n")
    }
    
}
