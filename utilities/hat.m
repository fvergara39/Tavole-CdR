function A = hat(a)

x = a(1);
y = a(2);
z = a(3);

A = [0 -z  y;
     z  0 -x;
    -y  x  0];
