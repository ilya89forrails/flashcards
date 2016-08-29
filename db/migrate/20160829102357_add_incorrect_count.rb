class AddIncorrectCount < ActiveRecord::Migration[5.0]
  def change
    add_column :cards, :incorrect_count, :integer, default: 0
  end
end
