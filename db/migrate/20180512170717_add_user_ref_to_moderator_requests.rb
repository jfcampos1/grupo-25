class AddUserRefToModeratorRequests < ActiveRecord::Migration[5.1]
  def change
    add_reference :moderator_requests, :user, foreign_key: true
    add_reference :moderator_requests, :tema, foreign_key: true
  end
end
