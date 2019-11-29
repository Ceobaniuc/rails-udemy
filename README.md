## Docker
### Para gerar, execute o comando abaixo:
```
docker build -t portfolio:latest .
```
### Para testar:
```
docker run --rm -p 3000:3000 portfolio:latest
```
ou
```
docker run --rm -p 3000:3000 -e portfolio:latest
