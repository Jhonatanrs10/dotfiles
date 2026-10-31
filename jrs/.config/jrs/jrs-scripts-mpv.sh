#!/bin/bash

mpv_paste() {
	if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
		LINK=$(wl-paste)
	elif [ "$XDG_SESSION_TYPE" = "x11" ]; then
		LINK=$(xclip -o -selection clipboard)
	else
		notify-send -i mpv "MPV" "XDG_SESSION_TYPE ?"
		exit 1
	fi

	if [ -n "$LINK" ]; then
		notify-send -i mpv "MPV" "Carregando:\n${LINK:0:45}..." && mpv --profile=low-1080p "$LINK"
	else
		notify-send -i mpv "MPV" "Null"
	fi
}

mpv_twitch() {
	echo "Twitch name:"
	read twitchName
	mpv "https://www.twitch.tv/$twitchName" &
	exit
}

mpv_twitchv2() {
    # Lista de streamers fixos (adicione ou remova nomes aqui facilmente)
    local streamers=("alanzoka" "madhousetv_")
    
    clear
    echo "====================================="
    echo "       SELETOR DE STREAM TWITCH      "
    echo "====================================="
    echo " [0] Digitar o nome de outro streamer"
    
    # Exibe dinamicamente as opções do array com base no índice
    for i in "${!streamers[@]}"; do
        # Ajustamos o índice visual para começar a partir de 1
        local id=$((i + 1))
        # Deixa a primeira letra maiúscula para ficar bonito no menu
        local nome_exibicao="$(tr '[:lower:]' '[:upper:]' <<< ${streamers[$i]:0:1})${streamers[$i]:1}"
        echo " [$id] $nome_exibicao"
    done
    
    echo "====================================="
    read -p "Escolha uma opção [0-$(( ${#streamers[@]} ))]: " opcao_canal

    case "$opcao_canal" in
    0)
        read -p "Digite o nome do canal na Twitch: " varnome
        varnome=$(echo "$varnome" | xargs)
        if [ -z "$varnome" ]; then
            echo "Erro: Nome do canal não pode estar vazio."
            exit 1
        fi
        ;;
    *)
        # Valida se a opção escolhida está dentro do intervalo do array
        if [[ "$opcao_canal" =~ ^[0-9]+$ ]] && [ "$opcao_canal" -ge 1 ] && [ "$opcao_canal" -le "${#streamers[@]}" ]; then
            # Como o menu começa em 1 e o array em 0, subtraímos 1
            varnome="${streamers[$((opcao_canal - 1))]}"
        else
            echo "Opção inválida! Saindo..."
            exit 1
        fi
        ;;
    esac

    echo ""
    echo "Canal selecionado: $varnome"
    echo "-------------------------------------"
    echo " Como você deseja assistir?"
    echo " [1] No MPV (direto via URL)"
    echo " [2] Navegador (Stream + Chat oficial)"
    echo "====================================="
    read -p "Escolha a forma de reprodução [1-2]: " opcao_modo

    case "$opcao_modo" in
    1)
        url="https://www.twitch.tv/$varnome"
        mpv "$url" &
        exit
        ;;
    2)
        url="https://www.twitch.tv/$varnome"
        chromium --app="https://www.twitch.tv/popout/$varnome/chat?popout=" &
        mpv "$url" &
        exit
        ;;
    *)
        echo "Opção inválida! Saindo..."
        exit 1
        ;;
    esac
}
