//
//  NewsView.swift
//  LiveFootballScore
//
//  Created by Talha Gergin on 5.01.2025.
//

import SwiftUI

struct NewsView: View {
    @Binding var selectionTabItem: Int
    @State private var newsClient = NewsClient()
    @State private var news: [News] = []
    
    private func getNews() async {
        do {
            news = try await newsClient.getNews()
        } catch {
            print("Hata oluştu: \(error.localizedDescription)")
        }
    }
    
    var body: some View {
        ZStack {
            List {
                ForEach(news) { newsItem in
                   
                        HStack {
                                AsyncImage(url: URL(string: newsItem.imageUrl)) { image in
                                        image.resizable()
                                    } placeholder: {
                                        ProgressView()
                                    }
                                .frame(width: 100, height: 100)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                            VStack(alignment: .leading){
                                Text(newsItem.title).font(.title3).bold()
                            }
                        }
                
                    }
            }
        }
        .navigationTitle("Haberler")
        .onAppear {
            Task {
               await getNews()
            }
        }
    }
}

#Preview {
    NewsView(selectionTabItem: .constant(1))
}
