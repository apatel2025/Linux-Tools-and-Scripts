#--------------------------------------------------------------------------------------------------
# Description: This program scans through a word list to forcefully crack the password of a zipfile
#
# Paramaters:	none 
#
# History:
# Date			   Author				Description
# 2018-05-24	Aditya Patel	     Initial Creation
#--------------------------------------------------------------------------------------------------

#Importing all commands required to brute force the zipfile password.
import optparse
import zipfile
from threading import Thread

#This loop is to extract the Zipfile password.
def extractZip(zFile, password):
    try:
            
            #This will start to extract all possible passcodes and report as a Pass and report the password
            # or if its a fail it will move on to the next possible password.
            zFile.extractall(pwd = password)
            print ("Password Found: " + password + '\n')
    except:
            pass
           

def main():
		#to make it work in a way that you have the option to type in the zip file name in the command prompt after the code
        parser = optparse.OptionParser("use "+\
                    "-f <zipfile> -d <dictionary>")
					
        #defining the options and assigning their values to the zipfile and the text file which contains the passwords            
        parser.add_option('-f', dest= 'zname', type= 'string',\
                        help = 'specify zip file')
        parser.add_option('-d', dest='dname', type='string',\
                        help = 'specify dictionary file')
        (options, arg) = parser.parse_args()
        if (options.zname == None) | (options.dname == None):
            print (parser.usage)
            exit(0)
        else:
            zname = options.zname
            dname = options.dname
        zFile = zipfile.ZipFile(zname)
        passFile= open(dname)
		
        #to read through the file
        for line in passFile.readlines():
            password = line.strip('\n')
            t = Thread(target = extractZip, args = (zFile, password))
            t.start()
		
if __name__ == '__main__':
	
	main()
	

