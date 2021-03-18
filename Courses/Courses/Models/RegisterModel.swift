//
//  RegisterModel.swift
//  Courses
//
//  Created by Roman Divkovic on 2021-03-02.
//

import Foundation

struct RegisterModel: RegisterProtocol {
    var register: EducationModel
    var ePost: String
    var firstName: String
    var lastName: String
    var phoneNumber: Int
    
    init(epost: String, firstName: String, lastName: String, phoneNumber: Int, register: EducationModel) {
        self.ePost = epost
        self.firstName = firstName
        self.lastName = lastName
        self.phoneNumber = phoneNumber
        self.register = register
    }
}
