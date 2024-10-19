@salihkrtl ➜ /workspaces/PrometheusAsDataSource (main) $  kubectl get pods -A
NAMESPACE     NAME                                                 READY   STATUS    RESTARTS      AGE
kube-system   coredns-6f6b679f8f-q8dhp                             1/1     Running   0             27m
kube-system   etcd-minikube                                        1/1     Running   0             27m
kube-system   kube-apiserver-minikube                              1/1     Running   0             27m
kube-system   kube-controller-manager-minikube                     1/1     Running   0             27m
kube-system   kube-proxy-gwsgm                                     1/1     Running   0             27m
kube-system   kube-scheduler-minikube                              1/1     Running   0             27m
kube-system   storage-provisioner                                  1/1     Running   1 (26m ago)   27m
monitoring    grafana-58bcdc8f86-drbgz                             1/1     Running   0             19m
monitoring    prometheus-alertmanager-0                            1/1     Running   0             21m
monitoring    prometheus-kube-state-metrics-75b5bb4bf8-d2c7h       1/1     Running   0             21m
monitoring    prometheus-prometheus-node-exporter-j8zts            1/1     Running   0             21m
monitoring    prometheus-prometheus-pushgateway-84557d6c79-5nb8v   1/1     Running   0             21m
monitoring    prometheus-server-644d686bc6-7w7w7                   2/2     Running   0             21m