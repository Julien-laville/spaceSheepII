require 'test/unit'
require 'arraylist.rb'
class ArrayList_test < Test::Unit::TestCase
  def test_new
    array = ArrayList.new
    assert_not_equal(array, nil)
  end
  def test_push
    array = ArrayList.new
    array.push("dffds")
    array.push("dsq")
    array.push("fsd")
    assert_equal(array.to_s,false)
  end
end