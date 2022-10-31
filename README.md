# custom-servers
In this repository, I create custom webservers as nginx for different configurations. 

# List images on gcp

 gcloud compute images list | grep ubuntu | grep 2204

# setup credentials

 gcloud auth application-default login

# steps packer version 1.8.4

packer init nginx/
packer build -force  nginx/
