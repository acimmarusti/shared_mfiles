for i = 1:38
  
  directory = '/home/candres/Documents/cqed-lab/quantum_beats/data-2010-10-15/';
  
  s = strcat( directory , 'spectrum' , num2str(i) , '.mat' );
  
  load( s );
  
  l1 = strcat( directory , 'spectrum' , num2str(i), '.txt' );
  
  l2 = strcat( 'spectrum' , num2str(i) );
  
  save( '-ascii' , l1 , l2 );
  
  clear all;
  
end
