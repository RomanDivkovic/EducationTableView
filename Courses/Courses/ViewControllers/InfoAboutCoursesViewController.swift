//
//  InfoAboutCoursesViewController.swift
//  Courses
//
//  Created by Roman Divkovic on 2021-02-26.
//

import UIKit

class InfoAboutCoursesViewController: UIViewController, CoursesListDelegate {
    func update(task: RegisterModel, index: Int) {
    }
    
    func save(task: EducationModel) {
//        let regCourse = WishList(context: context)
//        regCourse.education = task.courses.education
//        regCourse.course = task.courses.courses
//        regCourse.courseInfo = task.courses.courseDecription
//        do {
//            try context.save()
//        }catch {
//            print("Gick inget bra")
//        }
//        delegate?.updateEducation(task: task)
    }
    
    let context = (UIApplication.shared.delegate as? AppDelegate)!.persistentContainer.viewContext
    weak var delegate: CoursesListDelegate?
    
    @IBOutlet weak var courseLabel: UILabel!
    @IBOutlet weak var courseInfoText: UITextView!
    @IBOutlet weak var doneButton: UIButton!
    
    
    var utbildning = ""
    var kurs = ""
    var omKurs = ""
    var kursLängd = ""
    var education: EducationModel!
    var educationIndex: Int!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.courseInfoText.layer.borderWidth = 0.5
        self.courseInfoText.layer.borderColor = UIColor.lightGray.cgColor

        self.courseLabel.text = kurs
        self.courseInfoText.text = omKurs
        
    }
    
    @IBAction func registerCourseButton(_ sender: UIButton) {
    
        let myWishList = CoursesModel(education: "Registrerad", courses: [self.kurs], courseDecription: [self.omKurs], courseLenght: [self.kursLängd])
        let wishlist = EducationModel(courses: myWishList, status: .Registered)
        self.delegate?.save(task: wishlist)
        
    }
    
    @IBAction func buyCourseButton(_ sender: UIButton) {
        let alert = UIAlertController(title: "Köp kurs", message: "Gå vidare med köp", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Köp", style: .default, handler: { action in
                
                let myWishList = CoursesModel(education: "Köpt kurs", courses: [self.kurs], courseDecription: [self.omKurs], courseLenght: [self.kursLängd])
                let wishlist = EducationModel(courses: myWishList, status: .Bought)
                self.delegate?.save(task: wishlist)
                
                self.performSegue(withIdentifier: "registerFromInfo", sender: nil)
            }))
            alert.addAction(UIAlertAction(title: "Avbryt", style: .cancel, handler: { action in
            }))
            present(alert, animated: true, completion: nil)
    }
    
    @IBAction func SaveToWishList(_ sender: UIButton) {
        
        let myWishList = CoursesModel(education: "Önskelista", courses: [kurs], courseDecription: [omKurs], courseLenght: [kursLängd])
        let wishlist = EducationModel(courses: myWishList, status: .Register)
        delegate?.save(task: wishlist)
        
        navigationController?.popViewController(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          
          if segue.identifier == "registerFromInfo" {
              guard let vc = segue.destination as? RegisterViewController else { return }
             
              vc.education = utbildning
              vc.course = kurs
              vc.aboutCourse = omKurs
              vc.courseLenght = kursLängd
              vc.delegate = self
          }
     }
}
