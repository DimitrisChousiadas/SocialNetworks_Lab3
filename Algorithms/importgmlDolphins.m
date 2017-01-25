function G = importgmlDolphins(fileName)
inputfile = fopen(fileName); A=[];
found = false;
l=0; k=1; while 1

    % Get a line from the input file
    tline = fgetl(inputfile);
    % Quit if end of file
    if ~ischar(tline)
        break
    end
    
    
    if ~found
        nums = regexp(tline, 'edge', 'match');
        if ~size(nums)
            continue;
        else
            found = true;
        end
    end
    
    nums = regexp(tline,'\d+','match'); %get number from string
    if length(nums)
        if l==1
            l=0;
            A(k,2)=str2num(nums{1});
            k=k+1;
            continue;
        end
        A(k,1)=str2num(nums{1});
        l=1;
    else
        l=0;
        continue;
    end
end
G=[]; for i=1:length(A) G(A(i,1)+1,A(i,2)+1) = 1; end
len=size(G);
if len(1)>len(2)
    G(:,len(2)+1:len(1))=0;
end
