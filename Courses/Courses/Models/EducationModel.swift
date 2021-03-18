//
//  EducationModel.swift
//  Courses
//
//  Created by Roman Divkovic on 2021-02-25.
//

import Foundation

struct EducationModel: EducationProtocol {
    var status: RegistrasionStatusEnum
    var value: Int
    var courses: CoursesModel
    var date: Date
    
    
    init(courses: CoursesModel, status: RegistrasionStatusEnum) {
        self.courses = courses
        self.date = Date()
        self.value = 0
        self.status = status
    }
}
