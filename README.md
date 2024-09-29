# group1-miniproject for Opswerks
# Made by: Alcala, Baetiong, Tabotabo, Quijano

Steps:
1. On Jump Host:
   sudo usermod -aG docker jenkins
   sudo systemctl restart jenkins

3. On Jenkins UI:
   Manage Jenkins > Credentials > Add your Docker Hub Credentials
   ID = "docker_credentials"

4. On Pipeline:
   Pipeline Name: "mini-proj"
   Change "master" to "main"
