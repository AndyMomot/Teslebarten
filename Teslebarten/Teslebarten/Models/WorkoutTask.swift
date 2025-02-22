//
//  TaskModel.swift
//  BoFitvada
//
//  Created by Andrii Momot on 12.02.2025.
//

import Foundation

struct WorkoutTask: Identifiable, Codable, Equatable {
    let id: String
    let name: String
    let score: Int
    let type: WorkoutType
    var description: String?
    var isFinished: Bool = false
    var isCustom: Bool = false
    
    
}

enum WorkoutType: String, Codable, CaseIterable {
    case power = "Power"
    case endurance = "Endurance"
    case flexibility = "Flexibility"
    case speed = "Speed"
}

extension WorkoutTask {
    static let allStaticTasks: [WorkoutTask] = powerTasks + enduranceTasks + flexibilityTasks + speedTasks
    
    static var powerTasks: [WorkoutTask] {
        [
            .init(
                id: "1",
                name: "Lift a total of 500 kg (1100 lbs) in a single workout session",
                score: 10,
                type: .power
            ),
            .init(
                id: "2",
                name: "Do 20 push-ups in a row",
                score: 20,
                type: .power
            ),
            .init(
                id: "3",
                name: "Hold a plank for 2 minutes",
                score: 30,
                type: .power
            ),
            .init(
                id: "4",
                name: "Perform 10 pull-ups",
                score: 40,
                type: .power
            ),
            .init(
                id: "5",
                name: "Squat with your body weight for 15 reps",
                score: 50,
                type: .power
            ),
            .init(
                id: "6",
                name: "Deadlift 1.5x your body weight",
                score: 60,
                type: .power
            ),
            .init(
                id: "7",
                name: "Do 50 kettlebell swings (16 kg / 35 lbs)",
                score: 70,
                type: .power
            ),
            .init(
                id: "8",
                name: "Bench press your body weight for 5 reps",
                score: 90,
                type: .power
            ),
            .init(
                id: "9",
                name: "Perform a one-arm push-up",
                score: 90,
                type: .power
            ),
            .init(
                id: "10",
                name: "Do a muscle-up on a pull-up bar",
                score: 100,
                type: .power
            )
        ]
    }
    
    static var enduranceTasks: [WorkoutTask] {
        [
            .init(
                id: "11",
                name: "Run 1 km (0.6 miles) without stopping",
                score: 10,
                type: .endurance
            ),
            .init(
                id: "12",
                name: "Cycle for 5 km (3.1 miles)",
                score: 20,
                type: .endurance
            ),
            .init(
                id: "13",
                name: "Jump rope for 5 minutes continuously",
                score: 30,
                type: .endurance
            ),
            .init(
                id: "14",
                name: "Swim 200 meters (656 feet) without stopping",
                score: 40,
                type: .endurance
            ),
            .init(
                id: "15",
                name: "Run 5 km (3.1 miles) in under 30 minutes",
                score: 50,
                type: .endurance
            ),
            .init(
                id: "16",
                name: "Cycle 20 km (12.4 miles)",
                score: 60,
                type: .endurance
            ),
            .init(
                id: "17",
                name: "Swim 500 meters (1640 feet) without stopping",
                score: 70,
                type: .endurance
            ),
            .init(
                id: "18",
                name: "Run 10 km (6.2 miles) in under 1 hour",
                score: 80,
                type: .endurance
            ),
            .init(
                id: "19",
                name: "Complete a half marathon (21.1 km / 13.1 miles",
                score: 90,
                type: .endurance
            ),
            .init(
                id: "20",
                name: "Complete a full marathon (42.2 km / 26.2 miles)",
                score: 100,
                type: .endurance
            )
        ]
    }
    
    static var flexibilityTasks: [WorkoutTask] {
        [
            .init(
                id: "21",
                name: "Hold a deep squat for 30 seconds",
                score: 10,
                type: .flexibility
            ),
            .init(
                id: "22",
                name: "Touch your toes without bending your knees",
                score: 20,
                type: .flexibility
            ),
            .init(
                id: "23",
                name: "Perform a full backbend (bridge pose)",
                score: 30,
                type: .flexibility
            ),
            .init(
                id: "24",
                name: "Hold a side split stretch for 30 seconds on each side",
                score: 40,
                type: .flexibility
            ),
            .init(
                id: "25",
                name: "Do a forward split (or get as close as possible)",
                score: 50,
                type: .flexibility
            ),
            .init(
                id: "26",
                name: "Hold a standing split for 15 seconds",
                score: 60,
                type: .flexibility
            ),
            .init(
                id: "27",
                name: "Perform a full pancake stretch",
                score: 70,
                type: .flexibility
            ),
            .init(
                id: "28",
                name: "Hold a scorpion pose for 15 seconds",
                score: 80,
                type: .flexibility
            ),
            .init(
                id: "29",
                name: "Perform the lotus position (both legs)",
                score: 90,
                type: .flexibility
            ),
            .init(
                id: "30",
                name: "Achieve a full front split with no hands on the floor",
                score: 100,
                type: .flexibility
            )
        ]
    }
    
    static var speedTasks: [WorkoutTask] {
        [
            .init(
                id: "31",
                name: "Sprint 50 meters (164 feet) in under 10 seconds",
                score: 10,
                type: .speed
            ),
            .init(
                id: "32",
                name: "Perform 20 jumping squats in 30 seconds ",
                score: 20,
                type: .speed
            ),
            .init(
                id: "33",
                name: "Dribble a basketball through cones in under 20 seconds",
                score: 30,
                type: .speed
            ),
            .init(
                id: "34",
                name: "Jump onto a 50 cm (20 inches) box 10 times in a row ",
                score: 40,
                type: .speed
            ),
            .init(
                id: "35",
                name: "Sprint 100 meters (328 feet) in under 15 seconds",
                score: 50,
                type: .speed
            ),
            .init(
                id: "36",
                name: "Perform 50 quick punches on a heavy bag in 30 seconds",
                score: 60,
                type: .speed
            ),
            .init(
                id: "37",
                name: "Sprint 200 meters (656 feet) in under 30 seconds",
                score: 70,
                type: .speed
            ),
            .init(
                id: "38",
                name: "Do 100 jumping jacks in 60 seconds ",
                score: 80,
                type: .speed
            ),
            .init(
                id: "39",
                name: "Sprint 400 meters (0.25 miles) in under 1 minute",
                score: 90,
                type: .speed
            ),
            .init(
                id: "40",
                name: "Sprint 1 km (0.6 miles) in under 3 minutes",
                score: 100,
                type: .speed
            )
        ]
    }
}
