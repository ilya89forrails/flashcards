class AddRepetitionAndEfactorToCard < ActiveRecord::Migration[5.0]
  def change
    add_column :cards, :repetition, :integer, default: 1
    add_column :cards, :efactor, :float, default: 2.5
  end
end
