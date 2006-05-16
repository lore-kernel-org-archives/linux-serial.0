From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [RFC][PATCH] Xilinx uartlite serial driver
Date: Tue, 16 May 2006 13:53:29 +0100
Message-ID: <20060516125329.GE15481@flint.arm.linux.org.uk>
References: <87ac9o3ak3.fsf@sleipner.barco.com> <20060511222001.GC28693@flint.arm.linux.org.uk> <87slnapagf.fsf@LKG7F3A44.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:54797 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751806AbWEPMxq (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 16 May 2006 08:53:46 -0400
Content-Disposition: inline
In-Reply-To: <87slnapagf.fsf@LKG7F3A44.lan>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Peter Korsgaard <jacmet@sunsite.dk>
Cc: tnt@246tNt.com, linux-serial@vger.kernel.org

On Tue, May 16, 2006 at 11:48:00AM +0200, Peter Korsgaard wrote:
> >>>>> "Russell" == Russell King <rmk@arm.linux.org.uk> writes:
> 
> Hi,
> 
> Sorry for the slow reply, I've been away all weekend...
> 
>  >> Comments and suggestions are welcome. I'm especially wondering about
>  >> the fact that I'm hijacking the device nodes used by the mpc52xx_uart
>  >> driver ..
> 
>  Russell> That's for the mpc52xx folk to comment about.  I personally
>  Russel>  don't like> it.
> 
> What do you say Sylvain? Reusing device nodes seems pretty common
> (pxa.c, at91_serial.c, ..), and I cannot imagine anyone making a
> system with uartlite and mpc52xx UARTs ..

Actually they're wishing they hadn't because they can't interoperate
with standard 16550-based ports without resorting to nasty hacks.
As such they're _both_ transitioning away from using the major 4
space.

> Talking about driver, the following seems wrong (or atleast doesn't
> match 8250.c)
> 
> The interaction of the iflag bits is as follows (parity error
> given as an example):
> Parity error      INPCK   IGNPAR
> None              n/a     n/a     character received
> Yes               n/a     0       character discarded
> Yes               0       1       character received, marked as
>                                   TTY_NORMAL
> Yes               1       1       character received, marked as
>                                   TTY_PARITY

Actually that's wrong.  INPCK controls whether input parity _checking_
is be enabled.  If INPCK is not set, then there is no checking of input
parity, and therefore you don't know if there is an error or not.
IOW, INPCK takes precidence over IGNPAR.

So, this should be:

INPCK	Parity error	IGNPAR	Action
  0	n/a		n/a	character received, marked TTY_NORMAL
  1	0		n/a	character received, marked TTY_NORMAL
  1	1		0	character received, marked TTY_PARITY
  1	1		1	character ignored

which I believe is what 8250 and other ports implement.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
