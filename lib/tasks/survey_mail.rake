desc 'Sending monthly emails to users'
task survey_mail: :environment do
  puts 'sending...'
  User.all.each do |user|
    today = Date.today
    frequency = user.notification_frequency

    if frequency == 'monthly'
      UserMailer.survey_email(user).deliver if today == today.end_of_month
    elsif frequency == 'fortnightly'
      UserMailer.survey_email(user).deliver if today.day == 15
    elsif frequency == 'weekly'
      UserMailer.survey_email(user).deliver if today.saturday?
    end
  end
  puts 'done!'
  
end