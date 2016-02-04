From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: Data corruption on serial interface under load
Date: Thu, 4 Feb 2016 23:15:28 +0000
Message-ID: <20160204231528.GI10826@n2100.arm.linux.org.uk>
References: <CAHp75VehshCyAjKiOyB26zkeu4WUar9-z-XfFNLuchc0swyvSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHp75VehshCyAjKiOyB26zkeu4WUar9-z-XfFNLuchc0swyvSQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Peter Hurley <peter@hurleysoftware.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Thu, Feb 04, 2016 at 08:55:48PM +0200, Andy Shevchenko wrote:
> Hi!
> 
> Today I observed interesting bug / feature of uart layer in the kernel.
> I do have a setup which connects two identical devices by serial line.
> I run data transferring in one direction and got data corruption on
> receiver side (in uart layer, not the driver).
> 
> Here is the dump from test suite and real data from 8250 registers:
> 
> === 8< ===
> 
> Needed 16 reads 0 writes Oh oh, inconsistency at pos 1 (0x1).
> 
> Original sample:
> 00000000: 7f 45 4c 46 01 01 01 00  00 00 00 00 00 00 00 00   .ELF............
> 00000010: 02 00 03 00 01 00 00 00  19 8d 04 08 34 00 00 00   ............4...
> 00000020: 2c f2 00 00 00 00 00 00  34 00 20 00 04 00 28 00   ,.......4. ...(.
> 
> Received sample:
> 00000000: 7f 00 45 00 4c 00 46 00  01 00 01 00 01 00 00 00   ..E.L.F.........
> 00000010: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00   ................
> 00000020: 02 00 00 00 03 00 00 00  01 00 00 00 00 19 8d 04   ................
> loops 1 / 1
> 
> cts: 0 dsr: 0 rng: 0 dcd: 0 rx: 53434 tx: 0 frame 0 ovr 34201 par: 0
> brk: 0 buf_ovrr: 0
> 
> === 8< ===
> 
> R 356.360109 IIR 0xc4
> R 356.360114 LSR 0x63
> R 356.360119 RX 0x7f

I think the obvious question here is: why is your serial port reporting
overrun errors in loopback mode.

If you have no flow control, I suspect this is likely to happen: if we
try to fill the Tx FIFO, we won't be servicing the port trying to receive
characters.

So if (eg) the port already contains 12 characters in the RX FIFO, and
we load up a full complement of characters into the TX FIFO, the port
will transmit them to the RX side.  As we will not be reading the RX
side (as we're busy loading the TX side), if we fill the RX FIFO, you'll
then get overruns.

Even so, with a dumb 8250 based UART, there's no hardware assisted flow
control, so it's never going to be particularly reliable.  More modern
UARTs have realised this, and have implemented hardware (and software)
flow control mechanisms in hardware to reduce the chances of overruns.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
