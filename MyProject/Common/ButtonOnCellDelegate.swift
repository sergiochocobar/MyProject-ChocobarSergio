//
//  ButtonOnCellDelegate.swift
//  MyProject
//
//  Created by Sergio Chocobar on 08/11/2021.
//

import UIKit
import Foundation


//Este archivo en la clase 03 al principio ANGEL lo llama como igual que el PROTOCOLO "ButtonOncellDelegate.swift" y es buena practica hacerlo asi

protocol ButtonOnCellDelegate{
    func buttonTouchedOnCell(aCell:UITableViewCell) //este metodo recibe un parametro de tipo UITableViewCell
}

