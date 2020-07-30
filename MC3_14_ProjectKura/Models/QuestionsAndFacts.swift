//
//  FoodQuestions.swift
//  MC3_14_ProjectKura
//
//  Created by Aldo Sugiarto on 24/07/20.
//  Copyright © 2020 Vincent Anderson Ngadiman. All rights reserved.
//

import Foundation

struct QuestionsAndFact {
    let questions: String
    let factTitle: String
    let factBody: String
    let answers: [String]
    let goodAnswer: Int
    let imageName: String
}

let FoodQuestions = [
    QuestionsAndFact(questions: "Did you wash your plates hand or in the dishwasher?",
                     factTitle: "Hand washing dishes can use up to 50% more water than a water-saving energy-efficient dishwasher.",
                     factBody: "Make sure you use the dishwater when it's fully load. If you do wash dishes in the sink, fill up your sink first. Don’t let the water run constantly down the drain.",
                     answers: ["Dishwasher", "By Hand"],
                     goodAnswer: 0,
                     imageName: "foodFact1"),
    
    QuestionsAndFact(questions: "Did you takeaway your food for lunch?",
                     factTitle: "If you buy food from outside, try not to ask for non-reusable cutlery (straws, spoon, etc.)",
                     factBody: "Single use plastic cutlery does not get recycled because they are too light-weight and too contaminated. Maybe you think, “It’s just one fork,” but multiplied by millions upon millions, those plastic utensils are terrible for the environment!",
                     answers: ["No, I didn't", "Yes, I did"],
                     goodAnswer: 0,
                     imageName: "foodFact2"),
    
    QuestionsAndFact(questions: "Did you finish all your food?",
                     factTitle: "Let's make sure to eat what you can eat.",
                     factBody: "If you have leftovers, save any leftovers, rather than throwing them away. Food waste accounts for about 4,4 gigatonnes of greenhouse gas emissions (GHG) per year. To put this in perspective, if food loss and waste were its own country, it would be the world’s third-largest GHG emitter",
                     answers: ["No, I didn't", "Yes, I did"],
                     goodAnswer: 1,
                     imageName: "foodFact3")
]

let electricityQuestions = [
    QuestionsAndFact(questions: "Which one do you agree : leave the lights on or turn it on and off several times a day?",
                     factTitle: "It is always better to turn the lights off when not in use.",
                     factBody: "Turning off the lights when you leave your room can help save energy. It can also help reduce carbon emission and other harmful greenhouse gases. Hence, turning off your lights is a simple way to help protect the environment and save the Earth.",
                     answers: ["Leave The Lights On", "Turn It On and Off"],
                     goodAnswer: 1,
                     imageName: "ElectFact1"),
    QuestionsAndFact(questions: "Have you turn off all the unused lamp in your house?",
                     factTitle: "It is always better to turn the lights off when not in use.",
                     factBody: "Turning off the lights when you leave your room can help save energy. It can also help reduce carbon emission and other harmful greenhouse gases. Hence, turning off your lights is a simple way to help protect the environment and save the Earth.",
                     answers: ["No, I Haven't", "Yes"],
                     goodAnswer: 1,
                     imageName: "ElectFact1"),
    
]

let kipasQuestions = [
    QuestionsAndFact(questions: "Fresh morning air is very good for your health. Turn off your AC or fan and open your windows to let the air flows in.",
                     factTitle: "Turn off any air conditioning electronic in the morning to save enery and get fresh air.",
                     factBody: "Inadequate ventilation, high temperature and humidity are a few of the primary causes of indoor air pollution in our homes. Morning is the right time to get fresh air. Open your windows to air out your home often, as indoor air pollution can actually be more toxic than the air outside.",
                     answers: ["Agree", "Disagree"],
                     goodAnswer: 0,
                     imageName: "ElectFact2"),
    QuestionsAndFact(questions: "Is it better to leave air conditioner or turn it off if you're going away?",
                     factTitle: "Don’t forget to turn off the AC when you leave.",
                     factBody: "Not only can leaving your air conditioner on at full capacity throughout the day result in higher electricity bills, but it can shorten the lifespan of your system too.",
                     answers: ["Keep the AC Off", "Keep the AC On"],
                     goodAnswer: 0,
                     imageName: "ElectFact3"),
]

let shoppingBagQuestions = [
    QuestionsAndFact(questions: "Do you bring additional bag when you go shopping?",
                     factTitle: "When you go shopping, remember to bring additional reusable bag to avoid the use of plastic bag.",
                     factBody: "It takes 500 (or more) years for a plastic bag to degrade in a landfill. Unfortunately the bags don't break down completely but instead photo-degrade, becoming microplastics that absorb toxins and continue to pollute the environment.",
                     answers: ["No, I Don’t", "Yes, I Do"],
                     goodAnswer: 1,
                     imageName: "ShopBagFact1"),
    
    QuestionsAndFact(questions: "Do you bring your own tumbler when you go outside?",
                     factTitle: "If you go outside bring your own drink using reusable tumbler.",
                     factBody: "We use about the 12 billion paper cups in one year, which is nearly 8,000 tons of pulp. In this process, it is generates approximately 122,000 tons of carbon dioxide. To absorb this carbon dioxide, we have to plant 47,250,000 trees. When you use tumbler you already save tree, water and, energy.",
                     answers: ["No, I Don’t", "Yes, I Do"],
                     goodAnswer: 1,
                     imageName: "ShopBagFact2"),
    QuestionsAndFact(questions: "Do you often buy new shopping bag instead of using the old ones?",
                     factTitle: "Use available shopping bag instead of buying a new one.",
                     factBody: "Instead of always buying shopping bag, the best bag to use is one you already own no matter what it’s made from. Because if you just use it one or two times, it doesn't cover the the amount of resources wasted, and the levels of pollution produced.",
                     answers: ["No, I Don’t", "Yes, I Do"],
                     goodAnswer: 0,
                     imageName: "ShopBagFact3"),
//    QuestionsAndFact(questions: "Do you usually shop in bulk?",
//                     factTitle: "Buy in bulk to reduce packaging. If you cant buy in bulk, avoid unnecessary packaging.",
//                     factBody: "Buying in bulk eliminates the need for fancy packaging & single-use plastic. Making the switch to buying in bulk will make a dramatic impact on your weekly waste and encourage you to be more mindful about your consumption choices in general.",
//                     answers: ["No, I Don’t", "Yes, I Do"],
//                     goodAnswer: 1,
//                     imageName: "ShopBagFact4")
]

