BG = [0, 0, 0].freeze

def init(args)
  args.state.asteroids = 6.times.map { Asteroid.new(args, rand(1280), rand(720), rand(5), rand(5), 0) }
  args.state.ship = Ship.new(args)
  args.state.bullets = []
  args.state.lives = 3
  args.state.points = 0
end

def inputs(args)
  args.state.ship.angle -= args.inputs.left_right * 3
  args.state.ship.accel(args.inputs.up_down / 3)
  args.state.ship.fire(args) if args.inputs.keyboard.key_down.space
end

def draw(args)
  args.outputs.primitives << args.state.ship.draw
  args.outputs.primitives << args.state.bullets.map(&:draw)
  args.outputs.primitives << args.state.asteroids.map(&:draw)
  args.outputs.primitives << Letters.draw_string(args, 10, 680, "#{args.state.points}".rjust(3, '0'))

  args.outputs.primitives << Ship.new(args, 100, 680, 90)
  args.outputs.primitives << Letters.draw_string(args, 134, 680, "#{args.state.lives}")
end

def tick(args)
  args.outputs.background_color = BG
  init(args) if args.tick_count == 0

  inputs(args)

  args.state.ship.move
  args.state.asteroids.map(&:move)
  args.state.bullets.map(&:move)

  draw(args)

  bullet = args.geometry.find_intersect_rect args.state.ship, args.state.bullets
  if bullet
    bullet.dead!
    args.state.lives -= 1
  end

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

  $gtk.reset if args.inputs.keyboard.key_down.r
end

$gtk.reset
