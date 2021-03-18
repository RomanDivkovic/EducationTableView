//
//  CoursesModel.swift
//  Courses
//
//  Created by Roman Divkovic on 2021-02-25.
//

import Foundation

struct CoursesModel: CoursesProtocol {
    var courseLenght: [String]
    var education: String
    var courses: [String]
    var courseDecription: [String]
    // register: RegisterProtocol

    init(education: String, courses: [String], courseDecription: [String], courseLenght: [String]) {
        self.education = education
        self.courses = courses
        self.courseDecription = courseDecription
        self.courseLenght = courseLenght
       // self.register = register
    }
}
