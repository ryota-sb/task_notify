test_user = User.create!({
  name: "Test User",
  email: "test@example.com",
  password: "password"
})


test_user.tasks.create!(
  [
    { 
      content: "読書",
      is_done: false,
      notification_time: "2000-01-01T18:00:00.000+09:00",
      week: "monday",
      user_id: test_user.id
    },
    { 
      content: "英文法勉強",
      is_done: false,
      notification_time: "2000-01-01T19:00:00.000+09:00",
      week: "monday",
      user_id: test_user.id
    },
    { 
      content: "Railsアプリ作成続き",
      is_done: false,
      notification_time: "2000-01-01T20:00:00.000+09:00",
      week: "monday",
      user_id: test_user.id
    },
    { 
      content: "心理学について",
      is_done: false,
      notification_time: "2000-01-01T21:00:00.000+09:00",
      week: "monday",
      user_id: test_user.id
    },
  ]
)
