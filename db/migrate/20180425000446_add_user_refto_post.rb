class AddUserReftoPost < ActiveRecord::Migration[5.1]
  def change
    add_reference :posts, :user, foreign_key: true
    add_reference :posts, :tema, foreign_key: true
  end
end
