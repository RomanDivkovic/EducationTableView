//
//  EducationProtocol.swift
//  Courses
//
//  Created by Roman Divkovic on 2021-02-25.
//

import Foundation

enum RegistrasionStatusEnum {
    case Register
    case Registered
    case Bought
}

protocol EducationProtocol {
    var courses: CoursesModel {get set}
    var date: Date {get set}
    var value: Int {get set}
    var status: RegistrasionStatusEnum { get set }
}
