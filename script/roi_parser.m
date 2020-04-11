function roi_parser( dataDir, folder_name, file_name )
%PARSER Summary of this function goes here
%   - file_name: 
%
% ------
% Author: Elizabeth Vargas
% E-mail: EVargas@tmvse.com
% Created: 23-04-2015, using MATLAB 8.4.0.150421 (R2014b)
% Modified: 23-04-2015
% Copyright 2015 Toshiba Medical Visualization Systems Europe (TMVS)

    % Read VyNamedSelections file into memory
    fname = strcat(dataDir,folder_name,'/',file_name);
    fid = fopen(fname,'r');
    assert(fid > 0, 'Failed to open %s', fname)
    C = textscan(fid,'%s','Delimiter','\n');
    fclose(fid);

    % file content
    F = C{1};

    % stackinfo
    idx_ini = find(strcmp(F,'<stackinfo>'));
    idx_end = find(strcmp(F,'</stackinfo>'));
    nr_stack = (idx_end - idx_ini) - 1;
    stack_info = F(idx_ini+1:idx_end-1);

    % Name
    idx = find(strcmp(F,'<Name>'));
    name = F(idx+1);

    % IntervalCoding3D
    idx_ini = find(strcmp(F,'<IntervalCoding3D>'));
    idx_end = find(strcmp(F,'</IntervalCoding3D>'));
    roi = F(idx_ini+1:idx_end-1);

    % number of the current z value
    slice_nr = 0;

    % iterate thrugh each line
    for i=1:size(roi,1)

        % line of the IntervalCoding3D
        line = sscanf(roi{i},'%d %d %d %d');
        
        %% the slice is the same that is being processed
        if line(4) == slice_nr
            
            % print the line information on the file
            fprintf(f,'%d %d %d %d \n',line);

        %% the slice is the first one of the region
        elseif slice_nr == 0

            % update current slice number
            slice_nr = line(4);
            % write file header
            f = print_header(dataDir,folder_name,name,stack_info,nr_stack,slice_nr);
            % write the first line of the file
            fprintf(f,'%d %d %d %d \n',line);
            
        %% the slice is different that the one being processed
        else

            % update current slice number
            slice_nr = line(4);
            % print footer
            print_footer(f);
            % close current file
            fclose(f);
            % write file header
            f = print_header(dataDir,folder_name,name,stack_info,nr_stack,slice_nr);
            % write the first line of the file
            fprintf(f,'%d %d %d %d \n',line);
        end

    end
    
    print_footer(f)
    fclose(f);
end

function f = print_header(dataDir,folder_name,name,stack_info,nr_stack,slice_nr)
% PRINT_HEADER Prints the stackinfo information

    % create file and write header
    
    file_name = strcat(char(name),'_',int2str(slice_nr),'.txt');
    f = fopen(fullfile(dataDir,folder_name,file_name),'w');

    fprintf(f,'<stackinfo>\n');
    
    for j=1:nr_stack
        fprintf(f,'%s',char(stack_info{j}));
    fprintf(f,'\n');
    end
    
    fprintf(f,'</stackinfo>\n');
    fprintf(f,'<NamedSelections>\n');
    fprintf(f,'<Selection>\n');
    fprintf(f,'<Name>\n');
    fprintf(f,strcat(char(name),'_',int2str(slice_nr)));
    fprintf(f,'\n</Name>\n');
    fprintf(f,'<IntervalCoding3D>\n');

end

function print_footer(f)
% PRINT_FOOTER Prints the XML tags at the end of the file
   
    fprintf(f,'</IntervalCoding3D>\n');
    fprintf(f,'</Selection>\n');
    fprintf(f,'</NamedSelections>\n');     
end
