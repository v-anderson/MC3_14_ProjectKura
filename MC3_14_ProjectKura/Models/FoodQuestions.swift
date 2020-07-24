//
//  FoodQuestions.swift
//  MC3_14_ProjectKura
//
//  Created by Aldo Sugiarto on 24/07/20.
//  Copyright © 2020 Vincent Anderson Ngadiman. All rights reserved.
//

import Foundation

struct FoodQuestion {
    let questions: String
    let factTitle: String
    let factBody: String
    let answers: [String]
    let goodAnswer: Int
    let imageName: String
}

let questions = [
    FoodQuestion(questions: "Did you wash your plates hand or in the dishwasher?",
                 factTitle: "Hand washing dishes can use up to 50% more water than a water-saving energy-efficient dishwasher.",
                 factBody: "Make sure you use the dishwater when it's fully load. If you do wash dishes in the sink, fill up your sink first. Don’t let the water run constantly down the drain.",
                 answers: ["Dishwasher", "By Hand"],
                 goodAnswer: 0,
                 imageName: "foodFact1"),
    
    FoodQuestion(questions: "Did you takeaway your food for lunch?",
                 factTitle: "Hand washing dishes can use up to 50% more water than a water-saving energy-efficient dishwasher.",
                 factBody: "Make sure you use the dishwater when it's fully load. If you do wash dishes in the sink, fill up your sink first. Don’t let the water run constantly down the drain.",
                 answers: ["No, I didn't", "Yes, I did"],
                 goodAnswer: 0,
                 imageName: "foodFact2"),
    
    FoodQuestion(questions: "Did you finish all your food?",
                 factTitle: "Let's make sure to eat what you can eat.",
                 factBody: "If you have leftovers, save any leftovers, rather than throwing them away. Food waste accounts for about 4,4 gigatonnes of greenhouse gas emissions (GHG) per year. To put this in perspective, if food loss and waste were its own country, it would be the world’s third-largest GHG emitter",
                 answers: ["No, I didn't", "Yes, I did"],
                 goodAnswer: 1,
                 imageName: "foodFact3")
]


