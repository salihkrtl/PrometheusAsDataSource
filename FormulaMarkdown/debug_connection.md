**Check Prometheus and Grafana Pod Status**

@salihkrtl ➜ /workspaces/PrometheusAsDataSource (main) $ kubectl get pods -n monitoring
NAME                                                 READY   STATUS    RESTARTS   AGE
grafana-58bcdc8f86-drbgz                             1/1     Running   0          34m
prometheus-alertmanager-0                            1/1     Running   0          35m
prometheus-kube-state-metrics-75b5bb4bf8-d2c7h       1/1     Running   0          35m
prometheus-prometheus-node-exporter-j8zts            1/1     Running   0          35m
prometheus-prometheus-pushgateway-84557d6c79-5nb8v   1/1     Running   0          35m
prometheus-server-644d686bc6-7w7w7                   2/2     Running   0          35m

```bash
@salihkrtl ➜ /workspaces/PrometheusAsDataSource (main) $ kubectl get pods -A
NAMESPACE     NAME                                                 READY   STATUS    RESTARTS      AGE
kube-system   coredns-6f6b679f8f-q8dhp                             1/1     Running   0             43m
kube-system   etcd-minikube                                        1/1     Running   0             43m
kube-system   kube-apiserver-minikube                              1/1     Running   0             43m
kube-system   kube-controller-manager-minikube                     1/1     Running   0             43m
kube-system   kube-proxy-gwsgm                                     1/1     Running   0             43m
kube-system   kube-scheduler-minikube                              1/1     Running   0             43m
kube-system   storage-provisioner                                  1/1     Running   1 (43m ago)   43m
monitoring    grafana-58bcdc8f86-drbgz                             1/1     Running   0             35m
monitoring    prometheus-alertmanager-0                            1/1     Running   0             37m
monitoring    prometheus-kube-state-metrics-75b5bb4bf8-d2c7h       1/1     Running   0             37m
monitoring    prometheus-prometheus-node-exporter-j8zts            1/1     Running   0             37m
monitoring    prometheus-prometheus-pushgateway-84557d6c79-5nb8v   1/1     Running   0             37m
monitoring    prometheus-server-644d686bc6-7w7w7                   2/2     Running   0             37m

**Check Service and Ingress Configuration**
If you are using a LoadBalancer service or an Ingress, inspect the configuration of these resources.

Check Services:
kubectl get svc -n <namespace>
kubectl describe svc <prometheus-service-name> -n <namespace>
kubectl describe svc <grafana-service-name> -n <namespace>

@salihkrtl ➜ /workspaces/PrometheusAsDataSource (main) $ kubectl get svc -n monitoring
NAME                                  TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)    AGE
grafana                               ClusterIP   10.96.60.99     <none>        80/TCP     37m
prometheus-alertmanager               ClusterIP   10.98.139.81    <none>        9093/TCP   39m
prometheus-alertmanager-headless      ClusterIP   None            <none>        9093/TCP   39m
prometheus-kube-state-metrics         ClusterIP   10.109.129.90   <none>        8080/TCP   39m
prometheus-prometheus-node-exporter   ClusterIP   10.111.30.220   <none>        9100/TCP   39m
prometheus-prometheus-pushgateway     ClusterIP   10.104.27.156   <none>        9091/TCP   39m
prometheus-server                     ClusterIP   10.111.23.25    <none>        80/TCP     39m

