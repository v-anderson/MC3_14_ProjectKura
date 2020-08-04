//
//  DiaryContent.swift
//  MC3_14_ProjectKura
//
//  Created by Vincent Anderson Ngadiman on 04/08/20.
//  Copyright © 2020 Vincent Anderson Ngadiman. All rights reserved.
//

import Foundation

enum HeartType {
    case redHeart
    case blueHeart
    case yellowHeart
    case blackHeart
}

struct DiaryContent {
    let diaryImage: [String]
    let isiDiary: [String]
}


let diaryContents:[HeartType:DiaryContent] =
    [HeartType.redHeart: DiaryContent(
        diaryImage: ["PictureRedHeart","PictureRedHeart2"],
        isiDiary: ["Look at the sea! it’s sooo clean and the water is sooo clear that I can see through it. Oh, I can also see the beauty of colorful corals very clearly... such a sight that can really spoil the eyes! I bet this is because of Sheila’s environment friendly actions. I can swim all day between corals and seaweeds~","It was one of the best day I ever had! The beach is beautiful and clean. I don’t need to clean the beach and I’m just enjoying the view all day!. I might even get sun burnt. The air that’s very fresh make me relaxed. I love a day like this! Sheila really helped me a lot. Sheila’s really is a good person"]),
     HeartType.blueHeart: DiaryContent(
        diaryImage: ["PictureBlueHeart", "PictureBlueHeart2"],
        isiDiary: ["It’ll be great to sprawl on the beach while enjoying the sea breeze, but.. The weather feels like it’s getting hotter now! Therefore, I decided to refresh myself by swimming in the sea. Well, the sea still looks fine so far. Keep it up by reducing the use of plastic, Sheila!","Enjoying the breeze by the beach will never goes wrong! I almost fell asleep under a coconut tree, then suddenly my friend came over. He told me that he met “something” that looks like him but it doesn’t move at all. I wonder what exactly is the “something”  that he mentioned..."]),
     HeartType.yellowHeart: DiaryContent(
        diaryImage: ["PictureYellowHeart","PictureYellowHeart2"],
        isiDiary: ["I want to play with my friends at the sea, But... some of them couldn’t come because they’re suffering. I heard they were contaminated with plastic trash that started to appear recently.. :( I'm so sad, Sheila. I hope you can help me make the sea a safe place for us by reducing plastic trash..","When I went strolling this afternoon, I was shocked when i found trash scattered around the beach. I spent an entire afternoon to clean the beach. The beach still can be saved but I’m not sure if the condition keep like this. I really hoped Sheila did not forget about helping me.."]),
     HeartType.blackHeart: DiaryContent(
        diaryImage: ["PictureBlackHeart", "PictureBlackHeart2"],
        isiDiary: ["Oh, NO! Take a look at those trash! It’s covering all over the water.. More and more sea friends contaminated with the pollution.. and looks like the corals are also affected. The sea  turns into a place that could kill us. Please, Sheila.. Your choices and action will help me no matter how small it may be..","What a nightmare at the beach, I played with my friend and suddenly a plastic pops out of no where! He almost trapped if I didn’t help him immediately. Now the trash covered all over the water. I hope Sheila would’ve started doing environment friendly actions by now."])
]


