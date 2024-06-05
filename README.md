# smtp-relay

This image provides an SMTP relay host for emails from within a Kubernetes cluster.

Configure this container to use an upstream authenticated SMTP relay like SendGrid or your ISP's mail server, and provide an
open relay service to your cluster. This means you don't have to configure all of your containerised services with email auth secrets.

## Config

This image supports the following enironment variables. All are **required**.


| Variable                   | Use                                                                 | Example                   |
|----------------------------|---------------------------------------------------------------------|---------------------------|
| `SMTP_RELAY_HOST`          | Hostname of upstream SMTP relay server                              | `[smtp.sendgrid.net]:587` |
| `SMTP_RELAY_USERNAME`      | Username for upstream SMTP relay server                             | `apikey`                  |
| `SMTP_RELAY_PASSWORD`      | Password for upstream SMTP relay server                             | `pAsSwOrD`                |
| `SMTP_RELAY_MYHOSTNAME`    | Hostname of this SMTP relay                                         | `smtp-relay.yourhost.com` |
| `SMTP_RELAY_MYNETWORKS`    | Comma-separated list of local networks that can use this SMTP relay | `127.0.0.0/8,10.0.0.0/8`  |
| `SMTP_RELAY_WRAPPERMODE`   | Request postfix connects using SUBMISSIONS/SMTPS protocol instead of STARTTLS | `no`            |
| `SMTP_TLS_SECURITY_LEVEL`  | default SMTP TLS security level for the Postfix SMTP client         | `""`                      |
| `SMTP_USE_TLS`             | whether or not to use TLS, can be one of `yes`, `no`                | `yes`                     |

# Quickstart

Run on docker

```
docker run --rm -it -p 2525:25 \
	-e SMTP_RELAY_HOST="[smtp.gmail.com]:587" \
	-e SMTP_RELAY_MYHOSTNAME=smtp.gmail.local \
	-e SMTP_RELAY_USERNAME=lognset@gmail.com \
	-e SMTP_RELAY_PASSWORD="your_password" \
	-e SMTP_RELAY_MYNETWORKS=127.0.0.0/8,10.0.0.0/8,192.0.0.0/8 \
	-e SMTP_RELAY_WRAPPERMODE=no \
	-e SMTP_TLS_SECURITY_LEVEL="" \
	-e SMTP_USE_TLS="yes" \
	lognseth/smtp-relay
```

## Send a test message

First run `telnet localhost 2525`

You can then run the following command, just make sure to set the email address correctly:

```
helo localhost
mail from: your_email@gmail.com
rcpt to: your_recipient@domain.com
data
Subject: Moin
Is what they say in the North instead of Servus, in Norway the equivelant would be Morn
.
quit

```
