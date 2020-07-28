//
//  OnboardingCuestion.swift
//  MC3_14_ProjectKura
//
//  Created by M Habib Ali Akbar on 28/07/20.
//  Copyright © 2020 Vincent Anderson Ngadiman. All rights reserved.
//

import Foundation

enum OnboardingCuestionType {
    case single
    case multi
}

struct OnboardingQuestion {
    let question: String
    let questionsType: OnboardingCuestionType
    let answers: [String]
    let goodAnswer: Int
    let isLongQuestion: Bool
}

let onboardingQuestions = [
    OnboardingQuestion(question: "You look thirsty, Would you like to order some drink before we started? ", questionsType: .single, answers: ["OK"], goodAnswer: 0, isLongQuestion: true),
    OnboardingQuestion(question: "Great! What you want to order?", questionsType: .single, answers: ["Just Coffee Please"], goodAnswer: 0, isLongQuestion: false),
    OnboardingQuestion(question: "What do you want to use?", questionsType: .multi, answers: ["Mug", "Coffee Cup"], goodAnswer: 0, isLongQuestion: false),
    OnboardingQuestion(question: "While we are waiting, Do you want to get some straw first for your coffee?", questionsType: .multi, answers: ["Yes, I want it", "No, I’m Good"], goodAnswer: 1, isLongQuestion: true),
    OnboardingQuestion(question: "Do you want me to ask for a bottled water while we waiting for the coffee?", questionsType: .multi, answers: ["It’s OK. I bring my own water", "Sure. That would be great"], goodAnswer: 0, isLongQuestion: true),
    OnboardingQuestion(question: "Here’s your coffee. And how’s your home?", questionsType: .multi, answers: ["It’s all nice and good there, I really like it", "It’s so much nicer back then, now is dirty and polluted"], goodAnswer: 0, isLongQuestion: false),
    OnboardingQuestion(question: "I need your help to take care of the beach. With your help, my job would be a lot easier. I know it’s a big task but will you help me?", questionsType: .single, answers: ["OK"], goodAnswer: 0, isLongQuestion: true),
    OnboardingQuestion(question: "Wow you’re so kind. My father was right about you. But to begin I need to chat and remind you a thing or two with you so can you give me access to your notifications center?", questionsType: .single, answers: ["OK"], goodAnswer: 0, isLongQuestion: true),
    OnboardingQuestion(question: "Great. Now let’s go to my home", questionsType: .single, answers: ["OK"], goodAnswer: 0, isLongQuestion: false)
]
