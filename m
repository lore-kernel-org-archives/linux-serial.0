From: whitnl73@juno.com
Subject: Re: Serial/Parallel conflicts
Date: Fri, 31 Jan 2003 21:46:52 -0500 (EST)
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20030201.071711.8.0.whitnl73@juno.com>
References: <20030131055640.GA763@wheat.boylan.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20030131055640.GA763@wheat.boylan.org>
List-Id: linux-serial@vger.kernel.org
To: RossBoylan@stanfordalumni.org
Cc: rich+ml@lclogic.com, linux-serial@vger.kernel.org

On Thu, 30 Jan 2003, Ross Boylan wrote:

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

Only if it is an ISA Plug 'N' Pray card.  I have several internal
modems, one has jumpers to set the port and IRQ, the other has switches.
I guess the IRQ for a PCI card would be set by the BIOS, but I don;t
have any hardware that new.
>
> Is the problem that the serial driver can not adjust to changes in
> port locations after start up?

Not so.  The values the serial driver _uses_ (tries to use) can be set
using /bin/setserial at any time.  This has no effect on what the
hardware uses, but it is useful particularly to set the IRQ to some
non-default value so FI com1 and com3 amd/or com2 and com4 don't
conflict.  By default they do.  You have to set the hardware some other
way first - jumpers, isapnptools or the BIOS.
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

Serial driver doesn't read it (unless instructed by system administrator
(setserial <device> <port> auto_irq autoconfig)).  See man setserial.


Lawson

--
---oops---



________________________________________________________________
Sign Up for Juno Platinum Internet Access Today
Only $9.95 per month!
Visit www.juno.com
