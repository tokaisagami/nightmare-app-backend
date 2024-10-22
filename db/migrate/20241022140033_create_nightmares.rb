class CreateNightmares < ActiveRecord::Migration[7.0]
  def change
    create_table :nightmares do |t|
      t.integer :user_id
      t.text :description
      t.text :modified_description
      t.string :ending_type
      t.boolean :published

      t.timestamps
    end
  end
end
