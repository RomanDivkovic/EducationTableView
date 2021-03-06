//
//  EducationListViewController.swift
//  Courses
//
//  Created by Roman Divkovic on 2021-02-26.
//

import UIKit

class EducationListViewController: UITableViewController, CoursesListDelegate {
    
    func update(task: RegisterModel, index: Int) {

    }
    
    func save(task: EducationModel) {
        let myCourse = WishList(context: context)
        myCourse.education = task.courses.education
        myCourse.course = task.courses.courses
        myCourse.courseInfo = task.courses.courseDecription
        myCourse.courseLenght = task.courses.courseLenght
//        do {
//            try context.save()
//        }catch {
//            print("Gick inget bra")
//        }
        try? context.save()
        
        educations.append(task)
        tableView.reloadData()
    }
        
    //skapa en array av EducationModel object..
    var educations: [EducationModel] = [EducationModel]()
    weak var delegate: CoursesListDelegate?
    let context = (UIApplication.shared.delegate as? AppDelegate)!.persistentContainer.viewContext
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editEducation))
        
        setUpEducation()
        
        if let myCoursesFromCD = try? context.fetch(WishList.fetchRequest()) as? [WishList] {
            
            for v in myCoursesFromCD {
                
                let courses = CoursesModel(education: v.education ?? "",
                                           courses: v.course ?? [""],
                                           courseDecription: v.courseInfo ?? [""],
                                           courseLenght: v.courseLenght ?? [""])
                
                let myEducation = EducationModel(courses: courses, status: .Register)
                if myEducation.courses.education == "├ľnskelista" {
                    let myEducation = EducationModel(courses: courses, status: .Register)
                    educations.append(myEducation)
                }else if myEducation.courses.education == "Registrerad" {
                    let myEducation = EducationModel(courses: courses, status: .Registered)
                    educations.append(myEducation)
                }else {
                    let myEducation = EducationModel(courses: courses, status: .Bought)
                    educations.append(myEducation)
                }
                self.tableView.reloadData()
            }
        }
    }
    
    @objc func editEducation() {
            tableView.setEditing(!tableView.isEditing, animated: true)
               
               if tableView.isEditing {
                   navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(editEducation))
                callAlert()
               }else {
                   navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editEducation))
               }
    }
    
    func setUpEducation() {
    
        let Webbprogrammering = CoursesModel(education: "Webbprogrammering", courses: ["HTML & CSS", "Avancerad CSS", "JavaScript f├Âr nyb├Ârjare", "Avancerad JavaScript & serverprogrammering", "JavaScript f├Âr webben", "ASP.NET Core MVC"], courseDecription: ["Utbildning inom HTML & CSS d├Ąr man l├Ąr sig skapa hemsidor och hur man skapar design till hemsidorna ocks├ą", "Utbildning inom sj├Ąlva stylingen inom webbutveckling d├Ąr vi g├ąr djupare in p├ą design och hur man kan snygga till hemsidor", "Utbildning inom JavaScript f├Âr nyb├Ârjare s├ą man l├Ąr sig syntax osv", "Avancerad kurs inom JavaScript och serverprogrammering d├Ąr man f├ąr djupare kunskap", "Utveckling med JavaScript f├Âr webben s├ą man l├Ąr sig binda sin kunskap", "Vad ├Ąr ASP.NET Core MVC. ASP.NET Core MVC-ramverket ├Ąr en l├Ątt, ├Âppen k├Ąllkod, mycket testbar presentationsramverk optimerad f├Âr anv├Ąndning med ASP.NET Core"], courseLenght: ["1,5 veckor", "2 veckor", "2 veckor", "4 veckor", "3 veckor", "2 veckor"])
        let education1 = EducationModel(courses: Webbprogrammering, status: .Register)
        
        let Mobilprogrammering = CoursesModel(education: "Mobilprogrammering", courses: ["Introduktion till Android programmering", "Avancerad Android programmering", "iOS utveckling med Objective-C", "iOS utveckling med Swift", "Design och layout f├Âr mobila enheter"], courseDecription: ["Introduktion f├Âr Andriod d├Ąr vi bland annat g├ąr igenom java och sj├Ąlva syntaxen s├ą att ni kan bygga vidare sj├Ąlva sedan med den h├Ąr erfarenheten", "En mer avancerad kurs d├Ąr man du l├Ąr dig skapa och designa bra Andriod appar f├Âr att sj├Ąlva sedan kunna skapa och l├Ągga ut appar p├ą GooglePlay store", "IOS utveckling med apples gamla verktyg d├Ąr du f├ąr l├Ąra dig Objective-C spr├ąket och bygga appar via Apples gamla spr├ąk och Objective-C's syntax", "IOS Utveckling med apples nya spr├ąk, d├Ąr du f├ąr l├Ąra dig bygga snygga appar", "Ja det st├ąr ju i namnet h├Ąr l├Ąr du dig hur du kan f├ą snygga design och layouter f├Âr mobila enheter"], courseLenght: ["2 veckor", "3 veckor", "2 veckor", "4 veckor", "2 veckor"])
        let education2 = EducationModel(courses: Mobilprogrammering, status: .Register)
        
        let BackEndprogrammering = CoursesModel(education: "BackEndprogrammering", courses: ["IREST Api med node.js", "Web Api med .NET Core"], courseDecription: ["H├Ąr f├ąr man l├Ąra sig jobba med IREST API MED NODE.JS och l├Ąra sig varf├Âr det ├Ąr anv├Ąndbart och hur man programmerar med API's", "H├Ąr f├ąr ni bland annat l├Ąra er web API med .NET core och hur man ska bygga systemen med sj├Ąlva verktyget"], courseLenght: ["3 veckor", "3 veckor"])
        let education3 = EducationModel(courses: BackEndprogrammering, status: .Register)
        
        let Database = CoursesModel(education: "Database", courses: ["Administrera MS SQL Server", "Databas design", "Bygga system med MongoDB", "Vad ├Ąr ORM? Hur anv├Ąnder man ett s├ądant verktyg."], courseDecription: ["H├Ąr f├ąr du l├Ąra dig MS SQL server och hur du kan programmera f├Âr att bygga  upp den h├Ąr databasen. Hur man skriver tabeller och hur man h├Ąmtar ut tabellerna", "H├Ąr l├Ąr du dig hur man ska designa sina databaser", "H├Ąr l├Ąr du dig bygga databas system med MongoDB", "H├Ąr l├Ąr du dig om ORM och hur man ska anv├Ąnda sig utav det"], courseLenght: ["3 veckor", "3 veckor", "4 veckor", "4 veckor"])
        let education4 = EducationModel(courses: Database, status: .Register)
        
        educations.append(education1)
        educations.append(education2)
        educations.append(education3)
        educations.append(education4)
        
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return educations.count
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return educations[section].courses.courses.count

    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EducationCell", for: indexPath)
        var status: String = ""
        let education = educations[indexPath.section]
        
        switch education.status {
        case .Register:
            status = "REGISTRERA"
        case .Registered:
            status = "REGISTRERAD"
        case .Bought:
            status = "K├ľPT"
        }
       
        cell.textLabel?.text = educations[indexPath.section].courses.courses[indexPath.row]
        cell.detailTextLabel?.text = "STATUS: \(status), L├äNGD: \(educations[indexPath.section].courses.courseLenght[indexPath.row])"

        return cell
    }
    func callAlert() {
        let alert = UIAlertController(title: "Ta bort kurs", message: "Se till att bara radera fr├ąn dina egna kurser annars krashar appen", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okej", style: .cancel, handler: { action in
        }))
        present(alert, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        //callAlert()
        UISwipeActionsConfiguration(actions: [deleteValuationAction(forRowAt: indexPath)])
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        UISwipeActionsConfiguration(actions: [buyOrRegisterAction(forRowAt: indexPath)])
    }
    
    func buyOrRegisterAction(forRowAt indexPath: IndexPath) -> UIContextualAction {
        
        let action = UIContextualAction(style: .normal, title: "K├Âp || Registrera") {
        (contextualAction, swipeButton, completionHandler: (Bool) -> Void) in
            let alert = UIAlertController(title: "K├Âp eller registrera", message: "G├ą vidare med k├Âp eller registrering", preferredStyle: .alert)
                    
            alert.addAction(UIAlertAction(title: "K├Âp", style: .default, handler: { action in
        
                let alert = UIAlertController(title: "K├Âp kurs", message: "G├ą vidare med k├Âp", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "K├Âp", style: .default, handler: { action in
                        if let vc = self.storyboard?.instantiateViewController(identifier: "RegisterViewController") as? RegisterViewController {
                            vc.education = "K├Âpt kurs"
                            vc.course = self.educations[indexPath.section].courses.courses[indexPath.row].description
                            vc.aboutCourse = self.educations[indexPath.section].courses.courseDecription[indexPath.row].description
                            vc.courseLenght = self.educations[indexPath.section].courses.courseLenght[indexPath.row].description
                            vc.delegate = self
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                    }))
                    alert.addAction(UIAlertAction(title: "Avbryt", style: .cancel, handler: { action in
                    }))
                self.present(alert, animated: true, completion: nil)
                
            }))
            alert.addAction(UIAlertAction(title: "Registrera", style: .default, handler: { action in
                if let vc = self.storyboard?.instantiateViewController(identifier: "RegisterViewController") as? RegisterViewController {
                    vc.education = self.educations[indexPath.section].courses.education.description
                    vc.course = self.educations[indexPath.section].courses.courses[indexPath.row].description
                    vc.aboutCourse = self.educations[indexPath.section].courses.courseDecription[indexPath.row].description
                    vc.courseLenght = self.educations[indexPath.section].courses.courseLenght[indexPath.row].description
                    vc.delegate = self
                    self.navigationController?.pushViewController(vc, animated: true)
                }

            }))
            self.present(alert, animated: true, completion: nil)
        }
        return action
    }
   
    func deleteValuationAction(forRowAt indexPath: IndexPath) -> UIContextualAction {
           let action = UIContextualAction(style: .destructive, title: "Delete") {
               (contextualAction, swipeButton, completionHandler: (Bool) -> Void) in
               print("Deleting \(indexPath.row)")
                
            let courseFromCoreData = try? self.context.fetch(WishList.fetchRequest()) as? [WishList]
            
            self.context.delete(courseFromCoreData![indexPath.row])
           // self.context.delete(courseFromCoreData![indexPath.item])
            
            do {
                try self.context.save()
            }catch{
                print("Det gick inge bra det h├Ąr ...")
            }
            self.educations[indexPath.section].courses.courses.remove(at: indexPath.row)
            self.educations.remove(at: indexPath.section)
            self.tableView.reloadData()
           }
           return action
       }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return educations[section].courses.education
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
       if let vc = storyboard?.instantiateViewController(withIdentifier: "InfoAboutCoursesViewController") as? InfoAboutCoursesViewController {
           vc.kurs = educations[indexPath.section].courses.courses[indexPath.row].description
           vc.omKurs = educations[indexPath.section].courses.courseDecription[indexPath.row].description
           vc.utbildning = educations[indexPath.section].courses.education.description
           vc.kursL├Ąngd = educations[indexPath.section].courses.courseLenght[indexPath.row].description
           vc.delegate = self
           self.navigationController?.pushViewController(vc, animated: true)
       }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    

}

