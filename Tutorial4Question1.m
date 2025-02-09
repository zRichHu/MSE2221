function [accVal] = convert_to_decimal(num, current_base)
    neg = false;
    if num < 0
        num = abs(num);
        neg = true;
    end
    
    numStr = num2str(num);
    
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

    
    tempstr = num2str(accVal);
    if neg%addes - or +
        accVal = "-";
    else
        accVal = "+";
    end
    expo = 0;
    if str2double(tempstr) >= 1
        if contains(tempstr, ".")
            pos = strfind(tempstr, ".");
            tempstr = strrep(tempstr, ".", "");
            expo = pos-2;%figure out exponent
        else
            expo = strlength(tempstr) - 1;%accounts for the first digit always being before
        end
        accVal = strcat(accVal,tempstr(1), ".", tempstr(2:end), " x 2^", int2str(expo));
    else 
        count = 0;
        tempthing = str2double(tempstr);
        while tempthing < 1
            tempthing = tempthing * 10;
            count = count + 1;%figure out expoenent
        end
        tempstr = num2str(tempthing);
        expo = 0 - count;
        accVal = strcat(accVal,tempstr, " x 2^", int2str(expo));
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

function [accStr] = octal_to_binary(num)
    neg = false;
    if num < 0
        num = abs(num);
        neg = true;
    end
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

    if neg%addes - or +
        accStr = strcat("-",accStr);
    else
        accStr = strcat("+",accStr);
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
