class Shape
  attr_sprite
  attr_accessor :vx, :vy

  WIDTH = 3

  @@render_targets = {}

  def self.prepare(args, *pts, path:, w: 0, h: 0)
    pts.each do |pt|
      w = pt[0] if pt[0] > w
      h = pt[1] if pt[1] > h
    end
    w += WIDTH
    h += WIDTH

    lines = pts.each_cons(2).map

    rt = args.render_target(path)
    rt.w = w
    rt.h = h
    rt.primitives << lines.map do |line|
      draw_line(args, line[0], line[1], 3)
    end

    @@render_targets[path] = { w: w, h: h, pts: pts, lines: lines }
  end

  def initialize(args, x, y, path, angle: 0)
    @x = x
    @y = y
    @w = @@render_targets[path][:w]
    @h = @@render_targets[path][:h]
    @path = path

    @angle = angle

    @vx = 0
    @vy = 0

    @max_speed = 5
  end

  def dead?
    false
  end

  def speed(vx = @vx, vy = @vy)
    Math.sqrt(vx**2 + vy**2)
  end

  def accel(dv = 1)
    @vx += @angle.cos * dv
    @vy += @angle.sin * dv

    spd = speed
    if spd > @max_speed
      @vx *= @max_speed / spd
      @vy *= @max_speed / spd
    end
  end

  def move
    @x += vx
    @y += vy

    @vx = -@vx if @x > 1280 - @w || @x < 0
    @vy = -@vy if @y > 720 - @h || @y < 0

    @x = 0 if @x < 0
    @x = 1280 - @w if @x > 1280 - @w
    @y = 0 if @y < 0
    @y = 720 - @h if @y > 720 - @h

    @angle = @angle % 360
  end
end
