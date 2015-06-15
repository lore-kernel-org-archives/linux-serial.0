From: Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH] serial/amba-pl011: Disable interrupts around TX softirq
Date: Mon, 15 Jun 2015 15:03:00 +0100
Message-ID: <20150615140300.GB3651@e103592.cambridge.arm.com>
References: <1433513267-24163-1-git-send-email-Dave.Martin@arm.com>
 <20150613003945.GA10941@kroah.com> <557EB287.300@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <557EB287.300@arm.com>
Content-Language: en-US
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Andre Przywara <Andre.Przywara@arm.com>
Cc: Russell King <linux@arm.linux.org.uk>, Jakub =?utf-8?B?S2ljacWEc2tp?= <moorray3@wp.pl>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Jackson <Andrew.Jackson@arm.com>, Graeme Gregory <gg@slimlogic.co.uk>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, popcorn mix <popcornmix@gmail.com>, Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>, Robin Murphy <Robin.Murphy@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On Mon, Jun 15, 2015 at 12:09:59PM +0100, Andre Przywara wrote:

[...]

> On 06/13/2015 01:39 AM, Greg Kroah-Hartman wrote:

[...]

> > Too late for 4.1, sorry.
>
> So if I get this correctly, we go from "some characters lost from
> systemd messages" behaviour in 4.0 to "may deadlock" in 4.1 now?
> Is that right?

So it seems.  It's my bad that we hit this so late in the cycle.

> I understand that you are reluctant to take this patch this late in the
> game, but wouldn't it actually be better now to revert PL011 to the
> state of 4.0 to avoid ending up with worse-than-4.0 behaviour in the 4.1
> release?
> We could still backport the solution ending up in 4.2-rc to 4.1.x.

If neither this patch, nor what is in -next, can be applied in 4.1 (and
I understand where Greg was coming from in saying "no"), then this seems
inevitable.

The only other alternative that might be viable is to revert the relevant
changes from 4.1 as you suggest, and optionally try to fix the systemd
console corruption issue via stable.  However, all the fixes currently
available involve a lot of code -- I'm not sure whether they are good
candidates for stable.

There's also a risk of getting into a worse mess with that late revert
if it interacts with any other patches.

However, the revert [1] doesn't look complicated.  There is a 1-line
context clash with some of the dma changes that needs to be resolved,
but that's it.

Opinions?


To avoid further confusion I'll hold off on sending any further patch
for the moment -- I'd like to see some sort of consensus on the way
forward if possible.

Cheers
---Dave


[1] For me, I can build and boot Juno with the v4.0 behaviour with the
following reverts.  These would clash with next again, but the resolution
is the same as before: the code in -next overrides these changes in
master.


>From 89cd9714f223117389f24b191ff97f6969d81c3c Mon Sep 17 00:00:00 2001
From: Dave Martin <Dave.Martin@arm.com>
Date: Mon, 15 Jun 2015 14:06:25 +0100
Subject: [REVERT 1/2] Revert "serial/amba-pl011: Unconditionally poll for
 FIFO space before each TX char"

This reverts commit 43dd1f9a5b05d6db2cb258354a01ace63baa5c0b.
---
 drivers/tty/serial/amba-pl011.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 763eb20..6f5a072 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1249,19 +1249,20 @@ __acquires(&uap->port.lock)

 /*
  * Transmit a character
+ * There must be at least one free entry in the TX FIFO to accept the char.
  *
- * Returns true if the character was successfully queued to the FIFO.
- * Returns false otherwise.
+ * Returns true if the FIFO might have space in it afterwards;
+ * returns false if the FIFO definitely became full.
  */
 static bool pl011_tx_char(struct uart_amba_port *uap, unsigned char c)
 {
-       if (readw(uap->port.membase + UART01x_FR) & UART01x_FR_TXFF)
-               return false; /* unable to transmit character */
-
        writew(c, uap->port.membase + UART01x_DR);
        uap->port.icount.tx++;

-       return true;
+       if (likely(uap->tx_irq_seen > 1))
+               return true;
+
+       return !(readw(uap->port.membase + UART01x_FR) & UART01x_FR_TXFF);
 }

 static bool pl011_tx_chars(struct uart_amba_port *uap)
