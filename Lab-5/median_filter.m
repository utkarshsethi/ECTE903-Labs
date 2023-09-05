function g = median_filter(f)
[height, width]= size(f); % Size of input image
g = zeros(height, width); % Allocate memory for output image

for y = 1:height
    for x = 1:width
        x1 = x - 2; % left  column of the 5x5 window
        x2 = x + 2; % right column of the 5x5 window
        y1 = y - 2; % top row      of the 5x5 window
        y2 = y + 2; % bottom row   of the 5x5 window
        
        % When the neighbourhood exceeds the image boundary
        x1 = max(x1, 1);
        x2 = min(x2, width);
        y1 = max(y1, 1);
        y2 = min(y2, height);
 
        window = f(y1:y2, x1:x2); % 5 x 5 window
        window = window(:);       % rearrange window into a column vector
        g(y, x) = median(window); % output pixel = median of window 
    end
end
g = uint8(g); imshow(g); % convert to 8-bit image and display