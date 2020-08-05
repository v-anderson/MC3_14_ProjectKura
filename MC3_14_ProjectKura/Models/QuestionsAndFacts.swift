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
    QuestionsAndFact(questions: "Did you wash your plates by hand or in the dishwasher?",
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
                     imageName: "foodFact3"),
    QuestionsAndFact(questions: "Do you like to eat canned food?",
                     factTitle: "Try to not eating food that comes from cans.",
                     factBody: "BPA can be extremely dangerous to children, pregnant women and in actuality, all of us.",
                     answers: ["Yes, I do", "No, I don't"],
                     goodAnswer: 1,
                     imageName: "foodFact3"),
    QuestionsAndFact(questions: "Did you wash your hands with water running on?", factTitle: "Turn off the water",
                     factBody: "Turning off water while washing your hands will conserve the water.",
                     answers: ["Yes, I do", "No, I don't"],
                     goodAnswer: 1,
                     imageName: "foodFact1"),
    QuestionsAndFact(questions: "Does your fridge full?",
                     factTitle: "Keep your freezer and refrigerator full.",
                     factBody: "They will run better and stay cold longer. (Don’t want to buy more food to fill up a freezer? Fill gallon or half gallon jugs ¾ of the way with water and freeze.)",
                     answers: ["Yes, I do", "No, I don't"],
                     goodAnswer: 0,
                     imageName: "ElectFact1")
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
                     answers: ["No, I Haven't", "Yes, I Have"],
                     goodAnswer: 1,
                     imageName: "ElectFact1"),
    QuestionsAndFact(questions: "Are your battery charger still plug in?",
                     factTitle: "Unplug all unused appliances and electronic devices.",
                     factBody: "Although you may not be aware of it, unused but still plugged in devices, can suck vampire power from your home. Besides, power costs money",
                     answers: ["Yes, I do", "No, I don't"],
                     goodAnswer: 1,
                     imageName: "ElectFact3"),
    QuestionsAndFact(questions: "Do you like to open your windows in the morning?",
                     factTitle: "It is better to open up your windows in the morning if possible.",
                     factBody: "Toxic products, inadequate ventilation, high temperature and humidity are a few of the primary causes of indoor air pollution in our homes. Open your windows to air out your home often, as indoor air pollution can actually be more toxic than the air outside.",
                     answers: ["Yes, I do", "No, I don't"],
                     goodAnswer: 0,
                     imageName: "ElectFact2"),
    QuestionsAndFact(questions: "How do you do your laundry?",
                     factTitle: "Washer is more efficient with full loads",
                     factBody: "Your clothes washer and dishwasher are designed to run most efficiently with full loads. And more than that, if you run them only when full, you run them less often, which really cuts energy us",
                     answers: ["Wait until it piled up","Wash before it piled up"],
                     goodAnswer: 0,
                     imageName: "ElectFact1"),
    QuestionsAndFact(questions: "Do you wash your clothes with hot water?",
                     factTitle: "Cold water works efficiently",
                     factBody: "Clothes washers and laundry detergents are designed to work efficiently with cold water. If you only wash with hot water when you need to disinfect, you could save $60 or more a year.",
                     answers: ["Yes, I do", "No, I don't"],
                     goodAnswer: 1,
                     imageName: "ElectFact1"),
    QuestionsAndFact(questions: "Do you turn off your electronics while you're away?",
                     factTitle: "Turn off unused electronic devices",
                     factBody: "Leaving your computer on while idle wastes electricity and shortens the life of your machine. The same goes for televisions, printers and other electronics. If you see the indicator light on, you’re burning power needlessly.",
                     answers: ["Yes, I do", "No, I don't"],
                     goodAnswer: 0,
                     imageName: "ElectFact1"),
    QuestionsAndFact(questions: "Do you open your windows blind during hot weather?",
                     factTitle: "Closing the blinds will keep you from direct sunlight out of your home and reduce unwanted solar heat gain.",
                     factBody: "On hot  days, when the sun's light shines into some of your windows it's heating the interior, causing you to turn up the air conditioning and use more energy.",
                     answers: ["Yes, I do", "No, I don't"],
                     goodAnswer: 1,
                     imageName: "ElectFact1"),
    QuestionsAndFact(questions: "If the weather not so hot in the afternoon. What would you do?",
                     factTitle: "Fan is using less power than AC",
                     factBody: "Running a fan takes a lot less electricity than running an air conditioner; ceiling fans average at about 15-90 watts of energy used, and tower fans use about 100 watts.",
                     answers: ["Using fan and open the door", "Turn on the AC"],
                     goodAnswer: 0,
                     imageName: "ElectFact3"),
    QuestionsAndFact(questions: "Is it better to leave air conditioner or turn it off if you're going away?",
                     factTitle: "Turn it off when you leave.",
                     factBody: "Not only can leaving your air conditioner on at full capacity throughout the day result in higher electricity bills, but it can shorten the lifespan of your system too.",
                     answers: ["Keep the AC on", "Keep the AC off"],
                     goodAnswer: 1,
                     imageName: "ElectFact3")
    
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
    QuestionsAndFact(questions: "When you forgot to bring shopping bag. What will you do?",
                     factTitle: "Both options harm the environment.",
                     factBody: "Plastic will litter the ocean and paper create carbon emission during the manufacture. But if you forgot to bring it, better to reuse plastic for 2 until 3 times before you throw. But the best option is to always remember to bring reusable bag",
                     answers: ["Use plastic bag and reuse it", "Ask paper bag for single use"],
                     goodAnswer: 0,
                     imageName: "ShopBagFact1"),
    QuestionsAndFact(questions: "Did you forget to bring your own water bottle today?",
                     factTitle: "Do not forget to bring your own bottle!",
                     factBody: "By using a water filter and stainless steel or glass bottles you can save money and keep plastic bottles out of the landfills.",
                     answers: ["Yes, I do", "No, I don't"],
                     goodAnswer: 1,
                     imageName: "ShopBagFact2"),
    QuestionsAndFact(questions: "Do you like to collect receipt/ bills?",
                     factTitle: "Ask receipt if only necessary or just ask for e-receipt.",
                     factBody: "Skipping receipts would save 12 billion pounds of carbon dioxide (CO2), the equivalent of one million cars on the road.",
                     answers: ["Yes, I do", "No, I don't"],
                     goodAnswer: 1,
                     imageName: "ElectFact2"),
    QuestionsAndFact(questions: "Did you shop in bulk?",
                     factTitle: "Buy in bulk to reduce packaging",
                     factBody: "If you cant buy in bulk, avoid unnecessary packaging. Buying in bulk eliminates the need for fancy packaging & single-use plastic.",
                     answers: ["Yes, I do", "No, I don't"],
                     goodAnswer: 0,
                     imageName: "ShopBagFact3"),
    QuestionsAndFact(questions: "Did you bring shopping bag in your bag?",
                     factTitle: "Try to always bring a shopping bag in your bag.",
                     factBody: "If you forgot, you always have one in your bag. Or you can also add 'bring shopping bag' into your shopping list.",
                     answers: ["Yes, I do", "No, I don't"],
                     goodAnswer: 0,
                     imageName: "ShopBagFact1"),
    QuestionsAndFact(questions: "Do you like to buy shopping bag?",
                     factTitle: "The best bag to use is the one you already own",
                     factBody: "Instead of always buying shopping bag, it is best to use you already own no matter what it’s made from. Because if you just use it one or two times, it doesn't cover the the amount of resources wasted, and the levels of pollution produced.",
                     answers: ["Yes, I do", "No, I don't"],
                     goodAnswer: 1,
                     imageName: "ShopBagFact3")
    
    
//    QuestionsAndFact(questions: "Do you usually shop in bulk?",
//                     factTitle: "Buy in bulk to reduce packaging. If you cant buy in bulk, avoid unnecessary packaging.",
//                     factBody: "Buying in bulk eliminates the need for fancy packaging & single-use plastic. Making the switch to buying in bulk will make a dramatic impact on your weekly waste and encourage you to be more mindful about your consumption choices in general.",
//                     answers: ["No, I Don’t", "Yes, I Do"],
//                     goodAnswer: 1,
//                     imageName: "ShopBagFact4")
]