@@ -1295,8 +1296,7 @@ static bool pl011_tx_chars(struct uart_amba_port *uap)
                return false;

        if (uap->port.x_char) {
-               if (!pl011_tx_char(uap, uap->port.x_char))
-                       goto done;
+               pl011_tx_char(uap, uap->port.x_char);
                uap->port.x_char = 0;
                --count;
        }
--
1.7.10.4

>From ece86a450686f37c3761a25c64af013bc556ee61 Mon Sep 17 00:00:00 2001
From: Dave Martin <Dave.Martin@arm.com>
Date: Mon, 15 Jun 2015 14:07:39 +0100
Subject: [REVERT 2/2] Revert "serial/amba-pl011: Activate TX IRQ passively"

This reverts commit 734745caeb9f155ab58918834a8c70e83fa6afd3.

Conflicts:
        drivers/tty/serial/amba-pl011.c
---
 drivers/tty/serial/amba-pl011.c |  165 ++++++++++++---------------------------
 1 file changed, 50 insertions(+), 115 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 6f5a072..a9074c0 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -58,7 +58,6 @@
 #include <linux/pinctrl/consumer.h>
 #include <linux/sizes.h>
 #include <linux/io.h>
-#include <linux/workqueue.h>

 #define UART_NR                        14

@@ -157,9 +156,7 @@ struct uart_amba_port {
        unsigned int            lcrh_tx;        /* vendor-specific */
        unsigned int            lcrh_rx;        /* vendor-specific */
        unsigned int            old_cr;         /* state during shutdown */
-       struct delayed_work     tx_softirq_work;
        bool                    autorts;
-       unsigned int            tx_irq_seen;    /* 0=none, 1=1, 2=2 or more */
        char                    type[12];
 #ifdef CONFIG_DMA_ENGINE
        /* DMA stuff */
@@ -403,9 +400,8 @@ static void pl011_dma_remove(struct uart_amba_port *uap)
                dma_release_channel(uap->dmarx.chan);
 }

-/* Forward declare these for the refill routine */
+/* Forward declare this for the refill routine */
 static int pl011_dma_tx_refill(struct uart_amba_port *uap);
-static void pl011_start_tx_pio(struct uart_amba_port *uap);

 /*
  * The current DMA TX buffer has been sent.
@@ -443,13 +439,14 @@ static void pl011_dma_tx_callback(void *data)
                return;
        }

-       if (pl011_dma_tx_refill(uap) <= 0)
+       if (pl011_dma_tx_refill(uap) <= 0) {
                /*
                 * We didn't queue a DMA buffer for some reason, but we
                 * have data pending to be sent.  Re-enable the TX IRQ.
                 */
-               pl011_start_tx_pio(uap);
-
+               uap->im |= UART011_TXIM;
+               writew(uap->im, uap->port.membase + UART011_IMSC);
+       }
        spin_unlock_irqrestore(&uap->port.lock, flags);
 }

@@ -627,10 +624,12 @@ static inline bool pl011_dma_tx_start(struct uart_amba_port *uap)
                if (!uap->dmatx.queued) {
                        if (pl011_dma_tx_refill(uap) > 0) {
                                uap->im &= ~UART011_TXIM;
-                               writew(uap->im, uap->port.membase +
-                                      UART011_IMSC);
-                       } else
+                               ret = true;
+                       } else {
+                               uap->im |= UART011_TXIM;
                                ret = false;
+                       }
+                       writew(uap->im, uap->port.membase + UART011_IMSC);
                } else if (!(uap->dmacr & UART011_TXDMAE)) {
                        uap->dmacr |= UART011_TXDMAE;
                        writew(uap->dmacr,
@@ -1172,24 +1171,15 @@ static void pl011_stop_tx(struct uart_port *port)
        pl011_dma_tx_stop(uap);
 }

-static bool pl011_tx_chars(struct uart_amba_port *uap);
-
-/* Start TX with programmed I/O only (no DMA) */
-static void pl011_start_tx_pio(struct uart_amba_port *uap)
-{
-       uap->im |= UART011_TXIM;
-       writew(uap->im, uap->port.membase + UART011_IMSC);
-       if (!uap->tx_irq_seen)
-               pl011_tx_chars(uap);
-}
-
 static void pl011_start_tx(struct uart_port *port)
 {
        struct uart_amba_port *uap =
            container_of(port, struct uart_amba_port, port);

-       if (!pl011_dma_tx_start(uap))
-               pl011_start_tx_pio(uap);
+       if (!pl011_dma_tx_start(uap)) {
+               uap->im |= UART011_TXIM;
+               writew(uap->im, uap->port.membase + UART011_IMSC);
+       }
 }

 static void pl011_stop_rx(struct uart_port *port)
@@ -1247,87 +1237,40 @@ __acquires(&uap->port.lock)
        spin_lock(&uap->port.lock);
 }

