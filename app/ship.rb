class Ship < Shape
  def self.prepare(args)
    Shape.prepare(args, [0, 0], [30, 15], [0, 30], [5, 22], [5, 8], [0, 0], path: 'ship')
  end

  def initialize(args, x = 640, y = 360, angle = 0)
    super(args, x, y, 'ship', angle: angle)

    @max_speed = 10
  end

  def fire(args)
    bullet = Bullet.new(args, @x + 15 + @angle.cos * 15, @y + 15 + @angle.sin * 15, @angle)
    args.state.bullets << bullet
    bullet
  end
end
