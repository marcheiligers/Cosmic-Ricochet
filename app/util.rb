WHITE = { r: 255, g: 255, b: 255 }

def draw_line(args, p0, p1, width)
  w = width / 2
  Line.new(p0[0] + w, p0[1] + w, p1[0] + w, p1[1] + w, width).draw(args)
end
