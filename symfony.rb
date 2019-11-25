module Console
  def createBundle #Как сгенерить бандл генерация бандла 
	# 2.6
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
  
  def createApp
	# 3.4, symfony cli 4.7
	#symfony new appname --full [--version=3.4]
  end
end

module Configuration
  def mainConfigName
	# 2.6
    #app/config/parameters.yml
    
    # 3.4
    #config/services.yaml
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
	# Sym 2.6
    #$request = $this->getRequest()->request;
    
    # Sym 3.4
    # argument (Request $request)
    
    # ->has(); (?) -> get(); (?)  -> set(); (?)
    #$attr = $request->attributes
    # ->has();  -> get();   -> set(); (?)
  end
  
  def requestMethod
	$request->getMethod();
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
  
  def checkCurrentPassword
	$oUser = $this->oContainer->get('security.token_storage')->getToken()->getUser();
	#/** @var \Symfony\Component\Security\Core\Encoder\UserPasswordEncoder $encoder */
	$encoder = $this->_oContainer->get('security.password_encoder');
	$bCurrentPasswordIsValid = $encoder->isPasswordValid($oUser, $sRawPassword);
  end
  
  def getAuthUser
	#Sym 3.4
	$oUser = $this->getUser();
	#or, if all wrong
	$oUser = $this->oContainer->get('security.token_storage')->getToken()->getUser();
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
	
	def fieldComment
		# /*
		#  * @ORM\Column(type="string", length=64, nullable=true, options={"comment"="User login"})
		# */
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
		
		def setGlobal
			#in yaml file
			#twig:
			#	globals:
			#		x: 15
			#		y: "%app.y%"
			
			#Тогда в  services.yaml должно быть
			#parameters:
			#	app.y: 159
			
			# или 
			
			#parameters:
			#	app.y: "%env(resolve:ENV_FILE_PARAMETER_Y)%"
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
	
	def setDefaultTranslationInView
		# {% trans_default_domain 'FOSUserBundle' %}
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

# 3.4
module FormType
	class RoolFormType
		def extend_s
			# AbstractTyle
		end
		
		def getName
			return 'app.roolForm'
		end
		
		def buildForm
			#arg 0 FormBuilderInterface
			FormBuilderInterface
			#arg 1 array options
		end
	end
	
	class Controller
		def postRequest
		
			#see RoolFormType
			RoolFormType
			# $oForm = $this->createForm(get_class(new RoolFormType()), new AppEntity());
			
		
			#if ($oRequest->getMethod() == 'POST') {
			#	$oForm->handleRequest($oRequest);
			#	if ($oForm->isValid()) {
			#		//TODO save data
			#   	Например понадобилась дополнительная валидация, добавляем ошибку полю ввода	
			#		$oError = new \Symfony\Component\Form\FormError('User already exists');
			#		$vd = $oForm->get('phone')->addError($oError);
			#	} else {
			#		/** @var \Symfony\Component\Form\FormErrorIterator $errs */
			#		$errs = $oForm->getErrors(true);
			#	}
			#}
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
module Session
	class config
		def setLifetime
			# config/packages/framework.yaml
			
			# auth expired after one minute
			
			# framework:
			# 	session:
			# 		cookie_lifetime: 60
		end
	end
end

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

