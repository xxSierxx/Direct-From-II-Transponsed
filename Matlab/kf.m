clear all;
close all;
clc;


b = [
 0.726011405720693336895976699452148750424
-2.904045622882773347583906797808595001698 
 4.356068434324160243420465121744200587273
-2.904045622882773347583906797808595001698
 0.726011405720693336895976699452148750424];

%Ввод коэффициентов a из filterDesigner
a = [
    1                                        
3.36224561071794258992895265691913664341 
- 4.282318762300961978439772792626172304153
2.444525530046319783394892510841600596905
 -0.52709258846586859448279938078485429287
];

b_new=floor(b.*(2.^17)); 
a_new=floor(a.*(2.^17));


for i = 1:1:5
    a_per(i) = perevod (a_new(i), 21);

    b_per(i) = perevod (b_new(i), 21);
end
