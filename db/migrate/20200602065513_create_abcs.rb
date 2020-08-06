class CreateAbcs < ActiveRecord::Migration[5.2]
  def change
    create_table :abcs do |t|

      t.timestamps
    end
  end
end
