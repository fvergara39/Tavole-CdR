function a = vee(A)

if diag(A) == zeros(size(A,1),1)
    x = A(3,2);
    y = A(1,3);
    z = A(2,1);
    a = [x ; y; z];
else
    disp('The input matrix is not in hat form.')
end