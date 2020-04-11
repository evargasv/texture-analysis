# -*- coding: utf-8 -*-
"""
Spyder Editor

This is a temporary script file.
"""
    
import xml.etree.ElementTree as ET
tree = ET.parse('Kidney.txt')
root = tree.getroot()

region_nr = 1;

" iterate through Selection: each iteration is a region"
for child in root:
    
    name = child.find('Name').text
    interval = child.find('IntervalCoding3D').text
    
    "split IntervalCoding3D into lines"
    lines = interval.rstrip().split('\n')    
    lines.pop(0)
    
    slice_nr = 0;
    
    "iterate through each line"
    for line in lines:
        roi = line.strip().split(' ')
        
        """in case the line corresponds to the same slice, save the line on the
        same file"""
        if int(roi[3]) == slice_nr:
            f.write(line)
            f.write("\n")
        elif slice_nr == 0:

            slice_nr = int(roi[3])            
            
            f = open(name[1:-1]+"_"+str(slice_nr)+".txt",'w')
            f.write("<NamedSelections>\n")
            f.write("<Selection>\n")
            f.write("<Name>\n")
            f.write(str(region_nr)+"_"+str(slice_nr)+"\n")
            f.write("</Name>\n")
            f.write("<IntervalCoding3D>\n")
        else:
            """ 
            in case the slice is different, close the current file and write a
            new one
            """
            slice_nr = int(roi[3])

            f.write("</IntervalCoding3D>\n")
            f.write("</Selection>\n")
            f.write("</NamedSelections>")
            f.close()

            f = open(name[1:-1]+"_"+str(slice_nr)+".txt",'w')
            f.write("<NamedSelections>\n")
            f.write("<Selection>\n")
            f.write("<Name>\n")
            f.write(name[1:-1]+"_"+str(slice_nr)+"\n")
            f.write("</Name>\n")
            f.write("<IntervalCoding3D>\n")

    region_nr = region_nr + 1
  
f.close()