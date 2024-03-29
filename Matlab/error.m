% Очистка рабочего пространства перед запуском программы
clear all;
close all;
clc;

%Специальный блок для значений при построении синусоиды
f=1/9000; %Частота дискретизации (шаг в цикле)
F=350; %Частота синусоиды
A=1; %Амплитуда
time = 0:f:0.5; %Время сигнала
fun = A*sin(F*2*pi*time); %Сигнал синусоиды

%Ввод значения размерной сетки и колтчества бит под число
n=24;
N=n+1+3;

%Ввод коэффициентов b из filterDesigner
b = [
 0.726011405720693336895976699452148750424
-2.904045622882773347583906797808595001698
 4.356068434324160243420465121744200587273
-2.904045622882773347583906797808595001698
 0.726011405720693336895976699452148750424]

%Ввод коэффициентов a из filterDesigner
a = [
 1                                        
-3.36224561071794258992895265691913664341 
 4.282318762300961978439772792626172304153
-2.444525530046319783394892510841600596905
 0.52709258846586859448279938078485429287
];

%Задаём два массива, хранящие данные задержек для входа и выхода
in = zeros(1,5);
out = zeros(1,5);

%Загоняем данные для фильтрации
for i=1:1:length(fun)
    %Смотрим на схему фильтра и прописываем алгоритм фильтрации (прямая схема)
    in(1)=fun(i);
    out(1)=in(1)*b(1)+in(2)*b(2)+in(3)*b(3)+in(4)*b(4)+in(5)*b(5);
    out(1)=out(1)-(out(2)*a(2)+out(3)*a(3)+out(4)*a(4)+out(5)*a(5));
    %Запись предыдущих значений на входе и выходе
    for j=5:-1:2
        in(j)=in(j-1);
        out(j)=out(j-1);
    end
    
    %запись значений для работы с расчётным фильтром в дальнейшем 
    pryam(i,3)=out(1);

    %Запись значений идеального фильтра
    ideal(i)=out(1);
    
end

%Построение графика идеального фильтра
subplot(2,1,1);
plot(ideal)
title('Выход идеального фильтра')


%Фильтр с целочисленной арифметикой

%Перевод в целочисленную арифметику
b1=floor(b*2^n); 
a1=floor(a*2^n);

%Объявление нового массива входа и выхода (для наглядности)
in1 = zeros(1,5);
out1 = zeros(1,5);

%Загоняем данные для фильтрации
for i=1:1:length(fun)
    %Смотрим на схему фильтра и прописываем алгоритм фильтрации (прямая схема) с учётом перевода в прямой код
    in1(1)=(fun(i))*2^n;
    out1(1)=floor(in1(1)*b1(1)/2^n)+floor(in1(2)*b1(2)/2^n)+floor(in1(3)*(b1(3))/2^n)+floor(in1(4)*b1(4)/2^n)+floor(in1(5)*b1(5)/2^n);
    out1(1)=out1(1)-(floor(out1(2)*(a1(2))/2^n)+floor(out1(3)*a1(3)/2^n)+floor(out1(4)*(a1(4))/2^n)+floor(out1(5)*a1(5)/2^n));
    
    %Выход в прямом коде
    pryam(i,1)=out1(1);
    
    %Выход в вещественном виде
    raschet(i)=out1(1)/2^n; 
    
    %Выход в дополнительном коде
    pryam(i,2)=perevod(out1(1),N); 
    
    %Запись предыдущих значений на входе и выходе
   for j=5:-1:2
        in1(j)=in1(j-1);
        out1(j)=out1(j-1);
    end
end

%Построение графика расчётного фильтра
subplot(2,1,2)
plot(raschet)
title('Выход расчётного фильтра в прямом коде');

%Отклонение идеального и расчётного фильтра
mistake= raschet-ideal;
figure

plot(mistake)
title('Ошибка') 
