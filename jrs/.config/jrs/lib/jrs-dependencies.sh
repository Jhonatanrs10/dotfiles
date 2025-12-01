#!/bin/bash
dependencies() {
	local wrapper="$JRS_DIR/.jrs.sh"
	local link_name="jrs"
	local link_path="/usr/bin/$link_name"

	# Verifica se o arquivo wrapper já existe
	if [ ! -f "$wrapper" ]; then
		echo "O atalho '$link_name' não existe. Criando agora..."

		# Cria o diretório se ele não existir
		mkdir -p "$(dirname "$wrapper")"

		# Cria o arquivo wrapper
		cat <<EOF >"$wrapper"
#!/usr/bin/env bash
cd "$PWD"
bash "run.sh"
EOF

		# Torna o arquivo executável
		chmod +x "$wrapper"
		echo "Arquivo wrapper criado em: $wrapper"
	fi

	# Verifica se o link simbólico existe e o cria se não
	if [ ! -L "$link_path" ]; then
		echo "O link simbólico para '$link_name' não existe. Criando agora..."
		sudo ln -sf "$wrapper" "$link_path"
		echo "Atalho '$link_name' criado com sucesso!"
	else
		echo "Atalho '$link_name' já está instalado."

	fi
	sleep 0
}
