From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [matthew@wil.cx: Re: [parisc-linux] Console Kernel Panic]
Date: Wed, 21 Dec 2005 15:18:15 +0000
Message-ID: <20051221151814.GE1736@flint.arm.linux.org.uk>
References: <20051221143937.GB2361@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:34060 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932448AbVLUPS0 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 21 Dec 2005 10:18:26 -0500
Content-Disposition: inline
In-Reply-To: <20051221143937.GB2361@parisc-linux.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Matthew Wilcox <matthew@wil.cx>, Keven Tipping <bytelogix@shaw.ca>
Cc: linux-serial@vger.kernel.org, parisc-linux@lists.parisc-linux.org

(Sorry for this not being threaded).

On Wed, Dec 21, 2005 at 07:39:37AM -0700, Matthew Wilcox wrote:
> On Mon, Dec 19, 2005 at 08:50:18PM -0700, Keven Tipping wrote:
> > I am currently running Kernel version 2.6.15-rc6-pa1.
> > 
> > This problem, however, is evident in 2.6.14.3-pa0, and 2.6.15-rc5-pa5, as well as 2.6.12.2 (Gentoo 2005 LiveCD). Problem remains regardless of SMP or Uniprocessor kernels.
> > 
> > On the K Class (it appears it is limited to these machines?), if nothing is currently running on the ttyB0 Serial Console, if you press any key, the system burps up the following:
> > 
> > Kernel Panic: Kernel Fault
> > Not Syncing...
> > 
> > What I mean by "nothing running" is if Agetty is NOT running, NOR is Bash. 
> 
> I really think you could have provided the useful bits from a kernel panic
> here.  Please see http://www.parisc-linux.org/faq/kernelbug-howto.html
> 
> However, I've reproduced it myself.  Here's the relevant bits:
> 
>  IAOQ[0]: mux_read+0x4c/0x17c
>  IAOQ[1]: mux_read+0x50/0x17c
>  RP(r2): mux_poll+0x78/0x88
> 
> The instruction faulting is:
> 
>   4c:   48 94 02 28     ldw 114(,r4),r20
> 
> which corresponds to the load of flip.count:
> 
>                 if (tty->flip.count >= TTY_FLIPBUF_SIZE)
> 			continue;
> 
> ie the 'tty' variable is NULL at this point.
> 
> Alan, you seem to have the tarbaby for ttys at the moment ... any idea
> why port->info->tty would be NULL?  The corresponding routine in 8250.c
> (receive_chars()) doesn't check for tty being NULL.  So is there
> some non-obvious check the MUX driver is missing, or is this a latent
> problem in 8250 too?

Basically, mux.c is operating with an invalid assumption.  The
assumption that port->info is set to NULL when we don't want to
handle the port is bogus.

Let's look at the code:

static int mux_startup(struct uart_port *port)
{
        mod_timer(&mux_timer, jiffies + MUX_POLL_DELAY);
        return 0;
}

Ok, so mux_startup starts the mux_timer running.

static void mux_shutdown(struct uart_port *port)
{
}

mux_shutdown does nothing at all.

mux_poll is the mux_timer expiry function:

static void mux_poll(unsigned long unused)
{
        int i;
 
        for(i = 0; i < port_cnt; ++i) {
                if(!mux_ports[i].info)
                        continue;
 
                mux_read(&mux_ports[i]);
                mux_write(&mux_ports[i]);
        }
 
        mod_timer(&mux_timer, jiffies + MUX_POLL_DELAY);
}

and it assumes that we can call mux_read and mux_write if port->info
is non-NULL.  port->info is set non-NULL on the first open of the
port.  It will not be set to NULL when the port is closed - that
only happens when the port is removed from the serial subsystem.

So, this means that mux_read() will be called by mux_poll() after
mux_shutdown() has been called, and mux_read() will try to
dereference port->info->tty.

Since serial_core assumes that the shutdown method will shut the
driver up completely before returning, this obviously is bad,
especially when the serial_core NULLs out port->info->tty.

Hence, it's a mux driver bug.  Please fix.

-- 
Russell King
