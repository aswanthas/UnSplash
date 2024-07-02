//
//  MainView.swift
//  UnSplash
//
//  Created by Aswanth K on 01/07/24.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel = ViewModel()
    @State private var isChecked: Bool = false
    @State private var showDescriptionDialog: Bool = false
    @State private var toastMessage: String = ""
    var body: some View {
        NavigationView {
            ZStack {
                List {
                    ForEach(viewModel.response) { item in
                        ListCellView(data: item) { isChecked in
                            handleCellTap(isChecked: isChecked)
                        }
                        .onAppear {
                            if viewModel.response.isLastItem(item) {
                                viewModel.loadNextPage()
                            }
                        }
                    }
                }
                if showDescriptionDialog {
                    ToastView
                }
            }
            .navigationTitle("Home")
        }
        .onAppear(perform: {
            viewModel.fetchData(page: nil)
        })
        .alert(isPresented: $viewModel.showAlert) { // Display the alert
            Alert(
                title: Text("Warning"),
                message: Text(viewModel.errorMessage ?? "Please try again"),
                dismissButton: .default(Text("OK"))
            )
        }
    }
    var ToastView: some View {
        ZStack(alignment: .center, content: {
            VStack {
                Spacer()
                HStack {
                    Text(self.toastMessage)
                        .foregroundColor(.white)
                        .transition(.move(edge: .bottom))
                        .frame(maxWidth: .infinity, maxHeight: 42, alignment: .leading)
                        .cornerRadius(radius: 8)
                        .padding(EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16))
                }
                .background(Color.gray)
                .cornerRadius(4)
                .frame(maxWidth: .infinity, maxHeight: 42, alignment: .center)
                .padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16))
            }
            .padding(.horizontal, 16)
        })
        .onAppear(perform: {
            if self.showDescriptionDialog {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.showDescriptionDialog = false
                }
            }
        })
    }
    func handleCellTap(isChecked: Bool) {
        if isChecked {
            toastMessage = "checkBox enabled"
        } else {
            toastMessage = "Checkbox is disabled"
        }
        showDescriptionDialog = true
    }
}

#Preview {
    MainView()
}
