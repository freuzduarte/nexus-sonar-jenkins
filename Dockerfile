# Utiliza una imagen base con SoapUI instalado
FROM smartbear/soapuios-testrunner:latest

# Copia tu archivo de proyecto SoapUI al contenedor
COPY /var/jenkins_home/soapUi/test/REST-Project-2-soapui-project.xml /app/REST-Project-2-soapui-project.xml

# Establece el directorio de trabajo
WORKDIR /app

# Ejecuta el comando testrunner.sh al iniciar el contenedor
ENTRYPOINT ["testrunner.sh", "-sTestSuite", "-cTestCase", "-r", "-a", "-j", "-J", "-f/app/reports", "/app/REST-Project-2-soapui-project.xml"]
