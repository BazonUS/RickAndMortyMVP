//
//  Debagger.swift
//  RickAndMorty
//
//  Created by Aleksei Omelchenko on 10/13/22.
//

import Foundation

public func debugLog(object: Any, functionName: String = #function, fileName: String = #file, lineNumber: Int = #line) {
  #if DEBUG
    let className = (fileName as NSString).lastPathComponent
    print("<\(className)> \(functionName) [#\(lineNumber)]| \(object)\n")
  #endif
}
