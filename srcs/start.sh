echo "Autoindex :"
select ans in on off;
do
	case $ans in
	on)
		echo "autoindex is on"
		break
		;;
	off)
		sed -i "s/autoindex on/autoindex off/" /etc/nginx/sites-available/coolwebsite
		echo "autoindex is off"
		break
		;;
	*)
		echo "select using numbers 1 or 2"
	esac
done
#start mysql
service mysql start

# Config Access
chown -R www-data /var/www/*
chmod -R 755 /var/www/*

#creating mysql database
echo "CREATE DATABASE wordpress;" | mysql -u root --skip-password
echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'root'@'localhost' WITH GRANT OPTION;" | mysql -u root --skip-password
echo "update mysql.user set plugin='mysql_native_password' where user='root';" | mysql -u root --skip-password
echo "FLUSH PRIVILEGES;" | mysql -u root --skip-password

#start php / nginx
service php7.3-fpm start
service nginx start
bash