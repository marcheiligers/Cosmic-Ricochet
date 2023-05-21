WHITE = { r: 255, g: 255, b: 255 }

def draw_line(p0, p1, _width)
  {
    x: p0[0],
    y: p0[1],
    x2: p1[0],
    y2: p1[1]
  }.line!(WHITE)
end
