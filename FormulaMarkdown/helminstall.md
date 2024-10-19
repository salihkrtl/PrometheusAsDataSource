@salihkrtl ➜ /workspaces/PrometheusAsDataSource (main) $ helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
"prometheus-community" has been added to your repositories
@salihkrtl ➜ /workspaces/PrometheusAsDataSource (main) $ helm install prometheus prometheus-community/prometheus \
>   --namespace monitoring --create-namespace
NAME: prometheus
LAST DEPLOYED: Sat Oct 19 11:01:46 2024
NAMESPACE: monitoring
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
The Prometheus server can be accessed via port 80 on the following DNS name from within your cluster:
prometheus-server.monitoring.svc.cluster.local


Get the Prometheus server URL by running these commands in the same shell:
  export POD_NAME=$(kubectl get pods --namespace monitoring -l "app.kubernetes.io/name=prometheus,app.kubernetes.io/instance=prometheus" -o jsonpath="{.items[0].metadata.name}")
  kubectl --namespace monitoring port-forward $POD_NAME 9090


The Prometheus alertmanager can be accessed via port 9093 on the following DNS name from within your cluster:
prometheus-alertmanager.monitoring.svc.cluster.local


Get the Alertmanager URL by running these commands in the same shell:
  export POD_NAME=$(kubectl get pods --namespace monitoring -l "app.kubernetes.io/name=alertmanager,app.kubernetes.io/instance=prometheus" -o jsonpath="{.items[0].metadata.name}")
  kubectl --namespace monitoring port-forward $POD_NAME 9093
#################################################################################
######   WARNING: Pod Security Policy has been disabled by default since    #####
######            it deprecated after k8s 1.25+. use                        #####
######            (index .Values "prometheus-node-exporter" "rbac"          #####
###### .          "pspEnabled") with (index .Values                         #####
######            "prometheus-node-exporter" "rbac" "pspAnnotations")       #####
######            in case you still need it.                                #####
#################################################################################


The Prometheus PushGateway can be accessed via port 9091 on the following DNS name from within your cluster:
prometheus-prometheus-pushgateway.monitoring.svc.cluster.local


Get the PushGateway URL by running these commands in the same shell:
  export POD_NAME=$(kubectl get pods --namespace monitoring -l "app=prometheus-pushgateway,component=pushgateway" -o jsonpath="{.items[0].metadata.name}")
  kubectl --namespace monitoring port-forward $POD_NAME 9091

For more information on running Prometheus, visit:
https://prometheus.io/
@salihkrtl ➜ /workspaces/PrometheusAsDataSource (main) $ kubectl get pods -n monitoring
NAME                                                 READY   STATUS              RESTARTS   AGE
prometheus-alertmanager-0                            0/1     ContainerCreating   0          14s
prometheus-kube-state-metrics-75b5bb4bf8-d2c7h       0/1     Running             0          15s
prometheus-prometheus-node-exporter-j8zts            1/1     Running             0          15s
prometheus-prometheus-pushgateway-84557d6c79-5nb8v   0/1     Running             0          15s
prometheus-server-644d686bc6-7w7w7                   0/2     ContainerCreating   0          15s
@salihkrtl ➜ /workspaces/PrometheusAsDataSource (main) $ minikube service prometheus-server -n monitoring
|------------|-------------------|-------------|--------------|
| NAMESPACE  |       NAME        | TARGET PORT |     URL      |
|------------|-------------------|-------------|--------------|
| monitoring | prometheus-server |             | No node port |
|------------|-------------------|-------------|--------------|
😿  service monitoring/prometheus-server has no node port
❗  Services [monitoring/prometheus-server] have type "ClusterIP" not meant to be exposed, however for local development minikube allows you to access this !
🏃  Starting tunnel for service prometheus-server.
|------------|-------------------|-------------|------------------------|
| NAMESPACE  |       NAME        | TARGET PORT |          URL           |
|------------|-------------------|-------------|------------------------|
| monitoring | prometheus-server |             | http://127.0.0.1:41351 |
|------------|-------------------|-------------|------------------------|
🎉  Opening service monitoring/prometheus-server in default browser...
👉  http://127.0.0.1:41351
❗  Because you are using a Docker driver on linux, the terminal needs to be open to run it.


salihkrtl ➜ /workspaces/PrometheusAsDataSource (main) $ helm repo add grafana https://grafana.github.io/helm-charts
"grafana" has been added to your repositories
@salihkrtl ➜ /workspaces/PrometheusAsDataSource (main) $ helm repo update
Hang tight while we grab the latest from your chart repositories...
...Successfully got an update from the "grafana" chart repository
...Successfully got an update from the "prometheus-community" chart repository
...Successfully got an update from the "stable" chart repository
Update Complete. ⎈Happy Helming!⎈
@salihkrtl ➜ /workspaces/PrometheusAsDataSource (main) $ helm install grafana grafana/grafana \ --namespace monitoring
Error: INSTALLATION FAILED: expected at most two arguments, unexpected arguments:  --namespace, monitoring
@salihkrtl ➜ /workspaces/PrometheusAsDataSource (main) $ helm install grafana grafana/grafana \
>   --namespace monitoring
NAME: grafana
LAST DEPLOYED: Sat Oct 19 11:03:24 2024
NAMESPACE: monitoring
STATUS: deployed
REVISION: 1
NOTES:
1. Get your 'admin' user password by running:

   kubectl get secret --namespace monitoring grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo


2. The Grafana server can be accessed via port 80 on the following DNS name from within your cluster:

   grafana.monitoring.svc.cluster.local

   Get the Grafana URL to visit by running these commands in the same shell:
     export POD_NAME=$(kubectl get pods --namespace monitoring -l "app.kubernetes.io/name=grafana,app.kubernetes.io/instance=grafana" -o jsonpath="{.items[0].metadata.name}")
     kubectl --namespace monitoring port-forward $POD_NAME 3000

3. Login with the password from step 1 and the username: admin
#################################################################################
######   WARNING: Persistence is disabled!!! You will lose your data when   #####
######            the Grafana pod is terminated.                            #####
#################################################################################
@salihkrtl ➜ /workspaces/PrometheusAsDataSource (main) $ kubectl get secret --namespace monitoring grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo
m1cKuyXzJuaHkXtwgMzDG6rGB18uEsXuWgqsPEZK
@salihkrtl ➜ /workspaces/PrometheusAsDataSource (main) $ minikube service grafana -n monitoring
|------------|---------|-------------|--------------|
| NAMESPACE  |  NAME   | TARGET PORT |     URL      |
|------------|---------|-------------|--------------|
| monitoring | grafana |             | No node port |
|------------|---------|-------------|--------------|
😿  service monitoring/grafana has no node port
❗  Services [monitoring/grafana] have type "ClusterIP" not meant to be exposed, however for local development minikube allows you to access this !
🏃  Starting tunnel for service grafana.
|------------|---------|-------------|------------------------|
| NAMESPACE  |  NAME   | TARGET PORT |          URL           |
|------------|---------|-------------|------------------------|
| monitoring | grafana |             | http://127.0.0.1:41549 |
|------------|---------|-------------|------------------------|
🎉  Opening service monitoring/grafana in default browser...
👉  http://127.0.0.1:41549
❗  Because you are using a Docker driver on linux, the terminal needs to be open to run it.
