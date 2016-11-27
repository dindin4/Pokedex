//
//  PokeCell.swift
//  Pokedex
//
//  Created by Dinesh Vijaykumar on 27/11/2016.
//  Copyright © 2016 Dinesh Vijaykumar. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    @IBOutlet weak var thumbImage:UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var pokemon: Pokemon!
    
    func configureCell(pokemon:Pokemon) {
        self.pokemon = pokemon
        
        nameLabel.text = self.pokemon.name.capitalized
        thumbImage.image = UIImage(named: "\(self.pokemon.pokedexID)")
        
    }
}
