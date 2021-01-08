# Description of the practical assignment

Below are the assignment described in the form of a description of the ACME AB's IT strategist, Brumund Dal.

Hello!
We are in need of a new server environment where we can handle our DNS servers and the operations of our web applications.

## Web servers

In the DMZ we need to serve two different web sites

- The first web site runs on a Apache web server with support for PHP and will be hosting a Wordpress (latest version) installation(this requires mySQL or mariaDB as a database server also installed on the same instance). To show proof of concept just install a fresh Wordpress installation on the server showing that the server is correct configured. OBS! Use strong passwords for both the database server and the Wordpress installation. The Apache web server will be exposed to the public web!
- The second web site is running on Node.js instances. This web site have higher traffic rate and must be able to scale with a load balancer. We want to use Nginx to handle this. So install a Nginx as a load balancer and two Node.js instances behind with the same Node.js (LTS version) application installed. To show us it will work you should use some kind of template application that shows that the server and application is running correctly (Hint - see bash scripting video). The application running on this instances will be a stateless application meaning that no sessions is needed to be handled.

The web servers should listen to the standard port(s).

## DNS service

You must be able to access the sites for the outside with the help of the below URLs.

- acmea.xx222xx-1dv031.devopslab.xyz (PHP, Wordpress)
- acmeb.xx222xx-1dv031.devopslab.xyz (Node.js, Express-template)

To be able to handle the domain name we also need to have DNS management. You should set up two name servers, one primary and one secondary, to be authoritative for the zone xx222xx-1dv031.devopslab.xyz. When you are ready to be delegated the control for the zone you will "buy" the domain name and register your name servers from DNS Manager. Log in with the same credentials as you have at our CS Cloud. When logged in you can register your name servers, if you get an error look at the error messaged and fix your name servers and try again.

Please note that xx222xx should be replaced by your LNU username

Web Servers and DNS servers should be in our own DMZ network.

## Requirements of the assignment

- The network structure should of course work meaning
  - The DNS servers are correctly configuring meaning that the domain names acmea.xx222xx-1dv031.devopslab.xyz and acmeb.xx222xx-1dv031.devopslab.xyz is pointing to the web servers described above
  - The web servers is correctly installed and listening for HTTP requests
  - The load balancer is balancing the traffic between the two Node.js instances
  - The applications on the web servers is correctly installed and working as intended
- There be some shell scripts handling part of the work:
  - Installation and configuration of the load balancer (adding the configuration file though code)
    Installation and configuration of Apache and PHP
  - Downloading and installation of the latest Wordpress
  - Downloading and installation of the Node.js Applications
