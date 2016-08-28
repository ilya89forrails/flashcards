class AddRatingToCard < ActiveRecord::Migration[5.0]
  def change
    add_column :cards, :rating, :integer, default: 1
  end
end
