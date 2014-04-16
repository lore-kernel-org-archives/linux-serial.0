From: "Poulain, Loic" <loic.poulain@intel.com>
Subject: RE: 8250_dw DMA issue with BYT ?
Date: Wed, 16 Apr 2014 16:34:58 +0000
Message-ID: <50C3158CF44D924791C15F1437EF2EC65DA634@HASMSX104.ger.corp.intel.com>
References: <50C3158CF44D924791C15F1437EF2EC65D9BE7@HASMSX104.ger.corp.intel.com>
 <20140415065606.GA3368@xps8300>,<0C6A3B2997299B4EAD81D386F36CD8C210C8AB23@shsmsx102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:43567 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750997AbaDPQfM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 16 Apr 2014 12:35:12 -0400
In-Reply-To: <0C6A3B2997299B4EAD81D386F36CD8C210C8AB23@shsmsx102.ccr.corp.intel.com>
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "Jin, Yao" <yao.jin@intel.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Hello Heikki, Jin

> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -143,7 +143,7 @@ static int uart_port_startup(struct tty_struct *tty, struct uart_state *state,
>          */
>         if (!state->xmit.buf) {
>                 /* This is protected by the per port mutex */
> -               page = get_zeroed_page(GFP_KERNEL);
> +               page = get_zeroed_page(GFP_KERNEL | GFP_DMA);
>                 if (!page)
>                        return -ENOMEM;

This patch doesn't fix my problem.


After analysis, here is my status:

The Bluetooth chip generates hardware errors due to unexpected
data. These unexpected data are caused by 8250 concurrent TX.

- Concurrent DMA TX (8250_dma.c):

After each DMA transfer, __dma_tx_complete() is called.
This function updates the circular buffer tail and calls
serial8250_tx_dma() if data remains.

However these operations are not protected against concurrent
call of serial8250_tx_dma() (via uart start_tx). So, this concurrent 
call may use non-updated tail index and may be called in parallel 
of an other serial8250_tx_dma().


- Concurrent Chars TX (8250_corec.c):

In the serial8250_handle_irq(), serial8250_tx_chars is called if
UART_LSR_THRE. However we should not call this function
if we are using the DMA. Moreover, for the same reason as above,
serial8250_tx_chars could be called with bad tail index or in parallel
of a serial8250_tx_dma.


I think two fixes are necessary:

to avoid tx chars usage:

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 69932b7..e124983 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -1520,7 +1520,7 @@ int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
                        status = serial8250_rx_chars(up, status);
        }
        serial8250_modem_status(up);
-       if (status & UART_LSR_THRE)
+       if (!up->dma && (status & UART_LSR_THRE))
                serial8250_tx_chars(up);
 
        spin_unlock_irqrestore(&port->lock, flags);


to fix concurrent operations:

diff --git a/drivers/tty/serial/8250/8250_dma.c b/drivers/tty/serial/8250/8250_dma.c
index 7046769..4469190 100644
--- a/drivers/tty/serial/8250/8250_dma.c
+++ b/drivers/tty/serial/8250/8250_dma.c
@@ -20,6 +20,9 @@ static void __dma_tx_complete(void *param)
        struct uart_8250_port   *p = param;
        struct uart_8250_dma    *dma = p->dma;
        struct circ_buf         *xmit = &p->port.state->xmit;
+       unsigned long flags;
+
+       spin_lock_irqsave(&p->port.lock, flags);
 
        dma->tx_running = 0;
 
@@ -35,6 +38,8 @@ static void __dma_tx_complete(void *param)
 
        if (!uart_circ_empty(xmit) && !uart_tx_stopped(&p->port))
                serial8250_tx_dma(p);
+
+       spin_unlock_irqrestore(&p->port.lock, flags);
 }


The last one fixes TX issues but causes random freeze of my
platform (when uploading file via bluetooth). It seems to be a deadlock.
I have no kernel trace in my console, system is stuck.

To temporally workaround this, I simply moved "tx_running=0" after updating
tail index (in __dma_tx_complete) so that no dma_tx can happen before 
this update.

	xmit->tail += dma->tx_size;
	xmit->tail &= UART_XMIT_SIZE - 1;
	p->port.icount.tx += dma->tx_size;

	dma->tx_running = 0;


Regards,
Loic
---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, 
92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

