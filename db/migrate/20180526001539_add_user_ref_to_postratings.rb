class AddUserRefToPostratings < ActiveRecord::Migration[5.1]
  def change
    add_reference :postratings, :user, foreign_key: true
    add_reference :postratings, :post, foreign_key: true
  end
end
