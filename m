From: Ross Boylan <RossBoylan@stanfordalumni.org>
Subject: Update on problems with UPS
Date: Thu, 20 Feb 2003 22:32:20 -0800
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20030221063220.GF5567@wheat.boylan.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Ross Boylan <RossBoylan@stanfordalumni.org>

I wrote a few weeks ago about some problems using an APC UPS with the
serial port.

I've made some progress, but things are still not quite working right.

Originally, I got "LSR safety check engaged" on ttyS1 where the APC
was connected.  This went away when I disabled COM1 (aka ttyS0) in
BIOS, since I no longer use it.  However, I am still sharing an IRQ
between ttyS2 (from my ISA modem card) and the parallel printer.

It's not clear the sharing is causing trouble--both seem to be working
OK.  Does anyone know if it's a problem?

At any rate, it is puzzling to me that I can't control the IRQ for the
modem.  Only COM1/2 are configurable from BIOS.  I can also control
the parallel port from the BIOS, and I though putting it to IRQ5 would
force COM3 elsewhere.  It doesn't seem to.  I can reprogram the modem
through isapnp, but unless I put it to the IRQ 5 that ttyS2 gets on
startup, it doesn't work.  (Some people suggested the card might be
set through jumpers, but it's not).  I've also tried restarting after
reprogramming the modem, in hopes the new IRQ would stick, but it
doesn't.

Can anyone clarify what is going on with COM3?  I thought the modem
serial port was actually part of the card, and that reseting the card
through pnp would change the modem and the serial port.  The behavior
I'm seeing looks more like the serial port and the modem are distinct
devices, and pnp only affects the modem.  (My other theory is that pnp
affects both, but the serial driver doesn't know what's going on if I
move the location after startup.  This would also explain why the
modem doesn't work after I move the IRQ, but I thought I understood
someone on this list saying the serial driver could cope with such
moves.) 


On the original problem with the UPS, there is progress too.  It is no
longer disabled by the system.  I believe the cause is the the apcupsd
demon can now talk to the port, and puts more appropriate values out
to it.

Things aren't quite right at this level either, because the demon is
not responding, or responding properly, to power out signals.  I have
not yet had time to triple check my configuration settings for the
software; they might be off.  Or the software may not be quite right
for the cable I have, which has a slightly different model number than
any listed in the apcupsd software description.

Thanks for taking the time to read this.  If you have any thoughts,
answers or suggestions, I'd love to hear them.
