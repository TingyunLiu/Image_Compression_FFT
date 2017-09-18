function [Y, drop] = Compress(X, tol)
% It takes as inputs the original image, X, and the drop tolerance 
%   parameter, tol, and outputs a compressed image Y. It also returns
%   the drop ratio, drop, which is defined to be:
%   drop ratio =
%       Total number of nonzero Fourier coefficients dropped/
%       Total number of initially nonzero Fourier coefficients

% Counter for drop ratio
nonzeros = 0;
nonzeros_dropped = 0;

% Get the size of image
[row, column] = size(X);

% Initialize the output Y
Y = X;

for i = 0:row/8-1
    for j = 0:column/8-1
        
        % Fourier transform of each sub-block
        F = fft2(X(i*8+1:i*8+8,j*8+1:j*8+8));
        
        % Find the local maximum
        F_max = 0;
        for k = 1:8
            for l = 1:8
                if abs(F(k,l)) > F_max
                    F_max = abs(F(k,l));
                end
            end
        end
        
        % Set those Fourier coecients having modulus less than
        %   or equal to F_max*tol to 0
        for k = 1:8
            for l = 1:8
                if F(k,l) ~= 0
                    nonzeros = nonzeros + 1;
                end
                if abs(F(k,l)) <= F_max*tol
                    if F(k,l) ~= 0
                        nonzeros_dropped = nonzeros_dropped +1;
                    end
                    F(k,l) = 0;
                end
            end
        end
        
        % Reconstruct the compressed sub-block to Y
        Y(i*8+1:i*8+8,j*8+1:j*8+8) = real(ifft2(F));
        
    end
end

drop = nonzeros_dropped/nonzeros;

end

