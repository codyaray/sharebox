class Folder < ActiveRecord::Base
  acts_as_tree

  attr_accessible :name, :parent_id, :user_id

  belongs_to :user
  has_many :assets, :dependent => :destroy

  has_many :shared_folders, :dependent => :destroy
  
  def shared?
    !self.shared_folders.empty?
  end
end
