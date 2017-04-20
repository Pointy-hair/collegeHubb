//
//  Questions.swift
//  CollegeHub
//
//  Created by Sumanpreet on 22/02/17.
//  Copyright © 2017 Sumanpreet. All rights reserved.
//

import Foundation
import SwiftyJSON
import EZSwiftExtensions

enum questionKeys: String{
    case questions_id = "questions_id" // "questions_id":1,
    case question = "question"  //"question": "What’s your departure city?",
    case have_options = "have_options" //"have_options": 1,
    case type = "type"
    //0 select, 1 numeric, 2 file, 3 date, 4 radiobtn, 5 time, 6 dropdown, 7 images, 8 use_location, 9 text, 10 current_location, 11 price, 12 edition, 13 duration, 14 multiple_inputs
    case how_many = "how_many" //"how_many": 2,
    case question_for = "question_for"   //"question_for": 0,
    case sub_questions_id = "sub_questions_id"
    case sub_questions = "sub_questions" //"sub_questions" : []
    case sub1_questions = "sub1_questions" //"sub1_questions" : []
    case sub2_questions = "sub2_questions" //"sub1_questions" : []
}

class QuestionModel : NSObject, JSONDecodable{
    
    var questions_id : String?
    var question : String?
    var have_options : String?
    var type : String?
    var how_many : String?
    var question_for : String?
    
    var sub_questions_id : String?
    var sub1_questions_id : String?
    var sub2_questions_id : String?
    
    var sub_questions : [QuestionModel]?
    var sub1_questions : [QuestionModel]?
    var sub2_questions : [QuestionModel]?

    required init( withAttributes  attributes: OptionalSwiftJSONParameters) throws {
        super.init()
        
        questions_id = questionKeys.questions_id.rawValue => attributes
        question = questionKeys.question.rawValue => attributes
        have_options = questionKeys.have_options.rawValue => attributes
        type = questionKeys.type.rawValue => attributes
        how_many = questionKeys.how_many.rawValue => attributes
        question_for = questionKeys.question_for.rawValue => attributes
        
        if  let arrayTemp = questionKeys.sub_questions.rawValue =| attributes {
            sub_questions = []
            for dict in arrayTemp {
                sub_questions?.append(try QuestionModel(withAttributes: dict.dictionaryValue))
            }
        }
        
        if  let arrayTemp = questionKeys.sub1_questions.rawValue =| attributes {
            sub1_questions = []
            for dict in arrayTemp {
                sub1_questions?.append(try QuestionModel(withAttributes: dict.dictionaryValue))
            }
        }
        
        if  let arrayTemp = questionKeys.sub2_questions.rawValue =| attributes {
            sub2_questions = []
            for dict in arrayTemp {
                sub2_questions?.append(try QuestionModel(withAttributes: dict.dictionaryValue))
            }
        }
    }
    
    override init() {
        super.init()
    }
    
    class func parseArrayinToModal(withAttributes attributes : [JSON]?) -> AnyObject? {
        
        //Original data parsing method
        var arrayVendor : [[QuestionModel]] = []

        guard let arrayData = attributes else {return arrayVendor as AnyObject?}
        
        for i in 0...arrayData.count - 1{
            var arrayQuestions : [QuestionModel] = []
            for dict in arrayData[i].arrayValue {
                do {
                    print(dict.dictionaryValue)
                    let modal =  try QuestionModel(withAttributes: dict.dictionaryValue)
                    arrayQuestions.append(modal)
                } catch _ {
                }
            }
            do{
                arrayVendor.append(arrayQuestions)
            }catch _ {
            }
        }
        
        return arrayVendor as AnyObject?
        
        
//        var arrayVendor : [QuestionModel] = []
//        guard let arrayData = attributes else {return arrayVendor as AnyObject?}
//        
//        
//        for dict in arrayData {
//            do {
//                let modal =  try QuestionModel(withAttributes: dict.dictionaryValue )
//                arrayVendor.append(modal)
//            } catch _ {
//            }
//            
//        }
//        return arrayVendor as AnyObject?
        
    }
}

