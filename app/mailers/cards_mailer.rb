class CardsMailer < ApplicationMailer
  def pending_cards_notification(user)
    @user = user
    @url = 'https://desolate-taiga-89778.herokuapp.com/'
    url2 = "ilya89forrails@gmail.com"
    mail(to: url2, subject: 'hello everybody')
  end
end
