From: Nikolay Datchev <nik@varna.net>
Subject: hard to short-describe problem
Date: Fri, 5 Dec 2003 12:28:44 +0200 (EET)
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.33.0312051156550.16713-100000@ns.varna.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ns.varna.net ([195.24.57.1]:59859 "EHLO ns.varna.net")
	by vger.kernel.org with ESMTP id S263539AbTLEK2u (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 5 Dec 2003 05:28:50 -0500
Received: from localhost (nik@localhost)
	by ns.varna.net (8.12.10/8.12.9) with ESMTP id hB5ASiaF015239
	for <linux-serial@vger.kernel.org>; Fri, 5 Dec 2003 12:28:45 +0200
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hello list,

Here is my problem:

Linux, kernel 2.4.22, 6 serial ports, one 4-port PCI and one 2-port PCI
boards.  Standart modems attached to all the ports. This is a dial-in
server, working with terminal-based login - standart login prompt, and
then the login program sends user/password to other software.

All the ports/modems works, but after few days of using, something strange
happens: there are hang login processes, and huge ammount of data flowing
in both directions via serial port, on which the login process hangs. I
can see the same on modem's LED indicators. If i try to kill the login,
machine locks, and needs hardware reset. I don't know what will happen if
i switch off the power of the modem - i need this machine up and running
for now.

In the kernel log, i have lot of messages like this:

ttyS: 1 input overrun(s)

After searching with google, i've found that people has fixed this
overrun with disabling the IDE IRQ masking, but the IDE on this machine
generates 1 IRQ per minute, and the hard disk drive is totally not in
heavy use. On other hand, this machine has an ethernet interface, which is
under few Mbps load, with pics up to 10 Mbps.

Hardware is P4 2.4 GHz, ethernet is 3c940 (sk98 driver), serial boards
are:

02:0b.0 Seial controller: NetMos Technology 222N-2 I/O card (2S+1P) (rev 01)
02:0d.0 Seial controller: Oxford Semiconductor Ltd 0X16PCI954 (Quad 16950 UART) function 0

Seems that the problem with the login process hang and serial overruns are
two different problems.

Distribution is Slackware 9.0, i'm using uugetty to init and control the
serial ports.

This scheme has worked for years, but with slower PC, ISA serial boards,
older Linux distro (slackware 7.0) and same ethernet load. It never has
serial overruns (well, couple of overruns for 400 days uptime doesn't
matter).

Please help (no kernel modifications were made, this is the stock 2.4.22)

-- Nikolay Datchev

