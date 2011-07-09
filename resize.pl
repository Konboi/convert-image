#! /usr/bin/perl

use strict;
use warnings;
use Imager;
use FindBin;
use File::Path;
use Path::Class;

my $dir = $FindBin::Bin;
my $save_dir = dir( $dir, 'small' );

my $img = Imager->new;
my $standard_length = 800; # width or height 

#1.画像を読み込む
my @file = glob "*.JPG *.jpg";
my $file_num = @file;

if( -d $save_dir ){
}

else{
    print( 'can  not find \n' );
    print( $save_dir );
    mkpath( "small" ) or die $!;
}


for( my $i = 0; $i < $file_num ; $i++){
    print(" $i :: @file[$i] \n ");
    $img->read( file => "$dir/@file[$i]");

    my $pict_width = $img->getwidth;
    my $pict_height = $img->getheight;

    my $stand = $standard_length / $pict_width;
    my $stand_height = $pict_height * $stand;

    $img = $img->scale(
    xpixels => $standard_length,
    ypixels => $stand_height
    );

    my $save_file = file( $dir, "small", @file[$i] );
    $img->write( file => $save_file, jpegquality => 90 )
}
