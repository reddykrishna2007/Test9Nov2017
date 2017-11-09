//
//  ViewController.swift
//  DemoSQLite
//
//  Created by Manuh on 10/25/17.
//  Copyright © 2017 Manuh. All rights reserved.
//

import UIKit
import Eureka

class ViewController: FormViewController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        form +++ Section("Section1")
        
            <<< TextRow()
            {                
                $0.title = "Text Row"
                $0.placeholder = "Enter text here"
            }
            <<< PhoneRow()
            {
                $0.title = "Phone Row"
                $0.placeholder = "And numbers here"
            }
            
            +++ Section("Section2")
            
            <<< DateRow()
            {
                $0.title = "Date Row"
                $0.value = Date(timeIntervalSinceReferenceDate: 0)
            }
        
        form +++ Section()
            
            <<< SwitchRow("switchRowTag")
            {
                $0.title = "Show message"
            }
            
            <<< LabelRow()
            {
                $0.hidden = Condition.function(["switchRowTag"], { form in
                    return !((form.rowBy(tag: "switchRowTag") as? SwitchRow)?.value ?? false)
                })
                $0.title = "Switch is on!"
            }
        
            <<< LabelRow()
            {
                $0.hidden = Condition.function(["switchRowTag"], { form in
                    return !((form.rowBy(tag: "switchRowTag") as? SwitchRow)?.value ?? false)
                })
                $0.title = "Sreekar is On!"
            }

        
        form +++ SelectableSection<ListCheckRow<String>>("Where do you live", selectionType: .singleSelection(enableDeselection: true))
        
        let continents = ["Africa", "Antarctica", "Asia", "Australia", "Europe", "North America", "South America"]
        
        for option in continents
        {
            form.last! <<< ListCheckRow<String>(option){ listRow in
                listRow.title = option
                listRow.selectableValue = option
                listRow.value = nil
            }
        }
        
        //let pData = Databasemanagement()
        
    }

}

