module Console
  def createBundle #Как сгенерить бандл генерация бандла 
    #php app/console generate:bundle --namespace=Acme/HelloBundle
  end
  def createDatabase
    #write params in app/config/parameters.yml
    #php app/console doctrine:database:create
  end
  def createTable
    #php app/console doctrine:generate:entity --entity="AcmeHelloBundle:Product" 
    #> --fields="name:string(255) description:text price:float"
    
    #php app/console doctrine:schema:update --force
  end
  def clearCache
    #php app/console cache:clear --env=prod --no-debug
    #php app/console cache:clear --env=dev --no-debug
  end
  def migration
    #composer require doctrine/doctrine-migrations-bundle "^1.0"
    
    #add string in app/AppKernel.php
    #new Doctrine\Bundle\MigrationsBundle\DoctrineMigrationsBundle();
    
    #add config in app/config/parameters.yml
    #doctrine_migrations:
    #dir_name: "%kernel.root_dir%/DoctrineMigrations"
    #namespace: Application\Migrations
    #table_name: migration_versions
    #name: Application Migrations
  
		## Это создаст каталог s3.loc/www/app/DoctrineMigrations/
    #php app/console doctrine:migrations:status --show-versions
		## Это создаст файл миграции в s3.loc/www/app/DoctrineMigrations/
    #php app/console doctrine:migrations:generate
		## Это выполнит файл миграции, ПОСЛЕДНИЙ_НЕВЫПОЛНЕННЫЙ_НОМЕР получите командой php app/console doctrine:migrations:status --show-versions
    #php app/console doctrine:migrations:migrate ПОСЛЕДНИЙ_НЕВЫПОЛНЕННЫЙ_НОМЕР
  end
end

module Configuration
  def mainConfigName
    #app/config/parameters.yml
  end
end

module Controller
  def action
	#/**
    # * @Route("/comments", name="study_app_comments_add", requirements={ "_method" : "POST" })
    # * @Template("StudyAppCommentBundle:Default:index.html.twig")
    #*/
  end
  def orm
    #write 
    #$em = $this->getDoctrine()->getEntityManager();
	#$em->persist($product);
	#$em->flush();
	
	#get
	#$repository = $this->getDoctrine()->getRepository("AcmeHelloBundle:Product");
  end
  
  def request
    #$request = $this->getRequest()->request;
    # ->has(); (?) -> get(); (?)  -> set(); (?)
    #$attr = $request->attributes
    # ->has();  -> get();   -> set(); (?)
  end
  
  def session
    #$session = $this->getRequest()->getSession();
    
    # ->has(); -> get()  -> set() (?)
  end
  
  def AuthUser
    #Подключение SecurityContext
	#use Symfony\Component\Security\Core\SecurityContext;
	
	#Как проверить, была ли ошибка авторизации
	#$request->attributes->has(SecurityContext::AUTHENTICATION_ERROR);
	#$error = $session->get(SecurityContext::AUTHENTICATION_ERROR);

  end
  
  class Response
    def json
		use Symfony\Component\HttpFoundation\Response;
        /**
		 * json response
		*/
		private function _json($data) 
		{
			$data = json_encode($data);
			$response = new Response($data);
			$response->headers->set("Content-Type", "application/json");
			return $response;
		}
		# и возвращаем в контроллере
		return $this->_json(array('list' => $data));
    end
  end
end

module Test
  class Console
    def run
      # run all tests in the Utility directory
      $ phpunit -c app src/Acme/DemoBundle/Tests/Utility/

      # run tests for the Calculator class
	  $ phpunit -c app src/Acme/DemoBundle/Tests/Utility/CalculatorTest.php

	  # запустить все тесты для целого Bundle
	  $ phpunit -c app src/Acme/DemoBundle/
    end
  end
end

module Migration
	def addSql
		#$this->addSql("NATIVE SQL QUERY");
	end
end

