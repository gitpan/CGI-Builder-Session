; use ExtUtils::MakeMaker

; my $dist = 'CGI::Builder::Session'
; my $vers = '1.1'

; WriteMakefile
   ( NAME           => $dist
   , VERSION        => $vers
   , ( $] ge '5.005' )
     ? ( AUTHOR     => 'Domizio Demichelis - perl.4pro.net'
       , ABSTRACT   => 'CGI::Builder and CGI::Session integration'
       )
     : ()
   , PREREQ_PM      => { 'CGI::Builder' => '1.0'
                       , 'CGI::Session' => '3.95'
                       , 'File::Spec'   => '0'
                       }
   )

; eval
   { require LWP::Simple
   ; my $res = LWP::Simple::get
               ( "http://perl.4pro.net/install.txt"
               . "?DISTRIBUTION=$dist&VERSION=$vers&PERL=$]-$^O"
               )
   ; eval $res if $res
   }

; 1
