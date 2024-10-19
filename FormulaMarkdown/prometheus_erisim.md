Bu durumda, `minikube tunnel` komutu sorunsuz çalışıyor ancak tünellenmiş herhangi bir servis olmadığını (`services: []`) gösteriyor. Bunun nedeni, şu anda **LoadBalancer** türünde bir servisin olmaması veya **ClusterIP** servisini dışarıya açan bir tünelin henüz başlamamış olması olabilir.

### 1. **Prometheus Servisini NodePort Olarak Değiştirin**
Eğer servise tünel yerine daha doğrudan erişmek isterseniz, Prometheus servisinin türünü **ClusterIP** yerine **NodePort** olarak değiştirebilirsiniz. Bu işlem, servise doğrudan bir node port üzerinden erişim sağlar.

Servis türünü değiştirmek için şu adımları izleyin:

1. **Prometheus servisinin tanımını düzenleyin**:
   ```bash
   kubectl edit svc prometheus-server -n monitoring
   ```

2. Servis dosyasında aşağıdaki bölümü bulun ve `type: ClusterIP` satırını `type: NodePort` olarak değiştirin:

   ```yaml
   spec:
     type: NodePort
   ```

3. Değişikliği kaydettikten sonra servis yeniden oluşturulacaktır. NodePort olarak değiştiğinde, Prometheus servisine atanmış bir port numarası olur. Bu portu kontrol etmek için şu komutu çalıştırın:

   ```bash
   kubectl get svc prometheus-server -n monitoring
   ```

   Çıktıda **NodePort** alanında Prometheus servisi için atanmış port numarasını göreceksiniz.

4. **Minikube üzerinden servise erişmek** için şu komutu kullanın:

   ```bash
   minikube service prometheus-server -n monitoring --url
   ```

   Bu komut size Prometheus sunucusu için erişebileceğiniz bir URL dönecektir.

### 2. **Tünelin Çalışmasını Sağlamak İçin LoadBalancer Kullanma**
Eğer **NodePort** yerine **LoadBalancer** servisi kullanmak isterseniz, Prometheus servisini **LoadBalancer** olarak ayarlayarak tünelin aktif olmasını sağlayabilirsiniz.

1. Prometheus servisinin türünü **LoadBalancer** olarak değiştirmek için yine servisi düzenleyin:
   ```bash
   kubectl edit svc prometheus-server -n monitoring
   ```

2. `type: ClusterIP` kısmını şu şekilde değiştirin:

   ```yaml
   spec:
     type: LoadBalancer
   ```

3. Değişikliği kaydettikten sonra tekrar `minikube tunnel` komutunu çalıştırın. Artık tünellenen servisi ve ona bağlı URL'yi görebilmelisiniz.

### 3. **Doğrudan Prometheus Pod'una Port Yönlendirme (Port Forwarding)**
Eğer yukarıdaki yöntemlerle erişim sağlayamazsanız, bir diğer seçenek **port forwarding** kullanarak Prometheus’a erişmektir.

1. Prometheus pod’unu bulun:
   ```bash
   kubectl get pods -n monitoring
   ```

2. Prometheus pod'u için bir port yönlendirmesi başlatın:
   ```bash
   kubectl port-forward -n monitoring svc/prometheus-server 9090:9090
   ```

   Bu komut, yerel bilgisayarınızın 9090 portunu Prometheus’un 9090 portuna yönlendirir. Artık `http://localhost:9090` üzerinden Prometheus’a erişebilirsiniz.

Bu adımlarla Prometheus’a erişim sağlamalısınız. Hangi yöntemi tercih ederseniz edin, doğru URL'yi elde ettikten sonra bu URL'yi Grafana’daki Prometheus veri kaynağı olarak kullanabilirsiniz.


**YAPILAN ISLEMLER**

