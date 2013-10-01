require 'test/unit'
require '../Point.rb'
require '../Point_cloud.rb'
require '../Convex_hull.rb'

class Gosu_test < Test::Unit::TestCase
    #######points######
  def test_point
    p = Point.new()
    p1 = Point.new(10,10)
    assert_instance_of(p, Point, 'point was not created')
    assert_instance_of(p1, Point, 'point was not created')
  end
    ######cloud#####
  def test_cloud
    pc = Point_cloud.new
    pc1 = Point_cloud.new(100,100,5)
    assert_equal(pc1.cloud.size,5,'wrong size')
    assert_equal(pc.cloud.size,10,'wrong default size')
  end
  def test_hull
    pc = Point_cloud.new
    h = Convex_hull.new
    raise(false, h.make_hull(pc))
    #h.make_hull(pc)
    
    
    assert(h != nil,"h wasn't created")
  end
    #######fail#######
  def test_fail
    assert(true,'assertion was false')
  end
end