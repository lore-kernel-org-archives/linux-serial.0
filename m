From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: Data corruption on serial interface under load
Date: Fri, 5 Feb 2016 01:09:07 +0000
Message-ID: <20160205010906.GK10826@n2100.arm.linux.org.uk>
References: <CAHp75VehshCyAjKiOyB26zkeu4WUar9-z-XfFNLuchc0swyvSQ@mail.gmail.com>
 <20160204231528.GI10826@n2100.arm.linux.org.uk>
 <CAHp75VfLDbOuLAfaNK8OuZyS4AR3tJUTUC2TNx+HbmEV_zbcZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHp75VfLDbOuLAfaNK8OuZyS4AR3tJUTUC2TNx+HbmEV_zbcZQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Peter Hurley <peter@hurleysoftware.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Fri, Feb 05, 2016 at 01:19:44AM +0200, Andy Shevchenko wrote:
> On Fri, Feb 5, 2016 at 1:15 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Thu, Feb 04, 2016 at 08:55:48PM +0200, Andy Shevchenko wrote:
> >> Hi!
> >>
> >> Today I observed interesting bug / feature of uart layer in the kernel.
> >> I do have a setup which connects two identical devices by serial line.
> >> I run data transferring in one direction and got data corruption on
> >> receiver side (in uart layer, not the driver).
> >>
> >> Here is the dump from test suite and real data from 8250 registers:
> >>
> >> === 8< ===
> >>
> >> Needed 16 reads 0 writes Oh oh, inconsistency at pos 1 (0x1).
> >>
> >> Original sample:
> >> 00000000: 7f 45 4c 46 01 01 01 00  00 00 00 00 00 00 00 00   .ELF............
> >> 00000010: 02 00 03 00 01 00 00 00  19 8d 04 08 34 00 00 00   ............4...
> >> 00000020: 2c f2 00 00 00 00 00 00  34 00 20 00 04 00 28 00   ,.......4. ...(.
> >>
> >> Received sample:
> >> 00000000: 7f 00 45 00 4c 00 46 00  01 00 01 00 01 00 00 00   ..E.L.F.........
> >> 00000010: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00   ................
> >> 00000020: 02 00 00 00 03 00 00 00  01 00 00 00 00 19 8d 04   ................
> >> loops 1 / 1
> >>
> >> cts: 0 dsr: 0 rng: 0 dcd: 0 rx: 53434 tx: 0 frame 0 ovr 34201 par: 0
> >> brk: 0 buf_ovrr: 0
> >>
> >> === 8< ===
> >>
> >> R 356.360109 IIR 0xc4
> >> R 356.360114 LSR 0x63
> >> R 356.360119 RX 0x7f
> >
> > I think the obvious question here is: why is your serial port reporting
> > overrun errors in loopback mode.
> >
> > If you have no flow control, I suspect this is likely to happen: if we
> > try to fill the Tx FIFO, we won't be servicing the port trying to receive
> > characters.
> >
> > So if (eg) the port already contains 12 characters in the RX FIFO, and
> > we load up a full complement of characters into the TX FIFO, the port
> > will transmit them to the RX side.  As we will not be reading the RX
> > side (as we're busy loading the TX side), if we fill the RX FIFO, you'll
> > then get overruns.
> >
> > Even so, with a dumb 8250 based UART, there's no hardware assisted flow
> > control, so it's never going to be particularly reliable.  More modern
> > UARTs have realised this, and have implemented hardware (and software)
> > flow control mechanisms in hardware to reduce the chances of overruns.
> >
> 
> Yeah, above makes sense to me, but that is another issue I'm
> investigating. The issue I complained about is additional '\0'
> characters (seems uart_insert_char() does this).

Firstly, let's establish why this happens.  When an overflow error occurs,
what has happened is that a character was received by the hardware which
it had no room in its receive FIFO, and so the character is discarded.
However, the UART records that act in a flag.

Sensible ports attach the flag to the preceding character so that software
can read the successfully received characters without needing to care for
the overflow.

The Linux behaviour on encountering an overflow condition is to "undo"
the discarding: a NUL character is inserted into the stream which is
marked with a TTY_OVERRUN status.  (Standard Linux behaviour is to mark
the in-error characters with their error status if they are to be
received.)

When in-band error reporting to the application is disabled, this appears
as a plain NUL character.

I think the issue here is "if they are to be received".  If you have
cleared IGNBRK, break characters will be reported as NUL character.  If
IGNPAR is clear, a character with incorrect parity could be reported to
the application as a NUL character (it depends on other settings.)

Overflow is not covered in the standard termios modes, and it's been
standard Linux behaviour to pass these through unless both IGNPAR and
IGNBRK are set.

cfmakeraw clears IGNPAR, which means it's not in "real raw" mode.  If
you want to ignore parity, break, framing and overflow errors in the
resulting byte stream, you need to ensure IGNPAR and IGNBRK are both
set.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
