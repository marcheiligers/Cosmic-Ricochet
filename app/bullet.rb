class Bullet < Shape
  SPEED_INC = 10
  LIFE_TIME = 60

  def self.prepare(args)
    Shape.prepare(args, [0, 1], [6, 2], [0, 3], [0, 1], path: 'bullet')
  end

  def initialize(args, x, y, angle)
    super(args, x, y, 'bullet')

    @max_speed = 20
    @angle = angle
    accel(@max_speed)
    @life = LIFE_TIME
  end

  def dead!
    @life = 0
  end

  def dead?
    @life < 1
  end

  def move
    super
    @life -= 1
    @angle = Math.atan2(@vy, @vx).to_degrees
  end
end
