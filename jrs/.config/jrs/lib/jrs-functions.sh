#!/usr/bin/env sh
forLength(){
    echo $1
    read txtForLength
    if [ "$txtForLength" = "" ]; then
            txtForLength=$3
            echo "Valor vazio, Default $txtForLength"
    elif [ "`expr length $txtForLength`" = $2 ]; then
            echo "Escolha $txtForLength"
    else
            txtForLength=$3
            echo "Necessario 6 digitos, Default $txtForLength"    
    fi
}
#forLength "Titulo" "numero/tamanho/length" "default value"

listaOptions(){
    zListaOptions="/tmp/zListaOptions.txt"
    cd $1
    ls $3 .> $zListaOptions
    cd $OLDPWD
    echo "[ListaOptions] DIGITE O NUMERO DA SUA ESCOLHA:"
    cat -n $zListaOptions
    echo "[ListaOptions]"
    read zLOption
    #pega conteudo do arquivo | numera o conteudo por linha | escolhe uma linha | elimina o numero da linha e deixa so o conteudo
    export $2=$(cat $zListaOptions | grep -n ^| grep ^$zLOption | cut -d: -f2)
}

echoRead(){
    echo $1
    read $2
}
#echoRead "MSG" "VAR RETORNO"
#listaOptions "/home/user/diretorio" "nome-variavel-retorno" "criterio do ls ex ls jrs-*"

setLink(){
    varLink="$1"
}

yesorno(){
    echo -e "$1 [s/n]"
    read resp
    if [ "$resp" = "s" ]; then
        $2
    fi
}
#yesorno "Titulo" "Script"

baixaDebs(){
    criaDiretorio "diretorioBaixaDebs" "$JRS_DIR/tempArqs"
    clear
    echo -e "Deseja baixar $1? [s/n]"
    read resp
    if [ "$resp" = s ]; then
        baixaArq "diretorioNome" "$2" "$diretorioBaixaDebs/$1.deb"
    fi
}
#baixaDebs "Nomedoapp" "linkdodeb"

baixaArq(){
    if [ $1 = 'diretorio' ]; then
        wget -c -P "$3" "$2"
    elif [ $1 = 'diretorioNome' ]; then
        wget -c "$2" -O "$3"
    fi 
}
#baixaArq "diretorioNome Ou diretorio" "links" "diretorio/Nome.tar"

rofi-or-wofi(){
  # Detect session type and choose appropriate menu
  if [ "$XDG_SESSION_TYPE" = "x11" ] && command -v rofi &>/dev/null; then
    menu_cmd="rofi -dmenu -i -p Profiles"
  elif [ "$XDG_SESSION_TYPE" = "wayland" ] && command -v wofi &>/dev/null; then
    menu_cmd="wofi --dmenu --prompt=Options"
  else
    echo "ERROR: No suitable menu found" >&2
    exit 1
  fi
}