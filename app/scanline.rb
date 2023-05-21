class Scanline
  attr_sprite

  HEIGHT = 2
  WIDTH = 6
  COLORS = [
    [{ r: 0, g: 80, b: 100, a: 80 }] * 3,
    [{ r: 10, g: 80, b: 20, a: 100 }] * 2,
    { r: 20, g: 20, b: 0, a: 100 },
    { r: 50, g: 80, b: 0, a: 100 },
    { r: 0, g: 80, b: 0, a: 100 },
  ].flatten.freeze

  TOTAL_WIDTH = 1400
  TOTAL_HEIGHT = 750

  MODES = [
    { x: -1, y: 0, a: 200, ticks: 5 },
    { x: -5, y: 0, a: 200, ticks: 20 },
    { x: -0, y: -1, a: 230, ticks: 2 },
    { x: -50, y: -10, a: 200, ticks: 20 },
    { x: -80, y: -20, a: 200, ticks: 20 },
  ]

  def initialize(args)
    @x = 0
    @y = 0
    @w = TOTAL_WIDTH
    @h = TOTAL_HEIGHT
    @path = :scanline

    rt = args.render_target(@path)
    rt.w = TOTAL_WIDTH
    rt.h = TOTAL_HEIGHT
    rt.primitives << TOTAL_HEIGHT.idiv(HEIGHT * 2).times.map do |y|
      TOTAL_WIDTH.idiv(WIDTH).times.map do |x|
        {
          x: x * WIDTH,
          y: y * HEIGHT * 2,
          w: WIDTH,
          h: HEIGHT - 1
        }.solid!(COLORS.sample)
      end + [
        {
          x: 0,
          y: y * HEIGHT * 2 + HEIGHT,
          w: 1280,
          h: HEIGHT - 1,
          r: 0,
          g: 0,
          b: 0,
          a: 240
        }.solid!
      ]
    end

    @path = :scanline

    @angle = 0
    @r = 255
    @g = 255
    @b = 255
    @a = 255

    @ticks = 10
  end

  def move
    if (@ticks -= 1) <= 0
      mode = MODES.sample
      @x = mode[:x]
      @y = mode[:y]
      @a = mode[:a]
      @ticks = rand(mode[:ticks])
    end
  end
end
