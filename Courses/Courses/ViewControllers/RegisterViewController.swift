//
//  RegisterViewController.swift
//  Courses
//
//  Created by Roman Divkovic on 2021-03-01.
//

import UIKit

class RegisterViewController: UIViewController {
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var phoneNmr: UITextField!
    
    var inSchool = 0
    var fromHome = 0
    
    var education = ""
    var course = ""
    var aboutCourse = ""
    var courseLenght = ""
    weak var delegate: CoursesListDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
        
        print(education, course, aboutCourse, courseLenght)
        
    }
    
    @IBAction func RegisterButton(_ sender: UIButton) {
        
        if education == "Köpt kurs" {
            let buyedCourse = CoursesModel(education: "Köpt kurs", courses: [course], courseDecription: [aboutCourse], courseLenght: [courseLenght])
            let regAndBuyed = EducationModel(courses: buyedCourse, status: .Bought)
            
            let registresion = RegisterModel(epost: self.email.text!,
                                             firstName: self.firstName.text!,
                                             lastName: self.lastName.text!,
                                             phoneNumber: Int(self.phoneNmr.text!) ?? 0,
                                             register: regAndBuyed)
            
            delegate?.save(task: regAndBuyed)
            print(regAndBuyed, registresion)
        }else {
            let myCourse = CoursesModel(education: "Registrerad", courses: [course], courseDecription: [aboutCourse], courseLenght: [courseLenght])
            let registerEducation = EducationModel(courses: myCourse, status: .Registered)
            
            let registresion = RegisterModel(epost: self.email.text!,
                                             firstName: self.firstName.text!,
                                             lastName: self.lastName.text!,
                                             phoneNumber: Int(self.phoneNmr.text!) ?? 0,
                                             register: registerEducation)
            
            delegate?.save(task: registerEducation)
            print(registresion, registerEducation)
        }
        navigationController?.popViewController(animated: true)
    }
    
//    func relasionshipData() {
//        // create Course data
//        //var course = WishList(context: context)
//        //course.course = ""
//    }
}
