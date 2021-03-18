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
                if myEducation.courses.education == "Önskelista" {
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
    
        let Webbprogrammering = CoursesModel(education: "Webbprogrammering", courses: ["HTML & CSS", "Avancerad CSS", "JavaScript för nybörjare", "Avancerad JavaScript & serverprogrammering", "JavaScript för webben", "ASP.NET Core MVC"], courseDecription: ["Utbildning inom HTML & CSS där man lär sig skapa hemsidor och hur man skapar design till hemsidorna också", "Utbildning inom själva stylingen inom webbutveckling där vi går djupare in på design och hur man kan snygga till hemsidor", "Utbildning inom JavaScript för nybörjare så man lär sig syntax osv", "Avancerad kurs inom JavaScript och serverprogrammering där man får djupare kunskap", "Utveckling med JavaScript för webben så man lär sig binda sin kunskap", "Vad är ASP.NET Core MVC. ASP.NET Core MVC-ramverket är en lätt, öppen källkod, mycket testbar presentationsramverk optimerad för användning med ASP.NET Core"], courseLenght: ["1,5 veckor", "2 veckor", "2 veckor", "4 veckor", "3 veckor", "2 veckor"])
        let education1 = EducationModel(courses: Webbprogrammering, status: .Register)
        
        let Mobilprogrammering = CoursesModel(education: "Mobilprogrammering", courses: ["Introduktion till Android programmering", "Avancerad Android programmering", "iOS utveckling med Objective-C", "iOS utveckling med Swift", "Design och layout för mobila enheter"], courseDecription: ["Introduktion för Andriod där vi bland annat går igenom java och själva syntaxen så att ni kan bygga vidare själva sedan med den här erfarenheten", "En mer avancerad kurs där man du lär dig skapa och designa bra Andriod appar för att själva sedan kunna skapa och lägga ut appar på GooglePlay store", "IOS utveckling med apples gamla verktyg där du får lära dig Objective-C språket och bygga appar via Apples gamla språk och Objective-C's syntax", "IOS Utveckling med apples nya språk, där du får lära dig bygga snygga appar", "Ja det står ju i namnet här lär du dig hur du kan få snygga design och layouter för mobila enheter"], courseLenght: ["2 veckor", "3 veckor", "2 veckor", "4 veckor", "2 veckor"])
        let education2 = EducationModel(courses: Mobilprogrammering, status: .Register)
        
        let BackEndprogrammering = CoursesModel(education: "BackEndprogrammering", courses: ["IREST Api med node.js", "Web Api med .NET Core"], courseDecription: ["Här får man lära sig jobba med IREST API MED NODE.JS och lära sig varför det är användbart och hur man programmerar med API's", "Här får ni bland annat lära er web API med .NET core och hur man ska bygga systemen med själva verktyget"], courseLenght: ["3 veckor", "3 veckor"])
        let education3 = EducationModel(courses: BackEndprogrammering, status: .Register)
        
        let Database = CoursesModel(education: "Database", courses: ["Administrera MS SQL Server", "Databas design", "Bygga system med MongoDB", "Vad är ORM? Hur använder man ett sådant verktyg."], courseDecription: ["Här får du lära dig MS SQL server och hur du kan programmera för att bygga  upp den här databasen. Hur man skriver tabeller och hur man hämtar ut tabellerna", "Här lär du dig hur man ska designa sina databaser", "Här lär du dig bygga databas system med MongoDB", "Här lär du dig om ORM och hur man ska använda sig utav det"], courseLenght: ["3 veckor", "3 veckor", "4 veckor", "4 veckor"])
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
            status = "KÖPT"
        }
       
        cell.textLabel?.text = educations[indexPath.section].courses.courses[indexPath.row]
        cell.detailTextLabel?.text = "STATUS: \(status), LÄNGD: \(educations[indexPath.section].courses.courseLenght[indexPath.row])"

        return cell
    }
    func callAlert() {
        let alert = UIAlertController(title: "Ta bort kurs", message: "Se till att bara radera från dina egna kurser annars krashar appen", preferredStyle: .alert)
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
        
        let action = UIContextualAction(style: .normal, title: "Köp || Registrera") {
        (contextualAction, swipeButton, completionHandler: (Bool) -> Void) in
            let alert = UIAlertController(title: "Köp eller registrera", message: "Gå vidare med köp eller registrering", preferredStyle: .alert)
                    
            alert.addAction(UIAlertAction(title: "Köp", style: .default, handler: { action in
        
                let alert = UIAlertController(title: "Köp kurs", message: "Gå vidare med köp", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Köp", style: .default, handler: { action in
                        if let vc = self.storyboard?.instantiateViewController(identifier: "RegisterViewController") as? RegisterViewController {
                            vc.education = "Köpt kurs"
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
                print("Det gick inge bra det här ...")
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
           vc.kursLängd = educations[indexPath.section].courses.courseLenght[indexPath.row].description
           vc.delegate = self
           self.navigationController?.pushViewController(vc, animated: true)
       }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    

}

