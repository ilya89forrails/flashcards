class CardNotificationService
  include Interactor

  def call
    users_list = User.joins(:cards).where('cards.review_date <= ?', Time.now)
    users_list.uniq.each do |user|
      CardsMailer.pending_cards_notification(user).deliver_now
    end
  end
end
