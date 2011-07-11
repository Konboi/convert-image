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

print ( '変換する画像の縦を指定してください:');
my $standard_length = <STDIN> ; # width or height

#画像ファイルを読み込む
my @file = glob "*.JPG *.jpg *jpeg *.png *.PNG *.gif";
my $file_num = @file;

if( -d $save_dir ){
}

else{
    print( $save_dir );
    mkpath( "$dir/small" ) or die $!;
}


for( my $i = 0; $i < $file_num ; $i++){
    print(" $i :: @file[$i] \n ");
    #my $file_type = @file[i] =~ /^.+\.(.+?)$/ ? $1 : 'gif';

    $img->read( file => "$dir/@file[$i]");

    my $stand = $standard_length / $img->getwidth;
    my $stand_height = $img->getheight * $stand;

    $img = $img->scale(
    xpixels => $standard_length,
    ypixels => $stand_height
    );

    my $save_file = file( $dir, "small", @file[$i] );
    $img->write( file => $save_file, jpegquality => 100 )
}
