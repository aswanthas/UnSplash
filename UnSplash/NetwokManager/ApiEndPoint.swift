//
//  ApiEndPoint.swift
//  UnSplash
//
//  Created by Aswanth K on 02/07/24.
//

import Foundation

public enum ApiEndPoint {
    case getMainList(_ page: Int, _ limit: Int)
    
    private var baseUrl: String {
        return "https://picsum.photos/v2"
    }
    public var urlString: String {
        switch self {
        case .getMainList(let page, let limit):
            return "\(baseUrl)/list?page=\(page)&limit=\(limit)"
        }
    }
}
