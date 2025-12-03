User.create!(name: "管理者", email: "admin@example.com", password: "password", password_confirmation: "password", role: :admin)
u = User.create!(name: "学生A", email: "student@example.com", password: "password", password_confirmation: "password", role: :student)

3.times do |i|
  Event.create!(
    title: "サークルイベント #{i+1}",
    description: "説明 #{i+1}",
    location: "教室#{i+1}",
    start_datetime: Time.zone.now + (i+1).days,
    end_datetime: Time.zone.now + (i+1).days + 2.hours,
    capacity: 20,
    category: "サークル",
    organizer: "団体#{i+1}",
    creator: User.first
  )
end
