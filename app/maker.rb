BG = [0, 0, 0].freeze
GREEN = { r: 0, g: 255, b: 0 }.freeze
RED = { r: 255, g: 0, b: 0 }.freeze

def init(args)
  args.state.lines = []
  args.state.points = []
  args.state.current_thickness = 2
  args.state.current_line = nil
end

def inputs(args)
  if args.inputs.mouse.button_left && args.state.current_line.nil?
    args.state.current_line = Line.new(args.inputs.mouse.x, args.inputs.mouse.y, args.inputs.mouse.x, args.inputs.mouse.y, args.state.current_thickness)
    args.state.lines << args.state.current_line
    args.state.points << { x: args.inputs.mouse.x - 1, y: args.inputs.mouse.y - 1, w: 3, h: 3 }.solid!(GREEN)
  end

  if !args.inputs.mouse.button_left && args.state.current_line
    args.state.points << { x: args.inputs.mouse.x - 1, y: args.inputs.mouse.y - 1, w: 3, h: 3 }.solid!(RED)
    args.state.current_line = nil
  end

  args.state.current_thickness += 1 if args.inputs.keyboard.key_down.equal_sign
  args.state.current_thickness -= 1 if args.inputs.keyboard.key_down.minus
  args.state.current_thickness = 1 if args.state.current_thickness < 1

  if args.state.current_line
    args.state.current_line.x1 = args.inputs.mouse.x
    args.state.current_line.y1 = args.inputs.mouse.y
    args.state.current_line.thickness = args.state.current_thickness
  end
end

def draw(args)
  args.outputs.primitives << args.state.lines.map { |l| l.draw(args) } << args.state.points
end

def tick(args)
  args.outputs.background_color = BG
  init(args) if args.tick_count == 0

  inputs(args)
  puts draw(args)
  puts args.state.lines

  $gtk.reset if args.inputs.keyboard.key_down.r
end

$gtk.reset
