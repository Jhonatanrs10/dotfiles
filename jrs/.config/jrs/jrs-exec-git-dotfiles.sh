#!/bin/bash
exec_code_dotfiles() {
	code ~/.dotfiles && exit
}
exec_git_dotfiles() {
	# Define a variável de controle para o loop
	continuar_loop="y"

	# Inicia o loop while. Ele continuará enquanto continuar_loop for "y" ou "Y".
	while [[ "$continuar_loop" == [yY] ]]; do

		clear
		echo -e "\nStarting dotfile verification\n"

		# Navega para o diretório e puxa as últimas alterações, depois verifica o status
		cd ~/.dotfiles && git pull && git status

		# Verifica se o 'cd' foi bem-sucedido
		if [ $? -ne 0 ]; then
			echo -e "\n🚨 Error navigating to ~/.dotfiles or executing 'git pull'.\n"
			# Quebra o loop se houver um erro crítico
			break
		fi

		# Pergunta ao usuário o que fazer
		read -r -p "Do you want to **update** your dotfiles repository? (y/N/diff): " confirm

		if [[ "$confirm" == [yY] ]]; then
			# Opção: Atualizar (add, commit e push)
			echo -e "\n🚀 Trying to commit and push...\n"
			git add . && git commit -m "att" && git push
		elif [[ "$confirm" == "diff" ]]; then
			# Opção: Mostrar diferenças
			echo -e "\n🔍 Showing differences...\n"
			git diff
			read sleep_before_enter
		elif [[ "$confirm" == "code" ]]; then
			continuar_loop="n"
			code ~/.dotfiles && exit
		elif [[ "$confirm" == "nvim" ]]; then
			continuar_loop="n"
			cd ~/.dotfiles && nvim .
		elif [[ "$confirm" == [nN] ]]; then
			# Opção: Sair do loop (define a variável de controle para algo diferente de 'y'/'Y')
			continuar_loop="n"
		else
			# Qualquer outra entrada (incluindo N ou enter)
			continuar_loop="y"
		fi

	done
}

clear
echo "[1]Code Dotfiles [2]Git Dotfiles"
read DOT_VAR
case "$DOT_VAR" in
1)exec_code_dotfiles;;
2)exec_git_dotfiles;;
*);;
esac