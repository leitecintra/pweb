#!/bin/bash
clear
fun_bar () {
comando[0]="$1"
comando[1]="$2"
 (
[[ -e $HOME/fim ]] && rm $HOME/fim
${comando[0]} -y > /dev/null 2>&1
${comando[1]} -y > /dev/null 2>&1
touch $HOME/fim
 ) > /dev/null 2>&1 &
 tput civis
echo -ne "  \033[1;33mAGUARDE \033[1;37m- \033[1;33m["
while true; do
   for((i=0; i<18; i++)); do
   echo -ne "\033[1;31m#"
   sleep 0.1s
   done
   [[ -e $HOME/fim ]] && rm $HOME/fim && break
   echo -e "\033[1;33m]"
   sleep 1s
   tput cuu1
   tput dl1
   echo -ne "  \033[1;33mAGUARDE \033[1;37m- \033[1;33m["
done
echo -e "\033[1;33m]\033[1;37m -\033[1;32m OK !\033[1;37m"
tput cnorm
}
echo ""
echo -e "           \033[1;33m● \033[1;32mATUALIZANDO LINUX, PODE DEMORAR \033[1;33m●\033[0m"
fun_update () {
    apt-get update -y > /dev/null 2>&1 
	apt-get install figlet -y > /dev/null 2>&1
    curl -sS https://getcomposer.org/installer | php
    mv composer.phar /usr/local/bin/composer
    chmod +x /usr/local/bin/composer
}
##################################
fun_bar 'fun_update'
echo ""
clear
IP=$(wget -qO- ipv4.icanhazip.com)
echo "America/Sao_Paulo" > /etc/timezone
ln -fs /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime > /dev/null 2>&1
dpkg-reconfigure --frontend noninteractive tzdata > /dev/null 2>&1
IP=$(wget -qO- ipv4.icanhazip.com)
clear
echo -e "\E[44;1;37m    ATUALIZANDO O PAINEL MODO PADRÃO X86_64     \E[0m"
echo ""
echo -e "WEB GESTOR-SSH" | figlet
echo -e "                              \033[1;31mBy @nandoslayer\033[1;36m"
echo ""
clear
senha=$(cut -d"'" -f2 /var/www/html/pages/system/pass.php)
empresaatual=$(cut -d"'" -f2 /var/www/html/empresa)
echo ""
echo -e "           \033[1;33m● \033[1;32mFINALIZANDO A ATUALIZAÇÃO, PODE DEMORAR \033[1;33m● \033[1;33mAGUARDE...\033[0m"
cd /var/www/html || exit
find /var/www/html/ -iname "*.php" -type f -exec rm -rfv {} \; > /dev/null 2>&1
find /var/www/html/ -iname "*.html" -type f -exec rm -rfv {} \; > /dev/null 2>&1
find /var/www/html/ -iname "*.html" -type f -exec rm -rfv {} \; > /dev/null 2>&1
find /var/www/html/ -iname "*.svg" -type f -exec rm -rfv {} \; > /dev/null 2>&1
find /var/www/html/ -iname "*.jpg" -type f -exec rm -rfv {} \; > /dev/null 2>&1
find /var/www/html/ -iname "*.png" -type f -exec rm -rfv {} \; > /dev/null 2>&1
find /var/www/html/ -iname "*.png" -type f -exec rm -rfv {} \; > /dev/null 2>&1
find /var/www/html/ -iname "*.lock" -type f -exec rm -rfv {} \; > /dev/null 2>&1
wget https://github.com/nandoslayer/pweb/raw/painel/install/gestorssh.zip > /dev/null 2>&1
sleep 1
unzip -o gestorssh.zip > /dev/null 2>&1
rm -rf gestorssh.zip index.html > /dev/null 2>&1
(echo yes; echo yes; echo yes; echo yes) | composer install > /dev/null 2>&1
(echo yes; echo yes; echo yes; echo yes) | composer require phpseclib/phpseclib:~2.0 > /dev/null 2>&1
ln -s /usr/share/phpmyadmin/ /var/www/html > /dev/null 2>&1
chmod 777 -R /var/www/html > /dev/null 2>&1
sed -i "s;49875103u;$senha;g" /var/www/html/pages/system/config.php > /dev/null 2>&1
sed -i "s;localhost;$IP;g" /var/www/html/pages/system/config.php > /dev/null 2>&1
sleep 1
if [[ -e "/var/www/html/pages/system/pass.php" ]]; then
sed -i "s;1020;$senha;g" /var/www/html/pages/system/pass.php > /dev/null 2>&1
fi
##################################
clear
crontab -l > cronset > /dev/null 2>&1
echo "
@reboot /etc/autostart
* * * * * /etc/autostart
0 */12 * * * cd /var/www/html/pages/system/ && bash cron.backup.sh && cd /root
5 */6 * * * cd /var/www/html/pages/system/ && /usr/bin/php cron.backup.php && cd /root
* * * * * cd /var/www/html/pages/system/ && bash cron.userteste.sh && cd /root
2 */6 * * * cd /var/www/html/pages/system/ && bash cron.autobackup.sh && cd /root
* * * * * /usr/bin/php /var/www/html/pages/system/cron.online.ssh.php
@daily /usr/bin/php /var/www/html/pages/system/cron.rev.php
* * * * * /usr/bin/php /var/www/html/pages/system/cron.ssh.php
* * * * * /usr/bin/php /var/www/html/pages/system/cron.php
@monthly /usr/bin/php /var/www/html/pages/system/cron.limpeza.php" > cronset
crontab cronset && rm cronset > /dev/null 2>&1
##################################
clear
cd || exit
sed -i "s;EMPRESA;$empresaatual;g" /var/www/html/empresa > /dev/null 2>&1
sed -i "s;EMPRESA;$empresaatual;g" /var/www/html/home.php > /dev/null 2>&1
sed -i "s;EMPRESA;$empresaatual;g" /var/www/html/index.php > /dev/null 2>&1
sed -i "s;EMPRESA;$empresaatual;g" /var/www/html/login.php > /dev/null 2>&1
sed -i "s;EMPRESA;$empresaatual;g" /var/www/html/admin/home.php > /dev/null 2>&1
sed -i "s;EMPRESA;$empresaatual;g" /var/www/html/admin/index.php > /dev/null 2>&1
sed -i "s;EMPRESA;$empresaatual;g" /var/www/html/admin/login.php > /dev/null 2>&1
sed -i "s;EMPRESA;$empresaatual;g" /var/www/html/apps/index.php > /dev/null 2>&1
sed -i "s;EMPRESA;$empresaatual;g" /var/www/html/apps/termos.php > /dev/null 2>&1
echo ""
service apache2 restart > /dev/null 2>&1
echo -e "\E[44;1;32m    PAINEL ATUALIZADO COM SUCESSO     \E[0m"
echo ""
echo -e "WEB GESTOR-SSH" | figlet
echo ""
echo -e "\033[1;36m PAINEL WEB DIGITE ESSE IP NO NAVEGADOR:\033[1;37m http://$IP/admin\033[0m"
echo ""
echo -e "\033[1;36m LOJA DE APPS:\033[1;37m http://$IP/apps\033[0m"
echo ""
echo -e "\033[1;33m MAIS INFORMAÇÕES \033[1;31m(\033[1;36mTELEGRAM\033[1;31m): \033[1;37m@nandoslayer\033[0m"
echo ""
echo -ne "\n\033[1;31mENTER \033[1;33mpara retornar ao \033[1;32mPWEB! \033[0m"; read
cat /dev/null > ~/.bash_history && history -c
clear
pweb
exit;