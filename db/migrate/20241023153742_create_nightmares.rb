class CreateNightmares < ActiveRecord::Migration[7.0]
  def change
    create_table :nightmares do |t|
      t.integer :user_id
      t.text :description
      t.text :modified_description
      t.integer :ending_category, default: 0, null: false
      t.boolean :published
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
    end
  end
end
