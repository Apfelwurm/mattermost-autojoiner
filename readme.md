# Mattermost-autojoiner
This docker container joins all users in your mattermost instance to all teams and all channels via mmctl.

## Installation Prerequisites

### Prerequisites

- Docker v17
- (Docker-compose v1.18)
- API Accesstoken or username and password of administrative mattermost account

## Usage

### Docker

This method is intended to be run as just a image with your own database. Persistant storage is required for the storage/ directory.

you can run the autojoiner with (for detailed environment variables see below):
```
docker run --rm -it \
 -e MM_INSTANCE="https://yourmminstance" \
 -e MM_ACESS_TOKEN="ACCESSTOKEN" \
 -e MM_SERVERNAME="SERVERNAME" \
 --name mattermost_autojoiner \
 registry.gitlab.com/apfelwurm/mattermost-autojoiner:latest

```

### Docker-compose

This method is intended to be run with docker-compose.

```
version: "3.4"
services:
  app:
    image: registry.gitlab.com/apfelwurm/mattermost-autojoiner:latest
    restart: unless-stopped
    environment:
      # App Config
      - MM_INSTANCE=https://yourmminstance
      - MM_ACESS_TOKEN=ACCESSTOKEN
      - MM_SERVERNAME=SERVERNAME
    container_name: mattermost_autojoiner

```


### Environment Vars
The following Variables are available:
- MM_INSTANCE
    - the link to your mattermost instance with http / https | required!
- MM_SERVERNAME
    - your servername for mmctl | required, you can use what you want 
- MM_ACESS_TOKEN
    - your [mattermost access token](https://docs.mattermost.com/developer/personal-access-tokens.html#) of an administrative account | required if no user and password is provided
- MM_USERNAME
    - your mattermost username of an administrative account | required if no access_token is provided
- MM_PASSWORD
    - your mattermost password of the administrative account specified in MM_USERNAME | required if no access_token is provided
- SLEEPTIMERSEC
    - by default the autojoiner sleeps 3 seconds between each command to stay under the max api threshold of Mattermost if you not overwrite the value here | optional
- RUNOVERSEC
    - by default the autojoiner runs every 30 Minutes (1800sek) if you not overwrite the value here | optional
  
