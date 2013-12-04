# Antiexcel

## Short Description

Antiexcel is a Microsoft-Excel file reader. It shows the excel file on a 
text console or an x-console. It can be used as an attachment viewer for any 
text-based email client ( ex. mutt)

## About the author
My name is Peter Borkuti. I am using text console based email clients
(like mutt) and it was annoying, that I had to download the excel attachment
into my desktop PC and run OpenOffice just for viewing an excel file.
So I wrote these small programs. Enjoy it.

## About the name
I got the idea from a brilliant program, antiword, which can show MS Word files
on text console.


## Files


* antiexcel
a bash script wrapper

* csvviewer
a bash script for showing semicolon separated files.
usage : ./csvviewer filename
example: ./csvviewer example.xls
* antiexcel-parse.pl
a perl script for printing an xls file in a semicolon separated format.
usage: ./antiexcel-parse.pl filename
* example.xls
An excel file for example. It was made by OpenOffice.Calc
*README.md
This text
*copyright
Copyright notices

## INSTALL

Installation instructions for antiexcel

### Administrators

Please, dont install a system wide copy of this program. It is 
only in ALPHA state- you be warned.

### USERS

Let's say, your login name is 'john'

- TRY out these programs

Example:
  ./antiexcel example.xls
  You should see on the screen a simple spreadsheet. 

- PLACE theese files into your bin directorie.

Example: 
  mkdir ~/bin
  cp csvviewer ~/bin/.
  cp antiexcel ~/bin/.
  cp antiexcel-parse.pl ~/bin/.

- Modify your .mailcap in order to viewing the attachments
  If you dont want to use this program to viewing xls email-
  attachments, you dont have to do this.

 Append theese two lines into your ~/.mailcap file:
 application/msexcel; ~/bin/antiexcel %s; needsterminal;
 application/vnd.ms-excel; ~/bin/antiexcel %s; needsterminal;

Example:

```
cp ~/.mailcap mailcap.bak
# DANGEROUS: DONT FORGET THE DOUBLE '>' SIGN!
# IF YOU MAKE A MISTAKE DO : cp mailcap.bak ~/.mailcap
cat >>~/.mailcap <<DONE
application/msexcel; ~/bin/antiexcel %s
application/vnd.ms-excel; ~/bin/antiexcel %s
```

DONE


- Enjoy it.

Peter Borkuti
