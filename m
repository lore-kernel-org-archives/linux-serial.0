Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D862C77B7D
	for <linux-serial@archiver.kernel.org>; Wed, 10 May 2023 10:58:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbjEJK62 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 10 May 2023 06:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236295AbjEJK60 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 10 May 2023 06:58:26 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 902171733
        for <linux-serial@vger.kernel.org>; Wed, 10 May 2023 03:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683716304; x=1715252304;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=1hPfYegMPeQEo2LiTQf8D/TfBBhhhZrY3hKMUEsPmiw=;
  b=LBpYiiukSucrQrAf+1k69Ql7C9mdSLCaZlpPM2VhlUJHTkgVMJ1qnvAj
   AbWRgerdJ45WMHPJxg5lpjfNa8sMZz0OUkjFwXVE6yt/8v5IBYepWyg3d
   MOURVT11qFZFXDeMG73iCSEL7RJfERoAseYZBL3YGy+uwpM50dAIdDjUb
   AhobP3rRMSqHGWmjeALy70/BpvHsTys/EofEQB5B47xNd7yGlbRB6FX7b
   jeLgZ3INQvcfu/4Abgj6ytgxRoMdjgp8IhhLMUbATyx2AKHoA6MGoqMNl
   KDpiJQbTRSveo4DGLfJrfTN27+88d3apzLGB86JzuqcqhlbrA1tfv1MAJ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10705"; a="436506908"
X-IronPort-AV: E=Sophos;i="5.99,264,1677571200"; 
   d="scan'208";a="436506908"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2023 03:58:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10705"; a="788887511"
X-IronPort-AV: E=Sophos;i="5.99,264,1677571200"; 
   d="scan'208";a="788887511"
Received: from sschutze-mobl.ger.corp.intel.com ([10.251.218.236])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2023 03:58:21 -0700
Date:   Wed, 10 May 2023 13:58:19 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     qianfan <qianfanguijin@163.com>
cc:     linux-serial <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: serial8250: can not change baudrate while the controller is
 busy
In-Reply-To: <6cefcc6d-266f-64f0-91fc-93815b627828@163.com>
Message-ID: <9dffec2c-f0ed-fbd9-9ce8-5ea48f72784f@linux.intel.com>
References: <289bb78a-7509-1c5c-2923-a04ed3b6487d@163.com> <ab524eb-da1d-bf74-6d73-2defb7f7118@linux.intel.com> <d8693191-be31-b471-7ddc-b491daa48650@163.com> <20e0285b-47c8-2695-1be9-e5da981eef7c@linux.intel.com> <c66120b5-370a-778c-048d-a10ba04fe057@163.com>
 <e87414db-3482-c9f1-8212-3be1afb2c750@linux.intel.com> <eb286124-20b5-df7b-ac23-b54c07dc9a25@163.com> <4985eab-fd94-5468-9f59-3af72726193@linux.intel.com> <6cefcc6d-266f-64f0-91fc-93815b627828@163.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-372029734-1683716302=:2669"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-372029734-1683716302=:2669
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Tue, 9 May 2023, qianfan wrote:

> It's not constant, agreed. But your comment states that it's at most one
> frame worth of time so that should be the worst-case waiting time. Once
> the UART starts to do things like temporary switch to loopback and/or
> reinit/clearing FIFO, it doesn't seem that harmful to wait slightly
> longer for the worst-case frame time, so essentially you'd only need this
> (+ comment):
> 
> 	p->serial_out(p, UART_MCR, up->mcr | UART_MCR_LOOP);
> 	dw8250_force_idle(p);
> 	ndelay(p->frame_time);
> 	p->serial_out(p, UART_LCR, up->lcr | UART_LCR_DLAB);
> 
> If you insist, ndelay() could be replaced by:
> 	ret = read_poll_timeout_atomic(p->serial_in, usr, !(usr &
> DW_UART_USR_BUSY),
> 				       1, DIV_ROUND_UP(p->frame_time,
> NSEC_PER_USEC), false,
> 				       p, d->usr_reg);
> 
> You also don't explain why force_idle() is needed inside to loop, why
> doing it once before the loop is not enough? I can see the need for that
> in loop for dw8250_check_lcr() because it doesn't enable loopback, but
> here, so why?
> 
> Under my test, this code will not work:
> 
> p->serial_out(p, UART_MCR, up->mcr | UART_MCR_LOOP);
> dw8250_force_idle(p);
> /* waiting until not busy... */
> 
> Current byte maybe not finished when we set UART_MCR_LOOP and reset fifo,
> dw-uart will continue receive even if LOOP bit is set. After this byte
> is finished it will push data to rx fifo and remark BUSY flag again.
> That's why I leave dw8250_force_idle inside to loop.
> 
> It's a bit odd because BUSY should indicate a character is being received 
> (asserted around middle of the start bit according to the databook), not 
> 
> Is the databoot is public and may I read it?

