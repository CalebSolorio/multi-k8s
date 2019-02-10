docker build -t csolorio/multi-client:latest csolorio/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t csolorio/multi-server:latest csolorio/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t csolorio/multi-worker:latest csolorio/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push csolorio/multi-client:latest
docker push csolorio/multi-server:latest
docker push csolorio/multi-worker:latest

docker push csolorio/multi-client:$SHA
docker push csolorio/multi-server:$SHA
docker push csolorio/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=csolorio/multi-server:$SHA
kubectl set image deployments/client-deployment client=csolorio/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=csolorio/multi-worker:$SHA