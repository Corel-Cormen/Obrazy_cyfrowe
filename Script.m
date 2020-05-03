obraz = imread('coins.png');
[X, Y] = imhist(obraz);

prog = Otsu_thresholding(X);

subplot(3, 1, 1);
imshow(obraz);
title('Oryginalny obraz');
subplot(3, 1, 2);
plot(Y, X);
xline(prog * length(X));
title('Histogram z zaznaczonym progiem binaryzacji');
subplot(3, 1, 3);
imshow(im2bw(obraz, prog));
title('Zbinaryzowany obraz');