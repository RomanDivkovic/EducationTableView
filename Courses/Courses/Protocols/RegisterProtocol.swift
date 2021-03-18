//
//  RegisterProtocol.swift
//  Courses
//
//  Created by Roman Divkovic on 2021-02-26.
//

import Foundation

protocol RegisterProtocol {
    var ePost: String { get set }
    var firstName: String { get set }
    var lastName: String { get set }
    var phoneNumber: Int { get set}
    var register: EducationModel {get set}
}
