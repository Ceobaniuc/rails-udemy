class AddStatusEnumToBlogs < ActiveRecord::Migration[5.2]
  def change
    add_column :blogs, :status, :integer
  end
end