module EventListener
	class KernelEvents
		#This event is dispatched after the controller to be executed has been resolved but before executing it. 
		# Запускается перед запуском метода контроллера, но уже знаем какой контроллер будет запущен.
		def onKernelController(\Symfony\Component\HttpKernel\Event\FilterControllerEvent $evt)
		
		end
		
		#This event is dispatched just before a controller is called. 
		# Вызывается перед выхзовом контроллера. Можно подменить аргументы (метода?) контроллера
		def onKernelControllerArguments(FilterControllerArgumentsEvent $event)
		end
		
		#This event is dispatched after the controller has been executed but only if the controller does not return a Response object. It's useful to transform the returned value (e.g. a string with some HTML contents) into the Response object needed by Symfony:
		# Вызывается только если контролер не вернул объект Response - можно завернуть строку или число, которое он вернул
		#   в new Response() 
		def onKernelView(GetResponseForControllerResultEvent $event)
			value = $event->getControllerResult();
			$response = new Response();
			# // ... somehow customize the Response from the return value
			$event->setResponse($response);
		end
		
		# Можем изменить объект Response (понаставить заголовком, кук и т. п.) А вот переменные для viewData изменить увы - нельзя.
		def onKernelResponse(FilterResponseEvent $event)
			 $response = $event->getResponse();
		end
		
		# This event is dispatched after the kernel.response event. Происходит после kernel.response event
		# It's useful to reset the global state of the application  Полезно для изменения глобального состояния приложения.
		# (for example, the translator listener resets                Например тут переустанавливается устанавливается локаль
		# the translator's locale to the one of the parent request):	(а вот что такое "родительский запрос" - это туманно пока)
		def onKernelFinishRequest(FinishRequestEvent $event)
			#if (null === $parentRequest = $this->requestStack->getParentRequest()) {
			#	return;
			#}
			## // reset the locale of the subrequest to the locale of the parent request
			#$this->setLocale($parentRequest);
		end
		
		def  onKernelException(GetResponseForExceptionEvent $event)
			$exception = $event->getException();
			$response = new Response();
			// setup the Response object based on the caught exception
			$event->setResponse($response);
		end
		
		# Ещё не знаем, какой контроллер будет запущен
		def onRequestEvent
		end
	end
	class CreateListener
		# Sym 3.4
		def yaml
			# Здесь подписываемся на одно событие
			# #app/config/services.yml
			#services:
			#	App\EventListener\KernelEventsListener:
			#		tags:
			#			- { name: kernel.event_listener, event: kernel.controller }
		end
		def php
			# create file src/EventListener/KernelEventsListener.php
			# Не реализует интерфейсов!
			# Не наследует!
			# 
			#public function onKernelController(\Symfony\Component\HttpKernel\Event\FilterControllerEvent $evt);
			# see any events in KernelEvents
			KernelEvents
		end
	end
end

# Sym 3.4

module Bundles
	class FOSUserBundle
		def RegistrationEmailConfirm
			# registration:
			#	confirmation:
            #		enabled: true
		end
		
		def registerUser
			# Если форма регистрации одна, возможно правильнее будет декорировать контроллер, форму, шаблон
			OverrideBundle.Controller
			OverrideBundle.Form
			OverrideBundle.FormTheme
			OverrideBundle.View
			
			# Но можно создать учётку в контроллере и вот так:
			$oUserManager = $this->get('fos_user.user_manager');
			$oUser = $oUserManager->createUser();
            $oUser->setUsername($oRequest->get('username'));
            $oUser->setEmail($oRequest->get('email'));
            $oUser->setPlainPassword($oRequest->get('password'));
            $oUser->setEnabled(true);
            $oUserManager->updateUser($oUser);
		end
	end
end

# Sym 3.4
module Security
	class Yaml
		def security_yaml
		#main:
        #    pattern: ^/
        #    security: true
        #    anonymous: ~
        #    logout_on_user_change: true
        #    form_login:
        #        provider: users
        #	 #след. два в принципе необязательно указывать
        #	 	#login_path: /login
			 # можно указать как имя маршрута так и значение path:
        #    	#check_path: /login_check
        #    #а ещё можно вот так
        #    csrf_token_generator: security.csrf.token_manager
        #		#see services.yaml
        #     success_handler: app.security.authentication_handler
        #     failure_handler: app.security.authentication_handler
        #    
        #    logout:
        #        target: /hello/anonymous
        
        # конфигурация провайдера
        # 
        # для стандартного EntityUserProvider:
        # providers: 
		# 	users:
		#	   entity:
		#			class: App\Entity\User
		#			property: username
		# 
		# для собственного провайдера
		# providers:
		#	special:
		#		id: app.user.provider
        #
        # сослаться на провайдер в form_login
        
        # отдельно указываем алгоритм шифрования
        # encoders:
        # App\Entity\User: { algorithm: bcrypt }
		end
		
		def services
			# в случае собственного провайдера
			# app.user.provider:
			#	class: App\Provider\AppUserProvider
			#	arguments: ['@doctrine']
			
			# В случае хэндлеров успешного или неуспешного логина
			#app.security.authentication_handler:
			#	class: App\Handler\AuthenticationHandler
			#	public: false
			#	arguments: ["@router", "@service_container"]

			#app.security.logout_handler:
			#	class: App\Handler\LogoutHandler
			#	public: false
			#	arguments: ["@service_container"]
		end
		
		def routes
			#logout:
			#	path: /logout
		end
	end 
	class Controller
		#class SecurityController extends Controller
		#{
		#	/**
		#	 * @Route("/login", name="login")
		#	*/
		#	public function loginAction(AuthenticationUtils $authenticationUtils)
		#	{
		#		// get the login error if there is one
		#		$error = $authenticationUtils->getLastAuthenticationError();
