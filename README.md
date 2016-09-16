# Codaisseur Forum

The project consists on a forum application that will be used by current students and alumni from Codaisseur. It will provide the community a better tool for getting questions answered, and making it easier to connect with other people going through the same journey.

The original project was built as a full Ruby on Rails application by a group of Codaisseur students. In this fork the Rails app is transformed into an api to serve a [React frontend application](https://github.com/Ecthelion3/codaisseur-forum-react).

### Models
---

#### Model / Question
- Title
- Body
- [Bonus] images_url

#### Model / Answer
- Body

#### Model / Topic
- Title

### Model Associations
---

#### Users
- has_many :questions
- has_many :answers

#### Questions
- belongs_to :user
- has_many :answers
- has_one :topic

#### Answers
- belongs_to :user
- belongs_to :question

#### Topics
- has_many :questions

#### Votes
- [TODO]
