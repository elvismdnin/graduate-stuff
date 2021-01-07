##Laboratorio 1, lista 1, exercicio 4
##Elvis Nobrega
use warnings;
use strict;

open (my $arquivo, "<", "textinho.txt") or die "Arquivo nao encontrado";
#abre o arquivo para a vari�vel arqNomes

my $nrLinhas = 0;
while (<$arquivo>) {
	$nrLinhas++;
}
#print "Numero de linhas = ", $nrLinhas, "\n";
seek ($arquivo, 0, 0);
#conta o numero de linhas dentro do arquivo
#e volta o apontador para o in�cio do arquivo


my $nrChars = 0;
while (<$arquivo>) {
	$nrChars = $nrChars + length $_;
}
#print "Numero total de caracteres = ", $nrChars, "\n";
seek ($arquivo, 0, 0);
#fun��o que conta os caracteres incluindo \n
#e volta o apontador para o in�cio do arquivo

my $nrPalavras = 0;
my $nrLetras = 0;
my @palavras, my $palavras, my $caracter;
while (<$arquivo>) {
	@palavras = split (/ /);
	$nrPalavras = $nrPalavras + scalar @palavras;
	$palavras = "@palavras";
	$nrLetras = $nrLetras + length $palavras;
	while ($palavras) {
		$caracter = chop ($palavras);
		if (("\n" eq $caracter) || (" " eq $caracter)) {
			$nrLetras = $nrLetras - 1;
		}
		
	}
	print $nrLetras, "\n";
}


close $arquivo or die "Nao foi possivel fechar o arquivo";
#fecha o arquivo