Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E7BC6FD1D
	for <linux-serial@archiver.kernel.org>; Tue, 14 Mar 2023 11:48:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjCNLst (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 14 Mar 2023 07:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjCNLsm (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 14 Mar 2023 07:48:42 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640DE171E
        for <linux-serial@vger.kernel.org>; Tue, 14 Mar 2023 04:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678794515; x=1710330515;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=R4HHNoxG0BC5DFVbqZLYfqihSJBvEE4eybiKHWTy9gw=;
  b=POUHw3TsxZvjtdDkLC6ybfnkrqkY9a+qDsIKR7DpZDUGuo0+xrijCXvB
   +YAc2AJBX40Yw594+YGqXxxTEuIwsH+HWF0PhPxwf2xD3P7VbnufcsWJe
   etyo6+frevEfmw5N9QySH/UvYZW2ynCDWdDDgxzVDuZX9neN9DQ/PB++3
   otkCwCTzVugPBMbXjoRLNlUUR/d4TO0QCPGcR/v4UwgSrkniLGhn22nYh
   Pv//XZJfWdtJCaR/OCGBtXyKfE0LWhCQBfZOGf1/qEO6r0/yOwXFAuliS
   msFsRkIWtiZeGmt+1sG6jUhewKu/CKHh0O/6t71Q8wMGF9nn1vhTIo7tt
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="317047401"
X-IronPort-AV: E=Sophos;i="5.98,259,1673942400"; 
   d="scan'208";a="317047401"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 04:48:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="822341581"
X-IronPort-AV: E=Sophos;i="5.98,259,1673942400"; 
   d="scan'208";a="822341581"
Received: from npeltier-mobl1.ger.corp.intel.com ([10.252.33.129])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 04:48:33 -0700
Date:   Tue, 14 Mar 2023 13:48:31 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: [Regression] "serial: 8250: use THRE & __stop_tx also with DMA"
 breaks DMA rx
In-Reply-To: <316ab583-d217-a332-d161-8225b0cee227@redhat.com>
Message-ID: <1d7c80cf-cf79-ef1-58ba-e3b99294bb6@linux.intel.com>
References: <7f18e19d-4072-0609-afd0-244b06103b9c@redhat.com> <dd9ebf9-e2e9-2b6-eec5-6ab152f92032@linux.intel.com> <316ab583-d217-a332-d161-8225b0cee227@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1460968984-1678794514=:2593"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1460968984-1678794514=:2593
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 14 Mar 2023, Hans de Goede wrote:
> On 3/14/23 11:55, Ilpo Järvinen wrote:
> > On Tue, 14 Mar 2023, Hans de Goede wrote:
> > 
> >> I have spend the last couple of days debugging a problem with Bluetooth
> >> adapters (HCIs) connected over an UART connection on Intel Bay Trail
> >> and Cherry Trail devices.
> >>
> >> After much debugging I found out that sometimes the first byte of
> >> a received packet (data[0]) would be overwritten with a 0 byte.
> >>
> >> E.g. this packet received during init of a BCM4324B3 (1) Bluetooth HCI:
> >>
> >> 04 0e 0a 01 79 fc 00 54 fe ff ff 00 00
> >>
> >> would sometimes turn into:
> >>
> >> 00 0e 0a 01 79 fc 00 54 fe ff ff 00 00
> >>
> >> Further investigation revealed that this goes away if I stop
> >> the dw_dmac module from loading, leading to:
> >> "dw-apb-uart 80860F0A:00: failed to request DMA"
> >> and the UART working without DMA support.
> >>
> >> Testing various kernels showed that this problem was introduced
> >> in v5.19, v5.18 - v5.18.19 are fine. An a git bisect points to:
> >>
> >> e8ffbb71f783 ("serial: 8250: use THRE & __stop_tx also with DMA")
> >>
> >> And reverting that on top of v6.3-rc2 indeed solves the problem.
> > 
> > You did something else too than just that because you cannot cleanly 
> > revert just e8ffbb71f783. Please indicate what happened to:
> >   f8d6e9d3ca5c ("serial: 8250: Fix __stop_tx() & DMA Tx restart races")
> > 
> > I guess you reverted that too and forgot to mention about it but I just 
> > want to be sure we're on the same page?
> 
> I manually fixed up the revert, effectively
> dropping the drivers/tty/serial/8250/8250_port.c part of f8d6e9d3ca5c
> I did not revert f8d6e9d3ca5c in its entirety.
> 
> I've attached my manual fixed up revert as a patch here.
> 
> >> So it seems that that commit somehow interferes with DMA based
> >> data receiving, causing the first byte of a received data transfer
> >> to get replaced by 0.
> > 
> > Okay, and you're sure the problem/corruption occurs on the receiving side? 
> 
> What I am sure is that the first byte of a packet has been replaced by 0
> by the time drivers/tty/tty_buffer.c: receive_buf() gets called.
> 
> I did not dive into the serial-port code side of this problem since
> I'm unfamiliar with that.
> 
> > Maybe the the extra interrupt that the tx side change will trigger somehow 
> > causes the confusion on the rx side. So that would be an extra call into 
> > handle_rx_dma() that could either do an extra flush or start DMA Rx that 
> > would not occur w/o that tx side change.
> 
> That sounds like a likely candidate for causing this yes, as said
> I'm unfamiliar with the serial-port code, but I did already suspect
> that the change was causing some extra interrupt which somehow
> interfered with the rx side.
> 
> >> The issue has been seen on and the revert has been tested on
> >> the following HW:
> >>
> >> Asus T100TA
> >> SoC: Bay Trail UART: 80860F0A WIFI: brcmfmac43241b4-sdio BT: BCM4324B3
> >>
> >> Lenovo Yoga Tablet 2 1051L
> >> SoC: Bay Trail UART: 80860F0A WIFI: brcmfmac43241b4-sdio BT: BCM4324B3
> >>
> >> Lenovo Yoga Book X91F
> >> Soc: Cherry Trail UART: 8086228A WIFI: brcmfmac4356-pcie BT: BCM4356A2
> >>
> >> I have more hw which I believe is affected but these are the models
> >> where I have done detailed testing.
> >>
> >> I would be happy to test any patches, or run a kernel with some extra
> >> debugging added, just let me know what you need to help fixing this.
> > 
> > How easy this is to trigger in general? (Mainly trying to gauge how 
> > easy it will be to find the read and/or the irq that related to the 
> > corrupted payload).
> 
> For the git bisect I did 10 consecutive "rmmod hci_uart; modprobe hci_uart"
> calls, re-initializing and re-uploading the BT firmware 10 times and
> then looked for "Frame reassembly failed" errors (+ more error caused
> by this error) from the drivers/bluetooth/hci_bcm.c code.
> 
> This would usually trigger at least twice with the 10 rmmod + modprobe
> calls and typically more often then twice.
> 
> With the revert (and with 5.18.y) I never see a single error even
> with more rmmod + modprobe calls. Note it is not just the driver's
> probe() which fails, sometimes there are also later errors, this
> is just a somewhat convenient way to reproduce.
> 
> So this is somewhat easy to trigger, not trivial to trigger,
> but it also does not take waiting many hours before hitting it
> once.

Okay, maybe the patch below will manage to filter the interesting part of 
it (not tested beyond compiling). It should capture a few irq events after 
the THRI is set when DMA Tx completes.

What I'd expect is to have iir value variation between the working and not 
working case. Especially, if it's UART_IIR_THRI that shows up that might 
be usable as a condition to return from handle_rx_dma() without touching
DMA Rx.

From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH] DEBUG: DMA Rx problem

A DEBUG PATCH, not intended for upstream inclusing.

---
 drivers/tty/serial/8250/8250_dma.c  |  4 +++-
 drivers/tty/serial/8250/8250_port.c | 13 +++++++++++++
 include/linux/serial_8250.h         |  1 +
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_dma.c b/drivers/tty/serial/8250/8250_dma.c
index 7fa66501792d..20d54abdded2 100644
--- a/drivers/tty/serial/8250/8250_dma.c
+++ b/drivers/tty/serial/8250/8250_dma.c
@@ -32,8 +32,10 @@ static void __dma_tx_complete(void *param)
 		uart_write_wakeup(&p->port);
 
 	ret = serial8250_tx_dma(p);
-	if (ret || !dma->tx_running)
+	if (ret || !dma->tx_running) {
+		p->irq_debug = -5;
 		serial8250_set_THRI(p);
+	}
 
 	spin_unlock_irqrestore(&p->port.lock, flags);
 }
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index fa43df05342b..193c08b1888a 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1923,6 +1923,9 @@ int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
 	struct uart_8250_port *up = up_to_u8250p(port);
 	bool skip_rx = false;
 	unsigned long flags;
