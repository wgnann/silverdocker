# silverdocker
Container que exibe um Firefox capaz de usar o finado Silverlight

### Como funciona?
1. Instalar o `docker`;
2. Acessar o diretório depois de clonar;
3. Montar a imagem: `docker build -t igc .`;
4. Rodar o container: `run.sh`.

### Caveats
Depende do mecanismo de autenticação/autorização do X11. Aplica um patch no `install-dependency` usando a variável de build `DSHOWURL`. Basta dar uma lida no Dockerfile para entender melhor.
