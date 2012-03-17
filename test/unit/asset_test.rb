require 'test_helper'

class AssetTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Asset.new.valid?
  end
end
