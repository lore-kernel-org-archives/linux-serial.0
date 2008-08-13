From: "Robert Evans" <evans.robert.n@gmail.com>
Subject: [PATCH/RFC] RE: 8250 misses interrupt, stalls
Date: Wed, 13 Aug 2008 10:56:20 -0400
Message-ID: <11bfd16c0808130756s1d467e63p2466de4fe2fcd18d@mail.gmail.com>
References: <20080808052727.GB23330@blorp.plorb.com>
	 <BD6105C44DDDF84AB07C23F6A35AE54E01E99F6D@dhrseasvxb03.messaging.danaherad.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.183]:50312 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751436AbYHMO4W (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 13 Aug 2008 10:56:22 -0400
Received: by py-out-1112.google.com with SMTP id p76so2975pyb.10
        for <linux-serial@vger.kernel.org>; Wed, 13 Aug 2008 07:56:21 -0700 (PDT)
In-Reply-To: <BD6105C44DDDF84AB07C23F6A35AE54E01E99F6D@dhrseasvxb03.messaging.danaherad.com>
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

At Stratus we have also seen missed interrupts in 8250.c.  We
concluded these are due to serial driver UART_BUG_TXEN false positive
on SMP system as explained below with patches to fix this problem.

Symptom and Environment:

On an SMP x86_64 system that has 8 CPU cores, we see serial output to
16550A UARTs stalling.  When this situation occurs, the associated
tty_struct does not have stopped flags set and the uart_info->xmit
buffer is not empty.  If interrupts were occurring the data should be
sent to the UART.  Because the data is not being sent, it seems a
"transmitter holding register empty" interrupt (THRI) is getting lost
and therefore outgoing data stops.

We only see this bug on SMP systems.  When we boot a multi-core system
with maxcpus=1 the problem does not occur.  In these tests, a serial
console is on ttyS0 which uses IRQ4.  ttyS1 is used by pppd and it
uses IRQ3.  Neither IRQ is shared.  We can test by rebooting the
system and after the init scripts have run, looking at whether the
UART_BUG_TXEN bit is set for each tty.  With maxcpus=1 UART_BUG_TXEN
never gets set.  Without maxcpus on the kernel command line, we see
false positives in setting UART_BUG_TXEN perhaps 75 to 95 percent of
the time on ttyS1, and about 20 percent of the time on ttyS0.

The particular UARTs used in the Stratus system are part of the
PC87427 Server IO chip.  This chip was designed by National
Semiconductor and documentation on the NS web site says the chip is
compatible with 16450 and 16550A.  Now that business has transferred
to Winbond from NS; so those parts come from Winbond.  This is a
modern UART implementation that should not have the UART_BUG_TXEN.

We saw this problems in Red Hat Enterprise Linux 5.2, with kernel
linux-2.6.18-92.el5.  However from source code examination, it seems
this would also occur in linux 2.6.24 and later.

Analysis:
(line numbers from linux v2.6.24.4)

How UART_BUG_TXEN gets set due to a false positive on SMP systems ---
The UART is initialized by function serial8250_startup() in 8250.c.
At line 1860 the call to serial_link_irq_chain(up) connects the IRQ to
the ISR in this driver.  It is relevant that the ISR reads the IIR
before it tries to acquire the
up->port.lock spinlock and reading the IIR would clear THRI if it is
the interrupt cause thus breaking this detection logic that comes a
few lines later in serial8250_startup().  Line 1881 is the last step
necessary for the ISR to be
entered.
in serial8250_startup:
1860                retval = serial_link_irq_chain(up);
...
1874        } else
1875                /*
1876                 * Most PC uarts need OUT2 raised to enable interrupts.
1877                 */
1878                if (is_real_interrupt(up->port.irq))
1879                        up->port.mctrl |= TIOCM_OUT2;
1880
1881        serial8250_set_mctrl(&up->port, up->port.mctrl);
1882
1883        /*
1884         * Do a quick test to see if we receive an
1885         * interrupt when we enable the TX irq.
1886         */
1887        serial_outp(up, UART_IER, UART_IER_THRI);
1888        lsr = serial_in(up, UART_LSR);
1889        iir = serial_in(up, UART_IIR);
1890        serial_outp(up, UART_IER, 0);
1891
1892        if (lsr & UART_LSR_TEMT && iir & UART_IIR_NO_INT) {
1893                if (!(up->bugs & UART_BUG_TXEN)) {
1894                        up->bugs |= UART_BUG_TXEN;
1895                        pr_debug("ttyS%d - enabling bad tx status
workarounds\n",
1896                                 port->line);
1897                }
1898        } else {
1899                up->bugs &= ~UART_BUG_TXEN;
1900        }
1901
1902        spin_unlock_irqrestore(&up->port.lock, flags);