#
#				// last username entered by the user
#				$lastUsername = $authenticationUtils->getLastUsername();
#			
#				return $this->render('security/login.html.twig', [
#					'controller_name' => 'SecurityController',
#					 'last_username' => $lastUsername,
#					'error'         => $error,#
#				]);
#			}
#			
#			/**
#			 * @Route("/login_check", name="check_path")
#			*/
#			public function check()
#			{
#				return $this->redirectToRoute('login');
#			}
#			/**
#			 * @Route("/register", name="register")
#			*/
#			public function register(Request $oRequest, UserPasswordEncoderInterface $oEncoder)
#			{
#				if ($oRequest->getMethod() == 'POST') {
#					$sPassword = $oRequest->get('password');
#					$sPassword2 = $oRequest->get('password2');
#					$sEmail = $oRequest->get('email');
#					$sUsername = $oRequest->get('login');
#					
#					if ($sPassword != $sPassword2) {
#						$this->addFlash('notice', 'Passwords is different!');
#						return $this->redirectToRoute('register');
#					}
#					$oUser = new User();
#					$sPassword = $oEncoder->encodePassword($oUser, $sPassword);
#					
#					$oUser->setPassword($sPassword);
#					$oUser->setEmail($sEmail);
#					$oUser->setUsername($sUsername);
#					$oUser->setIsEmailApproved(true);
#					
#					$oEm = $this->getDoctrine()->getManager();
##					$oEm->flush();
	#				return $this->redirectToRoute('login');
#				}
#				return $this->render('security/register.html.twig', [
#					'controller_name' => 'SecurityController',
#				]);
#			}
#		}
	end
	
	class Entity
		#implements UserInterface
		
		#before class @ORM\Table(name="user")
		
		#public function getRoles()
		#{
		#	return ['ROLE_USER'];
		#}
		
		#public function eraseCredentials()
		#{
		#	;
		#}
	end
	
	class Provider
	    # Копируешь EntityUserProvider и изменяешь по ходу требований
	
	     #например так
	     #class AppUserProvider implements UserProviderInterface
		#	{
		#		private $registry;
		#		private $managerName = null;
		#		private $classOrAlias;
		#		private $class;
		#		private $property = 'username';
		#		private $repository;
#
#				public function __construct($doctrine)
#				{
#					$this->property = 'username';
#					$this->class = $this->classOrAlias = get_class(new User() );
#					$this->repository = $doctrine->getRepository($this->class);
#					$this->registry = $doctrine;
#				}
#
#				/**
#				 * {@inheritdoc}
#				 */
#				public function loadUserByUsername($username)
#				{
#					$repository = $this->getRepository();
#					if (null !== $this->property) {
#						$user = $repository->findOneBy([$this->property => $username,
#							'isEmailApproved' => true]);
#					} else {
#						if (!$repository instanceof UserLoaderInterface) {
#							throw new \InvalidArgumentException(sprintf('You must either make the "%s" entity Doctrine Repository ("%s") implement "Symfony\Bridge\Doctrine\Security\User\UserLoaderInterface" or set the "property" option in the corresponding entity provider configuration.', $this->classOrAlias, \get_class($repository)));
#						}
#
#						$user = $repository->loadUserByUsername($username);
#						
#					}
#
#					if (null === $user) {
#						throw new UsernameNotFoundException(sprintf('User "%s" not found.', $username));
#					}
#
#					return $user;
#				}
#
#				/**
#				 * {@inheritdoc}
#				 */
#				public function refreshUser(UserInterface $user)
#				{
#					$class = $this->getClass();
#					if (!$user instanceof $class) {
#						throw new UnsupportedUserException(sprintf('Instances of "%s" are not supported.', \get_class($user)));
#					}
#
#					$repository = $this->getRepository();
#					if ($repository instanceof UserProviderInterface) {
#						$refreshedUser = $repository->refreshUser($user);
#					} else {
#						// The user must be reloaded via the primary key as all other data
#						// might have changed without proper persistence in the database.
#						// That's the case when the user has been changed by a form with
#						// validation errors.
#						if (!$id = $this->getClassMetadata()->getIdentifierValues($user)) {
#							throw new \InvalidArgumentException('You cannot refresh a user '.
#								'from the EntityUserProvider that does not contain an identifier. '.
#								'The user object has to be serialized with its own identifier '.
#								'mapped by Doctrine.'
#							);
#						}
#
#						$refreshedUser = $repository->find($id);
#						if (null === $refreshedUser) {
#							throw new UsernameNotFoundException(sprintf('User with id %s not found', json_encode($id)));
#						}
#					}
#
#					return $refreshedUser;
#				}

