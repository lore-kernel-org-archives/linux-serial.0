From: whitnl73@juno.com
Subject: Re: RS485 communicatio
Date: Thu, 13 Mar 2003 19:05:14 -0500 (EST)
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20030313.222518.8.0.whitnl73@juno.com>
References: <20030313061505.5944.qmail@indiainfo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20030313061505.5944.qmail@indiainfo.com>
List-Id: linux-serial@vger.kernel.org
To: linuxppp@indiainfo.com
Cc: linux-serial@vger.kernel.org

|
| Hi all,
| am currently working on PPP over serial interface (RS485) in linux
| 2.4.2-2. I believe RS485 half duplex system and hence only one can
| transmit at a time. And for RS485 we basicaly use Master-Slave or
| Primary-Secondary kind of communication. I don't know how to achieve
| the same using PPP since i need to have max of 10 nodes connected via
| serial interface. I tested with two nodes using PPP daemon it works
| fine. Following are the commands i issued
|
| In PPP server:
| $usr/sbin/pppd -detach crtscts 10.10.10.100:10.10.10.101 115200
| /dev/ttyS0 &
|
| In PPP client side :
| $/usr/sbin/pppd call ppp-start
| where ppp-start file is copied into directory /etc/ppp/peers/ that had
| the following
|
| -detach /dev/ttyS0 115200 crtscts
| noauth
|
| This point to point communication worked fine with RS485 interface. If
| i had to connect one more node what i need to do. Please clarify with
| the following
|
| i) Whether the existing pppd takes care of the RS485 with multi node ,
| if so how do i manage giving commands

AFAIK there is no usable protocol for multidtop serial lines.  Ring ten
times for system a, 9 got system b...

| ii) If there is no direct support how do i go ahead. Is there any other
| layer 2 protocol allows me to acheive TCP/IP communicattion over RS485
| which is my ultimatum.

Use a separate serial line between each pair of nodes, or make one a
sort of hub and run a line from it to each other node?
|
| I will be grateful if anybody of them could help me with my current
| problem.
|
| Thanx in advance.
|
| Karthik
|
| --

Lawson
--
---oops---



________________________________________________________________
Sign Up for Juno Platinum Internet Access Today
Only $9.95 per month!
Visit www.juno.com
