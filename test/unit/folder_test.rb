require 'test_helper'

class FolderTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Folder.new.valid?
  end
end