I'm not sure. The title is "DesignWare DW_apb_uart Databook" in case that 
helps.

> that it was pushed to FIFO. Is it trying to indicate BUSY due to rxing 
> another character but then the hypothesis that enabling loopback takes at 
> most 1 frame would be false.
> 
> To understand better what's going on here during debugging, it might be 
> useful the check DR in LSR in the case when the BUSY is still held to 
> exclude data-in-RBR condition which is another condition that could 
> assert BUSY. Since the FIFO is being toggled off/on, there's window of 
> time when BUSY could be held due to something arriving into RBR.
> 
> IMHO, it would be nice if the FIFO reset turns out to be entirely 
> unnecessary for enforcing not-busy because of that very window of 
> receiving something into RBR. A character in RBR would need to be handled 
> by an extra read from UART_RX which is what dw8250_force_idle() actually 
> does, it looked earlier pretty magic to me but now realizing this race 
> window w/o FIFO, maybe that's the explanation. If FIFO reset is not 
> necessary, it would take away the need to understand how instanteneous 
> toggling UART_FCR_ENABLE_FIFO is wrt. arriving character.
> 
> Thanks and now I understand why we should read UART_RX register when dw8250_
> force_idle,
> the loopback mode takes affect right now when we set LOOP bit, the fifo is r
> eseted and
> the next incoming data will goto RBR register, not FIFO.
> 
> So the most important code in dw8250_force_idle after set loopback mode is r
> ead UART_RX, 
> not clear fifo. Is it right?
> 
> So the next code is better:
> p->serial_out(p, UART_MCR, up->mcr | UART_MCR_LOOP);
> if (p->serial_in(p, d->usr_reg) & DW_UART_USR_BUSY)
> 	ndelay(p->frame_time);
> dw8250_force_idle(p);
>
> Or maybe we should make dw8250_force_idle after ndelay such as:
> 
> p->serial_out(p, UART_MCR, up->mcr | UART_MCR_LOOP);
> ndelay(p->frame_time);
> dw8250_force_idle(p);
> 
> But that requires a test to see if it works.
> 
> Is Tx side empty during your test or can it interfere too here? (Just 
> thinking out loud, you probably considered that yourself).
> 
> I started to wonder whether dw8250_check_lcr() should also temporarily
> switch to loopback mode to ensure the UART becomes idle. Some common macro
> could be created which wraps the idle forcing for both use cases +
> restoring LCR & MCR. That is, dw8250_force_idle() + little bit extra ->
> __dw8250_idle_enter() and __dw8250_idle_exit() that are called by the
> macro.
> 
> Switch to loopback mode in dw8250_check_lcr is not enough. We also need intr
> oduce 
> sometings such as dw8250_check_dll() and dw8250_check_dlm(). That is not a g
> ood
> idea.

No. My point was that it would be nice to figure out a sequence of 
operations that is guaranteed to get BUSY deasserted. It helps both LCR 
(only) write problem and the divisor update problem because the cause for 
them seems to be the same.

So replacing dw8250_force_idle() with something like what is below might 
be useful.

I still don't understand why the FIFO needs to be disabled but included it 
into the idle sequence anyway.

In contrast to earlier:
  - FIFO is not reset but it could be added into the idle exit function if 
    it's a desirable feature.
  - IER is zeroed to prevent RBR filling triggering an interrupt (with 
    port's lock held here it's going to just keep attempt to acquire the 
    lock).
  - LCR write is handled as well (w/o now triggering extra FIFO reinits).
  - Flush DMA Rx


