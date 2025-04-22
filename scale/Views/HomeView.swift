//
//  HomeView.swift
//  scale
//
//  Created by Alexander Ng on 2025-04-20.
//

import SwiftUI

struct HomeView: View {
    @AppStorage("lastWeight") var lastWeight: Double = 0.0
    @ObservedObject var homeVM: HomeViewModel = HomeViewModel()

    static let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        return formatter
    }()

    init() {
        let vm = HomeViewModel()
        vm.weight = lastWeight
        self.homeVM = vm
    }

    var body: some View {
        VStack {
            Text("Autoset based on your last inputted weight. Just modify from here.")
            HStack{
                TextField("Enter value", value: $homeVM.weight, formatter: Self.numberFormatter)
                    .keyboardType(.decimalPad)
                    .padding()
                    .background(.gray.opacity(0.2))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke())

                Text("LBs").font(.title)

                VStack{
                    Text("1")
                    Button(action: {
                        homeVM.weight -= 1
                    }) {
                        Image(systemName: "minus")
                            .font(.title2)
                            .frame(width: 40, height: 40)
                            .background(Color.gray.opacity(0.2))
                            .clipShape(Circle())
                    }

                    Button(action: {
                        homeVM.weight += 1
                    }) {
                        Image(systemName: "plus")
                            .font(.title2)
                            .frame(width: 40, height: 40)
                            .background(Color.gray.opacity(0.2))
                            .clipShape(Circle())
                    }
                }

                VStack{
                    Text("0.1")
                    Button(action: {
                        homeVM.weight -= 0.1
                    }) {
                        Image(systemName: "minus")
                            .font(.title2)
                            .frame(width: 40, height: 40)
                            .background(Color.gray.opacity(0.2))
                            .clipShape(Circle())
                    }

                    Button(action: {
                        homeVM.weight += 0.1
                    }) {
                        Image(systemName: "plus")
                            .font(.title2)
                            .frame(width: 40, height: 40)
                            .background(Color.gray.opacity(0.2))
                            .clipShape(Circle())
                    }
                }
            }.padding()
            Button(action: {
                Task {
                    do {
                        try await homeVM.save()
                        print("WHAT")
                        lastWeight = homeVM.weight
                    } catch {
                        print("saving weights failed")
                    }
                }
            }) {
                Text("Save")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            .padding(.horizontal) // optional, for clarity
        }
    }
}

#Preview {
    HomeView()
}
