class CreateBloggersTable < ActiveRecord::Migration[5.2]
  def change
    def change
      create_table :bloggers do |t|
        t.string :username
        t.string :password
        t.string :fname
        t.string :lname
      end
    end
  end
end
