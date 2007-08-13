From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH, RFC] wake up from a serial port
Date: Mon, 13 Aug 2007 15:50:33 -0500
Message-ID: <46C0C419.6060009@freescale.com>
References: <Pine.LNX.4.60.0708130015430.3895@poirot.grange> <20070813155734.GB17535@ld0162-tx32.am.freescale.net> <Pine.LNX.4.60.0708132207530.5643@poirot.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from de01egw02.freescale.net ([192.88.165.103]:58551 "EHLO
	de01egw02.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030214AbXHMUut (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 13 Aug 2007 16:50:49 -0400
In-Reply-To: <Pine.LNX.4.60.0708132207530.5643@poirot.grange>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-serial@vger.kernel.org, linuxppc-dev@ozlabs.org, Greg KH <greg@kroah.com>

Guennadi Liakhovetski wrote:
> Well, sort of. One of them is more "natural" - it has a button on the 
> front panel, to use the other one you have to modify the hardware. 
> However, I like the idea - generally it does seem to be a better approach 
> to have it run-time configurable over sysfs... Only - how? The only 
> differentitaion ATM between the two ports are these two links:
> 
> # ls -l /sys/devices/platform/serial8250.0/tty*
> lrwxrwxrwx 1 root root 0 Aug 13 22:05 /sys/devices/platform/serial8250.0/tty:ttyS0 -> ../../../class/tty/ttyS0
> lrwxrwxrwx 1 root root 0 Aug 13 22:05 /sys/devices/platform/serial8250.0/tty:ttyS1 -> ../../../class/tty/ttyS1
> 
> And placing some wakeup file under the class/tty/ directory doesn't seem 
> very consistent with the current policy - until now they only live under 
> devices/... (Greg added to cc:).

Hmm... I'd assumed each port would have its own device directory.  Would 
anything break horribly if it were changed so that each tty:ttySx is a 
directory, which contains both a wakeup file and the symlink?

> Actually, it is good you replied, Scott:-) I wanted to ask you about the 
> following: I've switched to your generic suspend/resume routines using the 
> _TLF_NAPPING bit, the arch_suspend_{dis,en}able_irqs() hooks... On wakeup 
> your _TLF_NAPPING trick should bypass calling the ISR and jump directly to 
> the resume code. However, on wakeup, it looks like I do get the wakeup 
> interrupt too.

You should get the interrupt, but not until after the PM code enables 
IRQs.  Are you saying that the interrupt handler runs before then?

> Is it the correct behaviour and is this the (approximately) 
> correct explanation why:
> 
> 1. the AVR connected to ttyS0 sends 1 byte on button press and 1 byte on 
> button release. So, normally you would get 2 bytes and 2 interupts for one 
> such button down-up.
> 
> 2. Interrupt is configured as edge (is it correct - haven't found in 
> mpc8245um, UARTs are usually edge), so, 
> 
> --- button down -> byte #1 -> IRQ line active -> IC interrupts
> --- on resume interrupts are disabled, an EOI is performed (the line is 
> 	still active)
> --- interrupts are re-enabled 
> 
> 3. a second interrupt for the same byte is delivered.

No EOI is performed -- the idea is to defer the interrupt, not swallow 
it.  All that is done to defer the interrupt is clearing MSR[EE].

-Scott
