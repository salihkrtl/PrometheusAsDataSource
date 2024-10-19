Minikube üzerinde Helm, Prometheus, Grafana ve Thanos kurulumunu resimlerle anlatan bir rehber aşağıdaki adımlarla ilerleyebilir:

### 1. **Minikube’i Kurmak**
   İlk adım Minikube’in kurulumudur. Minikube, yerel bir Kubernetes kümesi oluşturmanızı sağlar.

   ```bash
   minikube start --memory=4096 --cpus=4
   ```

   - Bu komut, Minikube’i 4GB RAM ve 4 CPU kullanarak başlatır.
   
   Görsel: Minikube’in çalıştığı terminal çıktısı

### 2. **Helm’i Kurmak**
   Helm, Kubernetes için bir paket yöneticisidir. Helm chart'ları kullanarak uygulamaları kolayca kurabilirsiniz.

   Helm’in kurulumunu yaptıktan sonra Minikube üzerinde kullanmaya başlayabilirsiniz.

   ```bash
   helm repo add stable https://charts.helm.sh/stable
   helm repo update
   ```

   Görsel: Helm’in başarıyla kurulduğunu gösteren terminal çıktısı

### 3. **Prometheus Kurulumu**
   Prometheus, metrikleri toplamak ve izlemek için kullanılan bir sistemdir. Helm ile Prometheus’u kurmak için:

   ```bash
   helm install prometheus stable/prometheus --namespace monitoring --create-namespace
   ```

   - `--namespace monitoring`: Prometheus'u "monitoring" adlı bir namespace altında kurar.

   Görsel: Prometheus Helm chart kurulumunun başarıyla tamamlandığını gösteren ekran görüntüsü

### 4. **Grafana Kurulumu**
   Grafana, Prometheus gibi sistemlerden verileri görselleştirmenizi sağlar. Helm ile Grafana’yı kurabilirsiniz:

   ```bash
   helm install grafana stable/grafana --namespace monitoring
   ```

   - Kurulumdan sonra Grafana’nın admin parolasını almak için:

   ```bash
   kubectl get secret --namespace monitoring grafana -o jsonpath="{.data.admin-password}" | base64 --decode
   ```

   Görsel: Grafana arayüzü ve admin giriş ekranı

### 5. **Thanos Kurulumu**
   Thanos, Prometheus metriklerini uzun süreli saklamak ve ölçeklendirmek için kullanılır. Thanos’u da Helm ile kurabiliriz:

   ```bash
   helm install thanos stable/thanos --namespace monitoring
   ```

   - Bu komut Thanos’un temel bileşenlerini Kubernetes cluster'ına kurar.

   Görsel: Thanos kurulum aşamaları ve başarıyla tamamlanan terminal çıktısı

### 6. **Port Forward ile Erişim**
   Grafana ve Prometheus’u yerel tarayıcıdan görüntülemek için port yönlendirme yapabilirsiniz:

   ```bash
   kubectl port-forward svc/grafana 3000:80 --namespace monitoring
   kubectl port-forward svc/prometheus-server 9090:80 --namespace monitoring
   ```

   - Bu komutlarla Grafana’yı `http://localhost:3000` ve Prometheus’u `http://localhost:9090` adresinden görüntüleyebilirsiniz.

   Görsel: Browser üzerinden Grafana ve Prometheus arayüzlerinin görüntülenmesi.

### 7. **Sonuç**
   Artık Minikube üzerinde Prometheus, Grafana ve Thanos kurulu. Sistemi izlemeye ve grafikleri görselleştirmeye başlayabilirsiniz.

---

Bu adımları takip ederek Minikube üzerinde kolayca Prometheus, Grafana ve Thanos altyapısını kurabilirsiniz.
