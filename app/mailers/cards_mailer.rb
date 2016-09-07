class CardsMailer < ApplicationMailer
	default from: "Flashcards" 

  def pending_cards_notification(user)
    @user = user
    @url = @user.email
    mail(to: @url, subject: 'Unreviewed cards!')
  end
end
