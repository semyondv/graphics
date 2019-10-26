require 'ruby2d'

@CENTER_X = (get :width) / 2
@CENTER_Y = (get :height) / 2
@MUL = (get :height)  / 70

def fn(x)
  Math::cos(0.5*x)
  #x**2
  #14/x
end

def reset_step(x, st, &f)
  y1 = f.call(x)
  y2 = f.call(x + st)

  if (y1 - y2).abs > 1.0
    [st / (y1 - y2).abs, 0.001].max
  else
    st
  end
end

def draw_fn(interval, &func)
  step = 0.12
  c_step = step
  arg = interval.min

  while arg < interval.max do
    c_step = step
    c_step = reset_step(arg, step) {|xx| fn(xx)}

    Line.new(
        x1: @CENTER_X + arg * @MUL, y1: @CENTER_Y - func.call(arg) * @MUL,
        x2: @CENTER_X + 1 + arg * @MUL, y2: @CENTER_Y + 1 - func.call(arg) * @MUL,
        width: 1,
        color: 'lime',
        z: 20
    )
    arg += c_step
  end
end

draw_fn((-80..80)) {|args| fn(args)}

show

#Window.screenshot