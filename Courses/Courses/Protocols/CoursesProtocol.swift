//
//  CoursesProtocol.swift
//  Courses
//
//  Created by Roman Divkovic on 2021-02-25.
//

import Foundation


protocol CoursesProtocol {
    var education: String {get set}
    var courses: [String] {get set}
    var courseDecription: [String] {get set}
    var courseLenght: [String] {get set}
   // var register: RegisterProtocol {get set}
}