-/*
- * Transmit a character
- * There must be at least one free entry in the TX FIFO to accept the char.
- *
- * Returns true if the FIFO might have space in it afterwards;
- * returns false if the FIFO definitely became full.
- */
-static bool pl011_tx_char(struct uart_amba_port *uap, unsigned char c)
-{
-       writew(c, uap->port.membase + UART01x_DR);
-       uap->port.icount.tx++;
-
-       if (likely(uap->tx_irq_seen > 1))
-               return true;
-
-       return !(readw(uap->port.membase + UART01x_FR) & UART01x_FR_TXFF);
-}
-
-static bool pl011_tx_chars(struct uart_amba_port *uap)
+static void pl011_tx_chars(struct uart_amba_port *uap)
 {
        struct circ_buf *xmit = &uap->port.state->xmit;
        int count;

-       if (unlikely(uap->tx_irq_seen < 2))
-               /*
-                * Initial FIFO fill level unknown: we must check TXFF
-                * after each write, so just try to fill up the FIFO.
-                */
-               count = uap->fifosize;
-       else /* tx_irq_seen >= 2 */
-               /*
-                * FIFO initially at least half-empty, so we can simply
-                * write half the FIFO without polling TXFF.
-
-                * Note: the *first* TX IRQ can still race with
-                * pl011_start_tx_pio(), which can result in the FIFO
-                * being fuller than expected in that case.
-                */
-               count = uap->fifosize >> 1;
-
-       /*
-        * If the FIFO is full we're guaranteed a TX IRQ at some later point,
-        * and can't transmit immediately in any case:
-        */
-       if (unlikely(uap->tx_irq_seen < 2 &&
-                    readw(uap->port.membase + UART01x_FR) & UART01x_FR_TXFF))
-               return false;
-
        if (uap->port.x_char) {
-               pl011_tx_char(uap, uap->port.x_char);
+               writew(uap->port.x_char, uap->port.membase + UART01x_DR);
+               uap->port.icount.tx++;
                uap->port.x_char = 0;
-               --count;
+               return;
        }
        if (uart_circ_empty(xmit) || uart_tx_stopped(&uap->port)) {
                pl011_stop_tx(&uap->port);
-               goto done;
+               return;
        }

        /* If we are using DMA mode, try to send some characters. */
        if (pl011_dma_tx_irq(uap))
-               goto done;
+               return;

-       while (count-- > 0 && pl011_tx_char(uap, xmit->buf[xmit->tail])) {
+       count = uap->fifosize >> 1;
+       do {
+               writew(xmit->buf[xmit->tail], uap->port.membase + UART01x_DR);
                xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
+               uap->port.icount.tx++;
                if (uart_circ_empty(xmit))
                        break;
-       }
+       } while (--count > 0);

        if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
                uart_write_wakeup(&uap->port);

-       if (uart_circ_empty(xmit)) {
+       if (uart_circ_empty(xmit))
                pl011_stop_tx(&uap->port);
-               goto done;
-       }
-
-       if (unlikely(!uap->tx_irq_seen))
-               schedule_delayed_work(&uap->tx_softirq_work, uap->port.timeout);
-
-done:
-       return false;
 }

 static void pl011_modem_status(struct uart_amba_port *uap)
@@ -1354,28 +1297,6 @@ static void pl011_modem_status(struct uart_amba_port *uap)
        wake_up_interruptible(&uap->port.state->port.delta_msr_wait);
 }

