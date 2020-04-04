desc 'Sending monthly emails to users'
task survey_mail: :environment do
  puts 'sending...'
  User.all.each do |user|
    UserMailer.survey_email(user).deliver if today == today.end_of_month
  end
  puts 'done!'
  
end