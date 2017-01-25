% Undirected graph. Each unordered pair of nodes is saved only once
% For big size graphs change adjacency Matrix from full to sparse
% and then create adjacency lists using function adj2adjL
clear all;
filename = 'scalefree500';
inputFile = strcat( filename, '.txt');
fp = fopen( inputFile ); %open the file
delimiter = char(9);
m = 1;
adjMatrix = [];
while ~feof( fp ) % loop until end of file
   line = fgets( fp ); % read line by line
   if strfind(line, '#') % if line is a comment - do nothing   
   else
    [src, dest] = strtok(line, delimiter);
    src = str2num(src);
    src = int32(src);
    dest = str2num(dest);
    dest = int32(dest);
    %creates index matrix
    adjMatrix(src+1,dest+1) = 1;
    adjMatrix(dest+1, src+1) = 1;
   end
end
fclose(fp);
matrixFile = strcat( filename, '.mat');
%save adjacency matrix and index matrix
save(matrixFile, 'adjMatrix', '-v7.3' );