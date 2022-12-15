# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_12_15_024607) do
  create_table "birds", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "birds_trees", id: false, force: :cascade do |t|
    t.integer "bird_id"
    t.integer "tree_id"
    t.index ["bird_id"], name: "index_birds_trees_on_bird_id"
    t.index ["tree_id"], name: "index_birds_trees_on_tree_id"
  end

  create_table "trees", force: :cascade do |t|
    t.string "name"
    t.integer "height"
    t.string "species"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
