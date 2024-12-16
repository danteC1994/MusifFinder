//
//  ErrorHandler.swift
//  Discogsmusicfinder
//
//  Created by dante canizo on 15/12/2024.
//

import Networking

protocol ErrorHandler {
    func handle(error: APIError) -> UIError
}
