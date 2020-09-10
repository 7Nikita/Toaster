//
//  CardState.swift
//  Toaster
//
//  Created by Nikita Pekurin on 9/7/20.
//  Copyright © 2020 Nikita Pekurin. All rights reserved.
//

enum CardState {
    case expanded
    case collapsed
    
    var oppositeState: CardState {
        return self == .expanded ? .collapsed : .expanded
    }
    
}
