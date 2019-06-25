docker build -t lejarokos/multi-client:latest -t lejarokos/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t lejarokos/multi-server:latest -t lejarokos/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t lejarokos/multi-worker:latest -t lejarokos/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push lejarokos/multi-client:latest
docker push lejarokos/multi-server:latest
docker push lejarokos/multi-worker:latest

docker push lejarokos/multi-client:$SHA
docker push lejarokos/multi-server:$SHA
docker push lejarokos/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=lejarokos/multi-server:$SHA
kubectl set image deployments/client-deployment client=lejarokos/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=lejarokos/multi-worker:$SHA