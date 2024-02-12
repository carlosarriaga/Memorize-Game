
# Stanford Memory Game

This repository contains the result of the SwiftUI CS193p course taught at Stanford University.

[Stanford Course site](https://cs193p.sites.stanford.edu/2023)



## Course Content per Class

### Lecture 1: Getting started with SwiftUI

Introduction to the course.  The basics of SwiftUI.  Start working on the first application of the quarter, a card-matching game called Memorize.  This will be the foundation for the first few weeks of course material.

[Youtube - Lecture 1](https://www.youtube.com/watch?v=bqu6BquVi2M)


### Lecture 2: Learning more about SwiftUI

The very important concept of Views takes center stage as basic composition mechanisms of SwiftUI (stacking and gridding) are used to put multiple cards into the game, each built out of a reusable “card” View.  A simple demonstration of handling a tap gesture gets the cards flipping over and a couple of buttons are added to the user-interface to control the number of cards in the game.

[Youtube - Lecture 2](https://www.youtube.com/watch?v=3lahkdHEhW8)


### Lecture 3: Learning more about SwiftUI

SwiftUI iOS app development necessitates the MVVM architecture. This lecture introduces and showcases MVVM in the Memorize app. All SwiftUI development is done in Swift, a language uniquely supportive of modern programming paradigms. The lecture covers Swift's type system basics, including structs, classes, generics, and functions as types. The Memorize app then advances to implement Model and ViewModel, utilizing generics and functions as types throughout.

[Youtube - Lecture 3](https://www.youtube.com/watch?v=--qKOhdgJAs&t=1s)


### Lecture 4: Memorize Game Logic

Swift's enumeration semantics offer powerful features, allowing data storage in matching cases, creation of helper methods directly within the enumeration, pattern-matching in switch statements, and more. Many Swift libraries use the Optional enumeration, benefiting from Swift's syntax for handling Optionals. Optionals also play a role in graceful error-handling when an operation may or may not successfully return a desired value. These concepts are directly demonstrated in the final presentation of Memorize, summarizing the key features of Memorize in its functional state.

[Youtube - Lecture 4](https://www.youtube.com/watch?v=oWZOFSYS5GE)


### Lecture 5: Properties Layout @ViewBuilder

Video 5 of the SwiftUI development lecture series at Stanford (Spring 2021) redefines the use cases for @State, emphasizing its memory usage. The lecture expands on the concept of properties, covering computed properties and property observers. The architecture for laying out Views on screen is discussed, including combiner Views and tools like GeometryReader, overlay, and background. The @ViewBuilder directive is introduced for syntactical support in building lists of Views. Demonstrations in the Memorize game showcase automatic sizing of emoji font to fit available space. The lecture also highlights tightened access control on internal APIs in Memorize and demonstrates XCode features like rename and fold.

[Youtube - Lecture 5](https://www.youtube.com/watch?v=ayQl_F_uMS4&t=1s)


### Lecture 6: Protocols Shapes

Lecture 6 of Stanford’s CS193p SwiftUI development course given during the Spring of 2021 finished off the discussion of the Swift Type System with an explanation of perhaps the most important kind of type in Swift: protocols. We touch on a number of protocol concepts, including a "constrains and gains" conceptualization of protocol extensions, the use of generics and protocols together, and protocol inheritance. After combining the concepts of protocols and generics in the Memorize game to size the cards to fit the available space on screen by creating an AspectVGrid, the lecture moves on to the topic of drawing arbitrary shapes using the Shape protocol. We take a look back at previously employed modifiers to Shape like .fill() which we can now more deeply understand through our studies of generics and protocols.  We conclude this lecture by enhancing our Memory game to draw the pie-shaped countdown timer, using a custom Shape and ViewBuilder, which will be animated in the next lecture.

[Youtube - Lecture 6](https://www.youtube.com/watch?v=Og9gXZpbKWo)


### Lecture 7: ViewModifier Animation

Lecture 7 of Stanford’s CS193p iOS Development course from Spring of 2021 begins with an explanation of ViewModifier, including a demonstration of how to create a custom Cardify ViewModifier for the Memorize game. The lecture then transitions into an in-depth look at animation, covering topics such as implicit vs. explicit animations, Animation structs, transitions, matched geometry effects, the impact of container views, Shape animations, animating ViewModifiers and more. We begin the first part of a two-lecture-long demo by illustrating how to use implicit animation to spin an emoji when a card is successfully matched in our Memorize game. Throughout this process, we constantly refer back to some golden rules of animation, and demonstrate how to use them to diagnose problems when our animations fail to behave as we expect.

[Youtube - Lecture 6](https://www.youtube.com/watch?v=PoeaUMGAx6c)


### Lecture 8: Animation Demonstration

After having learned all about animation in the previous lecture, video 8 of Stanford’s CS193p iOS Development course from Spring 2021 is entirely comprised of demonstrations showing how to use animation to enhance our Memorize game.  We learn how to animate the appearance (dealing out) of the cards using matchedGeometryEffect, the flipping of the cards using AnimatableModifier, the shuffling and choosing of the cards using explicit animation, and the counting down of bonus time on a card by animating the pie Shape from a previous lecture. We also discuss how to delay animations and use @State with animation.

[Youtube - Lecture 6](https://www.youtube.com/watch?v=-N1UR7Y105g)

