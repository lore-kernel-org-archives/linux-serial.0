From: "Linux PPP" <linuxppp@indiainfo.com>
Subject: RS485 communicatio
Date: Thu, 13 Mar 2003 11:45:05 +0530
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20030313061505.5944.qmail@indiainfo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hi all,
am currently working on PPP over serial interface (RS485) in linux 2.4.2-2. I believe RS485 half duplex system and hence only one can transmit at a time. And for RS485 we basicaly use Master-Slave or Primary-Secondary kind of communication. I don't know how to achieve the same using PPP since i need to have max of 10 nodes connected via serial interface. I tested with two nodes using PPP daemon it works fine. Following are the commands i issued

In PPP server: 
$usr/sbin/pppd -detach crtscts 10.10.10.100:10.10.10.101 115200 /dev/ttyS0 &

In PPP client side : 
$/usr/sbin/pppd call ppp-start 
where ppp-start file is copied into directory /etc/ppp/peers/ that had the following

-detach /dev/ttyS0 115200 crtscts
noauth

This point to point communication worked fine with RS485 interface. If i had to connect one more node what i need to do. Please clarify with the following 

i) Whether the existing pppd takes care of the RS485 with multi node , if so how do i manage giving commands
ii) If there is no direct support how do i go ahead. Is there any other layer 2 protocol allows me to acheive TCP/IP communicattion over RS485 which is my ultimatum.

I will be grateful if anybody of them could help me with my current problem.

Thanx in advance.

Karthik

-- 
______________________________________________
http://www.indiainfo.com
Now with POP3/SMTP access for only US$14.95/yr

Powered by Outblaze
