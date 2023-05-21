class Line
  def initialize(x0, y0, x1, y1, w)
    @x0 = x0
    @y0 = y0
    @x1 = x1
    @y1 = y1
    @w = w
  end

  def length
    Math.sqrt((@x1 - @x0)**2 + (@y1 - @y0)**2)
  end

  def angle
    Math.atan2(@y1 - @y0, @x1 - @x0).to_degrees
  end

  def draw(args)
    {
      x: @x0 + @w / 2,
      y: @y0 + @w / 2,
      w: length - @w / 2,
      h: @w,
      angle: angle,
      angle_anchor_x: 0,
      angle_anchor_y: @w / 2,
      path: :pixel
    }.sprite!(WHITE)
  end
end
