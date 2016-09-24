class AddLocale < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :locale, :string, default: 'en'
  end
end
