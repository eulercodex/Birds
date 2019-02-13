//
//  Trie.swift
//  Birds
//
//  Created by Jesse Mihigo on 2/26/17.
//  Copyright © 2017 Jesse Nkingi. All rights reserved.
//

import Foundation
class Trie {
    private let root: TrieNode = TrieNode()
    
    func addWord(aWord: String) {
        root.addWord(word: aWord.lowercased(), index: 0)
    }
    
    private func returnTreeNodeFor(prefix: String) -> TrieNode? {
        let c: u_char = 'a'
        let lower = prefix.lowercased()
        let lengthOfPrefix = lower.characters.count
        if lengthOfPrefix == 0 {
            return nil
        }
        var index : Int = 0
        var parent = root
        var child: TrieNode?
        while index < lengthOfPrefix {
            let c : Character = lower[lower.index(lower.startIndex, offsetBy: index)]
            child = parent.getChild(key: c)
            if child == nil {
                return nil
            }
            parent = child!
            index += 1
        }
        return child
    }
    private func crawlForWordsStartingWith(prefix: String, treeNode: TrieNode, limit: Int, numberOfFoundWordsSoFar: inout Int, arrayOfWords: inout [String]) {
        if numberOfFoundWordsSoFar <= 0 {
            return
        }
        for (key,value) in treeNode.children {
            var newPrefix = prefix
            newPrefix.append(key)
            if value.isAWord {
                arrayOfWords.append(newPrefix.capitalized)
                numberOfFoundWordsSoFar -= 1
            }
            if value.children.count >= 0 {
                crawlForWordsStartingWith(prefix: newPrefix, treeNode: value, limit: limit, numberOfFoundWordsSoFar: &numberOfFoundWordsSoFar , arrayOfWords: &arrayOfWords)
            }
        }
    }
    
    func returnArrayOfValidWordsUsing(prefix: String, withLimit: Int) ->[String] {
        let treeNode = returnTreeNodeFor(prefix: prefix);
        if treeNode == nil {
            return [];
        }
        var result: [String] = [String]();
        var count: Int = withLimit
        crawlForWordsStartingWith(prefix: prefix.lowercased(), treeNode: treeNode!, limit: withLimit, numberOfFoundWordsSoFar: &count, arrayOfWords: &result)
        return result;
        
    }
}
