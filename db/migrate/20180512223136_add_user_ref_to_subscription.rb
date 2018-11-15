class AddUserRefToSubscription < ActiveRecord::Migration[5.1]
  def change
    add_reference :subscriptions, :user, foreign_key: true
    add_reference :subscriptions, :tema, foreign_key: true
  end
end
