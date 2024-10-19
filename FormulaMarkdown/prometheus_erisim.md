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