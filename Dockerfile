# Utiliza una imagen base con SoapUI instalado
FROM smartbear/soapuios-testrunner:latest

# Copia tus archivos necesarios al contenedor
COPY ./testSoapRunner /app

# Establece el directorio de trabajo
WORKDIR /app

# Ejecuta el comando testrunner.sh al iniciar el contenedor
ENTRYPOINT ["testrunner.sh", "-sTestSuite", "-cTestCase", "-r", "-a", "-j", "-J", "-f/app/reports", "/app/REST-Project-2-soapui-project.xml"]
