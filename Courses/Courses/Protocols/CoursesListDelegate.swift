//
//  CoursesListDelegate.swift
//  Courses
//
//  Created by Roman Divkovic on 2021-02-26.
//

import Foundation

protocol CoursesListDelegate: class {
    func update(task: RegisterModel, index: Int)
    func save(task: EducationModel)
}
