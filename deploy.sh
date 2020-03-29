docker build -t johnalejandro001/multi-client:latest -t johnalejandro001/multi-client:$SHA  -f ./client/Dockerfile ./client
docker build -t johnalejandro001/multi-server:latest -t johnalejandro001/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t johnalejandro001/multi-worker:latest -t johnalejandro001/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push johnalejandro001/multi-client:latest
docker push johnalejandro001/multi-server:latest
docker push johnalejandro001/multi-worker:latest
docker push johnalejandro001/multi-client:$SHA
docker push johnalejandro001/multi-server:$SHA
docker push johnalejandro001/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=johnalejandro001/multi-server:$SHA
kubectl set image deployments/worker-deployment server=johnalejandro001/multi-worker:$SHA
kubectl set image deployments/client-deployment server=johnalejandro001/multi-client:$SHA
