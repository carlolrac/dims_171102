#requires "Dancer2" => "0.160001";
#requires "Dancer2::Plugin::Database" => "0";
#requires "DBD::mysql" => "4.031";
#requires "YAML::XS" => "0";
#requires "Template" => "0";
#requires "GD" => "0";

requires "CGI" => "0";
requires "CGI::Carp" => "0";
requires "Env" => "0";

recommends "URL::Encode::XS"  => "0";
recommends "CGI::Deurl::XS"   => "0";
recommends "HTTP::Parser::XS" => "0";

recommends "Plack::Handler::Apache2" => "0";

#on "test" => sub {
#    requires "Test::More"            => "0";
#    requires "HTTP::Request::Common" => "0";
#};