% for small graphs use full matrices instead of sparse
clear all;
filename = 'testmatrix';
inputFile = strcat( filename, '.txt');
fp = fopen( inputFile ); %open the file
delimiter = char(9);
m = 1; n = -1;
while ~feof( fp ) % loop until end of file
   line = fgets( fp ); % read line by line
   if strfind(line, '#') % if line is a comment - do nothing   
   else
    [src, dest] = strtok(line, delimiter);
    src = str2num(src);
    src = int32(src);
    %creates index matrix
    if n == src %do nothing!
    else
       indexMatrix(m) = src;
       n = src;
       m = m +1;
    end
    dest = str2num(dest);
    dest = int32(dest);
    indexMatrix(m) = dest;
    m = m+1;
   end
end
fclose(fp);
indexMatrix = unique( indexMatrix );
nodesNumber = size( indexMatrix, 2 );
% zeros( nodeNumbers
adjMatrix = sparse( nodesNumber, nodesNumber );
fp2 = fopen( inputFile ); %open the file
while ~feof( fp2 ) % loop until end of file
    line = fgets( fp2 ); % read line by line
    if strfind(line, '#') % if line is a comment - do nothing   
    else
        [src, dest] = strtok(line, delimiter);
        src = str2num(src);
        src = int32(src);
        dest = str2num(dest);
        dest = int32(dest);
        i = find(indexMatrix == src);
        j = find(indexMatrix == dest);
        adjMatrix(i,j) = 1;
        adjMatrix(j,i) = 1;
    end
end
fclose(fp2);
matrixFile = strcat( filename, 'Sparse.mat');
% save adjacency matrix and index matrix
save(matrixFile, 'adjMatrix', '-v7.3' );
indexFile = strcat( 'index', filename, '.mat');
save( indexFile, 'indexMatrix');
clear