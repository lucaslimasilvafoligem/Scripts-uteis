#!/usr/bin/env bash

# Objetivo, auxiliar na inicialização ou push de projetos do gitHub
# Recomendação, defina a rota no: ~/.bashrc e adicione a rota no PATH, cuidado para não sobrescrever. 
# Exemplo: o meu novo-script está no ~/bin
# export PATH=$PATH:~/bin

read -p "Tecle 'p/P' para fazer push, 'i/I' para iniciar o repositório ou 'c/C' para cancelar: " resp

str1=${resp// /}

[[ ${#str1} -lt 1 ]] && echo "Foi passado um argumento em branco!" && exit 1

[[ ${#resp} -gt 1 ]] && echo "Resposta inválida!" && exit 1

resp=${resp^}

if [[ $resp == "C" ]]; then

	echo "Opção: Cancelar"
	exit 0

elif [[ $resp == "P" ]]; then

	echo "Opção: Push"

	read -p "Comentário1 (Opicional): " cmt1
	read -p "Comentário2 (Opicional): " cmt2

	c1=${cmt1// /}

	[[ ${#c1} -lt 1 ]] && comentario1="Commit" || comentario1=cmt1

	c2=${cmt2// /}

	[[ ${#c2} -lt 1 ]] && comentario2="Commit" || comentario2=cmt2

	git add .
	git commit -m comentario1 -m comentario2
	git push origin git branch

	exit 0

elif [[ $resp == "I" ]]; then

	echo "Opção: Iniciar"

	read -p "Para prosseguir, insira apenas a url HTTPS ou SSH do repositorio: " url

	str2=${url// /}

	[[ ${#str2} -lt 1 ]] && echo "Foi passado um argumento em branco!" && exit 1

	veriUrl=${url// /}

	[[ "${url: -4}" != ".git" || ${#url} -ne ${#veriUrl} ]] && echo "URL inválida!" && exit 1

	git init
	git add .
	git commit -m "first commit"
	git branch -M main
	git remote add origin $url
	git push -u origin main

	exit 0
else
	echo "Opção: Inválida!"
	exit 1
fi
