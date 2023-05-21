class Asteroid < Shape
  SHAPES = [
    [[0, 25], [10, 50], [40, 45], [50, 35], [45, 20], [50, 10], [40, 0], [25, 10], [10, 0], [0, 10], [5, 20], [0, 25]],
    [[0, 4], [4, 0], [17, 3], [23, 1], [29, 8], [22, 16], [27, 22], [20, 29], [6, 25], [1, 27], [0, 15], [2, 8], [0, 4]],
    [[0, 3], [4, 0], [10, 1], [14, 0], [13, 7], [14, 9], [11, 10], [7, 14], [0, 11], [2, 6], [0, 3]],
  ]

  def initialize(args, x, y, vx, vy, size)
    @max_speed = 10

    super(args, x, y, *SHAPES[size], path: "asteroid:#{size}")
    @vx = vx
    @vy = vy
    @vr = rand(5) - 3
    @size = size
    @dead = false
  end

  def move
    super
    @angle += @vr
  end

  def dead?
    @dead
  end

  def break!(args)
    @dead = true
    if @size < SHAPES.length - 1
      a1 = Asteroid.new(args, @x - 10, @y - 10, @vx, @vy, @size + 1)
      a2 = Asteroid.new(args, @x + 10, @y + 10, @vx, @vy, @size + 1)
      a1.accel(-5)
      a2.accel(5)
      args.state.asteroids.concat([a1, a2])
    end
  end
end
