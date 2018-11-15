class CreateComents < ActiveRecord::Migration[5.1]
  def change
    create_table :coments do |t|
      t.date :date
      t.text :content
      t.timestamps
    end
  end
end
