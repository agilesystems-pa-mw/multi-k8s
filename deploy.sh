docker build -t alinafembendera/multi-client:latest -t alinafembendera/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t alinafembendera/multi-server:latest -t alinafembendera/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t alinafembendera/multi-worker:latest -t alinafembendera/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push alinafembendera/multi-client:latest
docker push alinafembendera/multi-server:latest 
docker push alinafembendera/multi-worker:latest
docker push alinafembendera/multi-client:$SHA
docker push alinafembendera/multi-server:$SHA 
docker push alinafembendera/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=alinafembendera/multi-server:$SHA 
kubectl set image deployments/client-deployment client=alinafembendera/multi-client:$SHA 
kubectl set image deployments/worker-deployment worker=alinafembendera/multi-worker:$SHA 
