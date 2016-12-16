//
//  Pokemon.swift
//  Pokedex
//
//  Created by Dinesh Vijaykumar on 27/11/2016.
//  Copyright © 2016 Dinesh Vijaykumar. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    private var _name:String!
    private var _pokedexID: Int!
    private var _description: String!
    private var _type:String!
    private var _defense:String!
    private var _height:String!
    private var _weight:String!
    private var _attack:String!
    private var _nextEvolutionID:String!
    private var _nextEvolutionText:String!
    private var _nextEvolutionLevel:String!
    private var _pokemonURL:String!
    
    var name:String {
        return _name
    }
    
    var pokedexID: Int {
        return _pokedexID
    }
    
    var description: String {
        get {
            if _description == nil {
                return ""
            }
            return _description
        }
    }
    
    var type: String {
        get {
            if _type == nil {
                return ""
            }
            return _type
        }
    }
    
    var defence: String {
        get {
            if _defense == nil {
                return ""
            }
            return _defense
        }
    }
    
    var height: String {
        get {
            if _height == nil {
                return ""
            }
            return _height
        }
    }
    
    var weight: String {
        get {
            if _weight == nil {
                return ""
            }
            return _weight
        }
    }
    
    var attack: String {
        get {
            if _attack == nil {
                return ""
            }
            return _attack
        }
    }
    
    var nextEvolutionID: String {
        get {
            if _nextEvolutionID == nil {
                return ""
            }
            return _nextEvolutionID
        }
    }
    
    var nextEvolutionText: String {
        get {
            if _nextEvolutionText == nil {
                return ""
            }
            return _nextEvolutionText
        }
    }
    
    var nextEvolutionLevel: String {
        get {
            if _nextEvolutionLevel == nil {
                return ""
            }
            return _nextEvolutionLevel
        }
    }
    
    init(name:String, pokedexID: Int) {
        self._name = name
        self._pokedexID = pokedexID
        
        self._pokemonURL = "\(URL_BASE)\(URL_POKEMON)\(pokedexID)/"
    }
    
    func downloadPokemonDetails(completed:@escaping DownloadComplete) {
        Alamofire.request(self._pokemonURL).responseJSON { (response) in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, Any> {
                if let weight = dict["weight"] as? String {
                    self._weight = weight
                }
                if let height = dict["height"] as? String {
                    self._height = height
                }
                if let attack = dict["attack"] as? Int {
                    self._attack = "\(attack)"
                }
                if let defence = dict["defense"] as? Int {
                    self._defense = "\(defence)"
                }
                if let types = dict["types"] as? [Dictionary<String, String>], types.count > 0{
                    if let type = types[0]["name"] {
                        self._type = type
                    }
                    
                    if types.count > 1 {
                        for x in 1 ..< types.count {
                            if let name = types[x]["name"] {
                                self._type! += "/\(name)"
                            }
                        }
                    }
                } else {
                    self._type = ""
                }
                
                if let descArr = dict["descriptions"] as? [Dictionary<String,String>], descArr.count > 0 {
                    if let url = descArr[0]["resource_uri"] {
                        Alamofire.request("\(URL_BASE)\(url)").responseJSON(completionHandler: { (response) in
                            let desResult = response.result
                            if let descDict = desResult.value as? Dictionary<String,AnyObject> {
                                if let description = descDict["description"] as? String {
                                    self._description = description
                                    print(self._description)
                                }
                            }
                            completed()
                        })
                    }
                } else {
                    self._description = ""
                }
                
                if let evolutions = dict["evolutions"] as? [Dictionary<String, AnyObject>], evolutions.count > 0 {
                    if let to = evolutions[0]["to"] as? String {
                        
                        // Cannot support mega pokemon right now
                        if to.range(of: "mega") == nil {
                            if let uri = evolutions[0]["resource_uri"] as? String {
                                let newStr = uri.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                                let num = newStr.replacingOccurrences(of: "/", with: "")
                                self._nextEvolutionID = num
                                self._nextEvolutionText = to
                                
                                if let level = evolutions[0]["level"] as? Int {
                                    self._nextEvolutionLevel = "\(level)"
                                }
                                
                                print(self._nextEvolutionLevel)
                                print(self._nextEvolutionText)
                                print(self._nextEvolutionID)
                            }
                        }
                    }
                }
            }
        }
    }
}
