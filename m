From: whitnl73@juno.com
Subject: Re: serial port speeds >115k; PnP modem ID must contain modem substring
Date: Fri, 21 Feb 2003 23:56:00 -0500 (EST)
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20030221.235743.8.0.whitnl73@juno.com>
References: <20030221200939.GA1543@jats9>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20030221200939.GA1543@jats9>
List-Id: linux-serial@vger.kernel.org
To: delt@gate-way.net
Cc: linux-serial@vger.kernel.org

On Fri, 21 Feb 2003, Tim wrote:

> I have a Diamond/Supra v90 ISA modem (model SUP2124) in my
> Linux system running 2.4.20.  I've noticed that for the
> type of file I commonly access (large html text table) 115k
> port speed seems to be a significant bottleneck.  (These
> files compress to <10% of raw size.  Transfer speed is
> reported as ~10.5kByte/s, even if I reduce my modem speed
> from the typical 45kbps to 28.8.)  The modem documentation
> says it is capable of 230k port speed, so I tried specifying
> 230400 in my ppp config, which resulted in 9600 baud port
> speed; stty returns an error.

What error?  Quote exactly please.  If the doco says it can run
faster than 115200, it should also tell what you have to do to make it
do so.  (this may involve setting register(s) in the modem, and will
need in addition a setserial command to set baud_base (the serial
driver's understanding of how to set the divisor for am app (pppd,
FI) that requests a given speed) to get things to work
as you would expect they should).  I think you need to have programmed
one of these things by hand to understand the doco so that you don't
have to, but I don't know how to say it any better.
>
> At this point in my education, my guess is that the modem is
> being treated like a 16550A without extended FIFOs or 230k
> port speed.  If my modem was detected as a modem by Linux,
> would setserial -a show something more?

It was detected as a serial port.  Linux does not detect modems at
startup.  As far as the OS can see, a modem is just a serial port.
As far as the serial driver can see, it is a 16550a with a 16
byte FIFO.  The serial driver can detect more modern UART's such as the
16950, but yours seems to behave as if it were a 16550A.
You need something beyond what the serial driver does by default to get
the thing to run at a port speed >115200, I think.
>
> # setserial -a /dev/ttyS3
> /dev/ttyS3, Line 3, UART: 16550A, Port: 0x02e8, IRQ: 10
>         Baud_base: 115200, close_delay: 50, divisor: 0
>         closing_wait: 3000
>         Flags: spd_normal skip_test
>
...
>
> TIA,
> Tim.
>
Lawson
--
---oops---



________________________________________________________________
Sign Up for Juno Platinum Internet Access Today
Only $9.95 per month!
Visit www.juno.com
