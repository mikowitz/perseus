class CreateAuthorsAndWorks < ActiveRecord::Migration
  def up
    create_table :authors do |t|
      t.string :name, null: false
      t.string :language, null: false
    end

    add_index :authors, [:name, :language], :unique => true

    create_table :works do |t|
      t.references :author, null: false
      t.string :title, null: false
      t.string :perseus_code, null: false
      t.string :language, null: false
    end

    add_index :works, :perseus_code, :unique => true
    add_index :works, :language
    add_index :works, :author_id
  end

  def down
    drop_table :works
    drop_table :authors
  end
end
