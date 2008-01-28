From: "Kohne, Mike" <mike.kohne@gilbarco.com>
Subject: RE: Problems with serial hardware under newer kernels
Date: Mon, 28 Jan 2008 11:06:26 -0800
Message-ID: <BD6105C44DDDF84AB07C23F6A35AE54E0170A6B6@dhrseasvxb03.messaging.danaherad.com>
References: <BD6105C44DDDF84AB07C23F6A35AE54E0170A3C4@dhrseasvxb03.messaging.danaherad.com> <B1F576FE19C55C43B8D2E31F061B50C04E60E9@exchange.comtrol.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from dhreinsvgw01.danahermail.com ([193.221.156.12]:3400 "EHLO
	dhreinsvgw01.danahermail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751458AbYA1TGb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 28 Jan 2008 14:06:31 -0500
Content-class: urn:content-classes:message
In-Reply-To: <B1F576FE19C55C43B8D2E31F061B50C04E60E9@exchange.comtrol.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Kevin Wilson <Kevin.Wilson@comtrol.com>
Cc: linux-serial@vger.kernel.org

Thanks for the info. 
I think I have a clue on the 'device or resource busy' thing. I believe
that this has something to do with the kernel in general keeping better
track of driver-requested resources. I'm not quite sure what, but I
found that I could not do a setserial to change the ioports on my system
(I wanted them numbered in an order to match the case silk-screen).
What I finally had to do was

setserial /dev/ttyS4 port 0x0 irq 0
setserial /dev/ttyS4 port 0x2E8 irq 7

The setting of the port to 0 seemed to get the kernel to give up
whatever is locked down, and then the second call will work perfectly.

I'll let you know about any further discoveries.

-----Original Message-----
From: linux-serial-owner@vger.kernel.org
[mailto:linux-serial-owner@vger.kernel.org] On Behalf Of Kevin Wilson
Sent: Monday, January 28, 2008 9:23 AM
To: linux-serial@vger.kernel.org
Subject: RE: Problems with serial hardware under newer kernels

We have a similar problem with one of our networked-serial drivers in
psuedo-hdlc mode. The only oddity there is that only device (port/line)
7 always returns "device or resource busy" when issuing "setserial -g
/dev/ttySI*" to check all ports are alive. All the other ports report
back correctly. Since these devices all use a dynamic major, irq is 0
(not set) and sharing is (supposed) to be enabled then something is
blocking it but I haven't found what that item is.

Since yours is not working at all then I would diff your driver against
the likes of isicom.c, stallion.c and/or rocket.c to see some of the
most recent implementation changes. Ours is missing the
alloc_tty_driver(TOTAL_NUM_MINORS) which I will add today to see if it
helps. Maybe our not reserving prior to registering is a no-no and we
have just been lucky up to today. Dunno, I'm not an expert but with a
little hard work maybe someday I will be.

Let me know what your investigation turns up. I have a 2.6.13 kernel
that our driver works with just fine. However, shortly after that
(2.6.20 and on) is when changes in the kernel started to wreak havoc on
our drivers and we have been scrambling since early November to
troubleshoot what changes are affecting our implementation. Partly our
fault for not keeping up with the times but some of the latest breakages
observed with the .21 and later are difficult to track down.

Good luck,

Kevin

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


This message (including any attachments) contains confidential 
and/or proprietary information intended only for the addressee.  
Any unauthorized disclosure, copying, distribution or reliance on 
the contents of this information is strictly prohibited and may 
constitute a violation of law.  If you are not the intended 
recipient, please notify the sender immediately by responding to 
this e-mail, and delete the message from your system.  If you 
have any questions about this e-mail please notify the sender 
immediately.
