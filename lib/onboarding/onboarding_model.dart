class OnBoardingModel {
  String title;
  String description;

  OnBoardingModel({required this.title, required this.description});

  OnBoardingModel copyWith({
    String? title,
    String? description,
  }) {
    return OnBoardingModel(
        title: title ?? this.title,
        description: description ?? this.description);
  }
}

final List<OnBoardingModel> demoData = [
  OnBoardingModel(
    title: "Title 01",
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
  ),
  OnBoardingModel(
    title: "Title 02",
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
  ),
  OnBoardingModel(
    title: "Title 03",
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
  ),
  OnBoardingModel(
    title: "Title 04",
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
  ),
];
