docker build -t jyang116/multi-client:latest -t jyang116/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jyang116/multi-server:latest -t jyang116/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jyang116/multi-worker:latest -t jyang116/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push jyang116/multi-client:latest
docker push jyang116/multi-server:latest
docker push jyang116/multi-worker:latest
docker push jyang116/multi-client:$SHA
docker push jyang116/multi-server:$SHA
docker push jyang116/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=jyang116/multi-client:$SHA
kubectl set image deployments/server-deployment server=jyang116/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=jyang116/multi-worker:$SHA
