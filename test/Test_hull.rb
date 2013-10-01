require '../Point_cloud.rb'
require '../Convex_hull.rb'

pc = Point_cloud.new
#puts pc.to_s

ph = Convex_hull.new
ph.make_hull(pc)
puts ph.testme