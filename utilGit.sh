#!/usr/bin/env bash

# Objetivo, auxiliar na inicialização, push de projetos ou pull do gitHub
# Recomendação, defina a rota no: ~/.bashrc e adicione a rota no PATH, cuidado para não sobrescrever. 
# Exemplo: o meu novo-script está no ~/bin
# export PATH=$PATH:~/bin

senha=""

function exibirSenha() {
	read -p "Precisará da senha do gith?! s/S para sim, n/N para não: " resp
	
	str=${resposta// /}

	resp=${resp^}

	[[ $resp == "S" ]] && echo $senha
}

read -p "Tecle 'e/E' para enviar ao repositório remoto, 'i/I' para iniciar o repositório, 'b/B' para baixar um repositório, a/A para atualizar ou 'c/C' para cancelar: " resp

str1=${resp// /}

[[ ${#str1} -lt 1 ]] && echo "Foi passado um argumento em branco!" && exit 1

[[ ${#str1} -gt 1 ]] && echo "Resposta inválida!" && exit 1

resp=${resp^}

if [[ $resp == "C" ]]; then

	echo "Opção: Cancelar"
	exit 0

elif [[ $resp == "B" ]]; then

        echo "Opção: Baixar"

        read -p "Para prosseguir, insira apenas a url HTTPS ou SSH do repositorio: " url

        str2=${url// /}

        [[ ${#str2} -lt 1 ]] && echo "Foi passado um argumento em branco!" && exit 1

        [[ "${url: -4}" != ".git" || ${#url} -ne ${#str2} ]] && echo "URL inválida!" && exit 1

        exibirSenha

	git clone url

elif [[ $resp == "A" ]]; then

	exibirSenha

	git pull

elif [[ $resp == "E" ]]; then

	echo "Opção: Push"

	read -p "Comentário1 (Opicional): " cmt1
	read -p "Comentário2 (Opicional): " cmt2

	c1=${cmt1// /}

	[[ ${#c1} -lt 1 ]] && comentario1="Commit" || comentario1=cmt1

	c2=${cmt2// /}

	[[ ${#c2} -lt 1 ]] && comentario2="Commit" || comentario2=cmt2

	exibirSenha

	echo "Branch atual: "
	git branch

	echo "Todas as branchs: "
	git branch --list

	read -p "Digite a branch: " branch
	git add .
	git commit -m $comentario1 -m $comentario2
	git push origin $branch

	exit 0

elif [[ $resp == "I" ]]; then

	echo "Opção: Iniciar"

	read -p "Para prosseguir, insira apenas a url HTTPS ou SSH do repositorio: " url

	str2=${url// /}

	[[ ${#str2} -lt 1 ]] && echo "Foi passado um argumento em branco!" && exit 1

	[[ "${url: -4}" != ".git" || ${#url} -ne ${str2} ]] && echo "URL inválida!" && exit 1

	exibirSenha

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
