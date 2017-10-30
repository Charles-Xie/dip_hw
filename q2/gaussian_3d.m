for j = 1:10
    x = linspace(0, 20, 100);
    y = linspace(0, 20, 100);
    [XX, YY] = meshgrid(x, y);
    % ZZ = exp( - ((XX - 10)^2 + (YY - 10)^2) / (2 * j^2)) / (2 * pi * j^2);
    TMP = exp( - ((XX - 10)^2 + (YY - 10)^2) / (2 * j^2));
    for m = 1: 100
        for n = 1: 100
            TMP(m, n) = exp( - ((XX(m, n) - 10)^2 + (YY(m, n) - 10)^2) / (2 * j^2));
        end
    end
    ZZ = TMP / (2 * pi * j^2);
    surf(XX, YY, ZZ);
    title('gaussian 3d');
    frame = getframe(gcf);
    im = frame2im(frame);
    [I, MAP] = rgb2ind(im, 20);
    if j == 1
        imwrite(I, MAP, 'gaussian.gif', 'gif', 'LoopCount', Inf, 'DelayTime', 1);
    else
        imwrite(I, MAP, 'gaussian.gif', 'gif', 'WriteMode', 'append', 'DelayTime', 1);
    end
end 