+	long irq_debug;
+	unsigned int tx_running = 0, rx_running = 0, tx_err = 0;
+	unsigned int ier;
 	u16 status;
 
 	if (iir & UART_IIR_NO_INT)
@@ -1931,6 +1934,12 @@ int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
 	spin_lock_irqsave(&port->lock, flags);
 
 	status = serial_lsr_in(up);
+	if (up->dma) {
+		rx_running = up->dma->rx_running;
+		tx_running = up->dma->tx_running;
+		tx_err = up->dma->tx_err;
+	}
+	ier = up->ier;
 
 	/*
 	 * If port is stopped and there are no error conditions in the
@@ -1957,7 +1966,11 @@ int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
 			__stop_tx(up);
 	}
 
+	irq_debug = up->irq_debug++;
 	uart_unlock_and_check_sysrq_irqrestore(port, flags);
+	if (irq_debug < 0)
+		pr_err("8250irq: iir=%02x lsr+saved=%02x ier=%02x dma_t/rx/err=%u/%u/%u skiprx=%d cnt=%ld\n",
+		       iir, status, ier, tx_running, rx_running, tx_err, skip_rx, irq_debug);
 
 	return 1;
 }
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index 741ed4807a9c..8d9d7de6728d 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -107,6 +107,7 @@ struct uart_8250_port {
 	unsigned char		mcr;
 	unsigned char		cur_iotype;	/* Running I/O type */
 	unsigned int		rpm_tx_active;
+	long			irq_debug;
 	unsigned char		canary;		/* non-zero during system sleep
 						 *   if no_console_suspend
 						 */

-- 
tg: (571079f5ba93..) debug/dma-rx-problem (depends on: tty-next)
--8323329-1460968984-1678794514=:2593--
