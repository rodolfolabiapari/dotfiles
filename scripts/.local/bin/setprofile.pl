#!/usr/bin/env perl

use strict;
use warnings;

die "Uso: $0 <arquivo-credenciais> <perfil>\n" unless @ARGV >= 2;

my ( $cred_file, $profile ) = @ARGV[0, 1];

for my $var (qw(AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_SESSION_TOKEN)) {
  die "Variável ausente: $var\n"
    unless defined $ENV{$var} && $ENV{$var} ne '';
}

my $expiration = $ENV{AWS_CREDENTIAL_EXPIRATION} // $ENV{AWS_SESSION_EXPIRATION} // '';

open my $cf, '>', $cred_file
  or die "Não foi possível escrever $cred_file: $!\n";

print $cf <<"EOF";
[$profile]
aws_access_key_id=$ENV{AWS_ACCESS_KEY_ID}
aws_secret_access_key=$ENV{AWS_SECRET_ACCESS_KEY}
aws_session_token=$ENV{AWS_SESSION_TOKEN}
EOF

if ( $expiration ne '' ) {
  print $cf "expiration=$expiration\n";
}

close $cf;
chmod 0600, $cred_file;
