class CreateCompanies < ActiveRecord::Migration[5.0]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :contact_no
      t.string :email
      t.timestamps
    end
  end
end