#				/**
#				 * {@inheritdoc}
#				 */
#				public function supportsClass($class)
#				{
#					return $class === $this->getClass() || is_subclass_of($class, $this->getClass());
#				}

#				private function getObjectManager()
#				{
#					return $this->registry->getManager($this->managerName);
#				}
#
#				private function getRepository()
#				{
#					return $this->repository;
#				}
#
#				private function getClass()
#				{
#					if (null === $this->class) {
#						$class = $this->classOrAlias;
#
#						if (false !== strpos($class, ':')) {
#							$class = $this->getClassMetadata()->getName();
#						}
#
#						$this->class = $class;
#					}

#					return $this->class;
#				}

#				private function getClassMetadata()
#				{
#					return $this->getObjectManager()->getClassMetadata($this->classOrAlias);
#				}
#			}
	end
	
	class Handler
		def AuthenticationHandle
#			namespace App\Handler;
#
#			use Symfony\Component\HttpFoundation\JsonResponse;
#			use Symfony\Component\HttpFoundation\RedirectResponse;
#			use Symfony\Component\Routing\RouterInterface;
#			use Symfony\Component\Security\Core\Authentication\Token\TokenInterface;
#			use Symfony\Component\Security\Core\Exception\AuthenticationException;
#			use Symfony\Component\HttpFoundation\Request;
#			use Symfony\Component\Security\Core\Security;
#			use Symfony\Component\Security\Http\Authentication\AuthenticationSuccessHandlerInterface;
#			use Symfony\Component\Security\Http\Authentication\AuthenticationFailureHandlerInterface;
#			use Symfony\Component\DependencyInjection\ContainerInterface;
#
#			/**
#			 * Class AuthenticationHandler
#			 * @package App\Handler
#			 */
#			class AuthenticationHandler implements AuthenticationSuccessHandlerInterface, AuthenticationFailureHandlerInterface
#			{
#				/**
#				 * @var RouterInterface
#				 */
#				private $router;
#				/**
#				 * @var Session
#				 */
#				private $session;
#
#
#				/**
#				 * AuthenticationHandler constructor.
#				 * @param RouterInterface $router
#				 * @param Session $session
#				 */
#				public function __construct(RouterInterface $router,/* Session $session*/ ContainerInterface $oContainer)
#				{
#					$this->router = $router;
#					$this->_oContainer = $oContainer;
##				}

	#			/**
#				 * @param Request $request
#				 * @param TokenInterface $token
#				 * @return JsonResponse|RedirectResponse
#				 */
#				public function onAuthenticationSuccess(Request $request, TokenInterface $token)
#				{
#
#					if ($request->isXmlHttpRequest()) {
#						$url = $this->router->generate('fos_user_profile_show');
#						return new JsonResponse(array('success' => true));
#					}
#					else {
#						$url = $this->router->generate('fos_user_profile_show');
##						return new RedirectResponse($url);
#					}
#
#				}
#
#				/**
#				 * @param Request $request
#				 * @param AuthenticationException $exception
#				 * @return JsonResponse|RedirectResponse
#				 */
#				public function onAuthenticationFailure(Request $request, AuthenticationException $exception)
#				{
#					if ($request->isXmlHttpRequest()) {
#						//$request->get('session')->set(Security::AUTHENTICATION_ERROR, $exception);
#						$t = $this->_oContainer->get('translator');
#						$sMessage = $t->trans($exception->getMessage(), [], null);
#						return new JsonResponse(['success' => false, 'message' => $sMessage]);
#					} else {
#						$request->getSession()->set(Security::AUTHENTICATION_ERROR, $exception);
#						return new RedirectResponse($this->router->generate('fos_user_security_login'));
#					}
#				}
#			}
		end
		
		def logoutHandler
			#class LogoutHandler implements \Symfony\Component\Security\Http\Logout\LogoutHandlerInterface
			# public function logout(Request $request, Response $response, TokenInterface $token);
			#public function __construct(ContainerInterface $oContainer)
			#	{
			#		$this->_oContainer = $oContainer;
			#		$this->session = $oContainer->get('request_stack')->getCurrentRequest()->getSession();
			#	}
		end
	end
end
