BG = [0, 0, 0].freeze

def init(args)
  Ship.prepare(args)
  Bullet.prepare(args)
  Asteroid.prepare(args)
  Letters.prepare(args)

  args.state.asteroids = 6.times.map { Asteroid.new(args, rand(1280), rand(720), rand(5), rand(5), 0) }
  args.state.ship = Ship.new(args)
  args.state.bullets = []
  args.state.lives = 3
  args.state.points = 0
  args.state.scanline = Scanline.new(args)
end

def inputs(args)
  args.state.ship.angle -= args.inputs.left_right * 3
  args.state.ship.accel(args.inputs.up_down / 3)
  args.state.ship.fire(args) if args.inputs.keyboard.key_down.space
end

def draw(args)
  args.outputs.primitives << args.state.ship
  args.outputs.primitives << args.state.bullets
  args.outputs.primitives << args.state.asteroids
  args.outputs.primitives << Letters.draw_string(args, 10, 680, "#{args.state.points}".rjust(3, '0'))

  args.outputs.primitives << Ship.new(args, 100, 680, 90)
  args.outputs.primitives << Letters.draw_string(args, 134, 680, "#{args.state.lives}")

  args.outputs.primitives << Letters.draw_string(args, 300, 680, "ABCDEFGHIJKLMNOPQRSTUVWXYZ")

  args.outputs.primitives << args.state.scanline
end

def update(args)
  args.state.ship.move
  args.state.asteroids.map(&:move)
  args.state.bullets.map(&:move)
  args.state.scanline.move

  asteroid = args.geometry.find_intersect_rect args.state.ship, args.state.asteroids
  if asteroid
    asteroid.break!(args)
    args.state.lives -= 1
  end

  args.state.bullets.each do |bullet|
    asteroid = args.geometry.find_intersect_rect bullet, args.state.asteroids
    if asteroid
      bullet.dead!
      asteroid.break!(args)
      args.state.points += 1
    end
  end

  args.state.bullets.reject! { |s| s.dead? }
  args.state.asteroids.reject! { |s| s.dead? }
end

def tick(args)
  args.outputs.background_color = BG
  init(args) if args.tick_count == 0

  inputs(args)
  update(args)
  draw(args)

  $gtk.reset if args.inputs.keyboard.key_down.r
end

$gtk.reset
