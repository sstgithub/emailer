class CreateRecipients < ActiveRecord::Migration
  def change
    create_table :recipients do |t|
      t.string :email_address
      t.string :first_name
      t.string :last_name
      t.string :salutation

      t.timestamps null: false
    end
  end
end
