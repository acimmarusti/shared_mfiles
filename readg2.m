function data = readg2(directory, dataset)

    %data location - concatenation of file address and name
    datlocation = strcat(directory, 'data', int2str(dataset),'_g2.asc');
    
    %loads data from start_row/start_col and beyond (whitespace delimeter)
    start_row = 9;
    start_col = 0;
    data = dlmread(datlocation, '', start_row, start_col);

end