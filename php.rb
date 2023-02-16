module Date
    class date
        def numberDayOfWeek
            date('N'); #1 - Monday, 7 - Sunday
            date('w'); #0 - Sunday, 6 - Saturday
        end
        def pregMatchDate
			#^[0-9]{4}\-[0-9]{2}\-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}$#
			#^[0-9]{4}\-[0-9]{2}\-[0-9]{2}$#
        end
    end
end

module File
	def pathinfo
		['extension' => 'png', 'basename' => '0.png', 'filename' => '0', 'dirname' => '/home/user']
	end
end

module Curl
	def GetHeaders
	#~ public function getResponseHeadersOnly(string $url) : array
    #~ {
        #~ $curl = curl_init();
        #~ curl_setopt($curl, CURLOPT_URL, $url);
        #~ curl_setopt($curl, CURLOPT_NOBODY, true);
        #~ curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
        #~ curl_setopt($curl, CURLOPT_HEADER, true);
        #~ $headers = curl_exec($curl);
        #~ $info = curl_getinfo($curl);
        #~ curl_close($curl);

        #~ var_dump($headers);
        #~ var_dump($info);
    #~ }
	end
end

module AMQP
namespace App\Insurance\Library;

class RabbitQueueInfoProvider
{

    def getQuantityMessagesInQueue(

        string $queueName,

        string $envVariableName = 'MESSENGER_TRANSPORT_DSN',

        ?int $priority = null

    ) : int {

        $dsn = parse_url(getenv($envVariableName));

        $amqpConnection = new \AMQPConnection([

            'host' => ($dsn['host'] ?? 'localhost'),

            'port' => ($dsn['port'] ?? 5672),

            'vhost' => '/',

            'login' => ($dsn['user'] ?? 'guest'),

            'password' => ($dsn['pass'] ?? 'guest'),

        ]);

        $amqpConnection->connect();

        $channel = new \AMQPChannel($amqpConnection);

        $amqpQueue = new \AMQPQueue($channel);

        $amqpQueue->setFlags(AMQP_DURABLE);

        if (null !== $priority) {

            $amqpQueue->setArgument('x-max-priority', $priority);

        }

        $amqpQueue->setName($queueName);

        return  intval($amqpQueue->declareQueue());

	$}
    end

}
end
