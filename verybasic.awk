#!/usr/bin/awk -f

# Description: This script reads through an output, prints and counts source IP as well as destination ports.  
#
# Aditya Patel
# 10/02/2018
#

#the begin block
BEGIN  { LastSource = ""                                                 
	#ORS value used to add newline
     ORS = ""
#assigning initial variables
     Sources = 0                                                        

     Ports = 0                                                          
#setting the field seperator
     FS = ":"                                                          

   }                                    

#starting next block after begin block
   {                                                 

     if ($1 != LastSource){                           

#setting up the desired format
        ORS = "\n"
        print " "                                    
        ORS = " "
             # printing variables 1 and 2 from the output                         
        print $1, $2                    
 # Assigning LastSource to SourceIP 
	LastSource = $1                             

   # Incrementing the declared variables by 1 
        Sources += 1                                

        Ports += 1                                   

     } else {                                           

        ORS = ""          

#now printing DSP
        print $2                              

        Ports += 1                                      

       }                                                

   }

# starting the END Block after reading the last line               

END    { ORS = "\n"        #for newline                 

# Printing the total sum 

     print "\n" "Total number of Sources = ", Sources   
     print "\nTotal number of Distinct Ports Scanned = ", Ports    

   }                 











