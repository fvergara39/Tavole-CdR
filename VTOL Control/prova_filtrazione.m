x = sym('x',[2,1]);
f = [x(2)^2;0];
g = [0;1];

delta_0 = span_of(g);
delta = span(f,g);