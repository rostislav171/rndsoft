# config/initializers/scheduler.rb

scheduler = Rufus::Scheduler.new

scheduler.cron('0 7 * * *') do
  User.all.each do |user|
    ExampleMailer.sample_email(user).deliver_now
  end
end
