From: Nikolay Datchev <nik@varna.net>
Subject: serial port forcing
Date: Mon, 1 Dec 2003 13:18:44 +0200 (EET)
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.33.0312011257140.11314-100000@ns.varna.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ns.varna.net ([195.24.57.1]:29838 "EHLO ns.varna.net")
	by vger.kernel.org with ESMTP id S263364AbTLALSu (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 1 Dec 2003 06:18:50 -0500
Received: from localhost (nik@localhost)
	by ns.varna.net (8.12.10/8.12.9) with ESMTP id hB1BIiIJ003868
	for <linux-serial@vger.kernel.org>; Mon, 1 Dec 2003 13:18:45 +0200
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hello list,

Here is my problem:

I have one linux machine with one 4xserial PCI board, another one 2xserial
PCI board, and one onboard serial port, total 7 ports. After boot-up, only
6 ports appears (setserial -bg /dev/ttyS? shows ttyS0,1,4,5,6,7, same in
cat /proc/tty/driver/serial). 4 to 7 are the four-port board ports, and
they work fine. 0 and 1 are recognized with standart settings - port
0x3f8/0x2f8, irq 4/3, but i'm able to setserial them with the two board
ports settings, and all works fine. It works also if i setserial only one
of the two board ports, and i let ttyS0 with default settings, which makes
onboard port usable. But i need all the 7 ports.

I'm using linux kernel v. 2.4.22, and i get in /proc/tty/driver/serial
only ports, that has been recognized upon boot-up, hense i'm not able to
force using more than 6 ports (setserial /dev/ttySX port Y irq Z where X
is some serial port not appearing in /proc does not result in anything).
With kernel 2.4.18, i got up to 64 ports in /proc, but those not
recognized in the boot-time has unknown uart and fake recources.

How can i make all 7 ports usable ? In other words, how to force another
serial port recognition ? Kernel downgrade is not an option.

Thanks in advance.

-- Nikolay Datchev

