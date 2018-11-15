class AddUserRefToComentratings < ActiveRecord::Migration[5.1]
  def change
    add_reference :comentratings, :user, foreign_key: true
    add_reference :comentratings, :coment, foreign_key: true
  end
end
