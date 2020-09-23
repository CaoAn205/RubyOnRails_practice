class CreateFolloweds < ActiveRecord::Migration[5.2]
  def change
    create_table :followeds do |t|
      t.references :user, foreign_key: true
      t.references :follow, foreign_key: true

      t.timestamps
    end
  end
end
