desc "Send emails to users"
task :mailer do
  puts "Start sending emails"
  Card.notify_user
  puts "All emails has sended"
end
