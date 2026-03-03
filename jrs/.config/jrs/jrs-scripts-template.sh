#!/bin/bash

TEMPLATE() {

	installName="SCRIPTMODELO"
	uninstallPastaAtalhoBinMesmoNome "$installName"
	criaDiretorioInstall "$JRS_DIR/$installName"

	#criaPastaBaixaExtrai "$diretorioInstall" "Link" "mod.jar"

	#entra em pasta * pega arquivos * e move uma pasta atras .
	#mv */* .

	#criaArqRunDiretorioInstall "#!/bin/bash
	#cd $diretorioInstall
	#./nomearquivo"

	criaAtalho "$installName" "Description" "bash run.sh" "$diretorioInstall" "false" "$installName" "application-default-icon"
	criaAtalhoBin "$diretorioInstall/run.sh" "$installName"

}