class CardsMailer < ApplicationMailer
  default from: 'Flashcards'

  def pending_cards_notification(user)
    @user = user
    @email = @user.email
    mail(to: @email, subject: 'Unreviewed cards!')
  end
end
