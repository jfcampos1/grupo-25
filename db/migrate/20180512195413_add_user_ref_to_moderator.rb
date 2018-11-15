class AddUserRefToModerator < ActiveRecord::Migration[5.1]
  def change
    add_reference :moderators, :user, foreign_key: true
    add_reference :moderators, :tema, foreign_key: true
  end
end
