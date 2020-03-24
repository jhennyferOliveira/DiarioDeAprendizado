//
//  DisciplinaScreen.swift
//  DiarioDeAprendizado
//
//  Created by Vinicius Mesquita on 15/03/20.
//  Copyright © 2020 Vinicius Mesquita. All rights reserved.
//

import Foundation



protocol MenuOptionsDelegate: class {
    func startScreenDiary()
    func startScreenGrade()
    func startScreenUser()
}

public class MenuOptions: MenuOptionsDelegate {
    
    let folderPath = FileManager.default.currentDirectoryPath + "/json"
    let completePathDisciplinas = FileManager.default.currentDirectoryPath + "/json/disciplina.txt"
    let completePathAluno = FileManager.default.currentDirectoryPath + "/json/aluno.txt"
    
    func startScreenGrade() {
        
    }
    
    func startScreenUser() {
        
    }
    
    
    func startScreenDiary() {
        let telaDiario = ScreenMyDiary()
        let options = DiaryOptions()
        
        telaDiario.delegate = options
        telaDiario.main()
    }
    
    
    func createNewDiary() {
    
    }

    func searchGradeByName(nome : String) -> Grade?{
        let service = Service<Grade>()
        let arrayDisciplinas : [Grade] = service.read(filePath: completePathDisciplinas)
        for disciplina in arrayDisciplinas{
            if(disciplina.nome == nome){
                return disciplina
            }
        }
        return nil
    }
    
    
    func showGrades() {
        let service = Service<Grade>()
        let disciplinas = service.read(filePath: completePathDisciplinas)
        print("--------------------------------------")
        print("estas sao as disciplinas cadastradas: \n")
        disciplinas.enumerated().forEach { (index, disciplina) in
            print("\(index) - \(disciplina.nome)")
           
        }
        print("--------------------------------------\n\n")
        
    }
}
