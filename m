From: Haavard Skinnemoen <haavard.skinnemoen@atmel.com>
Subject: Re: [patch 2/3] atmel_serial might lose modem status change
Date: Mon, 12 Jan 2009 10:42:02 +0100
Message-ID: <20090112104202.5ea628f6@hskinnemoen-d830>
References: <200901092217.n09MHfmS021131@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from nat-132.atmel.no ([80.232.32.132]:63733 "EHLO relay.atmel.no"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753234AbZALKBU (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 12 Jan 2009 05:01:20 -0500
In-Reply-To: <200901092217.n09MHfmS021131@imap1.linux-foundation.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk, linux-serial@vger.kernel.org, akpm@linux-foundation.org, anemo@mba.ocn.ne.jp, linux@bohmer.net, marc.pignat@hevs.ch, Itai Levi <itai.levi.devel@gmail.com>

akpm@linux-foundation.org wrote:
> From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> 
> I found a problem of handling of modem status of atmel_serial driver.
> 
> With the commit 1ecc26 ("atmel_serial: split the interrupt handler"),
> handling of modem status signal was splitted into two parts.  The
> atmel_tasklet_func() compares new status with irq_status_prev, but
> irq_status_prev is not correct if signal status was changed while the port
> is closed.
> 
> Here is a sequence to cause problem:
> 
> 1. Remote side sets CTS (and DSR).
> 2. Local side close the port.
> 3. Local side clears RTS and DTR.
> 4. Remote side clears CTS and DSR.
> 5. Local side reopen the port.  hw_stopped becomes 1.
> 6. Local side sets RTS and DTR.
> 7. Remote side sets CTS and DSR.
> 
> Then CTS change interrupt can be received, but since CTS bit in
> irq_status_prev and new status is same, uart_handle_cts_change() will not
> be called (so hw_stopped will not be cleared, i.e.  cannot send any data).
> 
> I suppose irq_status_prev should be initialized at somewhere in open
> sequence.
> 
> Acked-by: Remy Bohmer <linux@bohmer.net>
> Cc: Haavard Skinnemoen <hskinnemoen@atmel.com>
> Cc: Marc Pignat <marc.pignat@hevs.ch>
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

I think I already ACKed this. However...

> diff -puN drivers/serial/atmel_serial.c~atmel_serial-might-lose-modem-status-change drivers/serial/atmel_serial.c
> --- a/drivers/serial/atmel_serial.c~atmel_serial-might-lose-modem-status-change
> +++ a/drivers/serial/atmel_serial.c
> @@ -877,6 +877,9 @@ static int atmel_startup(struct uart_por
>  		}
>  	}
>  
> +	/* Save current CSR for comparison in atmel_tasklet_func() */
> +	atmel_port->irq_status_prev = UART_GET_CSR(port);
> +

...Itai Levi pointed out that we need to initialize
atmel_port->irq_status as well here. His analysis is as follows:

> Regarding the second part of the patch (which resets irq_status_prev),
> it turns out that both versions of the patch (mine and Atsushi's)
> still leave enough room for faulty behavior when opening the port.
> 
> This is because we are not resetting both irq_status_prev and
> irq_status in atmel_startup() to CSR, which leads faulty behavior in
> the following sequences:
> 
> First case:
> 1. closing the port while CTS line = 1 (TX not allowed)
> 2. setting CTS line = 0 (TX allowed)
> 3. opening the port
> 4. transmitting one char
> 5. Cannot transmit more chars, although CTS line is 0
> 
> Second case:
> 1. closing the port while CTS line = 0 (TX allowed)
> 2. setting CTS line = 1 (TX not allowed)
> 3. opening the port
> 4. receiving some chars
> 5. Now we can transmit, although CTS line is 1
> 
> This reason for this is that the tasklet is scheduled as a result of
> TX or RX interrupts (not a status change!), in steps 4 above. Inside
> the tasklet, the atmel_port->irq_status (which holds the value from
> the previous session) is compared to atmel_port->irq_status_prev.
> Hence, a status-change of the CTS line is faultily detected.
> 
> Both cases were verified on 9260 hardware.
> 
> The solution for this, is to reset both irq_status_prev and irq_status
> to the value of CSR in atmel_startup().
> 
> Here is my updated patch (you can ignore the first part which you
> already accepted):

--- linux-2.6.27.6/drivers/serial/atmel_serial.c	2008-11-13 19:56:21.000000000 +0200
+++ my/drivers/serial/atmel_serial.c	2009-01-08 11:32:50.000000000 +0200
@@ -579,7 +579,7 @@ static void atmel_tx_dma(struct uart_por
-	if (!uart_circ_empty(xmit)) {
+	if (!uart_circ_empty(xmit) && !uart_tx_stopped(port)) {
 		dma_sync_single_for_device(port->dev,
 					   pdc->dma_addr,
 					   pdc->dma_size,
@@ -805,6 +805,9 @@ static int atmel_startup(struct uart_por
 	 */
 	UART_PUT_IDR(port, -1);

+	atmel_port->irq_status_prev = UART_GET_CSR(port);
+	atmel_port->irq_status = atmel_port->irq_status_prev;
+
 	/*
 	 * Allocate the IRQ
 	 */
