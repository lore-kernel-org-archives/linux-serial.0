Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64DEAC11F67
	for <linux-serial@archiver.kernel.org>; Wed, 14 Jul 2021 09:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 508BF61374
	for <linux-serial@archiver.kernel.org>; Wed, 14 Jul 2021 09:13:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238701AbhGNJQQ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 14 Jul 2021 05:16:16 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:57932 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238714AbhGNJQL (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 14 Jul 2021 05:16:11 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 16D252059F;
        Wed, 14 Jul 2021 09:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1626253997; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=slgsQLbMauzb11h5EbvFPoEpmJPXsIL8ogu9um/wcF4=;
        b=X6ItR0KfxCKLrw8vQ5eH8cWAOULlhdg4kpTF5/guqn6m9d1+8ntCVJfWacxk0pZmCsPz38
        /XcoGGdhMT96Q0acMGEpsPhLBND2r9o1fPFnq+VdSTa53RTghRrvkMx9TmHYOV+L3NWqxO
        MqfAxcUM4SYdw12626p/Xi5sKmr2b7M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1626253997;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=slgsQLbMauzb11h5EbvFPoEpmJPXsIL8ogu9um/wcF4=;
        b=pzkISy03AXuA3+YhLoQbwYAcT2g35HDMaauRh0F05oPTTdeKfli/z6QTLaoUf+SknyCMPB
        vu4iXnyAOnbB0UCg==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E7F3AA3B85;
        Wed, 14 Jul 2021 09:13:16 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 08/11] amiserial: expand "custom"
Date:   Wed, 14 Jul 2021 11:13:11 +0200
Message-Id: <20210714091314.8292-8-jslaby@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210714091314.8292-1-jslaby@suse.cz>
References: <20210714091314.8292-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

"custom" macro is a too generic name. Expand it -- that is use
amiga_custom on all the locations.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/amiserial.c | 86 ++++++++++++++++++++---------------------
 1 file changed, 42 insertions(+), 44 deletions(-)

diff --git a/drivers/tty/amiserial.c b/drivers/tty/amiserial.c
index 51b51c5acf96..4658df1b5623 100644
--- a/drivers/tty/amiserial.c
+++ b/drivers/tty/amiserial.c
@@ -87,8 +87,6 @@ struct serial_state {
 	int			x_char;	/* xon/xoff character */
 };
 
-#define custom amiga_custom
-
 static struct tty_driver *serial_driver;
 
 /* number of characters left in xmit buffer before we ask for more */
@@ -148,9 +146,9 @@ static void rs_stop(struct tty_struct *tty)
 	if (info->IER & UART_IER_THRI) {
 		info->IER &= ~UART_IER_THRI;
 		/* disable Tx interrupt and remove any pending interrupts */
-		custom.intena = IF_TBE;
+		amiga_custom.intena = IF_TBE;
 		mb();
-		custom.intreq = IF_TBE;
+		amiga_custom.intreq = IF_TBE;
 		mb();
 	}
 	local_irq_restore(flags);
@@ -166,10 +164,10 @@ static void rs_start(struct tty_struct *tty)
 	    && info->xmit.buf
 	    && !(info->IER & UART_IER_THRI)) {
 		info->IER |= UART_IER_THRI;
-		custom.intena = IF_SETCLR | IF_TBE;
+		amiga_custom.intena = IF_SETCLR | IF_TBE;
 		mb();
 		/* set a pending Tx Interrupt, transmitter should restart now */
-		custom.intreq = IF_SETCLR | IF_TBE;
+		amiga_custom.intreq = IF_SETCLR | IF_TBE;
 		mb();
 	}
 	local_irq_restore(flags);
@@ -194,9 +192,9 @@ static void receive_chars(struct serial_state *info)
 	icount = &info->icount;
 
 	status = UART_LSR_DR; /* We obviously have a character! */
-	serdatr = custom.serdatr;
+	serdatr = amiga_custom.serdatr;
 	mb();
-	custom.intreq = IF_RBF;
+	amiga_custom.intreq = IF_RBF;
 	mb();
 
 	if((serdatr & 0x1ff) == 0)
