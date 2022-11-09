def firstProject
	# Установка https://docs.docker.com/install/linux/docker-ce/ubuntu/
	# В ней же смотрим как ставить docker-compose, через синоптик может прийти треш
	#статья https://verstaem.com/devops/docker-php-development/?unapproved=1972&moderation-hash=8d5b070ff555fcfeccaa00887fd417ca#comment-1972

    
    # In ~/.bashrc
    #export XUSER=andrey
	#export XHOME=/home/${XUSER}
	export uid=$(id -u) 
	export gid=$(id -g)
	
	# In console 
	sudo su
	su andrey
    usermod -aG docker andrey
    sudo docker-compose up -d --build
    
    
    #При сборке пришлось выпилить xdebug из apache/Dockerfile, т к pecl Требовал php 7
    
    #После редактирования конфига docker-compose.yml (Добавил порты) необходимо 
    # sudo docker-compose up -d --build
    
    #конфиги докера 
    #git clone git@github.com:lamzin-andrey/hellodocker.git
end

def enterInContainerShell
	#Тут почти всегда работает
	
	# [sudo] docker ps
	# sudo docker run -it IMAGE_NAME bash
	# sudo docker run -it forecatsservice_php bash
	# IMAGE_NAME можно видеть в 3
	
	# Но если контейнеру была нужна сборка (в файле docker-composer.yml есть строка build: ./docker/apache)
	# вам возможно придётся использовать sh:
	# sudo docker run -it firstsite_apache sh
end

def runAndBuild
	# sudo docker-compose up -d --build
end

def rebuild
   #  docker-compose up -d --force-recreate --build
end

def runCommand
	 # -- как выполнить команду в один клик или хотя бы через alias migrund?
	 #   - Элементарно.
	 #docker exec -it  rosfines-dev_backend4_105_1 php bin/console doctrine:migration:migrate
	 #Уже в migrund.sh
end

def stop
	# sudo docker-compose down
	# sudo docker stop container_id
end

def whereIs
	# где вся эта байда лежит? Которую docker накачал и распаковал?
	# Хранится все это безобразие в /var/lib/docker (https://habr.com/ru/post/346634/)
	# ... чистится это тоже довольно просто — просто rm -rf. (https://habr.com/ru/post/346634/)
end


def dropContainer
	#docker rm <container>
end

def clearAll
	#docker system prune
end

def createNetwork
	# sudo docker network create front
end

def networkList
	# sudo docker network ls
end

def mysqlConnect
	# На практике не использовалось, но интересно
	# Источник https://qna.habr.com/q/466230
	
	#Создайте группу docker, если она еще не существует:
	#sudo groupadd docker
	#Добавьте себя, или любого другого пользователя, который будет работать с Docker в эту группу:
	#sudo gpasswd -a ${USER} docker
	#Перезапустите Docker демона:
	#sudo service docker restart
	#Перезапустите систему

	#И пользуйтесь

	#docker-compose logs _name_
end

# В принципе это за уши притянуто, это проект Symfony в котором каталог symfony (содержащий src) 
# в контейнере имеет путь /var/www/html
# Суть можно понять, после некотрого размышления 
def runTestSymfony
 #sudo docker exec -i 567e0d4cbc8d  php bin/phpunit 
 #567e0d4cbc8d - container_id при том, что после выполнения 
 #[sudo] docker run -it IMAGE_NAME bash попадаешь именно в тот каталог, в который прилинковано symfony
end
