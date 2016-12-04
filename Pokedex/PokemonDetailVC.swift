//
//  PokemonDetailVC.swift
//  Pokedex
//
//  Created by Dinesh Vijaykumar on 04/12/2016.
//  Copyright © 2016 Dinesh Vijaykumar. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {
    
    var pokemon: Pokemon!

    override func viewDidLoad() {
        super.viewDidLoad()

        print(pokemon.name)
    }


}
