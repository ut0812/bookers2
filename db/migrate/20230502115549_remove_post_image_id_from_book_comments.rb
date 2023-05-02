class RemovePostImageIdFromBookComments < ActiveRecord::Migration[6.1]
  def change
    remove_column :book_comments, :PostImageId_id, :integer
  end
end