@@ -273,10 +271,10 @@ static void receive_chars(struct serial_state *info)
 
 static void transmit_chars(struct serial_state *info)
 {
-	custom.intreq = IF_TBE;
+	amiga_custom.intreq = IF_TBE;
 	mb();
 	if (info->x_char) {
-	        custom.serdat = info->x_char | 0x100;
+	        amiga_custom.serdat = info->x_char | 0x100;
 		mb();
 		info->icount.tx++;
 		info->x_char = 0;
@@ -286,12 +284,12 @@ static void transmit_chars(struct serial_state *info)
 	    || info->tport.tty->flow.stopped
 	    || info->tport.tty->hw_stopped) {
 		info->IER &= ~UART_IER_THRI;
-	        custom.intena = IF_TBE;
+	        amiga_custom.intena = IF_TBE;
 		mb();
 		return;
 	}
 
-	custom.serdat = info->xmit.buf[info->xmit.tail++] | 0x100;
+	amiga_custom.serdat = info->xmit.buf[info->xmit.tail++] | 0x100;
 	mb();
 	info->xmit.tail = info->xmit.tail & (SERIAL_XMIT_SIZE-1);
 	info->icount.tx++;
@@ -305,7 +303,7 @@ static void transmit_chars(struct serial_state *info)
 	printk("THRE...");
 #endif
 	if (info->xmit.head == info->xmit.tail) {
-	        custom.intena = IF_TBE;
+	        amiga_custom.intena = IF_TBE;
 		mb();
 		info->IER &= ~UART_IER_THRI;
 	}
@@ -358,10 +356,10 @@ static void check_modem_status(struct serial_state *info)
 #endif
 				port->tty->hw_stopped = 0;
 				info->IER |= UART_IER_THRI;
-				custom.intena = IF_SETCLR | IF_TBE;
+				amiga_custom.intena = IF_SETCLR | IF_TBE;
 				mb();
 				/* set a pending Tx Interrupt, transmitter should restart now */
-				custom.intreq = IF_SETCLR | IF_TBE;
+				amiga_custom.intreq = IF_SETCLR | IF_TBE;
 				mb();
 				tty_wakeup(port->tty);
 				return;
@@ -374,9 +372,9 @@ static void check_modem_status(struct serial_state *info)
 				port->tty->hw_stopped = 1;
 				info->IER &= ~UART_IER_THRI;
 				/* disable Tx interrupt and remove any pending interrupts */
-				custom.intena = IF_TBE;
+				amiga_custom.intena = IF_TBE;
 				mb();
-				custom.intreq = IF_TBE;
+				amiga_custom.intreq = IF_TBE;
 				mb();
 			}
 		}
@@ -418,7 +416,7 @@ static irqreturn_t ser_tx_int(int irq, void *dev_id)
 {
 	struct serial_state *info = dev_id;
 
-	if (custom.serdatr & SDR_TBE) {
+	if (amiga_custom.serdatr & SDR_TBE) {
 #ifdef SERIAL_DEBUG_INTR
 	  printk("ser_tx_int...");
 #endif
@@ -478,7 +476,7 @@ static int startup(struct tty_struct *tty, struct serial_state *info)
 
 	/* Clear anything in the input buffer */
 
-	custom.intreq = IF_RBF;
+	amiga_custom.intreq = IF_RBF;
 	mb();
 
 	retval = request_irq(IRQ_AMIGA_VERTB, ser_vbl_int, 0, "serial status", info);
@@ -491,7 +489,7 @@ static int startup(struct tty_struct *tty, struct serial_state *info)
 	}
 
 	/* enable both Rx and Tx interrupts */
-	custom.intena = IF_SETCLR | IF_RBF | IF_TBE;
+	amiga_custom.intena = IF_SETCLR | IF_RBF | IF_TBE;
 	mb();
 	info->IER = UART_IER_MSI;
 
@@ -557,11 +555,11 @@ static void shutdown(struct tty_struct *tty, struct serial_state *info)
 	}
 
 	info->IER = 0;
-	custom.intena = IF_RBF | IF_TBE;
+	amiga_custom.intena = IF_RBF | IF_TBE;
 	mb();
 
 	/* disable break condition */
-	custom.adkcon = AC_UARTBRK;
+	amiga_custom.adkcon = AC_UARTBRK;
 	mb();
 
 	if (C_HUPCL(tty))
@@ -705,7 +703,7 @@ static void change_speed(struct tty_struct *tty, struct serial_state *info,
 	if(cval & UART_LCR_PARITY)
 	  serper |= (SERPER_PARENB);
 
-	custom.serper = serper;
+	amiga_custom.serper = serper;
 	mb();
 	}
 
@@ -749,10 +747,10 @@ static void rs_flush_chars(struct tty_struct *tty)
 
 	local_irq_save(flags);
 	info->IER |= UART_IER_THRI;
-	custom.intena = IF_SETCLR | IF_TBE;
+	amiga_custom.intena = IF_SETCLR | IF_TBE;
 	mb();
 	/* set a pending Tx Interrupt, transmitter should restart now */
-	custom.intreq = IF_SETCLR | IF_TBE;
+	amiga_custom.intreq = IF_SETCLR | IF_TBE;
 	mb();
 	local_irq_restore(flags);
 }
@@ -791,10 +789,10 @@ static int rs_write(struct tty_struct * tty, const unsigned char *buf, int count
 	    && !(info->IER & UART_IER_THRI)) {
 		info->IER |= UART_IER_THRI;
 		local_irq_disable();
-		custom.intena = IF_SETCLR | IF_TBE;
+		amiga_custom.intena = IF_SETCLR | IF_TBE;
 		mb();
 		/* set a pending Tx Interrupt, transmitter should restart now */
-		custom.intreq = IF_SETCLR | IF_TBE;
+		amiga_custom.intreq = IF_SETCLR | IF_TBE;
 		mb();
 		local_irq_restore(flags);
 	}
@@ -841,11 +839,11 @@ static void rs_send_xchar(struct tty_struct *tty, char ch)
 
 	        /* Check this ! */
 	        local_irq_save(flags);
