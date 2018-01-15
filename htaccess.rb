def goToWww
    RewriteCond %{HTTP_HOST} !^!www\..+$ [NC]
    #тут не помню уже где именно воскл. знак
	RewriteRule ^(.*)$ http://%{HTTP_HOST}/$1 [R=301,L]

	
end 
def goFromIndexToRoot
	RewriteCond %{THE_REQUEST} ^[A-Z]{3,9}\ /index.(php|html|htm)\ HTTP/
	RewriteRule ^(.*)index.(php|html|htm)$ http://%{HTTP_HOST}/$1 [R=301,L]
end
