# Utiliza una imagen base con SoapUI instalado
FROM smartbear/soapuios-testrunner:latest

# Copia tu archivo de proyecto SoapUI al contenedor
COPY /ruta/a/tu/proyecto.xml /proyecto.xml

# Establece el directorio de trabajo
WORKDIR /app

# Ejecuta el comando testrunner.bat al iniciar el contenedor
ENTRYPOINT ["testrunner.sh", "-sTestSuite", "-cTestCase", "-r", "-a", "-j", "-J", "-f/app/reports", "/proyecto.xml"]