module Entity
	class Datetime
		def created_at
			#Для работы с датой и временем сущности в Doctrine используй поля created_at
			# updated_at
			#
			/** @Column(type="datetime") */
			private $updated_at;
			private $created_at;
			
			#Для использования надо подключить
			#use Doctrine\ORM\Event\PreUpdateEventArgs;
			#use Doctrine\ORM\Mapping\HasLifecycleCallbacks;
			#use Doctrine\ORM\Mapping\PrePersist;
			#use Doctrine\ORM\Mapping\PreUpdate;
			
			#Для автоматического заполнения этих полей надо определить в классе сущности
			/**
			 * Set date create
			 * @PrePersist
			 */
			#public function initCreatedAt()
			#{
			#	//$this->updated_at = $this->created_at = date('Y-m-d H:i:s');
			#	$this->updated = new \DateTime("now");	
			#}
			/**
			 * Set date modify
			 * @PreUpdate
			 */
			#public function preUpdate(PreUpdateEventArgs $event)
			#{
			#	if ($event->hasChangedField('body')) {
			#		$this->updated_at = date('Y-m-d H:i:s');
			#	}
			#}
			
		end
		def updated_at
			@see created_at
		end
	end
end

module Doctrine2
	def Datetime
		@see Entity.Datetime.created_at
	end
	
	def findAll
		@see findBy
	end
	
	def findBy
		#In controller
		$this->getDoctrine()->getRepository('App[Bundle]::Product')->findBy(
			[
				'isDeleted' => 0,
			],
			[
				'delta' => 'ASC'
			],
			10, # limit
			0   # offset
		);
	end
	
	def getOneFieldValue
		$oRepository = $this->container->get("doctrine")->getRepository("App:User");
		#$oRepository = $this->getDoctrine()->getRepository("App:User");
		$sPhone = $oRepository->createQueryBuilder('u')
            ->andWhere('u.id = :id')
            ->setParameter('id', $nId)
            ->select('u.phone')
            ->getQuery()
            ->getOneOrNullResult();
            
        #Also ->getSingleResult() #return array, result in zero position
	end
	
	def getCollectionOfEntities
		$aPhones = $oRepository->createQueryBuilder('u')
            ->andWhere('u.id = :id')
            ->setParameter('id', $nId)
            ->select('u.phone')
            ->getQuery()
            ->execute();
	end
	
	def leftJoin
		$aPhones = $oRepository->createQueryBuilder('u')
            ->andWhere('u.id = :id')
            ->setParameter('id', $nId)
            ->leftJoin('AppEntityCities', 'c', DoctrineORMQueryExprJoin::WITH, 'c.id = u.city')
            ->addSelect('c.cityName')
            ->select('u.phone')
            ->getQuery()
            ->getResult();
	end
	
	def whereAndTokenOrOrToken
		 $qb = $oRepository->createQueryBuilder('u');
         $qb->andWhere('u.id = :id')
            ->setParameter('id', $nId)
            ->andWhere( $qb->->expr()->andX('u.x = 1 OR u.y = 2 OR u.z = 10') )
            ->select('u.phone');
         $aPhones = $qb->getQuery()->execute();
	end
end

module REST
  class methodPOST
	def annotation
      @see Controller.action
    end
  end
end
module NativeSqlQuery
	def exampleInController
		use Doctrine\ORM\Query\ResultSetMapping;
		#....
		$rsm = new ResultSetMapping();
		$rsm->addEntityResult('SkyengTT\SkyengTTBundle\Entity\Vocabulary', 'v');
		$rsm->addFieldResult('v', 'id', 'id');
		$rsm->addFieldResult('v', 'eng_word', 'eng_word');
		$rsm->addFieldResult('v', 'rus_word', 'rus_word');
		$rsm->addFieldResult('v', 'answer_id', 'answer_id');
	
		$doctrine = $this->getDoctrine();
	
		$answerResult = $doctrine->getEntityManager()->createNativeQuery(
            "SELECT v.id, v.eng_word, v.rus_word, v.answer_id FROM vocabulary AS v WHERE id != {$questionId} ORDER BY RANDOM() LIMIT 4", $rsm)
            ->getResult();
	end
end
