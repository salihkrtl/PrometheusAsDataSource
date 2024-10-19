 kubectl get secret --namespace monitoring grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo
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