-		if(!(custom.intenar & IF_TBE)) {
-		    custom.intena = IF_SETCLR | IF_TBE;
+		if(!(amiga_custom.intenar & IF_TBE)) {
+		    amiga_custom.intena = IF_SETCLR | IF_TBE;
 		    mb();
 		    /* set a pending Tx Interrupt, transmitter should restart now */
-		    custom.intreq = IF_SETCLR | IF_TBE;
+		    amiga_custom.intreq = IF_SETCLR | IF_TBE;
 		    mb();
 		}
 		local_irq_restore(flags);
@@ -1016,7 +1014,7 @@ static int get_lsr_info(struct serial_state *info, unsigned int __user *value)
 	unsigned long flags;
 
 	local_irq_save(flags);
-	status = custom.serdatr;
+	status = amiga_custom.serdatr;
 	mb();
 	local_irq_restore(flags);
 	result = ((status & SDR_TSRE) ? TIOCSER_TEMT : 0);
@@ -1078,9 +1076,9 @@ static int rs_break(struct tty_struct *tty, int break_state)
 
 	local_irq_save(flags);
 	if (break_state == -1)
-	  custom.adkcon = AC_SETCLR | AC_UARTBRK;
+	  amiga_custom.adkcon = AC_SETCLR | AC_UARTBRK;
 	else
-	  custom.adkcon = AC_UARTBRK;
+	  amiga_custom.adkcon = AC_UARTBRK;
 	mb();
 	local_irq_restore(flags);
 	return 0;
@@ -1257,10 +1255,10 @@ static void rs_close(struct tty_struct *tty, struct file * filp)
 	state->read_status_mask &= ~UART_LSR_DR;
 	if (tty_port_initialized(port)) {
 	        /* disable receive interrupts */
-	        custom.intena = IF_RBF;
+	        amiga_custom.intena = IF_RBF;
 		mb();
 		/* clear any pending receive interrupt */
-		custom.intreq = IF_RBF;
+		amiga_custom.intreq = IF_RBF;
 		mb();
 
 		/*
@@ -1319,7 +1317,7 @@ static void rs_wait_until_sent(struct tty_struct *tty, int timeout)
 	printk("In rs_wait_until_sent(%d) check=%lu...", timeout, char_time);
 	printk("jiff=%lu...", jiffies);
 #endif
-	while(!((lsr = custom.serdatr) & SDR_TSRE)) {
+	while(!((lsr = amiga_custom.serdatr) & SDR_TSRE)) {
 #ifdef SERIAL_DEBUG_RS_WAIT_UNTIL_SENT
 		printk("serdatr = %d (jiff=%lu)...", lsr, jiffies);
 #endif
@@ -1526,7 +1524,7 @@ static int __init amiga_serial_probe(struct platform_device *pdev)
 
 	state = rs_table;
 	memset(state, 0, sizeof(*state));
-	state->port = (int)&custom.serdatr; /* Just to give it a value */
+	state->port = (int)&amiga_custom.serdatr; /* Just to give it a value */
 	tty_port_init(&state->tport);
 	state->tport.ops = &amiga_port_ops;
 	tty_port_link_device(&state->tport, serial_driver, 0);
@@ -1554,11 +1552,11 @@ static int __init amiga_serial_probe(struct platform_device *pdev)
 	local_irq_save(flags);
 
 	/* turn off Rx and Tx interrupts */
-	custom.intena = IF_RBF | IF_TBE;
+	amiga_custom.intena = IF_RBF | IF_TBE;
 	mb();
 
 	/* clear any pending interrupt */
-	custom.intreq = IF_RBF | IF_TBE;
+	amiga_custom.intreq = IF_RBF | IF_TBE;
 	mb();
 
 	local_irq_restore(flags);
@@ -1618,8 +1616,8 @@ module_platform_driver_probe(amiga_serial_driver, amiga_serial_probe);
 
 static void amiga_serial_putc(char c)
 {
-	custom.serdat = (unsigned char)c | 0x100;
-	while (!(custom.serdatr & 0x2000))
+	amiga_custom.serdat = (unsigned char)c | 0x100;
+	while (!(amiga_custom.serdatr & 0x2000))
 		barrier();
 }
 
@@ -1632,9 +1630,9 @@ static void amiga_serial_putc(char c)
 static void serial_console_write(struct console *co, const char *s,
 				unsigned count)
 {
-	unsigned short intena = custom.intenar;
+	unsigned short intena = amiga_custom.intenar;
 
-	custom.intena = IF_TBE;
+	amiga_custom.intena = IF_TBE;
 
 	while (count--) {
 		if (*s == '\n')
@@ -1642,7 +1640,7 @@ static void serial_console_write(struct console *co, const char *s,
 		amiga_serial_putc(*s++);
 	}
 
-	custom.intena = IF_SETCLR | (intena & IF_TBE);
+	amiga_custom.intena = IF_SETCLR | (intena & IF_TBE);
 }
 
 static struct tty_driver *serial_console_device(struct console *c, int *index)
-- 
2.32.0

