class CreateComentratings < ActiveRecord::Migration[5.1]
  def change
    create_table :comentratings do |t|
      t.integer :star

      t.timestamps
    end
  end
end
