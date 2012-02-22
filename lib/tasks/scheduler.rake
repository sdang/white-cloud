desc "Send reminders to users using their selected notification method"
task :send_reminders => :environment do
  Reminder.send_reminders
end

desc "Daily task to tell supervisors who hasn't completed their reminders"
task :send_reminders_to_supervisors => :environment do
  ReminderList.send_supervisor_reminders
end