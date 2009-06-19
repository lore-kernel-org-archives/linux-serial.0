From: Robert Evans <evans.robert.n@gmail.com>
Subject: Re: [Xen-devel] Re: [PATCH] IRQ handling race and spurious IIR read
	in serial/8250.c
Date: Thu, 18 Jun 2009 21:39:20 -0400
Message-ID: <11bfd16c0906181839g6ad62367ud45b869536ed9d70@mail.gmail.com>
References: <874oxyei9k.fsf@pike.pond.sub.org>
	 <20090312180955.1f52a401@lxorguk.ukuu.org.uk>
	 <18873.25299.416627.13221@mariner.uk.xensource.com>
	 <20090312213831.5045f5d0@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ew0-f210.google.com ([209.85.219.210]:59743 "EHLO
	mail-ew0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751931AbZFSBjT (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 18 Jun 2009 21:39:19 -0400
Received: by ewy6 with SMTP id 6so2104613ewy.37
        for <linux-serial@vger.kernel.org>; Thu, 18 Jun 2009 18:39:21 -0700 (PDT)
In-Reply-To: <20090312213831.5045f5d0@lxorguk.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Ian Jackson <Ian.Jackson@eu.citrix.com>, Jeremy Fitzhardinge <jeremy@goop.org>, "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, Markus Armbruster <armbru@redhat.com>, Anders Kaseorg <andersk@mit.edu>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>

On Thu, Mar 12, 2009 at 5:38 PM, Alan Cox<alan@lxorguk.ukuu.org.uk> wrote:
...
>>  4. Any fix which does not involve completely removing UART_BUG_TXEN
>>     will need my change.
>
> Or the locking fix
>
> It was described as a band aid so I treated it as such. Regardless of the
> right thing to do long term its not a 2.6.29 candidate at this point but
> certainly something that wants looking into in 2.6.30

Stratus has experienced this same problem on bare metal.  An analysis
and proposed fixes were posted to this list on 2008-08-13.  See
  http://marc.info/?l=linux-serial&m=121863945506976&w=2

The first proposed fix takes the port's irq lock when starting up the
UART to provide mutual exclusion between the "quick test" in the
startup code and the interrupt service routine.  Stratus has quite a
bit or runtime with this locking fix on kernels of the 2.6.18 vintage
with good success.

Is this a "right thing" fix that could be considered for inclusion upstream?

--- linux-2.6.18-92-old/drivers/serial/8250.c   2008-08-13
14:07:08.000000000 +0000
+++ linux-2.6.18-92-new/drivers/serial/8250.c   2008-08-13
14:04:12.000000000 +0000
@@ -1749,65 +1749,73 @@

               timeout = timeout > 6 ? (timeout / 2 - 2) : 1;

               up->timer.data = (unsigned long)up;
               mod_timer(&up->timer, jiffies + timeout);
       } else {
               retval = serial_link_irq_chain(up);
               if (retval)
                       return retval;
       }

       /*
        * Now, initialize the UART
        */
       serial_outp(up, UART_LCR, UART_LCR_WLEN8);

-       spin_lock_irqsave(&up->port.lock, flags);
+       if (is_real_interrupt(up->port.irq)) {
+               spin_lock_irqsave(&irq_lists[up->port.irq].lock, flags);
+               spin_lock(&up->port.lock);
+       } else
+               spin_lock_irqsave(&up->port.lock, flags);
       if (up->port.flags & UPF_FOURPORT) {
               if (!is_real_interrupt(up->port.irq))
                       up->port.mctrl |= TIOCM_OUT1;
       } else
               /*
                * Most PC uarts need OUT2 raised to enable interrupts.
                */
               if (is_real_interrupt(up->port.irq))
                       up->port.mctrl |= TIOCM_OUT2;

       serial8250_set_mctrl(&up->port, up->port.mctrl);

       /*
        * Do a quick test to see if we receive an
        * interrupt when we enable the TX irq.
        */
       serial_outp(up, UART_IER, UART_IER_THRI);
       lsr = serial_in(up, UART_LSR);
       iir = serial_in(up, UART_IIR);
       serial_outp(up, UART_IER, 0);

       if (lsr & UART_LSR_TEMT && iir & UART_IIR_NO_INT) {
               if (!(up->bugs & UART_BUG_TXEN)) {
                       up->bugs |= UART_BUG_TXEN;
                       pr_debug("ttyS%d - enabling bad tx status workarounds\n",
                                port->line);
               }
       } else {
               up->bugs &= ~UART_BUG_TXEN;
       }

-       spin_unlock_irqrestore(&up->port.lock, flags);
+       if (is_real_interrupt(up->port.irq)) {
+               spin_unlock(&up->port.lock);
+               spin_unlock_irqrestore(&irq_lists[up->port.irq].lock, flags);
+       } else
+               spin_unlock_irqrestore(&up->port.lock, flags);

       /*
        * Finally, enable interrupts.  Note: Modem status interrupts
        * are set via set_termios(), which will be occurring imminently
        * anyway, so we don't enable them here.
        */
       up->ier = UART_IER_RLSI | UART_IER_RDI;
       serial_outp(up, UART_IER, up->ier);

       if (up->port.flags & UPF_FOURPORT) {
               unsigned int icp;
               /*
                * Enable interrupts on the AST Fourport board
                */
               icp = (up->port.iobase & 0xfe0) | 0x01f;
               outb_p(0x80, icp);


Robert N. Evans
Software Engineer
STRATUS TECHNOLOGIES
111 Powdermill Road,
Maynard, MA 01754-3409  U.S.A.
