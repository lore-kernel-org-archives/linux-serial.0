From: "Riley Williams" <Riley@Williams.Name>
Subject: Re: Serious problem with MAKEDEV and setserial command
Date: Tue, 6 May 2003 22:08:55 +0100
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <BKEGKPICNAKILKJKMHCAOENKCKAA.Riley@Williams.Name>
References: <3EB6C131.9090109@gniinc.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from murphys.services.quay.plus.net ([212.159.14.225]:52389 "HELO
	murphys.services.quay.plus.net") by vger.kernel.org with SMTP
	id S261950AbTEFUzz (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 6 May 2003 16:55:55 -0400
In-reply-to: <3EB6C131.9090109@gniinc.net>
List-Id: linux-serial@vger.kernel.org
To: Samuel Jobin <sjobin@gniinc.net>, linux-serial@vger.kernel.org

Hi Sam.

 > I have a serious problem with the MAKEDEV and setserial command.
 > I'm trying to put a lots of multi-modem card into a standard Linux
 > PC (Slackware 8.1). I have to associate the modem by myself with
 > the setserial command. For this, I do:
 >
 > setserial /dev/ttyS20 irq 10 port 0xd000 ^auto_irq ^fourport \
 >	skip_test autoconfig
 >
 > Everything works fine. The problem is that there's no enough ttyS.
 > On my Linux box, I have ttyS1 to ttyS31, but I want more of them.

It's possible that your MAKEDEV hasn't been taught how to create more
than 32 serial ports. The following commands should in theory create
all the valid ttyS ports, according to the devices.txt in the current
kernels...

    cd /dev
    rm -f ttyS*
    for N in `seq 0 191` ; do mknod ttyS${N} c 4 $[${N}+64] ; done
    chown uucp. ttyS*

...and watch the type of brackets on the third line as they do matter.

 > I tried the /dev/MAKEDEV command (and I changed the group for uucp). 
 > The new dev was created (ttyS32).  I tried to make a setserial 
 > it and I got:

As stated above, it's quite possible that your MAKEDEV doesn't know
how to do this as few systems have that many serial ports.

Best wishes from Riley.
---
 * Nothing as pretty as a smile, nothing as ugly as a frown.

---
Outgoing mail is certified Virus Free.
Checked by AVG anti-virus system (http://www.grisoft.com).
Version: 6.0.476 / Virus Database: 273 - Release Date: 24-Apr-2003

