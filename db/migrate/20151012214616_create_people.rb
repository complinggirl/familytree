class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.column :given_name, :string
      t.column :family_name, :string
      t.column :mother_id, :int
      t.column :father_id, :int
    end
  end
end
