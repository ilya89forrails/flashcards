# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20_160_918_121_741) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'authentications', force: :cascade do |t|
    t.integer  'user_id',    null: false
    t.string   'provider',   null: false
    t.string   'uid',        null: false
    t.datetime 'created_at'
    t.datetime 'updated_at'
    t.index %w(provider uid), name: 'index_authentications_on_provider_and_uid', using: :btree
  end

  create_table 'cards', force: :cascade do |t|
    t.string   'original_text'
    t.string   'translated_text'
    t.date     'review_date'
    t.datetime 'created_at',                    null: false
    t.datetime 'updated_at',                    null: false
    t.integer  'user_id'
    t.string   'pic'
    t.integer  'deck_id'
    t.integer  'rating',          default: 1
    t.integer  'incorrect_count', default: 0
    t.integer  'repetition',      default: 1
    t.float    'efactor',         default: 2.5
  end

  create_table 'decks', force: :cascade do |t|
    t.string   'title'
    t.integer  'user_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'users', force: :cascade do |t|
    t.string   'email'
    t.datetime 'created_at',                      null: false
    t.datetime 'updated_at',                      null: false
    t.string   'crypted_password'
    t.string   'salt'
    t.integer  'current_deck_id'
    t.string   'locale', default: 'en'
    t.index ['email'], name: 'index_users_on_email', unique: true, using: :btree
  end
end
