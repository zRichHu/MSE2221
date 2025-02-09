function [accVal] = convert_bases(num, current_base, new_base)
    
    numStr = num2str(num);
    length = strlength(numStr);%6
    
    splitNumStr = split(numStr,".");

    leftStr = char(splitNumStr(1));

    accVal = 0;
    try
        rightStr = char(splitNumStr(2));
        counter = 1;
    for x = -1:-1:0-strlength(rightStr)
        accVal = accVal + current_base^x * str2double(rightStr(counter));
        counter = counter + 1;
    end
    catch exception
    end

    counter = 1;
   
    for x = strlength(splitNumStr(1))-1:-1:0
        accVal = accVal + current_base^x * str2double(leftStr(counter));
        counter = counter + 1;
    end
    
    %{
    temp = num;
    answer = "";
    while temp ~= 0 
        answer = strcat(int2str(rem(temp, new_base)), answer)
        temp = floor(temp / new_base);
    end
    %}
end

function [accStr] = convert(num)
    
    numStr = num2str(num);
    
    d = dictionary("0","000","1","001","2","010","3","011","4","100","5","101","6","110","7","111");
   
    accStr="";
    for x = 1:1:strlength(numStr)
        if(numStr(x) == ".")
            accStr = strcat(accStr,".");
            continue

        end
        newStr = d(numStr(x));

        accStr = strcat(accStr,newStr); %convert to binary
    end
    
end
function openFile(fileName)
    fileID = fopen(fileName, "r"); % Open file for reading
    
    if fileID == -1
        error("Could not open the file.");
    end

    while ~feof(fileID)
        line = strtrim(fgetl(fileID)); % Read line and remove whitespace
        if isempty(line) || contains(line, ",")
            continue; % Skip empty lines and malformed lines
        end
        convertedNum = convert_bases(line, 8, 10); % Pass as string
        fprintf("Original base 8: %s, Base 10: %f\n", line, convertedNum);
    end

    fclose(fileID); % Close the file
end

disp("00110001 to base 10: "+ convert_bases(00110001,2,10));
disp("0.01011 to base 10: "+ convert_bases(0.01011,2,10))
disp("61565 to base 2: " + convert(61565))

x = input("Enter file name: ","S");
openFile(x);
