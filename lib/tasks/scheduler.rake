desc "Send reminders to users using their selected notification method"
task :send_reminders => :environment do
  Reminder.send_reminders
end
