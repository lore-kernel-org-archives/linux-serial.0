From: rich+ml@lclogic.com
Subject: Re: Serial/Parallel conflicts
Date: Fri, 31 Jan 2003 14:34:54 -0800 (PST)
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0301311352280.5171-100000@deadrat.localdomain>
References: <20030131055640.GA763@wheat.boylan.org>
Reply-To: rich+ml@lclogic.com
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20030131055640.GA763@wheat.boylan.org>
List-Id: linux-serial@vger.kernel.org
To: Ross Boylan <RossBoylan@stanfordalumni.org>
Cc: linux-serial@vger.kernel.org

Possibly the modem is static ISA, i.e. has jumpers for port and irq? If so
then PNP can find it but can't change it, the only software solution is to
disable COM1 ('setserial /dev/ttyS0 uart none') to avoid IRQ 4 contention.

== Rich

On Thu, 30 Jan 2003, Ross Boylan wrote:

> Date: Thu, 30 Jan 2003 21:56:40 -0800
> From: Ross Boylan <RossBoylan@stanfordalumni.org>
> To: rich+ml@lclogic.com
> Cc: Ross Boylan <RossBoylan@stanfordalumni.org>, linux-serial@vger.kernel.org
> Subject: Re: Serial/Parallel conflicts
> 
> This is kind of a "please tell me it isn't so message."  
> My efforts to dislodge ttyS2 (aka COM3, my internal modem) from IRQ 5
> have been unsuccessful.  The BIOS offers no direct control over it,
> since it is not a built in serial port.
> 
> In particular, neither of the following worked, even with reboots:
> 1. reprogramming the card via /proc/isapnp.  If I set the IRQ to a
> value other than shown in the dmesg start up, I can't communicate with
> the modem at all.  This doesn't make any sense to me, since the serial
> port is actually part of the card (as I understand it), and presumably
> is reprogrammed by isapnp.
> 
> Is the problem that the serial driver can not adjust to changes in
> port locations after start up?
> 
> 2. I set the BIOS manually to use IRQ 5 for the parallel port.  I
> thought this would force it to put ttyS2 elsewhere, but it doesn't
> seem to.  The good news is that both the modem and the parallel port
> appear to work sharing the same interrupt, so I may have symptomatic
> relief.
> 
> 3. I also disabled COM1 in BIOS, hoping to get the system to use the
> newly availabe interrupt.  It put one of the ethernet cards there
> (IRQ4).
> 
> Anyway, please tell me this info isn't just buried in the ESCD with no
> way to kick it out short of flashing the whole thing!  Isn't there
> some other way to influence it?  Is the full story "ECSD sets
> location; serial driver reads it; nothing changes it"?
> 
> 
> On Wed, Jan 29, 2003 at 02:13:23PM -0800, rich+ml@lclogic.com wrote:
> > Hi, bios does indeed save state, "non-pnp os" means that the bios itself
> > should do the pnp setup because the os won't. It stores card info in the
> > 'ESCD'.
> > 
> > AMI should do the right thing on auto, however if you go manual and cause
> > it to generate a broken ESCD, I'm not sure that restoration to 'auto' will
> > necessarily cause it to be fixed. Maybe something like "restore factory 
> > defaults" (but write down current settings first :) 
> > 
> > According to serial.c, "LSR safety check engaged" means that driver tried
> > to reset the line status register but read back an 0xFF. Shouldn't be
> > possible with real uart, so presumably it's a winmodem or broken FPGA core
> > or whatever. There's certainly SOMETHING there or bios wouldn't have 
> > autodetected it.
> > 
> > HTH == Rich
> > 
> > On Wed, 29 Jan 2003, Ross Boylan wrote:
> > 
> > > Date: Wed, 29 Jan 2003 09:07:50 -0800
> > > From: Ross Boylan <RossBoylan@stanfordalumni.org>
> > > To: linux-serial@vger.kernel.org
> > > Cc: Ross Boylan <RossBoylan@stanfordalumni.org>
> > > Subject: Serial/Parallel conflicts
> > > 
> > > I've had some success with the problems reported earlier, but seem to
> > > have created a new problem.
> > > 
> > > I went into the BIOS and changed the settings for the serial ports
> > > from "AUTO" to 
> > > Port A: 3f8/com1
> > > Port B: 2f8/com2
> > > My hope was that by setting COM2 to 2f8 explicitly I would get rid of
> > > the "LSR safety check" warning on ttyS1.
> > > 
> > > As a result, the messages when I started up went from:
> > > Jan 19 10:30:05 wheat kernel: ttyS00 at 0x03f8 (irq = 4) is a 16550A
> > > Jan 19 10:30:05 wheat kernel: ttyS02 at 0x03e8 (irq = 4) is a 16550A
> > > Jan 19 10:30:05 wheat kernel: ttyS01 at port 0x02f8 (irq = 3) is a 16550A
> > > 
> > > to:
> > > Jan 29 05:47:49 wheat kernel: ttyS00 at 0x03f8 (irq = 4) is a 16550A
> > > Jan 29 05:47:49 wheat kernel: ttyS01 at 0x02f8 (irq = 3) is a 16550A
> > > Jan 29 05:47:49 wheat kernel: ttyS02 at port 0x03e8 (irq = 5) is a 16550A
> > > and I no longer got the "LSR safety check engaged" message.  (Note
> > > also the change in order of the reports).
> > > 
> > > Unfortunately, my parallel port stopped working:
> > > Jan 29 08:45:12 wheat kernel: lp: driver loaded but no devices found
> > > 
> > > 
> > > I notice that if I do not pick auto for the parallel port, I am given
> > > a manual choice of IRQ 5 or 7 for it.  7 is used by my soundcard, and
> > > as noted above, 5 is being used by ttyS02 (modem).
> > > 
> > > I set my BIOS back to AUTO for all ports, but I still see the second
> > > configuration reported above.  This has not reverted things to their
> > > previous state.  I can think of 3 possible reasons:
> > > 1. the hardware is saving state
> > > 2. the hardware is saving state because I rebooted without powering
> > > off
> > > 3. Linux is saving state.
> > > 
> > > So I have several questions.
> > > What is going on?
> > > How can I get my printer (LPT1) back?
> > > Is there any way I can make all my devices happy (i.e, no LSR safety
> > > check for the serial ports and working parallel port)?
> > > 
> > > I have an AMIBIOS with a setting of "Non-PNP OS".  2.4.19 kernel.
> > > 
> > > Thanks.
> > > -
> > > To unsubscribe from this list: send the line "unsubscribe linux-serial" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > 
> > 
> > 
> > 
> 

