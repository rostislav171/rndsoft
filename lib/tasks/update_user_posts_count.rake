# lib/tasks/update_user_posts_count.rake
task :update_user_posts_count => :environment do
  User.all.each do |user|
    user.posts_count = user.posts.where(created_at: (Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)).count
    user.save
  end
end
