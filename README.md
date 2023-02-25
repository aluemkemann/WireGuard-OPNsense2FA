WireGuard-OPN2FA
WireGuard VPN on OPNsense 2nd-Factor-Authentication 

Multi factor authentication is indispensible, OpenVPN uses 
passwords, certificates and OTP. Unfortunately, WireGuard lacks 
any additional auth methods. 

This approach combines OPNsense user passwords with OTP 
tokens through the captive function that was meant for securing
wireless networks.

Hotspots allow clients to connect, but block any routing unless 
the client authenticated, registered, accepted terms of use, 
Data protection guidelines or some other BS. They often intercept
and then redirect DNS queries to force clients to open the login
page. This practice has several downsides. Operating systems,
browsers or security software defend against this practice.
With DNS over HTTPS becoming more and more ubiquitous, this
approach is going to stop functioning in the near future.

This implementation allows WireGuard clients to connect as well,
but unless user authenticated with username, password and OTP 
token it blocks all other network access. 
Overcoming questionable DNS forging, we use a powershell script 
to interact with the OPNsense authentication. Right now the 
script is tested on Windows (10,11) and Linux with PowerShell 
Core - didn't try OSX yet but don't see why it shouldnt work.

The configuration of several services on your OPNsense and 
several firewall rules are needed to complete the server side 
setup. Until I find the time to doc it, look at Sunnyvalley's 
Captive Portal tutorial under (1).

The procedure is as follows:
- WireGuard setup (local IP 10.0.0.1/24)
- Firewall: don't add too many rules yet; I emphasize not to use 
floating rules as they reduce granularity
- NAT is APITA for UDP, go for routed setup, so change NAT to manual
or hybrid
-- add local users on OPNsense, create OTP seeds, pair authenticator 
app on smartphone
- Unbound DNS setup
-- add A Record for OPNsense name and WireGuard interface IP 
(wireguard.example.tld -> 10.0.0.1) 
-- forward local / split-DNS Domains to their respective DNS 
servers
-- add DNS of OPNsense in WireGuard config file on client
(easier then adding all DNS Servers in client config)

Links:
(1) https://www.sunnyvalley.io/docs/network-security-tutorials/how-to-configure-captive-portal-on-opnsense
