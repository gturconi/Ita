clc
clear

function y = f1(x)
    y = cos(x).*cosh(x)+1;
endfunction

function y = f2(x)
    y = x.*x - sin(x) .*2;
endfunction

function y = f3(x)
    y = exp(-x) - x.^4;
endfunction

function y = f4(x)
    y = x - log(x) - 1;
endfunction

function y = f5(x)
    y = x.*x/4 - sin(x);
endfunction


function y = f6(x)
    g = 9.8
    T = 5
    h = 4
    y = 4.* %pi.^2 / (g .* T.*T .* tanh(h.*x)) - x
endfunction


function y = f7(x)
    y1 = x(1).^2 + x(1).*x(2).^3 - 9
    y2 = 3*x(1).^2*x(2)  - 4 - x(2).^3
    y = [y1;y2]
endfunction

function y = f8(x)
    y(1) = 2  + exp(2*x(1)^2 + x(2)^2) * 4 * x(1)
    y(2) = 6 * x(2) + exp(2*x(1)^2 + x(2)^2) * 2 * x(2)
endfunction

function y = f8_campo(x)
    y = 2.*x(1) + 3.*x(2)^2 + exp(2.*x(1)^2 + x(2)^2)
endfunction

function r = bisecar(f, a, b, err)
    
    while( b-a > err )
        m = (a + b) / 2
        if( sign(f(a)) * sign(f(m)) < 1 )
            b = m;
        else
            a = m;
        end
    end
    r = m;
endfunction

function r = secar(f, x0, x1, err)
    while(abs(x1 - x0) > err)
        ant = x1
        x1 = x1 - f(x1).*(x1 - x0)./(f(x1) - f(x0))
        x0 = ant;
    end
    r = x1;
endfunction


function r = newtar(f, x1, err)
    x0 = x1 - err - 1
    while( norm(x1 - x0) > err )
        ant = x1
        x1 = x1 - inv(numderivative(f, x1))*f(x1)
        x0 = ant;
    end
    r = x1;
endfunction

x = (-0:0.0001:0.2);

//plot(x, f6(x))
//plot(x, x);

//r = secar(f6, 0.1, 1, 0.1)
//r2 = bisecar(f, 1.7, 1, 0.1)
r = newtar(f8, [1 ; 1], 1e-12)

//disp(r)
//disp(r2)
disp(r)
p = f8_campo(r)
disp(p)

[J, H] = numderivative(f8_campo, r, [], [],  "blockmat")

disp("pepe")
disp(spec(H))

x0 = 1
for(i = 1:30)
    x0 = f6(x0)
end



