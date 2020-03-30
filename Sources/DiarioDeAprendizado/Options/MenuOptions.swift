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
    
    func startScreenGrade() {
        let screen = ScreenSubject()
        let options = SubjectOptions()
        
        screen.delegate = options
        screen.main()
    }
    
    func startScreenUser() {
        let screen = ScreenUser()
        let options = UserOptions()
       
        screen.delegate = options
        screen.main()
    }
    
    func startScreenDiary() {
        let screen = ScreenMyDiary()
        let options = DiaryOptions()
        
        screen.delegate = options
        screen.main()
    }
}
