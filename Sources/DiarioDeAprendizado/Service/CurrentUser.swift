//
//  File.swift
//  
//
//  Created by Vinicius Mesquita on 01/04/20.
//

import Foundation

public final class CurrentUser: User {
    
    static var instance = CurrentUser()
    
    override private init() {
        super.init()
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
}
