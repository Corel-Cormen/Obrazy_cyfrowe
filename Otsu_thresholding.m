% @param
%   quantity - tablica liczebności poszczególnych pikseli w obrazie w skalach szarości
% @return
%   thresholding - najbardziej optymalny próg binaryzacji

function [thresholding] = Otsu_thresholding(quantity)
    thresholding = 0;
    class = 0;
    N = 0;
    for i = 1 : length(quantity)
        N = N + quantity(i);
    end
    
    
    % pętla przechodząca po histogramie wyznaczająca wszystkie możliwe
    % wartości progowe i obliczanie miary rozrzutu dla pikseli z każdej
    % strony progu
    for SECTION = 0 : length(quantity)
        Wb = 0;
        for i = 1 : SECTION
            Wb = Wb + quantity(i);
        end
        sum = Wb;
        Wb = Wb / N;
        
        ub = 0;
        for i = 1 : SECTION
            ub = ub + ((i - 1) * quantity(i));
        end
        if sum ~= 0
            ub = ub / sum;
        end
        
        vb = 0;
        for i = 1 : SECTION
            vb = vb + (power((i-1) - ub, 2) * quantity(i));
        end
        if sum ~= 0
            vb = vb / sum;
        end
        
        Wf = 0;
        for i = SECTION + 1 : length(quantity)
            Wf = Wf + quantity(i);
        end
        sum = Wf;
        Wf = Wf / N;
        
        uf = 0;
        for i = SECTION + 1 : length(quantity)
            uf = uf + ((i - 1) * quantity(i));
        end
        if sum ~= 0
            uf = uf / sum;
        end
        
        vf = 0;
        for i = SECTION + 1 : length(quantity)
            vf = vf + (power((i - 1) - uf, 2) * quantity(i));
        end
        if sum ~= 0
            vf = vf / sum;
        end
        
        class_variance = Wb * vb + Wf * vf;
        
        if SECTION == 0 || class_variance < class
            class = class_variance;
            thresholding = SECTION / length(quantity);
        end
    end
end

