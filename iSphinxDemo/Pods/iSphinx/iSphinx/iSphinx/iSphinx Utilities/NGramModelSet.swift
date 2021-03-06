//
//  NGramModelSet.swift
//  iSphinx
//
//  Created by Saiful I. Wicaksana on 20/12/17.
//  Copyright © 2017 icaksama. All rights reserved.
//

import Foundation

open class NGramModelSet {
    
    fileprivate var pointer: OpaquePointer!
    
    internal init() {}
    
    /** Init the NGramModelSet with lmctl file. */
    public init(config: Config, logMath: LogMath, lmctlFile: String) {
        self.pointer = ngram_model_set_read(config.getPointer(), lmctlFile, logMath.getPointer())
    }
    
    /** Init the NGramModelSet with current config and logmath. */
    public init(config: Config, logMath: LogMath) {
        self.pointer = ngram_model_set_init(config.getPointer(), nil, nil, nil, 0)
    }
    
    internal func getPointer() -> OpaquePointer {
        return pointer
    }
    
    /** Get the iterator of NGramModel */
    open func iterator() -> NGramModelSetIterator {
        return NGramModelSetIterator(nGramSet: self)
    }
    
    /** Get count of NGramModel in iterator. */
    open func count() -> Int {
        return Int(ngram_model_set_count(pointer))
    }
    
    /** Add new NGramModel to iterator. */
    open func add(nGramModel: NGramModel, name: String, weight: Float, reuseWidmap: Bool) -> NGramModel {
        let isReuseWidmap: Int = reuseWidmap ? 1 : 0
        return NGramModel(pointer: ngram_model_set_add(pointer, nGramModel.getPointer(), name, weight, Int32(isReuseWidmap)))
    }
    
    /** Get NgramModel by name. */
    open func select(name: String) -> NGramModel {
        return NGramModel(pointer: ngram_model_set_select(pointer, name))
    }
    
    /** Get NgramModel by name. */
    open func lookup(name: String) -> NGramModel {
        return NGramModel(pointer: ngram_model_set_lookup(pointer, name))
    }
    
    /** Set current iterator. */
    open func current() -> String {
        return String.init(cString: ngram_model_set_current(pointer))
    }
}
