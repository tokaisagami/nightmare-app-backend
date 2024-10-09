class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :password_digest, null: false
      t.string :password_confirmation
      t.string :reset_password_token
      t.datetime :reset_password_sent_at
      t.string :remember_me_token
      t.timestamps null: false
    end
  end
end
