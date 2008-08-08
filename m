From: "Kohne, Mike" <mike.kohne@gilbarco.com>
Subject: RE: 8250 misses interrupt, stalls
Date: Fri, 8 Aug 2008 05:36:58 -0700
Message-ID: <BD6105C44DDDF84AB07C23F6A35AE54E01E99F6D@dhrseasvxb03.messaging.danaherad.com>
References: <20080808052727.GB23330@blorp.plorb.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from dhreinsvgw02.danahermail.com ([193.221.156.38]:4097 "EHLO
	dhreinsvgw02.danahermail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750939AbYHHNH4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 8 Aug 2008 09:07:56 -0400
Content-class: urn:content-classes:message
In-Reply-To: <20080808052727.GB23330@blorp.plorb.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jeff DeFouw <jeffd@i2k.com>, linux-serial@vger.kernel.org

I have a system (single core CPU, Winbond 83627HF, but with extra serial
ports provided by a SCH3116 - another superio chip). In my box, the
extra serial ports refuse to work (I never see interrupts) when I use
SMP kernels. If I rebuild the kernel without SMP, my serial ports work
fine. I've never gotten a sufficient explaination as to why turning on
an SMP kernel would screw up these serial ports. We don't have the heavy
(continuous) use that you do, so we would never have noticed the kind of
errors you see.

Now obviously there's a wide difference between my behavior (they never
work) and yours (they work for a while), but you might want to try
building a non-SMP kernel (I took the distributed kernel config as my
starting point, and just turned off SMP using make menuconfig). 

I'd be interested to know if this had any effect on your problem. 

Good luck!

-----Original Message-----
From: linux-serial-owner@vger.kernel.org
[mailto:linux-serial-owner@vger.kernel.org] On Behalf Of Jeff DeFouw
Sent: Friday, August 08, 2008 1:27 AM
To: linux-serial@vger.kernel.org
Subject: 8250 misses interrupt, stalls

I have a Celeron ETX processor module with a Winbond W83627HF SuperIO
chip, providing two 16550A compatible UARTs, which connects over LPC to
an 82801DB south bridge.  I'm only using the first serial port at the
moment.  The modules 8250 and 8250_pnp are loaded, and the serial port
is on standard resources (irq 4).  After one of my complex applications
at work runs for a few minutes, the serial port suddenly stops.  The
UART IIR indicates an interrupt is pending, and the LSR indicates data
is waiting to be received (as well as sent), but the interrupt handler
is not being called.  If while it's stuck I reset the enabled interrupts
(save IER, clear IER, restore IER) the I/O resumes.  I don't see
anything wrong with the way the UART is being serviced.  The kernel is
patched to 2.6.25.11, configured by Debian as SMP, no PREEMPT, shared
IRQ (nothing else is on irq 4) and without any external modules loaded.

It's a Celeron without any HT or multiple cores, so it's uniprocessor.  
I haven't been able to make a simple test case.  The real program is
kind of a loopback that's continuously receiving and sending data at
115200 8N1 with no flow control.  The full data rate isn't being used,
and I'm not getting any overruns (until it stalls).  A simple loopback
program doesn't demonstrate the problem, but the real application runs
into it every time within 10 minutes (usually under 5).

--
Jeff DeFouw <jeffd@i2k.com>
--
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
