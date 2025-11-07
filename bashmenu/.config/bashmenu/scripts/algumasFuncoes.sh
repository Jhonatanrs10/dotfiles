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