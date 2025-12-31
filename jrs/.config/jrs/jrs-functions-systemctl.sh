#!/bin/bash


enableSystemctl() {
	SERVICE_NAME="$1"

	# 1. Verifica se o serviço JÁ ESTÁ habilitado.
	# O comando retorna 0 se habilitado, e 1 ou mais se desabilitado/mascarado.
	if systemctl is-enabled "$SERVICE_NAME" >/dev/null 2>&1; then
		#echo "✅ O serviço $SERVICE_NAME já está HABILITADO. Ignorando a ativação."
		return # Sai da função após a verificação
	fi

	# 2. Se não estiver habilitado, exibe o prompt original:
	echo "⚠️ O serviço $SERVICE_NAME não está habilitado."
	echo "Opções: [1] Habilitar (enable)"
	read -r resp
	case $resp in
	1)
		echo "Habilitando e iniciando $SERVICE_NAME..."
		sudo systemctl enable "$SERVICE_NAME" --now
		echo "O serviço $SERVICE_NAME foi habilitado e iniciado."
		;;
	*)
		echo "Opção inválida. Nenhuma alteração feita."
		;;
	esac
}

disableSystemctl() {
	SERVICE_NAME="$1"

	# 1. Verifica se o serviço JÁ ESTÁ habilitado.
	# O comando retorna 0 se habilitado, e 1 ou mais se desabilitado/mascarado.
	if systemctl is-enabled "$SERVICE_NAME" >/dev/null 2>&1; then
		echo "⚠️ O serviço $SERVICE_NAME está habilitado."
		echo "Opções: [1] Desabilitar (disable)"
		read -r resp
		case $resp in
		1)
			# Desabilitar um serviço que já não está habilitado não causará erro,
			# mas é incluído para consistência com as opções do usuário.
			echo "Desabilitando (se aplicável) $SERVICE_NAME..."
			sudo systemctl disable "$SERVICE_NAME"
			echo "O serviço $SERVICE_NAME foi desabilitado."
			;;
		*)
			echo "Opção inválida. Nenhuma alteração feita."
			;;
		esac
	fi

}
