From: "Kohne, Mike" <mike.kohne@gilbarco.com>
Subject: RE: Problems with serial hardware under newer kernels
Date: Wed, 30 Jan 2008 17:49:16 -0800
Message-ID: <BD6105C44DDDF84AB07C23F6A35AE54E017398C6@dhrseasvxb03.messaging.danaherad.com>
References: <BD6105C44DDDF84AB07C23F6A35AE54E0170A3C4@dhrseasvxb03.messaging.danaherad.com> <B1F576FE19C55C43B8D2E31F061B50C04E60E9@exchange.comtrol.com> <BD6105C44DDDF84AB07C23F6A35AE54E0170A6B6@dhrseasvxb03.messaging.danaherad.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from dhreinsvgw02.danahermail.com ([193.221.156.38]:4660 "EHLO
	dhreinsvgw02.danahermail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752996AbYAaBtW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 30 Jan 2008 20:49:22 -0500
Received: from dhreinsvxf01.messaging.danaherad.com (unknown [172.29.216.75])
	by dhreinsvgw02.danahermail.com (BorderWare MXtreme Mail Firewall) with ESMTP id 85C55F6BVC
	for <linux-serial@vger.kernel.org>; Thu, 31 Jan 2008 02:47:27 +0100 (CET)
Content-class: urn:content-classes:message
In-Reply-To: <BD6105C44DDDF84AB07C23F6A35AE54E0170A6B6@dhrseasvxb03.messaging.danaherad.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

I'm following up my own message here, with the 'solution' I've found to
my problem.

Basically, I did recompiles of various kernels under various conditions
and finally came the conclusion that the issue has to do with SMP. If I
turn SMP on for my kernel, the serial ports will NOT work (as described
below). If turn SMP off, they will work fine. 

The motherboard is a single processor and the CPU has but one core. So
something that is turned on by the activation of SMP is killing my
serial ports. 

If anyone can give me any idea what's going on, I'd appreciate it - I
can certainly build kernels without SMP, but I'd like to understand why
I need to.

Thanks!


-----Original Message-----
From: linux-serial-owner@vger.kernel.org
[mailto:linux-serial-owner@vger.kernel.org]On Behalf Of Kohne, Mike
Sent: Sunday, January 27, 2008 20:41
To: linux-serial@vger.kernel.org
Subject: Problems with serial hardware under newer kernels


OK, it's been a few years, but I'm back to fooling with serial ports
again.
Our system runs on a semi-customized box from Advantec. Motherboard is
PCM9380, extra serial ports are on an Advantec board based on the
SCH3116 (an I/O chip from SMSC) (I have no docs on this board yet, I
just opened up the case and had a look). This chip provides a number of
functions, but the only one we seem to use it for is extra serial ports.
They show up as NS16550 at various addresss:
0x3E8/IRQ7
0x2E8/IRQ7
0x3E0/IRQ7
0x2E0/IRQ7
0x4E8/IRQ7
 
Various setserial commands are issued by a file in rcN.d to get the
ports properly configured at startup.
 
Now this board was originally developed while we were still using Fedora
Core 1 as our base system, and all ports work just fine under FC1
(that's kernel 2.4.22). 
I fired the whole thing up under Ubuntu 7.04 and no love - none of the
ports work (as in, I can't get them to transmit bytes). If I play around
with the setserial commands and set the IRQs to 0 instead of 7, I can
get bytes to flow, but it's obvious from the timing that the port
interrupts aren't being obeyed. Changing the selected interrupt in the
BIOS (to 3,4, or 5, for instance, making sure that nothing is using the
selected interrupt) has no effect.
 
Now, I did some playing around with various distros that I had on hand
and found that Fedora Core 4 works (kernel 2.6.11) and that Fedora Core
5 doesn't (kernel 2.6.15). 
 
I did check the config files on the default kernels and IRQ sharing IS
turned on. I also tested with all but one port of the serial card
disabled in the BIOS.
 
I'm presently setting up a system where I can do kernel builds (the
system with the serial ports has very limited disk space, and thus can't
do a build). As soon as I get that setup, I will grab the 2.6.13 tarball
from kernel.org and start trying to figure out exactly what changes are
killing me.
 
In the meantime, does anyone have any good ideas where I ought to be
looking? Obviously there is something wierd about our serial board that
the latest kernels don't like. I believe it must have something to do
with the interrupt routing, but I don't have the foggiest clue where
it's all going south. I'm trying to get in touch with our contacts at
the manufacturer to see if they know what's up, but I'm not sure how
fast they'll be able to figure it out either.
 
Any suggestions for directions to look in would be greatfully accepted.
 
Thanks! 
 
Michael Kohne
Gilbarco Veeder-Root
336-510-4372
Mike.Kohne@gilbarco.com

This message (including any attachments) contains confidential and/or
proprietary information intended only for the addressee.  
Any unauthorized disclosure, copying, distribution or reliance on the
contents of this information is strictly prohibited and may constitute a
violation of law.  If you are not the intended recipient, please notify
the sender immediately by responding to this e-mail, and delete the
message from your system.  If you have any questions about this e-mail
please notify the sender immediately.
-
To unsubscribe from this list: send the line "unsubscribe linux-serial"
in the body of a message to majordomo@vger.kernel.org More majordomo
info at  http://vger.kernel.org/majordomo-info.html
-
To unsubscribe from this list: send the line "unsubscribe linux-serial"
in the body of a message to majordomo@vger.kernel.org More majordomo
info at  http://vger.kernel.org/majordomo-info.html


This message (including any attachments) contains confidential and/or
proprietary information intended only for the addressee.  
Any unauthorized disclosure, copying, distribution or reliance on the
contents of this information is strictly prohibited and may constitute a
violation of law.  If you are not the intended recipient, please notify
the sender immediately by responding to this e-mail, and delete the
message from your system.  If you have any questions about this e-mail
please notify the sender immediately.
-
To unsubscribe from this list: send the line "unsubscribe linux-serial"
in the body of a message to majordomo@vger.kernel.org More majordomo
info at  http://vger.kernel.org/majordomo-info.html


This message (including any attachments) contains confidential 
and/or proprietary information intended only for the addressee.  
Any unauthorized disclosure, copying, distribution or reliance on 
the contents of this information is strictly prohibited and may 
constitute a violation of law.  If you are not the intended 
recipient, please notify the sender immediately by responding to 
this e-mail, and delete the message from your system.  If you 
have any questions about this e-mail please notify the sender 
immediately.
