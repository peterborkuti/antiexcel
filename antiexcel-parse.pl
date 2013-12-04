#!/usr/bin/perl 
# Excel parser
# It is print an excel file in a semicolon delimited form.
# I saw this example among in the spreadsheet-parseexcel perl library's 
# examples.
# Rewritten by Peter Borkuti, 2003. 01. 

use strict;

if($#ARGV < 0) {
    usage();
    exit;
}

# Change this for your localized Windows Codepage.
# Now it is for the Central European codepage
# It is working with my Hungarian excel files
# Other codepages :
#    * 1250 (Central Europe)
#    * 1251 (Cyrillic)
#    * 1252 (Latin I)
#    * 1253 (Greek)
#    * 1254 (Turkish)
#    * 1255 (Hebrew)
#    * 1256 (Arabic)
#    * 1257 (Baltic)
#    * 1258 (Viet Nam)
#    * 874 (Thai)
# If you have excel files mainly in Hebrew, you may should
# change $codepage to 'CP1255'
# Warning : I have never tried codepages other than CP1250
# 
# More documentation about Microsoft codepages :
#	http://www.microsoft.com/globaldev/reference/WinCP.asp
#

my $code='CP1250';
if (@ARGV>1) { $code=$ARGV[1]; };

use Spreadsheet::ParseExcel;
use Spreadsheet::ParseExcel::FmtUnicode;
my $oExcel = new Spreadsheet::ParseExcel;
my $oFmt = Spreadsheet::ParseExcel::FmtUnicode->new(Unicode_Map => $code);
my $oBook = $oExcel->Parse($ARGV[0], $oFmt);
if (!defined($oBook)) {
    print STDERR "Error opening file:".$ARGV[0]."\n";
    exit;
};

my($oWkS, $oWkC, $MyMaxCol,@MyCells);
# for all the sheets in the xls file
#for(my $iSheet=0; $iSheet < $oBook->{SheetCount}; $iSheet++) {
# Only the first sheet will be parsed
for(my $iSheet=0; $iSheet < 1 ; $iSheet++) {
        $oWkS = $oBook->{Worksheet}[$iSheet];
#	print "--------- SHEET:", $oWkS->{Name}, "\n";
	if ($#ARGV<=2) { $MyMaxCol=$oWkS->{MaxCol}; } 
	    else { $MyMaxCol=$ARGV[2]; };
	
    for(my $iR = $oWkS->{MinRow} ; 
            defined $oWkS->{MaxRow} && $iR <= $oWkS->{MaxRow} ; $iR++) {
	@MyCells=();
	for(my $iC = $oWkS->{MinCol} ;
                        defined $MyMaxCol && $iC <= $MyMaxCol ; 
			$iC++) {
            $oWkC = $oWkS->{Cells}[$iR][$iC];
	    if ($oWkC) {
		$MyCells[$iC]=OneCell($oWkC);
	    } else {
		$MyCells[$iC]='';
	    };   
	};
	print join(';',@MyCells)."\n";
    };
};

sub OneCell {
    my $cell=$_[0];
    my $len=0;
    my $mycell;
    if ($cell->{Type} eq 'Numeric' ){
        $mycell=$cell->{Val};
    } else {
        $mycell=$cell->Value;
    };
    return($mycell);
}

sub usage {

print<<EOF;
Usage: $0 Excel_File [Code] [MaxColNum]

  MaxColNum : Maximum number of columns. At some cases this program couldnt
		 determine the right number of columns. In theese cases you
		 should use this parameter.
  
  Code	    : CP932, CP1251, ... (same as Unicode::Map)
		 The default is CP1250 which is for Central Eurpeans 

This script depends on Spreadsheet::ParseExcel and Unicode::Map
EOF

}