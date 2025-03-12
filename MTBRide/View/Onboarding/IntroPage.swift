//
//  IntroPage.swift
//  MTBRide
//
//  Created by Adnann Muratovic on 10.03.25.
//

import SwiftUI

struct IntroPage: View {
    /// View Properties
    @State private var activeCard: Card? = cards.first
    @State private var scrollPosition: ScrollPosition = .init()
    @State private var currentScrollOffset: CGFloat = 0
    @State private var timer = Timer.publish(every: 0.01, on: .current, in: .default).autoconnect()
    @State private var initialAnimation: Bool = false
    @State private var titleProgress: CGFloat = 0
    @State private var isNavigationToSignIn: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                /// Ambient Background View
                AmbientBackground()
                    .animation(.easeIn(duration: 1), value: activeCard)
                
                VStack(spacing: 40) {
                    MainContent()
                    TextSection()
                }
                .safeAreaPadding(15)
            }
            .navigationDestination(isPresented: $isNavigationToSignIn) {
                SignIn()
            }
        }
        .onReceive(timer) { _ in
            currentScrollOffset += 0.35
            scrollPosition.scrollTo(x: currentScrollOffset)
        }
        .task {
            try? await Task.sleep(for: .seconds(0.35))
            
            withAnimation(.smooth(duration: 0.75)) {
                initialAnimation = true
            }
            
            withAnimation(.smooth(duration: 2.5, extraBounce: 0).delay(0.3)) {
                titleProgress = 1
            }
        }
    }
    
    @ViewBuilder
    private func MainContent() -> some View {
        InfiniteScrollView {
            ForEach(cards) { card in
                CarouselCardView(card)
            }
        }
        .scrollIndicators(.hidden)
        .scrollPosition($scrollPosition)
        .containerRelativeFrame(.vertical) { value, _ in
            value * 0.45
        }
        .onScrollGeometryChange(for: CGFloat.self) {
            $0.contentOffset.x + $0.contentInsets.leading
        } action: { oldValue, newValue in
            currentScrollOffset = newValue
            
            let activeIndex = Int((currentScrollOffset / 220).rounded()) % cards.count
            activeCard = cards[activeIndex]
        }
        
        .visualEffect { [initialAnimation] content, proxy in
            content
                .offset(y: !initialAnimation ? -(proxy.size.height + 200) : 0)
        }
    }
    
    @ViewBuilder
    private func TextSection() -> some View {
        VStack(spacing: 4) {
            Text("Welcome to")
                .foregroundStyle(.textSecondary)
                .blurOpacityEffect(initialAnimation)
            Text("MTB Rides+")
                .font(.displayLarge)
                .foregroundStyle(.white)
                .textRenderer(TitleTextRender(progress: titleProgress))
                .padding(.bottom, 12)
            
            Text("Track and explore the best MTB trails.\nRide solo or with friends and track your progress. Navigation and stats included\n with MTB Ride+.")
                .font(.callout)
                .multilineTextAlignment(.center)
                .foregroundStyle(.white.secondary)
                .blurOpacityEffect(initialAnimation)
        }
        
        Button {
            /// cancel timer
            timer.upstream.connect().cancel()
            isNavigationToSignIn.toggle()
        } label: {
            Text("Create Account")
                .fontWeight(.semibold)
                .foregroundStyle(.textPrimary)
                .padding(.horizontal, 25)
                .padding(.vertical, 12)
                .background(.primaryAction, in: .capsule)
        }
        .blurOpacityEffect(initialAnimation)
    }
    
    @ViewBuilder
    private func AmbientBackground() -> some View {
        GeometryReader {
            let size = $0.size
            
            ZStack {
                ForEach(cards) { card in
                    Image(card.image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .ignoresSafeArea()
                        .frame(width: size.width, height: size.height)
                    /// Show only active card
                        .opacity(activeCard?.id == card.id ? 1 : 0)
                }
                
                Rectangle()
                    .fill(.black.opacity(0.5))
                    .ignoresSafeArea()
            }
            .compositingGroup()
            .blur(radius: 90, opaque: true)
            .ignoresSafeArea()
        }
    }
    
    /// Carousel Card View
    @ViewBuilder
    private func CarouselCardView(_ card: Card) -> some View {
        GeometryReader {
            let size = $0.size
            
            Image(card.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: size.width, height: size.height)
                .clipShape(.rect(cornerRadius: 20))
                .shadow(color: .black.opacity(0.4), radius: 10, x: 1, y: 0)
        }
        
        .frame(width: 220)
        .scrollTransition(.interactive.threshold(.centered), axis: .horizontal) { content, phase in
            content
                .offset(y: phase == .identity ? -10 : 0)
                .rotationEffect(.degrees(phase.value * 5), anchor: .bottom)
        }
    }
}

#Preview {
    IntroPage()
}

extension View {
    func blurOpacityEffect(_ show: Bool) -> some View {
        self
            .blur(radius: show ? 0 : 2)
            .opacity(show ? 1 : 0)
            .scaleEffect(show ? 1 : 0.9)
    }
}
