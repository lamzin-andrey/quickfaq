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
		## Это выполнит файл миграции, ПОСЛЕДНИЙ_НЕВЫПОЛНЕННЫЙ_НОМЕР получите командой 
		 #php app/console doctrine:migrations:status --show-versions
    #php app/console doctrine:migrations:migrate ПОСЛЕДНИЙ_НЕВЫПОЛНЕННЫЙ_НОМЕР
  end
end

module Configuration
  def mainConfigName
    #app/config/parameters.yml
  end
  def swiftmailerInEnvFile
	# MAILER_URL=gmail://username_without!_@gmail.com:password@localhost
	# smtp://smtp.gmail.com:587?encryption=tls&auth_mode=login&username=username_without!_@gmail.com&password=password
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
	#(Sym 2.6)
    #Подключение SecurityContext 
	#use Symfony\Component\Security\Core\SecurityContext;
	
	#(Sym 3.4)
    #Подключение Security
	#use Symfony\Component\Security\Core\Security;
	
	
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
	
	def selectAndUpdateEntities
		#use Symfony\Component\DependencyInjection\ContainerAwareInterface;
		#use Symfony\Component\DependencyInjection\ContainerInterface;
		#use Symfony\Component\DependencyInjection\ContainerAwareTrait;

		#use App\Entity\Main;
		#use App\Entity\Users;
		
		#//add implements ContainerAwareInterface
		#final class Version20191115131343 extends AbstractMigration  implements ContainerAwareInterface
		
		#//add setContainer method
		#public function setContainer(ContainerInterface $container = null);
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
	class Assert
		def localizationMessages
			#Чтобы локализовать сообщение X, которое например в @Assert\NotBlank(message="X")
			#Создаёшь файл translations/validators.ru.yml и в нем пишешь.
			#X: FFFFFF!
			
			#То есть всё просто и то, что домен трансляции для formBuilfer 
			#может быть указан как FOSUserBundle - это сбивать с толку не должно.
		end
	end
	
	def findByCriteria
		$oRepository = $this->getDoctrine()->getRepository('App:Main');
		$oCriteria = Criteria::create();
		$e = Criteria::expr();
		$oCriteria->where($e->eq('people', 1));
		#/** @var \Doctrine\ORM\LazyCriteriaCollection $aResult */
		$aResult = $oRepository->matching($oCriteria);
		$aResult->get(0);
		
		# более сложное условие
		#SELECT * FROM main WHERE (people = 1 OR box = 1) AND (near = 1 OR far = 1)
        $oRepository = $this->getDoctrine()->getRepository('App:Main');
        $oCriteria = Criteria::create();
        $oExpression = Criteria::expr();
        $oCriteria->where( $oExpression->andX(
                $oExpression->orX(
                    $oExpression->eq('people', 1),
                    $oExpression->eq('box', 1)
                ),
                $oExpression->orX(
                    $oExpression->eq('far', 1),
                    $oExpression->eq('near', 1)
                )
        ));
        $aResult = $oRepository->matching($oCriteria);
        
        #а если бы надо было динамически
        $oCriteria = Criteria::create();
		$e = Criteria::expr();
		$oCriteria->where( $e->eq('isDeleted', 0) )
			->andWhere( $e->eq('isHide', 0) )
			->andWhere( $e->eq('isModerate', 1) )
		#	->orderBy(['delta' => Criteria::DESC])
			->setMaxResults($limit)
			->setFirstResult(0);
		#...
		$oSession = $oRequest->getSession();
		$aOrWhereType = [];
		$aOrWhereDistance = [];
		#if (intval($oSession->get('people', 0))) {
		#	$aOrWhereType[] = $e->eq('people', 1);
		#}
		#if (intval($oSession->get('box', 0))) {
		#	$aOrWhereType[] = $e->eq('box', 1);
		#}
		#...
		#if (intval($oSession->get('far', 0))) {
		#	$aOrWhereDistance[] = $e->eq('far', 1);
		#}
		#...
		#if ($aOrWhereType) {
            #Добавляем первые скобки с OR
			$oCriteria->andWhere(call_user_func_array([$e, 'orX'], $aOrWhereType) );
		#}
		#if ($aOrWhereDistance) {
            #//Добавляем вторые скобки с OR
		#	$oCriteria->andWhere(call_user_func_array([$e, 'orX'], $aOrWhereDistance) );
		#}
		$aCollection = $repository->matching($oCriteria)->toArray();
	end
	
	def queryCache
		#1 Включить кеш второго уровня в config/packages/doctrine.yaml
		# doctrine:
		#	orm:
		#		second_level_cache:
		#			enabled: true
        
        #2 Добавить аннотации всем Entity
        # @ORM\Cache(usage="READ_ONLY", region="regionname")
        
        #3 Использовать Criteria и EntityRepository::matching для получения результатов
        #4 Если это невозможно, вызывать QueryBuilder::setCacheable(true)
	end
	def Memcache
		#1 Включить кеш второго уровня в config/packages/doctrine.yaml
		# doctrine:
		#	orm:
		#		second_level_cache:
		#		enabled: true
		#			regions:
        #				regionname:
		#					lifetime: 900
        #            		cache_driver:
        #                		type: memcache
        #                		host: localhost
        #                		port: 11211
        
        #2 Добавить аннотации всем Entity
        # @ORM\Cache(usage="READ_ONLY", region="regionname")
        
        #3 Использовать Criteria и EntityRepository::matching для получения результатов
        #4 Если это невозможно, вызывать QueryBuilder::setCacheable(true)
	end
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
								  #id - field in the sql query
		$rsm->addFieldResult('v', 'id', 'id');
											  #eng_word - field of the class SkyengTT\SkyengTTBundle\Entity\Vocabulary
		$rsm->addFieldResult('v', 'eng_word', 'eng_word');
		$rsm->addFieldResult('v', 'rus_word', 'rus_word');
		$rsm->addFieldResult('v', 'answer_id', 'answer_id');
	
		$doctrine = $this->getDoctrine();
	
		$answerResult = $doctrine->getEntityManager()->createNativeQuery(
            "SELECT v.id, v.eng_word, v.rus_word, v.answer_id FROM vocabulary AS v WHERE id != {$questionId} ORDER BY RANDOM() LIMIT 4", $rsm)
            ->getResult();
	end
