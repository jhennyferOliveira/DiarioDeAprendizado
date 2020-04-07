//
//  File.swift
//  
//
//  Created by Vinicius Mesquita on 01/04/20.
//

import Foundation

public class CurrentUser: User {
    
    static var instance = CurrentUser()
    var isLogged = false
    override private init() {
        super.init()
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
}
