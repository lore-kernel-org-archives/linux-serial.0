Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C00C61DA4
	for <linux-serial@archiver.kernel.org>; Wed, 15 Mar 2023 14:47:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232058AbjCOOry (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 15 Mar 2023 10:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232114AbjCOOrx (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 15 Mar 2023 10:47:53 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BCA08FBF2
        for <linux-serial@vger.kernel.org>; Wed, 15 Mar 2023 07:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678891671; x=1710427671;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=pSmfLY/ILEW9MgGK0FPfHTfJv/IahkJWYXQaVKoEp1E=;
  b=oHFsneuCvsp1g2kTWjgKNIZXmGDV8PoFxacgmq89KvnBd+UKPsrplnWU
   NprybyqXmHEwWknhMwSAUbAQcRxcgsQ3XK9mb90EykilqJMxoiDHdstXF
   cOOytVHLyknF4R4r4dfaDkzw6JF4DoSA2ztPcpjsKx41tSR8WLW06KIgs
   JPLDRtJ02bcdKY4CcW3w4scMnRWPhjzDcSe/wS0k/G98HgXeIZnyqwTOM
   zRd/zlt9C2Iwe/N+XeeCxI4w/Sib35n9hC9LElN0vfMtMy7N+4O6hnNZQ
   KZfY8yfVdukBWwxAva6mKQcbwiaHWRUZRvnxV655ZJfxmEtwFgPVf2JeM
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="339259965"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="339259965"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 07:47:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="822796319"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="822796319"
Received: from vsemouch-mobl.ger.corp.intel.com ([10.251.220.181])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 07:47:48 -0700
Date:   Wed, 15 Mar 2023 16:47:45 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: [Regression] "serial: 8250: use THRE & __stop_tx also with DMA"
 breaks DMA rx
In-Reply-To: <00de13b2-0ed9-efe2-e8d8-c9370c04e80b@redhat.com>
Message-ID: <322489-e120-dcbf-fffc-d9df31d8c499@linux.intel.com>
References: <7f18e19d-4072-0609-afd0-244b06103b9c@redhat.com> <dd9ebf9-e2e9-2b6-eec5-6ab152f92032@linux.intel.com> <316ab583-d217-a332-d161-8225b0cee227@redhat.com> <1d7c80cf-cf79-ef1-58ba-e3b99294bb6@linux.intel.com> <9e1e207f-a74f-cedb-6811-993d6b0a26cf@redhat.com>
 <f729bfb4-cde1-9859-f1ff-58716772dfc4@linux.intel.com> <00de13b2-0ed9-efe2-e8d8-c9370c04e80b@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1060986318-1678890368=:2112"
Content-ID: <bab67c94-5d7f-9681-977-a2e536a1e1f@linux.intel.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1060986318-1678890368=:2112
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <8013e745-acba-d01a-d9e-2b2439746cf4@linux.intel.com>

On Tue, 14 Mar 2023, Hans de Goede wrote:
> On 3/14/23 17:55, Ilpo Järvinen wrote:
> > On Tue, 14 Mar 2023, Hans de Goede wrote:
> >> On 3/14/23 12:48, Ilpo Järvinen wrote:
> >>> On Tue, 14 Mar 2023, Hans de Goede wrote:
> >>>> On 3/14/23 11:55, Ilpo Järvinen wrote:
> >>>>> On Tue, 14 Mar 2023, Hans de Goede wrote:
> >>>>>
> >>>>>> I have spend the last couple of days debugging a problem with Bluetooth
> >>>>>> adapters (HCIs) connected over an UART connection on Intel Bay Trail
> >>>>>> and Cherry Trail devices.
> >>>>>>
> >>>>>> After much debugging I found out that sometimes the first byte of
> >>>>>> a received packet (data[0]) would be overwritten with a 0 byte.
> >>>>>>
> >>>>>> E.g. this packet received during init of a BCM4324B3 (1) Bluetooth HCI:
> >>>>>>
> >>>>>> 04 0e 0a 01 79 fc 00 54 fe ff ff 00 00
> >>>>>>
> >>>>>> would sometimes turn into:
> >>>>>>
> >>>>>> 00 0e 0a 01 79 fc 00 54 fe ff ff 00 00
> >>>>>>
> >>>>>> Further investigation revealed that this goes away if I stop
> >>>>>> the dw_dmac module from loading, leading to:
> >>>>>> "dw-apb-uart 80860F0A:00: failed to request DMA"
> >>>>>> and the UART working without DMA support.
> >>>>>>
> >>>>>> Testing various kernels showed that this problem was introduced
> >>>>>> in v5.19, v5.18 - v5.18.19 are fine. An a git bisect points to:
> >>>>>>
> >>>>>> e8ffbb71f783 ("serial: 8250: use THRE & __stop_tx also with DMA")
> >>>>>>
> >>>>>> And reverting that on top of v6.3-rc2 indeed solves the problem.
> >>>>>
> >>>>>> So it seems that that commit somehow interferes with DMA based
> >>>>
> >>>>> Maybe the the extra interrupt that the tx side change will trigger somehow 
> >>>>> causes the confusion on the rx side. So that would be an extra call into 
> >>>>> handle_rx_dma() that could either do an extra flush or start DMA Rx that 
> >>>>> would not occur w/o that tx side change.
> >>>>
> >>>> That sounds like a likely candidate for causing this yes, as said
> >>>> I'm unfamiliar with the serial-port code, but I did already suspect
> >>>> that the change was causing some extra interrupt which somehow
> >>>> interfered with the rx side.
> >>>>
> >>>>>> The issue has been seen on and the revert has been tested on
> >>>>>> the following HW:
> >>>>>>
> >>>>>> Asus T100TA
> >>>>>> SoC: Bay Trail UART: 80860F0A WIFI: brcmfmac43241b4-sdio BT: BCM4324B3
> >>>>>>
> >>>>>> Lenovo Yoga Tablet 2 1051L
> >>>>>> SoC: Bay Trail UART: 80860F0A WIFI: brcmfmac43241b4-sdio BT: BCM4324B3
> >>>>>>
> >>>>>> Lenovo Yoga Book X91F
> >>>>>> Soc: Cherry Trail UART: 8086228A WIFI: brcmfmac4356-pcie BT: BCM4356A2
> >>>>>>
> >>>>>> I have more hw which I believe is affected but these are the models
> >>>>>> where I have done detailed testing.
> >>>>>>
> >>>>>> I would be happy to test any patches, or run a kernel with some extra
> >>>>>> debugging added, just let me know what you need to help fixing this.

> > From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > Subject: [PATCH] serial: 8250: Prevent starting up DMA Rx on THRI interrupt
> > 
> > Hans de Goede reported Bluetooth adapters (HCIs) connected over an UART
> > connection failed due corrupted Rx payload. The problem was narrowed
> > down to DMA Rx starting on UART_IIR_THRI interrupt. The problem occurs 
> > despite LSR having DR bit set, which is precondition for attempting to 
> > start DMA Rx.
> > 
> > This problem became apparent after e8ffbb71f783 ("serial: 8250: use
> > THRE & __stop_tx also with DMA") changed Tx stopping to get triggered
> > using THRI interrupt.
> > 
> > Don't setup DMA Rx on UART_IIR_THRI but leave it to a subsequent
> > interrupt which has Rx related IIR value.
> > 
> > Reported-by: Hans de Goede <hdegoede@redhat.com>
> > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> 
> I can confirm that this fixes things for me:
> 
> Tested-by: Hans de Goede <hdegoede@redhat.com>

Okay, thanks for testing.

Here's is a slightly improved debug patch which will count how many 
characters are received by DMA and non-DMA rx. It should be tested 
WITHOUT the fix.

I'm mostly interested in knowing if it's purely DMA Rx issue or whether 
the non-DMA rx is muddling the waters too. While investigating other 
issues I've seen UART_IIR_TIMEOUT (inter-character timeout) to often come 
so early from UART that the tail of characters is left there to be handled 
by the non-DMA path.


From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH] DEBUG: Dma rx-problem

A DEBUG PATCH, not intended for upstream inclusing.

---
 drivers/tty/serial/8250/8250_dma.c  | 17 ++++++++++++-----
 drivers/tty/serial/8250/8250_port.c | 19 +++++++++++++++++++
 include/linux/serial_8250.h         |  3 +++
 3 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dma.c b/drivers/tty/serial/8250/8250_dma.c
index 7fa66501792d..705c26941429 100644
--- a/drivers/tty/serial/8250/8250_dma.c
+++ b/drivers/tty/serial/8250/8250_dma.c
@@ -32,13 +32,15 @@ static void __dma_tx_complete(void *param)
 		uart_write_wakeup(&p->port);
 
 	ret = serial8250_tx_dma(p);
-	if (ret || !dma->tx_running)
+	if (ret || !dma->tx_running) {
+		p->irq_debug = -5;
 		serial8250_set_THRI(p);
+	}
 
 	spin_unlock_irqrestore(&p->port.lock, flags);
 }
 
-static void __dma_rx_complete(struct uart_8250_port *p)
+static int __dma_rx_complete(struct uart_8250_port *p)
 {
 	struct uart_8250_dma	*dma = p->dma;
 	struct tty_port		*tty_port = &p->port.state->port;
@@ -53,7 +55,7 @@ static void __dma_rx_complete(struct uart_8250_port *p)
 	 */
 	dma_status = dmaengine_tx_status(dma->rxchan, dma->rx_cookie, &state);
 	if (dma_status == DMA_IN_PROGRESS)
-		return;
+		return -1;
 
 	count = dma->rx_size - state.residue;
 
@@ -62,6 +64,8 @@ static void __dma_rx_complete(struct uart_8250_port *p)
 	dma->rx_running = 0;
 
 	tty_flip_buffer_push(tty_port);
+
+	return count;
 }
 
 static void dma_rx_complete(void *param)
@@ -69,10 +73,11 @@ static void dma_rx_complete(void *param)
 	struct uart_8250_port *p = param;
 	struct uart_8250_dma *dma = p->dma;
 	unsigned long flags;
+	int count = -1;
 
 	spin_lock_irqsave(&p->port.lock, flags);
 	if (dma->rx_running)
-		__dma_rx_complete(p);
+		count = __dma_rx_complete(p);
 
 	/*
 	 * Cannot be combined with the previous check because __dma_rx_complete()
@@ -81,6 +86,8 @@ static void dma_rx_complete(void *param)
 	if (!dma->rx_running && (serial_lsr_in(p) & UART_LSR_DR))
 		p->dma->rx_dma(p);
 	spin_unlock_irqrestore(&p->port.lock, flags);
+
+	pr_err("8250dma: rx complete %d\n", count);
 }
 
 int serial8250_tx_dma(struct uart_8250_port *p)
@@ -172,7 +179,7 @@ void serial8250_rx_dma_flush(struct uart_8250_port *p)
 
 	if (dma->rx_running) {
 		dmaengine_pause(dma->rxchan);
-		__dma_rx_complete(p);
+		p->dma_rx_count = __dma_rx_complete(p);
 		dmaengine_terminate_async(dma->rxchan);
 	}
 }
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index fa43df05342b..0c950ff7a8ee 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1811,6 +1811,7 @@ u16 serial8250_rx_chars(struct uart_8250_port *up, u16 lsr)
 	} while (lsr & (UART_LSR_DR | UART_LSR_BI));
 
 	tty_flip_buffer_push(&port->state->port);
+	up->rx_chars_count = 256 - max_count;
 	return lsr;
 }
 EXPORT_SYMBOL_GPL(serial8250_rx_chars);
@@ -1923,6 +1924,10 @@ int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
 	struct uart_8250_port *up = up_to_u8250p(port);
 	bool skip_rx = false;
 	unsigned long flags;
+	long irq_debug;
+	unsigned int tx_running = 0, rx_running = 0, tx_err = 0;
+	unsigned int ier;
+	int rx_count, dma_count;
 	u16 status;
 
 	if (iir & UART_IIR_NO_INT)
@@ -1931,6 +1936,14 @@ int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
 	spin_lock_irqsave(&port->lock, flags);
 
 	status = serial_lsr_in(up);
+	up->dma_rx_count = 0;
+	up->rx_chars_count = 0;
+	if (up->dma) {
+		rx_running = up->dma->rx_running;
+		tx_running = up->dma->tx_running;
+		tx_err = up->dma->tx_err;
+	}
+	ier = up->ier;
 
 	/*
 	 * If port is stopped and there are no error conditions in the
@@ -1957,7 +1970,13 @@ int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
 			__stop_tx(up);
 	}
 
+	irq_debug = up->irq_debug++;
+	rx_count = up->rx_chars_count;
+	dma_count = up->dma_rx_count;
 	uart_unlock_and_check_sysrq_irqrestore(port, flags);
+	if (irq_debug < 0)
+		pr_err("8250irq: iir=%02x lsr+saved=%02x received=%d/%d ier=%02x dma_t/rx/err=%u/%u/%u cnt=%ld\n",
+		       iir, status, dma_count, rx_count, ier, tx_running, rx_running, tx_err, irq_debug);
 
 	return 1;
 }
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index 741ed4807a9c..4a0c0d549d7b 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -107,6 +107,9 @@ struct uart_8250_port {
 	unsigned char		mcr;
 	unsigned char		cur_iotype;	/* Running I/O type */
 	unsigned int		rpm_tx_active;
+	long			irq_debug;
+	int			rx_chars_count;
+	int			dma_rx_count;
 	unsigned char		canary;		/* non-zero during system sleep
 						 *   if no_console_suspend
 						 */

-- 
tg: (571079f5ba93..) debug/dma-rx-problem (depends on: tty-next)
--8323329-1060986318-1678890368=:2112--
