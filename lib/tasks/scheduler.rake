desc "Send emails to users"
task update_feed => :environment do
  puts "Start sending emails"
  Card.notify_user
  puts "All emails has sended"
end
