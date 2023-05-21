class Line
  attr_accessor :x0, :y0, :x1, :y1, :thickness

  def initialize(x0, y0, x1, y1, thickness)
    @x0 = x0
    @y0 = y0
    @x1 = x1
    @y1 = y1
    @thickness = thickness
  end

  def length
    Math.sqrt((@x1 - @x0)**2 + (@y1 - @y0)**2)
  end

  def angle
    Math.atan2(@y1 - @y0, @x1 - @x0).to_degrees
  end

  def draw(args)
    {
      x: @x0 + @thickness / 2,
      y: @y0 - @thickness / 2,
      w: length + @thickness / 2,
      h: @thickness,
      angle: angle,
      angle_anchor_x: 0,
      angle_anchor_y: 0.5,
      path: :pixel
    }.sprite!(WHITE)
  end

  def serialize
    {
      x0: @x0,
      y0: @y0,
      x1: @x1,
      y1: @y1,
      thickness: @thickness,
    }
  end

  def inspect
    serialize.to_s
  end

  def to_s
    serialize.to_s
  end
end
