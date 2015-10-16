module SASSC
    def AsInstalOnUbuntuAndXAMPP #16-10-2015
       git clone https://github.com/sass/sassc.git
       git clone https://github.com/sass/libsass.git
       cd sassc
       SASS_LIBSASS_PATH="/home/USER/hdata/soft/libsass"; make
       cd /usr/bin
       sudo ln -s /home/USER/hdata/soft/sassc/bin/sassc sassc
       sudo mv /opt/lampp/lib/libstdc++.so.6 /opt/lampp/lib/libstdc++.so.6.back
       sudo cp -s /usr/lib/x86_64-linux-gnu/libstdc++.so.6.0.19 /opt/lampp/lib/libstdc++.so.6
    end
end
