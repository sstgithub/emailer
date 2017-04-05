class DeleteMailerServices < ActiveRecord::Migration
  def change
    drop_table :mailer_services
  end
end
