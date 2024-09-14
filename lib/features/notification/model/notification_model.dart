

class NotificationModel {
  final String ? title;
  final String body;
  final String ? image;
  final String ? time;
  NotificationModel({
    this.title,
    required this.body,
    this.image,
    this.time,
  });



  static List<NotificationModel> notifications = [
    NotificationModel(
      title: "New Course: Machine Learning Basics",
      body:
          "Get started with 'Machine Learning 101' and understand the fundamentals of AI.",
      image: "https://example.com/ml_basics.png",
      time: "Just now",
    ),
    NotificationModel(
      title: "Data Science Bootcamp: Enrollment Open",
      body:
          "Master Data Science with our new 6-week bootcamp. Limited seats available!",
      image: "https://example.com/ds_bootcamp.png",
      time: "15 mins ago",
    ),
    NotificationModel(
      title: "UI/UX Design: Beginner to Pro",
      body: "Transform your design skills with our comprehensive UI/UX course.",
      image: "https://example.com/uiux_course.png",
      time: "1 hour ago",
    ),
    NotificationModel(
      title: "Business Analytics: New Assignment",
      body:
          "Analyze the latest case study in 'Business Analytics' and submit by Friday.",
      image: "https://example.com/analytics_assignment.png",
      time: "Today, 8:00 AM",
    ),
    NotificationModel(
      title: null,
      body:
          "New video available: 'Data Visualization with Python'. Watch it now!",
      image: null,
      time: "Yesterday, 5:45 PM",
    ),
    NotificationModel(
      title: "Marketing Strategy Masterclass",
      body:
          "Learn how to build effective marketing strategies in the digital era.",
      image: "https://example.com/marketing_masterclass.png",
      time: "Yesterday",
    ),
    NotificationModel(
      title: "Advanced Flutter: Workshop Tomorrow",
      body:
          "Join the advanced Flutter workshop to take your development skills to the next level.",
      image: "https://example.com/flutter_workshop.png",
      time: "Tomorrow, 10:00 AM",
    ),
    NotificationModel(
      title: "Introduction to Cloud Computing",
      body: "Start learning the basics of cloud computing and AWS today.",
      image: "https://example.com/cloud_computing.png",
      time: "2 days ago",
    ),
    NotificationModel(
      title: "Marketing Campaign: Case Study Released",
      body:
          "Read and analyze the new case study on a successful marketing campaign.",
      image: null,
      time: "3 days ago",
    ),
    NotificationModel(
      title: "UI Design Trends in 2024",
      body:
          "Stay updated with the latest trends in UI design with our new article.",
      image: "https://example.com/ui_trends.png",
      time: "Last week",
    ),
  ];


  
}
