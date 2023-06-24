use strict;
use warnings;
use Tk;

my $mw = MainWindow->new;
$mw->title("Perl GUI Password Generator");

$mw->geometry("500x500");
$mw->resizable(0, 0);

my $label = $mw->Label(
    -text => "Perl GUI Password Generator",
    -font => 'Helvetica 18 bold'
)->pack(-pady => 20);

my $length_label = $mw->Label(
    -text => "Password Length:",
)->pack;

my $length_entry = $mw->Entry(-textvariable => 12)->pack(-pady => 10);
$length_entry->focus;

my $password = '';

my $button_generate = $mw->Button(
    -text    => "Generate Password",
    -command => \&generate_password_button
)->pack;

my $button_copy = $mw->Button(
    -text    => "Copy Password",
    -command => \&copy_password_button
)->pack;

sub generate_password {
    my $length = $length_entry->get();
    my @chars = ('A'..'Z', 'a'..'z', 0..9, qw(! @ $ % ^ & *));
    my $password = '';
    for (1..$length) {
        my $char = $chars[rand @chars];
        $password .= $char;
    }
    return $password;
}

sub generate_password_button {
    $password = generate_password();
    $label->configure(-text => $password);
}

sub copy_password_button {
    if ($password) {
        my $cmd = qq{echo "$password" | xclip -selection clipboard};
        system($cmd);
    }
}

MainLoop;