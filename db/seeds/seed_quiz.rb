#Seed file to create some initial quizzes

animal_category = Category.create(name: 'Animals')

quiz = Quiz.create(name: 'Animal Quiz')

QuizCategory.create(quiz: quiz, category: animal_category)

question1 = Question.create(questions: 'What is a group of owls called?', quiz: quiz, score: 10)

Option.create(opt_name: 'An Army', question: question1, is_answer: false)

Option.create(opt_name: 'A Bewilderment', question: question1, is_answer: false)

Option.create(opt_name: 'A Parliment', question: question1, is_answer: true)

Option.create(opt_name: 'A Surprise', question: question1, is_answer: false)

question2 = Question.create(questions: 'Do blue whales have teeth?', quiz: quiz, score: 5)

Option.create(opt_name: 'Yes', question: question2, is_answer: false)

Option.create(opt_name: 'No', question: question2, is_answer: true)

question3 = Question.create(questions: "In what country would you find the world's northernmost wild monkey population?", quiz: quiz, score: 15)

Option.create(opt_name: 'India', question: question3, is_answer: false)

Option.create(opt_name: 'Japan', question: question3, is_answer: true)

Option.create(opt_name: 'Spain', question: question3, is_answer: false)

Option.create(opt_name: 'United States', question: question3, is_answer: false)

question4 = Question.create(questions: 'Which of the following is NOT a type of antelope?', quiz: quiz, score: 10)

Option.create(opt_name: 'Impala', question: question4, is_answer: false)

Option.create(opt_name: 'Gazelle', question: question4, is_answer: false)

Option.create(opt_name: 'Marten', question: question4, is_answer: true)

Option.create(opt_name: 'Springbok', question: question4, is_answer: false)

