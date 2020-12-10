read -p "Enter what you want to call this distro: " DISTRO
sed -i "4s/.*/iso_name=\"$DISTRO\"/" ./profiledef.sh
sed -i "1s/.*/NAME=\"$DISTRO\"/" ./theming/os-release
sed -i "2s/.*/PRETTY_NAME=\"$DISTRO\"/" ./theming/os-release
sed -i "10s/.*/LOGO=$DISTRO/" ./theming/os-release
read -p "Enter what you want to call this ISO: " ISO
sed -i "3s/.*/ID=\"$ISO\"/" ./theming/os-release
read -p "Enter who is the ISO's publisher: " PUBLISHER
sed -i "6s/.*/iso_publisher=\"$PUBLISHER\"/" ./profiledef.sh
read -p "Enter what the ISO's application is: " APPLICATION
sed -i "7s/.*/iso_application=\"$APPLICATION\"/" ./profiledef.sh
read -p "Enter what you want the ISO version layout to be (by default it's \$(date +%Y.%m.%d)): " VERSION
sed -i "8s/.*/iso_version=\"$VERSION\"/" ./profiledef.sh
read -p "Enter what you want the install directory to be : " DIRECTORY
sed -i "9s/.*/install_dir=\"$DIRECTORY\"/" ./profiledef.sh
sed -i "5s/.*/iso_label=\"$ISO-$VERSION\"/" ./profiledef.sh

read -p "Enter what you want to call the default user: " USER
sed -i "2s/.*/$USER:x:1000:1000::\/home\/$USER:\/usr\/bin\/zsh/" ./airootfs/etc/passwd
sed -i "2s/.*/User=$USER/" ./airootfs/etc/sddm.conf.d/autologin.conf
sed -i "2s/.*/adm:x:4:$USER/" ./airootfs/etc/group
sed -i "3s/.*/wheel:x:10:$USER/" ./airootfs/etc/group
sed -i "4s/.*/uucp:x:14:$USER/" ./airootfs/etc/group
sed -i "5s/.*/$USER:x:1000:/" ./airootfs/etc/group
sed -i "2s/.*/$USER:!!::/" ./airootfs/etc/gshadow

read -p "Enter what you want to this user's password to be?: " PASSWORD
declare PASSWD=$(echo $PASSWORD | openssl passwd -6 -stdin)
ESCAPED_PASSWD=$(printf '%s\n' "$PASSWD" | sed -e 's/[]\/$*.^[]/\\&/g');
sed -i """2s/.*/$USER:$ESCAPED_PASSWD:14871::::::/""" ./airootfs/etc/shadow

