import 'package:flutter/material.dart';

class HeroAnimation extends StatefulWidget {
  const HeroAnimation({super.key});

  @override
  State<HeroAnimation> createState() => _HeroAnimationState();
}

class _HeroAnimationState extends State<HeroAnimation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('People'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: people.length,
        itemBuilder: (context, index) {
          var person = people[index];
          return ListTile(
            leading: Hero(
              tag: person.emoji,
              child: Text(
                person.emoji,
                style: const TextStyle(fontSize: 40),
              ),
            ),
            title: Text(person.name),
            trailing: const Icon(Icons.arrow_forward_ios),
            subtitle: Text('${person.age} years old'),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => DetailsScreen(person: person))),
          );
        },
      ),
    );
  }
}

class DetailsScreen extends StatelessWidget {
  final Person person;
  const DetailsScreen({super.key, required this.person});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Hero(
            flightShuttleBuilder: (flightContext, animation, flightDirection,
                fromHeroContext, toHeroContext) {
              switch (flightDirection) {
                case HeroFlightDirection.push:
                  return Material(
                      color: Colors.transparent,
                      child: ScaleTransition(
                          scale: animation.drive(Tween<double>(
                            begin: 0.0,
                            end: 1.0,
                          ).chain(CurveTween(curve: Curves.fastOutSlowIn))),
                          child: toHeroContext.widget));
                case HeroFlightDirection.pop:
                  return Material(
                      color: Colors.transparent, child: fromHeroContext.widget);
              }
            },
            tag: person.emoji,
            child: Text(
              person.emoji,
              style: const TextStyle(fontSize: 30),
            )),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(children: [
            Text(
              person.name,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "${person.age} years old",
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

const people = [
  Person(name: 'John', age: 20, emoji: '1'),
  Person(name: 'Jane', age: 21, emoji: '2'),
  Person(name: 'Jack', age: 23, emoji: '3'),
];

class Person {
  final String name;
  final int age;
  final String emoji;
  const Person({
    required this.name,
    required this.age,
    required this.emoji,
  });
}
