function [out, max_atoms] = g2_abs_2lvl_wt(t, gamma, kappa, ...
                                           gmax, natoms, w0, l)
% [out, max_atoms] = g2_abs_2lvl_wt(t, gam, k, gmax, N, w0, l)
% Computes 2nd order correlation function at time 't' for 'gamma'
% 'kappa', dipole coupling 'g', 'N' the number of atoms, 'w0'
% cavity waist and 'l' cavity spacing
% Input values should be in 2 * pi * Hz and time is seconds
% and w0 and l in meters
% Following Carmichael, Opt Comm 82, 1991 (Eq. 11)
% Carmichael, PRA 1999 and Sanders, PRA 1997 for atomic beam simulation

%Wavelength
lam = 780e-9;

%Poissonian distribution: number of atoms to sample
max_atoms = 0;

sum_poiss = 0;

while (sum_poiss < 0.9999999999);

    sum_poiss = sum_poiss + poisspdf(max_atoms, natoms);
    
    max_atoms = max_atoms + 1;
    
end

%Rayleigh length
zr = pi * w0^2 / lam;

%Choose smaller distance between Rayleigh length and half cavity spacing
if (l / 2 < zr)
    
    zlimit = l / 2;
    
else
    
    zlimit = zr;
    
end


var_atoms = 0 : max_atoms;
    
g2_final = 0;
    
for atoms = var_atoms
    
    geff = 0;
    
    if (atoms > 0)
    
        for at = 1 : atoms
    
            z = unifrnd(-zlimit, zlimit);
    
            beam_width = w0 * sqrt(1 + (z / zr)^2);
    
            x = unifrnd(-beam_width, beam_width);
        
            y = unifrnd(-beam_width, beam_width);
        
            while (sqrt(x^2 + y^2) > beam_width)
            
                x = unifrnd(-beam_width, beam_width);
        
                y = unifrnd(-beam_width, beam_width);
            
            end
        
            %Coupling strength for Gaussian standing wave
            g = gmax * abs(cos(2 * pi * z / lam)) * exp(- (x^2 + y^2) / w0^2);
        
            geff = geff + g; 
        
        end
    
        geff = geff / atoms;
        
    else
        
        geff = gmax;
        
    end
    
    g2_final = g2_final .+ (g2_abs_2lvl(t, gamma, kappa, geff, atoms) * poisspdf(atoms, natoms));
        
end

out = g2_final;

end