[PATCH 1/1] serial: 8250_dw: Ensure BUSY is deasserted

DW UART cannot write to LCR, DLL, and DLH while BUSY is asserted.
Existance of BUSY depends on uart_16550_compatible, if UART HW is
configured with 16550 compatible those registers can always be
written.

There currently is dw8250_force_idle() which attempts to archive
non-BUSY state by disabling FIFO, however, the solution is unreliable
when Rx keeps getting more and more characters.

Create a sequence of operations to enforce that ensures UART cannot
keep BUSY asserted indefinitely. The new sequence relies on enabling
loopback mode temporarily to prevent incoming Rx characters keeping
UART BUSY.

Use the new dw8250_idle_enter/exit() to do divisor writes and LCR
writes.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/8250/8250_dw.c    | 141 ++++++++++++++++++++-------
 drivers/tty/serial/8250/8250_dwlib.h |   1 +
 2 files changed, 106 insertions(+), 36 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 7db51781289e..c9d9b4bda36a 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -44,6 +44,8 @@
 /* DesignWare specific register fields */
 #define DW_UART_MCR_SIRE		BIT(6)
 
+#define DW_UART_USR_BUSY		BIT(0)
+
 /* Renesas specific register fields */
 #define RZN1_UART_xDMACR_DMA_EN		BIT(0)
 #define RZN1_UART_xDMACR_1_WORD_BURST	(0 << 1)
@@ -80,57 +82,123 @@ static inline int dw8250_modify_msr(struct uart_port *p, int offset, int value)
 	return value;
 }
 
