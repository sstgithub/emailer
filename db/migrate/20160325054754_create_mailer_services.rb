class CreateMailerServices < ActiveRecord::Migration
  def change
    create_table :mailer_services do |t|
      t.string :username
      t.string :password
      t.string :domain
      t.string :address
      t.integer :port

      t.timestamps null: false
    end
  end
end
