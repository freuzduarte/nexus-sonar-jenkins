FROM smartbear/soapuios-testrunner:latest

# # Define volúmenes
# VOLUME /tests
# VOLUME /reports

# Establece el directorio de trabajo
WORKDIR /app

# # Copia tu archivo de proyecto SoapUI al contenedor
# COPY /var/jenkins_home/soapUi/test/REST-Project-2-soapui-project.xml /app/REST-Project-2-soapui-project.xml

# Ejecuta el comando testrunner.sh al iniciar el contenedor
# ENTRYPOINT ["testrunner.sh", "-sTestSuite", "-cTestCase", "-r", "-a", "-j", "-J", "-f/app/reports", "/app/REST-Project-2-soapui-project.xml"]

ENTRYPOINT [ "" ]
CMD [ "/bin/bash" ]