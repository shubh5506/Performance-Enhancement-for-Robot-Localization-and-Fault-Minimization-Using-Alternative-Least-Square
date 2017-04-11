function y = cummean(x,dim)

if nargin==1,
  % Determine which dimension CUMSUM./[1:N] will use
  dim = min(find(size(x) ~= 1));
  if isempty(dim), dim = 1; end
end

siz = [size(x) ones(1, dim-ndims(x))];
n = size(x, dim);

% Permute and reshape so that DIM becomes the row dimension of a 2-D array
perm = [dim:max(length(size(x)), dim) 1:dim-1];
x = reshape(permute(x, perm), n, prod(siz)/n);

% Calculate cummulative mean
y = cumsum(x, 1)./repmat([1:n]', 1, prod(siz)/n);

% Permute and reshape back
y = ipermute(reshape(y, siz(perm)), perm);
