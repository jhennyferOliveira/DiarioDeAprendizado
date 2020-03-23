//
//  main.swift
//  DiarioDeAprendizado
//
//  Created by Vinicius Mesquita on 14/03/20.
//  Copyright © 2020 Vinicius Mesquita. All rights reserved.
//

import Foundation

let menu = ScreenMenu()
let options = MenuOptions()
menu.delegate = options

menu.show()
while let input = readLine() {

    guard input != "quit" else {
        break
    }

    switch input {
    case "1":
        menu.options = .showGrades
        menu.run()
    case "2":
        menu.options = .showUserInformation
        menu.run()
    case "3":
        menu.options = .createNewGrade
        menu.run()
    case "4":
        menu.options = .createNewDiaryAnotation
        menu.run()
    case "5":
        menu.options = .searchDiary
        menu.run()
    default:
        options.clearScreen()
        options.handler(input)
        print("?")
    }
    menu.show()
}

