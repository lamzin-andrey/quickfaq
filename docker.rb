def firstProject
	# Установка https://docs.docker.com/install/linux/docker-ce/ubuntu/
	#статья https://verstaem.com/devops/docker-php-development/?unapproved=1972&moderation-hash=8d5b070ff555fcfeccaa00887fd417ca#comment-1972

    #После создания папок и конфигов, то ли нужно, то ли не нужно было 
    #usermod -aG docker ${USER}
    
    #При сборке пришлось выпилить xdebug из apache/Dockerfile, т к pecl Требовал php 7
    
    #После редактирования конфига docker-compose.yml (Добавил порты) необходимо 
    # sudo docker-compose up -d --build
    
    #конфиги докера 
    #git clone git@github.com:lamzin-andrey/hellodocker.git
end

def enterInContainerShell
	#Тут почти всегда работает
	# sudo docker run -it IMAGE_NAME bash
	# IMAGE_NAME можно видеть в 3
	# sudo docker ps
	
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

def stop
	# sudo docker-compose down
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