function out = g2_abs_2lvl(t, gamma, kappa, g, N)
% out = g2_abs_2lvl(t, gam, k, g, N)
% Computes 2nd order correlation function at time 't' for 'gamma'
% 'kappa', dipole coupling 'g' and 'N' the number of atoms
% Input values should be in 2 * pi * Hz and time is seconds
% Following Carmichael, Opt Comm 82, 1991 (Eq. 11)

C1 = g^2 / (kappa * gamma);

C1p = C1 / (1 + (gamma / (2 * kappa)));

C = C1 * N;

freq = sqrt((kappa - gamma / 2)^2 / 4 - g^2 * N);

dalpha = - 2 * C1p * (2 * C / (1 + 2 * C - 2 * C1p));

t = abs(t);
    
g2 = (1 + dalpha .* exp(- (kappa + gamma / 2) .* t/2 ) .* ...
      (cosh(freq * t) + (kappa + gamma / 2) / 2 * sinh(freq * t) / freq)).^2;
    
out = g2;

end
