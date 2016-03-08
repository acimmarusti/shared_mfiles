function [out, max_atoms] = g2_abs_2lvl_poiss(t, transit, gamma, kappa, g, natoms)
% out = g2_abs_2lvl_poiss(t, transit, gamma, k, g, N)
% Computes 2nd order correlation function at time 't' for 'gamma'
% 'kappa', dipole coupling 'g' and 'N' the number of atoms and a
% transit time 'transit'
% Input values should be in 2 * pi * Hz and times is seconds
% Following Reiner et al, J. Opt. B (2004)
% Adds in poissonian weight to 'simulate' atomic beam number fluctuations

%Poissonian distribution: number of atoms to sample
max_atoms = 0;

sum_poiss = 0;

while (sum_poiss < 0.9999999999);

    sum_poiss = sum_poiss + poisspdf(max_atoms, natoms);
    
    max_atoms = max_atoms + 1;
    
end

var_atoms = 0 : max_atoms;
    
g2_final = 0;
    
for atoms = var_atoms
       
    g2_final = g2_final .+ (g2_abs_2lvl_beam(t, transit, gamma, kappa, g, atoms) * poisspdf(atoms, natoms));
        
end

out = g2_final;

end