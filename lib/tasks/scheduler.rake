desc 'Send emails to users'
task :mailer do
  puts 'Start sending emails'
  SendCardNotification.call
  puts 'All emails has sended'
end
