#!/usr/bin/env bash

# Objetivo auxiliar e simplificar a criação de outros scripts. o nome do script deve ser passado como argumento,
# Faz verificações de segurança e inicia o novo script se tudo estiver correto
# Recomendação, defina a rota no: ~/.bashrc e adicione a rota no PATH, cuidado para não sobrescrever.
# Exemplo: o meu novo-script está no ~/bin
# export PATH=$PATH:~/bin
 

editor="nano"

[[ $# -ne 1 ]] && echo "Erro, se faz necessário um argumento" && exit 1

str=${1// /}

[[ ${#str} -lt 1 ]] && echo "Foi passado um argumento em branco" && exit 1

[[ -f $1 ]] && echo "Esse arquivo já existe" && exit 1

echo -e '#!/usr/bin/env bash\n\nexit 0' > $1
chmod u+x $1
$editor $1

exit 0

