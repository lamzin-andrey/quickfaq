#тут как обновитьб nodejs до последней версии
module install
  def console
	
    sudo npm cache clean -f
	sudo npm install -g n
	sudo n stable

	sudo ln -sf /usr/local/n/versions/node/<VERSION>/bin/node /usr/bin/nodejs
	
  end
end
