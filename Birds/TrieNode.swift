//
//  TrieNode.swift
//  Birds
//
//  Created by Jesse Mihigo on 2/27/17.
//  Copyright © 2017 Jesse Nkingi. All rights reserved.
//

import Foundation
class TrieNode {
    var children: [Character:TrieNode] = [:]
    var isAWord = false
    func addWord(word: String, index: Int) {
        if word.characters.count == 0{
            return
        }
        let key:Character = word[word.index(word.startIndex, offsetBy: index)]
        if children[key] == nil {
            children[key] = TrieNode()
        }
        let child:TrieNode = children[key]!
        if index == (word.characters.count-1) {
            child.isAWord = true
            return
        }
        child.addWord(word: word, index: index+1)
    }
    
    func getChild(key: Character) -> TrieNode? {
        return children[key]
    }
}