-static void pl011_tx_softirq(struct work_struct *work)
-{
-       struct delayed_work *dwork = to_delayed_work(work);
-       struct uart_amba_port *uap =
-               container_of(dwork, struct uart_amba_port, tx_softirq_work);
-
-       spin_lock(&uap->port.lock);
-       while (pl011_tx_chars(uap)) ;
-       spin_unlock(&uap->port.lock);
-}
-
-static void pl011_tx_irq_seen(struct uart_amba_port *uap)
-{
-       if (likely(uap->tx_irq_seen > 1))
-               return;
-
-       uap->tx_irq_seen++;
-       if (uap->tx_irq_seen < 2)
-               /* first TX IRQ */
-               cancel_delayed_work(&uap->tx_softirq_work);
-}
-
 static irqreturn_t pl011_int(int irq, void *dev_id)
 {
        struct uart_amba_port *uap = dev_id;
@@ -1414,10 +1335,8 @@ static irqreturn_t pl011_int(int irq, void *dev_id)
                        if (status & (UART011_DSRMIS|UART011_DCDMIS|
                                      UART011_CTSMIS|UART011_RIMIS))
                                pl011_modem_status(uap);
-                       if (status & UART011_TXIS) {
-                               pl011_tx_irq_seen(uap);
+                       if (status & UART011_TXIS)
                                pl011_tx_chars(uap);
-                       }

                        if (pass_counter-- == 0)
                                break;
@@ -1621,7 +1540,7 @@ static int pl011_startup(struct uart_port *port)
 {
        struct uart_amba_port *uap =
            container_of(port, struct uart_amba_port, port);
-       unsigned int cr;
+       unsigned int cr, lcr_h, fbrd, ibrd;
        int retval;

        retval = pl011_hwinit(port);
@@ -1639,11 +1558,30 @@ static int pl011_startup(struct uart_port *port)

        writew(uap->vendor->ifls, uap->port.membase + UART011_IFLS);

-       /* Assume that TX IRQ doesn't work until we see one: */
-       uap->tx_irq_seen = 0;
-
+       /*
+        * Provoke TX FIFO interrupt into asserting. Taking care to preserve
+        * baud rate and data format specified by FBRD, IBRD and LCRH as the
+        * UART may already be in use as a console.
+        */
        spin_lock_irq(&uap->port.lock);

+       fbrd = readw(uap->port.membase + UART011_FBRD);
+       ibrd = readw(uap->port.membase + UART011_IBRD);
+       lcr_h = readw(uap->port.membase + uap->lcrh_rx);
+
+       cr = UART01x_CR_UARTEN | UART011_CR_TXE | UART011_CR_LBE;
+       writew(cr, uap->port.membase + UART011_CR);
+       writew(0, uap->port.membase + UART011_FBRD);
+       writew(1, uap->port.membase + UART011_IBRD);
+       pl011_write_lcr_h(uap, 0);
+       writew(0, uap->port.membase + UART01x_DR);
+       while (readw(uap->port.membase + UART01x_FR) & UART01x_FR_BUSY)
+               barrier();
+
+       writew(fbrd, uap->port.membase + UART011_FBRD);
+       writew(ibrd, uap->port.membase + UART011_IBRD);
+       pl011_write_lcr_h(uap, lcr_h);
+
        /* restore RTS and DTR */
        cr = uap->old_cr & (UART011_CR_RTS | UART011_CR_DTR);
        cr |= UART01x_CR_UARTEN | UART011_CR_RXE | UART011_CR_TXE;
@@ -1697,8 +1635,6 @@ static void pl011_shutdown(struct uart_port *port)
            container_of(port, struct uart_amba_port, port);
        unsigned int cr;

-       cancel_delayed_work_sync(&uap->tx_softirq_work);
-
        /*
         * disable all interrupts
         */
@@ -2245,7 +2181,6 @@ static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
        uap->port.ops = &amba_pl011_pops;
        uap->port.flags = UPF_BOOT_AUTOCONF;
        uap->port.line = i;
-       INIT_DELAYED_WORK(&uap->tx_softirq_work, pl011_tx_softirq);

        /* Ensure interrupts from this UART are masked and cleared */
        writew(0, uap->port.membase + UART011_IMSC);
--
1.7.10.4