end

module Repository
	def createSelf
		#class CitiesRepository extends ServiceEntityRepository
		#__construct(ManagerRegistry $registry)
		#	parent::__construct($registry, 'App:Cities');
	end
end

module Twig
	class twigVariable
		def ifdefined
			#if ( nIspage100Percents is defined )
		end
		
		def ifnotdefined
			#if ( nIspage100Percents is not defined )
		end
		
		def isvardefined
			see_ifdefined
		end
		
		def isvarnotdefined
			see_ifnotdefined
		end
		
		def resetvalue
			#{% set doNotShowCabBtn = 1 %}
		end
	end
		
	def route
		#< ahref="{{path('My_route')}}" >Link</a>
	end
		
	def link
		see_route
	end
	
	def overrideBundleViewFile
		#cp fos/user-bundle/Resources/views/layout.html.twig
		#to templates/bundles/FOSUserBundle/layout.html.twig
	end
end
module Translation
	def overrideBundleLangFile
		#cp fos/user-bundle/Resources/translations/FOSUserBundle.ru.yml
		#to translations/FOSUserBundle.ru.yml
	end
	
	def AnnotationAssertMessages
		# see OverrideBundle.Translations.AnnotationAssertMessages
		OverrideBundle.Translations.AnnotationAssertMessages
	end
end

