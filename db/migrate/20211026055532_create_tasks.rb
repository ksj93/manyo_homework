class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :title, null:false
      t.text :content, null:false
      t.string :status, null:false
      t.date :deadline, null:false
      # ,dafault:Time.now.strftime("%Y-%m-%d")
      t.string :priority, null:false

      t.timestamps
    end
  end
end
