#!/bin/bash


echo "				██████╗ ███████╗██████╗ ██╗      ██████╗ ██╗   ██╗███████╗██████╗ "
echo "				██╔══██╗██╔════╝██╔══██╗██║     ██╔═══██╗╚██╗ ██╔╝██╔════╝██╔══██╗ "
echo "				██║  ██║█████╗  ██████╔╝██║     ██║   ██║ ╚████╔╝ █████╗  ██████╔╝ "	
echo "				██║  ██║██╔══╝  ██╔═══╝ ██║     ██║   ██║  ╚██╔╝  ██╔══╝  ██╔══██╗ "
echo "				██████╔╝███████╗██║     ███████╗╚██████╔╝   ██║   ███████╗██║  ██║ "
echo "				╚═════╝ ╚══════╝╚═╝     ╚══════╝ ╚═════╝    ╚═╝   ╚══════╝╚═╝  ╚═╝ v1 "
echo "							  web hacker edition					   "
echo "							coded by Oscar Gutierrez				           "


echo "please execute with root privileges"

getDependencies () {
	
	echo "[*] Updating your sources"

	apt-get update

	echo "[*] Installing dependencies"

	apt-get -y install python-pip
	apt-get -y install python3-pip
	apt-get install -y libssl-dev libffi-dev python-dev build-essential
	apt-get -y install golang
	pip3 install scapy
	pip3 install future
	pip3 install twisted
	pip3 install netifaces
	pip3 install impacket
	pip3 install shodan
}

helpMessage () {
	echo "Usage: sudo ./deployer-web.sh -<installation type>"
	echo "Instalation types: "
	echo "-f : Install all the tools, wordlists and popular PoCs"
	echo "-l : Install most popular tools"
	echo "-w : Download wordlists only"
	echo "-p : Download pocs from Tenable's repository"
	echo "-h : Print this help message "
}

fullInstall () {

	echo "[*] Installing all tools, hold on"
	getDependencies
	go get github.com/ffuf/ffuf
	go get -u -v github.com/lc/gau
	git clone https://github.com/hahwul/dalfox
	cd dalfox && go install
	cd ..
	pip3 install shodan
	go get -u github.com/projectdiscovery/httpx/cmd/httpx
	go get -u github.com/projectdiscovery/subfinder/cmd/subfinder
	apt-get install amass
	git clone https://github.com/maurosoria/dirsearch.git
	go get github.com/hakluke/hakrawler
	go get -u github.com/tomnomnom/meg
	go get -u github.com/tomnomnom/assetfinder
	go get github.com/tomnomnom/waybackurls
	go get -u github.com/iamstoxe/urlgrab
	echo "export PATH='~/go/bin/:$PATH'" | tee -a ~/.bashrc
	source ~/.bashrc
	git clone https://github.com/defparam/smuggler.git
	git clone https://github.com/devanshbatham/ParamSpider
	pip3 install -r ParamSpider/requirements.txt
	git clone --recursive https://github.com/FortyNorthSecurity/EyeWitness.git
	EyeWitness/Python/setup/./setup.sh
	go get -u -v github.com/projectdiscovery/nuclei/v2/cmd/nuclei
	nuclei -update-templates
	apt-get install zmap
	go get -u -v github.com/projectdiscovery/shuffledns/cmd/shuffledns
	go get -u github.com/projectdiscovery/chaos-client/cmd/chaos
	go get -u -v github.com/projectdiscovery/dnsprobe
	echo "[*] Downloading wordlists and pocs"
	git clone --recursive https://github.com/danielmiessler/SecLists.git
	git clone --recursive https://github.com/swisskyrepo/PayloadsAllTheThings.git
	git clone --recursive https://github.com/tenable/poc
	echo "Enjoy! :) "	
}

liteInstall () {
	echo "[*] Installing top 5 tools "
	getDependencies
	go get -u github.com/projectdiscovery/subfinder/cmd/subfinder 
	go get -u github.com/projectdiscovery/httpx/cmd/httpx
	go get -u -v github.com/lc/gau
	go get github.com/ffuf/ffuf
	go get -u -v github.com/projectdiscovery/nuclei/v2/cmd/nuclei
	echo "export PATH='~/go/bin/:$PATH'" | tee -a ~/.bashrc
	source ~/.bashrc
	nuclei -update-templates
	echo "Enjoy! :) "
}

wordLists () {
	echo "[*] Downloading wordlists "
	git clone --recursive https://github.com/danielmiessler/SecLists.git
        git clone --recursive https://github.com/swisskyrepo/PayloadsAllTheThings.git
	echo "Enjoy! :)"
}

pocs () {
	echo "[*] Downloading PoCs "
	git clone --recursive https://github.com/tenable/poc
	echo "Enjoy! :) "
}

while getopts "flwph" OPTION
do
	case $OPTION in
		f)
			fullInstall
			exit
			;;
		l)
			liteInstall
			exit
			;;
		w)
			wordLists
			exit
			;;
		p)
			pocs
			exit
			;;
		h)
			helpMessage
			exit
			;;
	esac
done


