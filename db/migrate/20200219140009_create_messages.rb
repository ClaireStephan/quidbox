class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.string :from, null: false
      t.string :to, null: false
      t.text :body, null: false
      t.boolean :private, null: false
      t.timestamp :posted

      t.timestamps
    end
  end
end
