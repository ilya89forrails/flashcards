desc 'Send emails to users'
task :mailer do
  puts 'Start sending emails'
  CardNotificationService.call
  puts 'All emails has sended'
end
