class AddUserReftoTema < ActiveRecord::Migration[5.1]
  def change
    add_reference :temas, :foro, foreign_key: true
  end
end
