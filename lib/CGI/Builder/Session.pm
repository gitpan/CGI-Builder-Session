package CGI::Builder::Session ;
$VERSION = 1.0 ;

; use strict
; use CGI::Session
; $Carp::Internal{+__PACKAGE__}++
; $Carp::Internal{'CGI::Session'}++
; use File::Spec

; use Object::props
      ( { name       => 'cs'
        , default    => sub{ shift()->cs_new(@_) }
        }
      )

; sub cs_new
   { my $s = shift
   ; CGI::Session->new( undef
                      , $s->cgi
                      , { Directory => File::Spec->tmpdir }
                      )
   }

; 1

__END__

=head1 NAME

CGI::Builder::Session - CGI::Builder and CGI::Session integration

=head1 VERSION 1.0

To have the complete list of all the extensions of the CBF, see L<CGI::Builder/"Extensions List">

=head1 INSTALLATION

=over

=item Prerequisites

    CGI::Builder >= 1.0
    CGI::Session >= 3.95
    File::Spec   >  0

=item CPAN

    perl -MCPAN -e 'install CGI::Builder::Session'

If you want to install all the extensions and prerequisites of the CBF, all in one easy step:

    perl -MCPAN -e 'install Bundle::CGI::Builder::Complete'

=item Standard installation

From the directory where this file is located, type:

    perl Makefile.PL
    make
    make test
    make install

=back

=head1 SYNOPSIS

    use CGI::Builder
    qw| CGI::Builder::Session
        ...
      |;

=head1 DESCRIPTION

This is a very simple module which integrates C<CGI::Builder> and C<CGI::Session> and provides you a ready to use CGI::Session object (C<cs> property) useful to maintain the state of your application between requests. Please refer to L<CGI::Session> for more documentation.

=head1 PROPERTY ACCESSORS

This module adds one property to the standard CBF properties.

=head2 cs

This property returns the internal C<CGI::Session> object that is automatically created just before you use it. It is already initialized with the existing session or with a new session if there are no existing session yet. Anyway, you can directly use it in your code without any other initialization.

    # check some flag
    sub OH_pre_process {
        my $s = shift;
        $s->cs->param('logged')
           || switch_to('login');
    }

    # saves cgi parameter for later use
    sub PH_myPage1 {
        my $s = shift;
        $s->cs->save_param($s->cgi, "category");
    }

    # retrieve a session parameter saved in a previous request
    sub PH_myPage2 {
        my $s = shift;
        my $categ = $s->cs->param("category");
    }

B<Note>: You can completely override the creation of the internal object by overriding the C<cs_new()> method.

=head1 METHODS

=head2 cs_new()

This method is not intended to be used directly in your CBB. It is used internally to initialize and returns the C<CGI::Session> object with the more compatible and multi platform defaults, that are:

    CGI::Session->new( undef,   # DNS equal to File
                       $s->cgi ,
                       { Directory => File::Spec->tmpdir }
                     );

B<Note>: You should redefine this method in your CBB if you need some more customized object. (see L<CGI::Session>).

=head1 SUPPORT and FEEDBACK

You can join the CBF mailing list at this url:

    http://lists.sourceforge.net/lists/listinfo/cgi-builder-users

=head1 AUTHOR and COPYRIGHT

© 2004 by Domizio Demichelis (http://perl.4pro.net)

All Rights Reserved. This module is free software. It may be used, redistributed and/or modified under the same terms as perl itself.
