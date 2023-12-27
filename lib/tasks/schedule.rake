# lib/tasks/schedule.rake
task :schedule => :environment do
  require 'rufus-scheduler'

  scheduler = Rufus::Scheduler.new

  scheduler.cron '0 7 * * *' do
    Rake::Task['update_user_posts_count'].invoke
  end

  # Keep the scheduler running
  scheduler.join
end
