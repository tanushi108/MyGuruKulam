# Assignment-2_Ansible

## Inventory file
```
[workers]
server1 ansible_host=54.153.242.169
server2 ansible_host=13.210.229.3
server3 ansible_host=13.210.118.95


[workers:vars]
ansible_ssh_private_key_file="/home/tanushi/key-ec2.pem"
ansible_user=ubuntu
ansible_host_key_checking=false
```

## Ansible Connectivity +Install ngnix

```
ansible workers -i inventory -m ping
ansible workers -i inventory -b -m apt -a "update_cache=yes"
ansible workers -i inventory -b -m apt -a "name=nginx state=present"
ansible workers -i inventory -b -m service -a "name=nginx state=started enabled=yes"
ansible workers -i inventory -b -m shell -a "nginx -v"
ansible workers -i inventory -b -m shell -a "systemctl is-active nginx"

```
<img width="1350" height="529" alt="image" src="https://github.com/user-attachments/assets/b43f98c6-aff0-4bbb-b38f-492c1fd96195" />

<img width="1356" height="684" alt="image" src="https://github.com/user-attachments/assets/53749879-7c3d-4549-b748-606b967bda14" />

<img width="1361" height="328" alt="image" src="https://github.com/user-attachments/assets/bd888adc-9cb3-42d4-9d29-acb868092225" />

## Nginx log management / Logrotate

### check log management
```
ansible workers -i inventory -b -m shell -a "du -sh /var/log/nginx"
ansible workers -i inventory -b -m shell -a "du -h /var/log/nginx/*"
```
```
ansible workers -i inventory -b -m copy -a "content='/var/log/nginx/*.log {
    size 1G
    rotate 5
    compress
    missingok
    notifempty
    sharedscripts
    postrotate
        systemctl reload nginx >/dev/null 2>&1
    endscript
}
' dest=/etc/logrotate.d/nginx"
```
<img width="1363" height="620" alt="image" src="https://github.com/user-attachments/assets/625a4471-7edf-4d88-8b02-1fe0d15fbf80" />

## Website Creation

```
/var/www/tanya
        |
        └── index.html
/var/www/heena
        |
        └── index.html
```

```
ansible workers -i inventory -b -m file -a "path=/var/www/tanya state=directory"
ansible workers -i inventory -b -m copy -a "content='<h1>Welcome to Tanya Website</h1>' dest=/var/www/tanya/index.html"
```

<img width="1363" height="685" alt="image" src="https://github.com/user-attachments/assets/f00a27b0-6473-4e1b-9d6d-daf9d242458c" />

<img width="1364" height="670" alt="image" src="https://github.com/user-attachments/assets/e8bc5c6f-26e1-49d0-b935-9d2f6c8a6dbe" />

```
ansible workers -i inventory -b -m file -a "path=/var/www/heena state=directory"
ansible workers -i inventory -b -m copy -a "content='<h1>Welcome to Heena Website</h1>' dest=/var/www/heena/index.html"
```
<img width="1358" height="597" alt="image" src="https://github.com/user-attachments/assets/2c92ff99-4aec-4c57-b109-9ce2206a8d85" />

<img width="1355" height="682" alt="image" src="https://github.com/user-attachments/assets/a726fd21-ca10-489b-b3ef-e0396c1c3af1" />


## Nginx Virtual Host configuration

### Default site remove:
```
ansible workers -i inventory -b -m file -a "path=/etc/nginx/sites-enabled/default state=absent"
````
<img width="1361" height="376" alt="image" src="https://github.com/user-attachments/assets/a837ad52-675e-4dda-ab1f-111bef4a7651" />

### Virtual host create:

```
ansible workers -i inventory -b -m copy -a "content='server {
    listen 80;
    server_name team.opstree.com;
    root /var/www/tanya;
    index index.html;
    location / {
        try_files \$uri \$uri/ =404;
    }
}
' dest=/etc/nginx/sites-available/team.opstree.com"
```
<img width="1362" height="677" alt="image" src="https://github.com/user-attachments/assets/9c249e2f-298b-4b7c-94bd-91a3db5ed9f4" />


### Enable site + Test configuration + Reload

```
ansible workers -i inventory -b -m file -a "src=/etc/nginx/sites-available/team.opstree.com dest=/etc/nginx/sites-enabled/team.opstree.com state=link"
ansible workers -i inventory -b -m shell -a "nginx -t"
ansible workers -i inventory -b -m service -a "name=nginx state=reloaded"
```
<img width="1361" height="619" alt="image" src="https://github.com/user-attachments/assets/c244203b-2c8f-435b-aa32-25477f887311" />




### Check + Manually Run + Cron
```
ansible workers -i inventory -b -m shell -a "cat /usr/local/bin/website-switch.sh"
ansible workers -i inventory -b -m shell -a "/usr/local/bin/website-switch.sh"
ansible workers -i inventory -b -m cron -a "name='Website rotation test' hour='*/2' job='/usr/local/bin/website-switch.sh'"
ansible workers -i inventory -b -m shell -a "crontab -l"
```
<img width="1363" height="494" alt="image" src="https://github.com/user-attachments/assets/766bde5d-d24d-47bb-ab3b-8507f33739c2" />



## Apache installation

### Installation + Version:
```
ansible workers -i inventory -b -m apt -a "update_cache=yes"
ansible workers -i inventory -b -m apt -a "name=apache2 state=present"

ansible workers -i inventory -b -m shell -a "apache2 -v"
```
<img width="1361" height="681" alt="image" src="https://github.com/user-attachments/assets/ee040b92-11e2-4bfd-9662-b2e952450d4e" />


## Apache port change

### VirtualHost + Check Ports

```
ansible workers -i inventory -b -m lineinfile -a "path=/etc/apache2/ports.conf regexp='^Listen 80$' line='Listen 8080'"
ansible workers -i inventory -b -m replace -a "path=/etc/apache2/sites-available/000-default.conf regexp='<VirtualHost \*:80>' replace='<VirtualHost *:8080>'"
ansible workers -i inventory -b -m shell -a "ss -lntp | grep -E ':80|:8080'"
```
<img width="1362" height="611" alt="image" src="https://github.com/user-attachments/assets/856f6402-d066-4b76-8702-dbb9a8eebe03" />

<img width="1357" height="681" alt="image" src="https://github.com/user-attachments/assets/8e6c1d2f-2cfa-473d-a0cb-64f9862c5043" />




<img width="679" height="324" alt="Screenshot 2026-09-02 003451" src="https://github.com/user-attachments/assets/ca4b8a10-d770-4b35-a1ef-745a0d3a6bfd" />


After 2 Hours 

<img width="680" height="271" alt="Screenshot 2026-09-02 003610" src="https://github.com/user-attachments/assets/16cc80e8-6d35-4739-bc14-ae166749216b" />

