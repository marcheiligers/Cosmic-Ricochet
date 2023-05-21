WHITE = { r: 255, g: 255, b: 255 }

def draw_line(args, p0, p1, width)
  Line.new(p0[0], p0[1], p1[0], p1[1], width).draw(args)
end
