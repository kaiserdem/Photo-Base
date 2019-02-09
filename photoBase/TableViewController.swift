//
//  TableViewController.swift
//  photoBase
//
//  Created by Kaiserdem on 08.02.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import UIKit
import CoreData

class TableViewController: UITableViewController, NSFetchedResultsControllerDelegate {

  var frc: NSFetchedResultsController = NSFetchedResultsController<NSFetchRequestResult>()
  
  var pc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
  
  func fetchRequest() -> NSFetchRequest<NSFetchRequestResult> { // получить запрос
    
    let fetchResult = NSFetchRequest<NSFetchRequestResult>(entityName: "Entity")
    let sorted = NSSortDescriptor(key: "titleText", ascending: true)
    fetchResult.sortDescriptors = [sorted]
    return fetchResult
  }
  
  func getFRC() -> NSFetchedResultsController<NSFetchRequestResult> {
    frc = NSFetchedResultsController(fetchRequest: fetchRequest(), managedObjectContext: pc, sectionNameKeyPath: nil, cacheName: nil)
    return frc
  }
  
    override func viewDidLoad() {
        super.viewDidLoad()

       frc = getFRC()
      frc.delegate = self
      
      do {
        try frc.performFetch()
      }
      catch {
        print(error)
        return
      }
      self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
      
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
      let numberOfRows = frc.sections?[section].numberOfObjects
      return numberOfRows!
    }

  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell

      let item = frc.object(at: indexPath) as! Entity
      cell.cellTitle.text = item.titleText
      cell.cellDescription.text = item.descriptionText
      cell.cellImage.image = UIImage(data: (item.image)! as Data)
      
        return cell
    }
  func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    
    tableView.reloadData()
  }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

  
    // Override to support editing the table view.
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
      
      let mangaedObject : NSManagedObject = frc.object(at: indexPath) as! NSManagedObject
      
      pc.delete(mangaedObject)
      
      do {
        try pc.save()
      }
      catch {
        print(error)
        return
      }
    }
  

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

  
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if segue.identifier == "edit" {
        
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)
        
        let itemController : AddViewController = segue.destination as! AddViewController
        
        let item : Entity = frc.object(at: indexPath!) as! Entity
        
        itemController.item = item
      }
    }
 

}
