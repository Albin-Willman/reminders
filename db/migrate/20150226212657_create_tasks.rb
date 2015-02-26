class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name
      t.string :description
      t.integer :offset
      t.integer :frequenzy
      t.integer :recurrance_type

      t.timestamps null: false
    end
  end
end