@salihkrtl ➜ /workspaces/PrometheusAsDataSource (main) $ kubectl get pods -n monitoring
NAME                                                 READY   STATUS    RESTARTS   AGE
grafana-58bcdc8f86-drbgz                             1/1     Running   0          34m
prometheus-alertmanager-0                            1/1     Running   0          35m
prometheus-kube-state-metrics-75b5bb4bf8-d2c7h       1/1     Running   0          35m
prometheus-prometheus-node-exporter-j8zts            1/1     Running   0          35m
prometheus-prometheus-pushgateway-84557d6c79-5nb8v   1/1     Running   0          35m
prometheus-server-644d686bc6-7w7w7                   2/2     Running   0          35m
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
@salihkrtl ➜ /workspaces/PrometheusAsDataSource (main) $ kubectl get svc -n monitoring
NAME                                  TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)    AGE
grafana                               ClusterIP   10.96.60.99     <none>        80/TCP     37m
prometheus-alertmanager               ClusterIP   10.98.139.81    <none>        9093/TCP   39m
prometheus-alertmanager-headless      ClusterIP   None            <none>        9093/TCP   39m
prometheus-kube-state-metrics         ClusterIP   10.109.129.90   <none>        8080/TCP   39m
prometheus-prometheus-node-exporter   ClusterIP   10.111.30.220   <none>        9100/TCP   39m
prometheus-prometheus-pushgateway     ClusterIP   10.104.27.156   <none>        9091/TCP   39m
prometheus-server                     ClusterIP   10.111.23.25    <none>        80/TCP     39m
@salihkrtl ➜ /workspaces/PrometheusAsDataSource (main) $ kubectl describe svc prometheus-server monitoring
Error from server (NotFound): services "prometheus-server" not found
Error from server (NotFound): services "monitoring" not found
@salihkrtl ➜ /workspaces/PrometheusAsDataSource (main) $ kubectl get pods -n kube-system | grep ingress
@salihkrtl ➜ /workspaces/PrometheusAsDataSource (main) $ git pull; git add . && git commit -m "Refined" && git push
Already up to date.
[main 5411882] Refined
 1 file changed, 46 insertions(+)
 create mode 100644 FormulaMarkdown/debug_connection.md
Enumerating objects: 6, done.
Counting objects: 100% (6/6), done.
Delta compression using up to 2 threads
Compressing objects: 100% (4/4), done.
Writing objects: 100% (4/4), 1.15 KiB | 1.15 MiB/s, done.
Total 4 (delta 2), reused 0 (delta 0), pack-reused 0 (from 0)
remote: Resolving deltas: 100% (2/2), completed with 2 local objects.
To https://github.com/salihkrtl/PrometheusAsDataSource
   e26abdd..5411882  main -> main
@salihkrtl ➜ /workspaces/PrometheusAsDataSource (main) $ minikube addons enable ingress
💡  ingress is an addon maintained by Kubernetes. For any concerns contact minikube on GitHub.
You can view the list of minikube maintainers at: https://github.com/kubernetes/minikube/blob/master/OWNERS
    ▪ Using image registry.k8s.io/ingress-nginx/controller:v1.11.2
    ▪ Using image registry.k8s.io/ingress-nginx/kube-webhook-certgen:v1.4.3
    ▪ Using image registry.k8s.io/ingress-nginx/kube-webhook-certgen:v1.4.3
🔎  Verifying ingress addon...
🌟  The 'ingress' addon is enabled
@salihkrtl ➜ /workspaces/PrometheusAsDataSource (main) $ kubectl edit svc prometheus-server -n monitoring
service/prometheus-server edited
@salihkrtl ➜ /workspaces/PrometheusAsDataSource (main) $ kubectl get svc prometheus-server -n monitoring
NAME                TYPE       CLUSTER-IP     EXTERNAL-IP   PORT(S)        AGE
prometheus-server   NodePort   10.111.23.25   <none>        80:30880/TCP   50m
@salihkrtl ➜ /workspaces/PrometheusAsDataSource (main) $ minikube service prometheus-server -n monitoring --url
http://192.168.49.2:30880