Line 1887 causes an interrupt and the problem can occur when the ISR
is entered on another processor.  If ISR reads the IIR, clearing THRI,
before the IIR is read on line 1889, a false positive is detected.


How incorrectly detecting UART_BUG_TXEN causes output to stall ---

When usermode has more characters for the UART to transmit, the
characters are placed into the uart_info->xmit circular buffer and
serial8250_start_tx() gets called.  That function flows through the
following code path:

in serial8250_start_tx:
1241        struct uart_8250_port *up = (struct uart_8250_port *)port;
1242
1243        if (!(up->ier & UART_IER_THRI)) {
1244                up->ier |= UART_IER_THRI;
1245                serial_out(up, UART_IER, up->ier);
1246
1247                if (up->bugs & UART_BUG_TXEN) {
1248                        unsigned char lsr, iir;
1249                        lsr = serial_in(up, UART_LSR);
1250                        up->lsr_saved_flags |= lsr & LSR_SAVE_FLAGS;
1251                        iir = serial_in(up, UART_IIR) & 0x0f;
1252                        if ((up->port.type == PORT_RM9000) ?
1253                                (lsr & UART_LSR_THRE &&
1254                                (iir == UART_IIR_NO_INT || iir ==
UART_IIR_THRI)) :
1255                                (lsr & UART_LSR_TEMT && iir &
UART_IIR_NO_INT))
1256                                transmit_chars(up);
1257                }
1258        }

On NON-buggy UARTs line 1245 causes a THRI interrupt request.  If the
IIR has not been read by the ISR by the time it is read on line 1251,
the value read by line 1251 can indicate that THRI is pending; in this
case, reading the IIR would clear the THRI status, causing the
interrupt to get lost.  This value read from the IIR would not be
UART_IIR_NO_INT so that line 1256 would be bypassed; with no
characters sent to the transmitter in the UART another THRI interrupt
request would not occur.  Subsequent calls to this routine do nothing
because the  UART_IER_THRI bit is already set.  This causes output
stalls.


Proposed fixes ---

Here are two patches that are alternatives for fixing this problem:


The first patch was tested at Red Hat and Stratus.  It has been
released to users of Red Hat Enterprise Linux 5.2.
This patch takes the port's irq lock when starting up the UART to
provide mutual exclusion between the "quick test" in the startup code
and the interrupt service routine.

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






The second patch blocks the 16550A UART from asserting its IRQ during
the quick test in serial8250_startup previously discussed.  This patch
patch has only had limited testing at Stratus.

--- linux-2.6.24.4.old/drivers/serial/8250.c    2008-03-24
18:49:18.000000000 +0000
+++ linux-2.6.24.4.new/drivers/serial/8250.c    2008-04-16
19:40:41.000000000 +0000
@@ -1876,21 +1876,25 @@
                * Most PC uarts need OUT2 raised to enable interrupts.
                */
               if (is_real_interrupt(up->port.irq))
                       up->port.mctrl |= TIOCM_OUT2;

-       serial8250_set_mctrl(&up->port, up->port.mctrl);
+       /* Block IRQ to avoid false positive if SMP */
+       serial8250_set_mctrl(&up->port, 0);

       /*
        * Do a quick test to see if we receive an
        * interrupt when we enable the TX irq.
        */
       serial_outp(up, UART_IER, UART_IER_THRI);
       lsr = serial_in(up, UART_LSR);
       iir = serial_in(up, UART_IIR);
       serial_outp(up, UART_IER, 0);

+       /* Enable this UART to assert its IRQ */
+       serial8250_set_mctrl(&up->port, up->port.mctrl);
+
       if (lsr & UART_LSR_TEMT && iir & UART_IIR_NO_INT) {
               if (!(up->bugs & UART_BUG_TXEN)) {
                       up->bugs |= UART_BUG_TXEN;
                       pr_debug("ttyS%d - enabling bad tx status workarounds\n",
                                port->line);


Robert N. Evans
Software Engineer
STRATUS TECHNOLOGIES
111 Powdermill Road,
Maynard, MA 01754-3409  U.S.A.
