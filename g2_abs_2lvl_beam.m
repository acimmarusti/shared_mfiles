function out = g2_abs_2lvl_beam(t, transit, gamma, kappa, g, N)
% out = g2_abs_2lvl_beam(t, transit, gamma, k, g, N)
% Computes 2nd order correlation function at time 't' for 'gamma'
% 'kappa', dipole coupling 'g' and 'N' the number of atoms and a
% transit time 'transit'
% Input values should be in 2 * pi * Hz and times is seconds
% Following Reiner et al, J. Opt. B (2004)

% Homogeneous transit broadening
gam = gamma + 2 * pi / (2 * transit);

C1 = g^2 / (kappa * gam);

C1p = C1 / (1 + (gam / (2 * kappa)));

C = C1 * N;

freq = sqrt(g^2 * N - (kappa - gam / 2)^2 / 4);

a2 = (freq^2 + kappa * gam * (1 + gam / (2 * kappa))) / (2 * g^2);

dalpha = -1 + (1 + 2 * C) * (1 + 2 * C / C1 * log(1/2 + 1/2 * sqrt(1 - 1/a2))) / (1 - (1 + gam / kappa) * 2 * C / C1 * log(1/2 + 1/2 * sqrt(1 - 1/a2)));

t = abs(t);
    
g2 = (1 + dalpha .* exp(- (kappa + gam / 2) .* t/2 ) .* ...
      (cos(freq * t) + (kappa + gam / 2) / 2 * sin(freq * t) / freq)).^2;
    
out = g2;

end