-static void dw8250_force_idle(struct uart_port *p)
+/*
+ * Ensure BUSY is not asserted. If DW UART is configured with
+ * !uart_16550_compatible, the writes to LCR, DLL, and DLH fail while
+ * BUSY is asserted.
+ *
+ * Context: port's lock must be held
+ */
+static int dw8250_idle_enter(struct uart_port *p)
 {
+	struct dw8250_data *d = to_dw8250_data(p->private_data);
 	struct uart_8250_port *up = up_to_u8250p(p);
-	unsigned int lsr;
+	u32 lsr;
 
-	serial8250_clear_and_reinit_fifos(up);
+	if (d->uart_16550_compatible)
+		return 0;
 
-	/*
-	 * With PSLVERR_RESP_EN parameter set to 1, the device generates an
-	 * error response when an attempt to read an empty RBR with FIFO
-	 * enabled.
-	 */
-	if (up->fcr & UART_FCR_ENABLE_FIFO) {
-		lsr = p->serial_in(p, UART_LSR);
-		if (!(lsr & UART_LSR_DR))
-			return;
+	d->in_idle = 1;
+
+	/* Prevent triggering interrupt from RBR filling */
+	p->serial_out(p, UART_IER, 0);
+
+	serial8250_rx_dma_flush(up);
+	// What about Tx DMA? Should probably pause that too and resume
+	// afterwards.
+
+	p->serial_out(p, UART_MCR, up->mcr | UART_MCR_LOOP);
+	if (up->capabilities & UART_CAP_FIFO)
+		p->serial_out(p, UART_FCR, 0);
+
+	if (p->serial_in(p, d->pdata->usr_reg) & DW_UART_USR_BUSY)
+		ndelay(p->frame_time);
+
+	lsr = serial_lsr_in(up);
+	if (lsr & UART_LSR_DR) {
+		p->serial_in(p, UART_RX);
+		up->lsr_saved_flags = 0;
 	}
 
-	(void)p->serial_in(p, UART_RX);
+	/* Now guaranteed to have BUSY deasserted? Just sanity check */
+	if (p->serial_in(p, d->pdata->usr_reg) & DW_UART_USR_BUSY)
+		return -EBUSY;
+
+	return 0;
+}
+
+static void dw8250_idle_exit(struct uart_port *p)
+{
+	struct dw8250_data *d = to_dw8250_data(p->private_data);
+	struct uart_8250_port *up = up_to_u8250p(p);
+
+	if (d->uart_16550_compatible)
+		return;
+
+	if (up->capabilities & UART_CAP_FIFO)
+		p->serial_out(p, UART_FCR, up->fcr);
+	p->serial_out(p, UART_MCR, up->mcr);
+	p->serial_out(p, UART_IER, up->ier);
+
+	// Maybe move the DMA Rx restart check in dma_rx_complete() to own
+	// function (serial8250_rx_dma_restart()) and call it from here.
+	// DMA Tx resume
+
+	d->in_idle = 0;
+}
+
+static void dw8250_set_divisor(struct uart_port *p, unsigned int baud,
+			       unsigned int quot, unsigned int quot_frac)
+{
+	struct uart_8250_port *up = up_to_u8250p(p);
+	int ret;
+
+	ret = dw8250_idle_enter(p);
+	if (ret < 0)
+		goto idle_failed;
+
+	p->serial_out(p, UART_LCR, up->lcr | UART_LCR_DLAB);
+	if (!(p->serial_in(p, UART_LCR) & UART_LCR_DLAB))
+		goto idle_failed;
+
+	serial_dl_write(up, quot);
+	p->serial_out(p, UART_LCR, up->lcr);
+
+idle_failed:
+	dw8250_idle_exit(p);
 }
 
 static void dw8250_check_lcr(struct uart_port *p, int value)
 {
-	void __iomem *offset = p->membase + (UART_LCR << p->regshift);
-	int tries = 1000;
+	struct dw8250_data *d = to_dw8250_data(p->private_data);
+	unsigned int lcr = p->serial_in(p, UART_LCR);
+	int ret;
 
 	/* Make sure LCR write wasn't ignored */
-	while (tries--) {
-		unsigned int lcr = p->serial_in(p, UART_LCR);
-
-		if ((value & ~UART_LCR_SPAR) == (lcr & ~UART_LCR_SPAR))
-			return;
+	if ((value & ~UART_LCR_SPAR) == (lcr & ~UART_LCR_SPAR))
+		return;
 
-		dw8250_force_idle(p);
+	if (d->in_idle) {
+		/*
+		 * FIXME: this deadlocks if port->lock is already held
+		 * dev_err(p->dev, "Couldn't set LCR to %d\n", value);
+		 */
+		return;
+	}
 
-#ifdef CONFIG_64BIT
-		if (p->type == PORT_OCTEON)
-			__raw_writeq(value & 0xff, offset);
-		else
-#endif
-		if (p->iotype == UPIO_MEM32)
-			writel(value, offset);
-		else if (p->iotype == UPIO_MEM32BE)
-			iowrite32be(value, offset);
-		else
-			writeb(value, offset);
+	ret = dw8250_idle_enter(p);
+	if (ret < 0) {
+		/*
+		 * FIXME: this deadlocks if port->lock is already held
+		 * dev_err(p->dev, "Couldn't set LCR to %d\n", value);
+		 */
+		goto idle_failed;
 	}
-	/*
-	 * FIXME: this deadlocks if port->lock is already held
-	 * dev_err(p->dev, "Couldn't set LCR to %d\n", value);
-	 */
+
+	p->serial_out(p, UART_LCR, value);
+
+idle_failed:
+	dw8250_idle_exit(p);
 }
 
 /* Returns once the transmitter is empty or we run out of retries */
@@ -540,6 +608,7 @@ static int dw8250_probe(struct platform_device *pdev)
 	p->serial_out	= dw8250_serial_out;
 	p->set_ldisc	= dw8250_set_ldisc;
 	p->set_termios	= dw8250_set_termios;
+	p->set_divisor	= dw8250_set_divisor;
 
 	p->membase = devm_ioremap(dev, regs->start, resource_size(regs));
 	if (!p->membase)
diff --git a/drivers/tty/serial/8250/8250_dwlib.h b/drivers/tty/serial/8250/8250_dwlib.h
index f13e91f2cace..bafacd327fc4 100644
--- a/drivers/tty/serial/8250/8250_dwlib.h
+++ b/drivers/tty/serial/8250/8250_dwlib.h
@@ -45,6 +45,7 @@ struct dw8250_data {
 
 	unsigned int		skip_autocfg:1;
 	unsigned int		uart_16550_compatible:1;
+	unsigned int		in_idle:1;
 };
 
 void dw8250_do_set_termios(struct uart_port *p, struct ktermios *termios, const struct ktermios *old);
-- 
2.30.2

--8323329-372029734-1683716302=:2669--
