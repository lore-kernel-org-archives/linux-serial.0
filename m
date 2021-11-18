Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C71C433EF
	for <linux-serial@archiver.kernel.org>; Thu, 18 Nov 2021 07:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C21561875
	for <linux-serial@archiver.kernel.org>; Thu, 18 Nov 2021 07:31:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243865AbhKRHe3 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 18 Nov 2021 02:34:29 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:46346 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243836AbhKRHe1 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 18 Nov 2021 02:34:27 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 4645F218B0;
        Thu, 18 Nov 2021 07:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637220687; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=twCXtdNMFjK6+ut7YGNVcpyx3BxA2wQIdmMshhy9FjQ=;
        b=G+IBM6FQOkwklFAl1mJ3zA6yFkJowqIe1IH11aQABUvx8rF8hXyuNUuxetxLuPqT4kAWDj
        TpJYFfs6sDeCY11CyVZOSIuf55oIYJbxqqTyFHcvH4Ycol4jlx2bJsf5Jm1OpvnAtAijCt
        baZusufTad0/PpHTcwyCEMQb2JRvfCA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637220687;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=twCXtdNMFjK6+ut7YGNVcpyx3BxA2wQIdmMshhy9FjQ=;
        b=+1w3owIhhMe5GLYfnAOryi3kVGSQ/N2oSwNXE+OeSBT+NeI+4ld3LCiujvW6O93iA4DdGp
        KEFlGAa1yYJZoZBQ==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 272B8A3B83;
        Thu, 18 Nov 2021 07:31:27 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 04/19] mxser: move MSR read to mxser_check_modem_status()
Date:   Thu, 18 Nov 2021 08:31:10 +0100
Message-Id: <20211118073125.12283-5-jslaby@suse.cz>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211118073125.12283-1-jslaby@suse.cz>
References: <20211118073125.12283-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The MSR read is currently performed on both places where
mxser_check_modem_status() is called. So move it there to avoid code
duplication.

Rename the variable to msr while we move it, to actually see what
"status" we are testing.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/mxser.c | 46 ++++++++++++++++++++++++---------------------
 1 file changed, 25 insertions(+), 21 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index c8a56b0d900d..3d5c20e31836 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -683,27 +683,34 @@ static void mxser_change_speed(struct tty_struct *tty, struct ktermios *old_term
 	outb(cval, info->ioaddr + UART_LCR);
 }
 
-static void mxser_check_modem_status(struct tty_struct *tty,
-				struct mxser_port *port, int status)
+static u8 mxser_check_modem_status(struct tty_struct *tty,
+				struct mxser_port *port)
 {
+	u8 msr = inb(port->ioaddr + UART_MSR);
+
+	if (!(msr & UART_MSR_ANY_DELTA))
+		return msr;
+
 	/* update input line counters */
-	if (status & UART_MSR_TERI)
+	if (msr & UART_MSR_TERI)
 		port->icount.rng++;
-	if (status & UART_MSR_DDSR)
+	if (msr & UART_MSR_DDSR)
 		port->icount.dsr++;
-	if (status & UART_MSR_DDCD)
+	if (msr & UART_MSR_DDCD)
 		port->icount.dcd++;
-	if (status & UART_MSR_DCTS)
+	if (msr & UART_MSR_DCTS)
 		port->icount.cts++;
 	wake_up_interruptible(&port->port.delta_msr_wait);
 
-	if (tty_port_check_carrier(&port->port) && (status & UART_MSR_DDCD)) {
-		if (status & UART_MSR_DCD)
+	if (tty_port_check_carrier(&port->port) && (msr & UART_MSR_DDCD)) {
+		if (msr & UART_MSR_DCD)
 			wake_up_interruptible(&port->port.open_wait);
 	}
 
 	if (tty_port_cts_enabled(&port->port))
-		mxser_handle_cts(tty, port, status);
+		mxser_handle_cts(tty, port, msr);
+
+	return msr;
 }
 
 static void mxser_disable_and_clear_FIFO(struct mxser_port *info)
@@ -1135,25 +1142,24 @@ static int mxser_get_lsr_info(struct mxser_port *info,
 static int mxser_tiocmget(struct tty_struct *tty)
 {
 	struct mxser_port *info = tty->driver_data;
-	unsigned char control, status;
+	unsigned char control;
 	unsigned long flags;
+	u8 msr;
 
 	if (tty_io_error(tty))
 		return -EIO;
 
 	spin_lock_irqsave(&info->slock, flags);
 	control = info->MCR;
-	status = inb(info->ioaddr + UART_MSR);
-	if (status & UART_MSR_ANY_DELTA)
-		mxser_check_modem_status(tty, info, status);
+	msr = mxser_check_modem_status(tty, info);
 	spin_unlock_irqrestore(&info->slock, flags);
 
 	return ((control & UART_MCR_RTS) ? TIOCM_RTS : 0) |
 		    ((control & UART_MCR_DTR) ? TIOCM_DTR : 0) |
-		    ((status & UART_MSR_DCD) ? TIOCM_CAR : 0) |
-		    ((status & UART_MSR_RI) ? TIOCM_RNG : 0) |
-		    ((status & UART_MSR_DSR) ? TIOCM_DSR : 0) |
-		    ((status & UART_MSR_CTS) ? TIOCM_CTS : 0);
+		    ((msr & UART_MSR_DCD) ? TIOCM_CAR : 0) |
+		    ((msr & UART_MSR_RI) ? TIOCM_RNG : 0) |
+		    ((msr & UART_MSR_DSR) ? TIOCM_DSR : 0) |
+		    ((msr & UART_MSR_CTS) ? TIOCM_CTS : 0);
 }
 
 static int mxser_tiocmset(struct tty_struct *tty,
@@ -1656,7 +1662,7 @@ static void mxser_transmit_chars(struct tty_struct *tty, struct mxser_port *port
 static bool mxser_port_isr(struct mxser_port *port)
 {
 	struct tty_struct *tty;
-	u8 iir, msr, status;
+	u8 iir, status;
 	bool error = false;
 
 	iir = inb(port->ioaddr + UART_IIR);
@@ -1689,9 +1695,7 @@ static bool mxser_port_isr(struct mxser_port *port)
 			status = mxser_receive_chars(tty, port, status);
 	}
 
-	msr = inb(port->ioaddr + UART_MSR);
-	if (msr & UART_MSR_ANY_DELTA)
-		mxser_check_modem_status(tty, port, msr);
+	mxser_check_modem_status(tty, port);
 
 	if (port->board->must_hwid) {
 		if (iir == 0x02 && (status & UART_LSR_THRE))
-- 
2.33.1