module FormBuilderInterface
	# Sym 3.4 (Sym cli 4.3)
	
	# options - третий аргумент метода FormBuilderInterface::add
	class add
		def name
			# Либо имя поля, которое есть в связанной сущности, либо тупо имя и тогда mapped => false
			options.mapped
		end
		def className
			# обычно передаём например так: CheckboxType::class (там огромный namespace ещё есть)
		end
		def options
		 #see options
		 options.mapped
		end
	end

	# options - третий аргумент метода FormBuilderInterface::add
	class options
		def mapped
			#При установке в false позволяет добавлять поля, которых нет в entity
		end
		def addCustomField
			#@see mapped
			mapped
		end
		def setInputAttributes
			# $options - третий аргумент метода add
			# Установить таким образом id, type - невозможно. Вобще никак невозможно, не мучайся.
			# $options['attr'] => [ 'value' => '1', 'autocomplete' => 'current_password' ]
		end
		def required
			#default false
		end
		def label
			#bo comment
		end
		def translation_domain
			#Можно указать имя файла с трансляцией (например FOSUserBundle, если существует файл 
			#  translations/FOSUserBundle.ru.yml)
			# Чтобы использовать messages.ru.yaml указать null
		end
	end
	
	class RadioType
		# использовать RadioType нет смысла, используй ChoiceType
		def ChoiceType
			#[
			#	'expanded' => true, 'multiple' => false
			#	'choices' => [
			#		'One' => false,
			#		'Two' => true,
			#		'Three' => false
			#	]
			#]
		end
		
		def CheckboxType
			# В Symfony 3.4 in 16/11/2019 имел траблу - надписи выводились перед чекбоксом. Как победить глобально - см
			# see 
			OverrideBundle.FormTheme.Global
		end
		
		def NumberType
			#Если нужен в результате input[type=number] на момент 16/11/2019 используй MoneyType или IntegerType.
			# А  NumberType выводится как input[type=text] - наверное им  (Symfony-стам) так надо.
		end
	end
end

