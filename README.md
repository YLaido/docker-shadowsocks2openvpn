## Intro
Connect to an openvpn tunnel over a shadowsocks service. The aim is to bridge the traffic between the host and the container via a shadowsocks tunnel.

## Usage
Download this repo
```bash
git clone https://github.com/YLaido/docker-shadowsocks2openvpn
```
Change the shadowsocks config accorrdingly or use the default.
```bash
vi config.json
```
`/your/openvpn/directory` should contain *one* OpenVPN `.conf` file. It can reference other certificate files or key files in the same directory.

```bash
docker build . --tag shadowsocks2openvpn
docker run -d --device=/dev/net/tun --cap-add=NET_ADMIN \
    --name  openvpn-client\
    --volume /your/openvpn/config/directory/:/etc/openvpn/:ro -p <YOUR_SHADOWSOCKS_PORT>:8081 \
    shadowsocks2openvpn
```
Then connect to your shadowsocks server.
