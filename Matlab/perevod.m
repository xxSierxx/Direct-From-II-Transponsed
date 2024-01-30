%Функция для перевода в дополнительный код
function f = perevod(x, n)
w = size(x, 2);
for i = 1:w
    if (x(i) >= 0)
        f(i) = x(i);
    else
        f(i) = 2^n + x(i);
    end
end