module OverrideBundle

	# Sym 3.4 Sym - CLI 4.3
	
	class FormTheme
		# Перегружаем что-то для всех форм, используемых в проекте
		def Global
			# надо создать файл templates/form/layout.html.twig
			# и определить в нём блок form_row
			
			# содержимое form_row.html.php по умолчанию 
			# {{- form_label(form) -}}
			# {{- form_errors(form) -}}
			#  это непосредственно инпут
			# {{- form_widget(form) -}}
			
			# доступна переменная-массив block_prefixes и один из его элементов 
			# позволяет определить тип инпута, например он равен checkbox если в конструкторе формы
			# использовался CheckboxType
		end
	end
	
	class View
		def FOSUserBundle
			# На примере FOSUserBundle
			# Берем файлы  vendor/friendsofsymfony/user-bundle/Resources/views/Resetting/request_content.html.twig
			# и vendor/friendsofsymfony/user-bundle/Resources/views/Resetting/request.html.twig
			
			# и сохраняем в templates/bundles/FOSUserBundle/Resetting/request_content.html.twig
			# и в templates/bundles/FOSUserBundle/Resetting/request.html.twig
			# соответственно.
			#
			# Пишем в них код, радуемся.
			#
			#
		end
	end
	
	class Controller
		def FOSUserBundle
			# На примере FOSUserBundle
			
			# Берем файл vendor/friendsofsymfony/user-bundle/Controller/ResettingController.php
			
			# и сохраняем в src/Controller/ResettingController.php
			
			#
			# Наследование от Controller меняем на наследование от AbstractController
			# Добавляем use оригинальный контроллер.
			# Не забываем сменить namespace
			# Берем полное имя перегружаемого контроллера (namespace + имя класса)
			# Выполняем поиск по xml, yaml и yml файлам этого имени (оно должно быть в атрибуте class) 
			# и получаем значение атрибута id - его и передаем в конфиге после decorates.
			# Идентификаторы сервисов - аргументов можно также видеть в найденном конфигурационном файле.
			# Мы переписываем их в config/services.yaml
			# но нулевым аргументом передаём  App\Controller\ResettingController.inner. 
			# Понятно только что это ПОЛНОЕ_ИМЯ_нашей_КОПИИ_их_КОНТРОЛЛЕРА.inner - вероятно, это такое правило.
			
			# Пример получившегося конфига (который добавляем в файл config/services.yaml):
			#	App\Controller\ResettingController:
			#	decorates: fos_user.resetting.controller
			#	arguments:
			#		- '@App\Controller\ResettingController.inner'
			#		- '@event_dispatcher'
			#		- '@fos_user.resetting.form.factory'
			#		- '@fos_user.user_manager'
			#		- '@fos_user.util.token_generator'
			#		- '@fos_user.mailer'
			#		- '%fos_user.resetting.retry_ttl%'
			#		- '@security.csrf.token_manager
			
			
			#  Далее, в файле с маршрутами указать, что теперь соответствующий маршрут обрабатывает наш контроллер
			#
			
			# Это фрагмент файла
			#	fos_user_resetting_request:
			#		path: /remind
			#		defaults: { _controller: 'AppControllerResettingController::requestAction' }
			#
		end
	end
	
	class Form
		
		# Sym 3.4 (Sym CLI 4.3)
		
		# На примере FOSUserBundle
		
		# Создаём src/Form/ProfileFormType
		
		#	namespace App\Form;
		#	use Symfony\Component\Form\AbstractType;
		#	use Symfony\Component\Form\FormBuilderInterface;
		
		#	class ProfileFormType extends AbstractType{
		#		
		#		
		#		public function buildForm(FormBuilderInterface $oBuilder, array $options)
		#		{
		#			//Например, удаляем одно из полей оригинальной формы и добавляем другое
		#			$oBuilder->remove('username');
		#			$oBuilder->add('display_name');
		#		}
		#		Это обязательно!
		#		public function getParent()
		#		{
		#			return 'FOS\UserBundle\Form\Type\ProfileFormType';
		#		}
		#		Это обязательно! Значение используется в config/services.yaml
		#		public function getBlockPrefix() : string
		#		{
		#			return 'app_user_profile';
		#		}
		#		Это обязательно, но не связано с перегрузкой, для любой формы так надо!
		#		public function getName() : string
		#		{
		#			return $this->getBlockPrefix();		
		#		}
		#		
		#	} 
		
		# Далее 
		# В файле config/services.yaml  добавляем
		
		#
		#	app.form.profile:
		#		class: App\Form\ProfileFormType
		#		tags:
		#			- { name: form.type, alias: app_user_profile }
		#
		#
		
		# Далее 
		# В файле  config/packages/fos_user.yml  добавляем
		
		#
		#	profile:
		#		form:
		#			type: App\Form\ProfileFormType 
		#
		
	end

	class Translations
		def FOSUserBundle
			# На примере FOSUserBundle
			# Берем файл  vendor/friendsofsymfony/user-bundle/Resources/translations/FOSUserBundle.ru.yml
			# и сохраняем в translations/FOSUserBundle.ru.yml
			#
			# Пишем код, радуемся.
			#
		end
		
		def AnnotationAssertMessages
			# тут независимо от бандла всё в файле translations/validators.ru.yml
			# see also
			Doctrine2.Assert.localizationMessages
		end
	end
end #OverrideBundle

# Sym 3.4 Sym-CLI 4.3
module SwiftMailer
	class sendEmail
		def send
			# in controller
			
			# use Symfony\Bundle\SwiftmailerBundle;
			
			# $message = new Swift_Message();
			# $message->setSubject($s);
			# $message->setBody($s, "text/html", "UTF-8");
			# $message->setFrom($s);
			# $message->setTo($s);
			# $this->get('mailer')->send($message);
		end
		
		def configDotEnvGmail
			# Да, username тут указывается без @gmail.com.
			# Да, localhost тут можно (возможно, даже нужно) оставить без изменений.
			# MAILER_URL=gmail://yourbox:password@localhost
			
			# Тоже вариант
			# MAILER_URL=smtp://smtp.gmail.com:587?encryption=tls&auth_mode=login&username=yourbox&password=***
		end
		
		def configDotEnvISPMgrMailbox
			# Это пример с сайта, размещённого на hostiman.ru
			# В админке ISPMgr создан ящик, у него есть пароль и всё что надо.
			
			# Да, username тут указывается с @andryuxa.ru.
			# mail.andryuxa.ru взято из настроек IspMgr.
			# Порт для tls другой, но к нему подсоединиться не удалось
			
			# MAILER_URL=smtp://mail.andryuxa.ru:25?auth_mode=login&username=admin@andryuxa.ru&password=*****
		end
	end
end
