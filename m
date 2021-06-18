Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA45C49EA3
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2422961154
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:15:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232990AbhFRGRl (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 18 Jun 2021 02:17:41 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:58952 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232862AbhFRGR2 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 18 Jun 2021 02:17:28 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B405821B4D;
        Fri, 18 Jun 2021 06:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623996918; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/BStP6RpxFDwuUTjL7UXZHaSYbkwvTAEWBd7rzHAhSk=;
        b=j3fO9gS0j4DuQ7GWwEC4fajCtWN0poji6ZlJxXsIlvcm1GxTMCped9sTfAiuUSz+iVgsQe
        w8vePjnNpvtR4IOwdaBm2VSc/At0X3LrmMKTNuSIW30ra3mNQvnwCEMa08h2sQ4meAX8VM
        oiWDv/oSTrA4W6ghA5tLLcXXJH2firc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623996918;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/BStP6RpxFDwuUTjL7UXZHaSYbkwvTAEWBd7rzHAhSk=;
        b=T7Kk7+Ub9PGwY4YvOw5HdwfXILJlkMAA7wi0PrCcXrTFLicxW6l3PTGwoCBb/QHokFmg1P
        48s21Hru1xBQPxDw==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 7EEA8A3B99;
        Fri, 18 Jun 2021 06:15:18 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 07/70] mxser: rename mxser_board::chip_flag to must_hwid
Date:   Fri, 18 Jun 2021 08:14:13 +0200
Message-Id: <20210618061516.662-8-jslaby@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618061516.662-1-jslaby@suse.cz>
References: <20210618061516.662-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

It is named IsMoxaMustChipFlag in the original Moxa's driver. Over the
time, it was reduced to chip_flag which doesn't make much sense. So dub
it again by what it is: must_hwid (mxser_must_get_hwid assigns to it).

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/mxser.c | 70 ++++++++++++++++++++++-----------------------
 1 file changed, 35 insertions(+), 35 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index 72e1aeabdee7..1865f965334a 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -370,7 +370,7 @@ struct mxser_board {
 	unsigned long vector;
 	unsigned long vector_mask;
 
-	int chip_flag;
+	int must_hwid;
 	int uart_type;
 
 	struct mxser_port ports[MXSER_PORTS_PER_BOARD];
@@ -616,7 +616,7 @@ static void process_txrx_fifo(struct mxser_port *info)
 		info->xmit_fifo_size = 1;
 	} else
 		for (i = 0; i < UART_INFO_NUM; i++)
-			if (info->board->chip_flag == Gpci_uart_info[i].type) {
+			if (info->board->must_hwid == Gpci_uart_info[i].type) {
 				info->rx_low_water = Gpci_uart_info[i].rx_low_water;
 				info->rx_high_water = Gpci_uart_info[i].rx_high_water;
 				info->xmit_fifo_size = Gpci_uart_info[i].fifo_size;
@@ -775,7 +775,7 @@ static void mxser_change_speed(struct tty_struct *tty)
 		cval |= UART_LCR_SPAR;
 
 	if ((info->type == PORT_8250) || (info->type == PORT_16450)) {
-		if (info->board->chip_flag) {
+		if (info->board->must_hwid) {
 			fcr = UART_FCR_ENABLE_FIFO;
 			fcr |= MOXA_MUST_FCR_GDA_MODE_ENABLE;
 			mxser_set_must_fifo_value(info);
@@ -783,7 +783,7 @@ static void mxser_change_speed(struct tty_struct *tty)
 			fcr = 0;
 	} else {
 		fcr = UART_FCR_ENABLE_FIFO;
-		if (info->board->chip_flag) {
+		if (info->board->must_hwid) {
 			fcr |= MOXA_MUST_FCR_GDA_MODE_ENABLE;
 			mxser_set_must_fifo_value(info);
 		} else {
@@ -810,7 +810,7 @@ static void mxser_change_speed(struct tty_struct *tty)
 	tty_port_set_cts_flow(&info->port, cflag & CRTSCTS);
 	if (cflag & CRTSCTS) {
 		info->IER |= UART_IER_MSI;
-		if ((info->type == PORT_16550A) || (info->board->chip_flag)) {
+		if ((info->type == PORT_16550A) || (info->board->must_hwid)) {
 			info->MCR |= UART_MCR_AFE;
 		} else {
 			status = inb(info->ioaddr + UART_MSR);
@@ -818,7 +818,7 @@ static void mxser_change_speed(struct tty_struct *tty)
 				if (status & UART_MSR_CTS) {
 					tty->hw_stopped = 0;
 					if (info->type != PORT_16550A &&
-							!info->board->chip_flag) {
+							!info->board->must_hwid) {
 						outb(info->IER & ~UART_IER_THRI,
 							info->ioaddr +
 							UART_IER);
@@ -832,7 +832,7 @@ static void mxser_change_speed(struct tty_struct *tty)
 				if (!(status & UART_MSR_CTS)) {
 					tty->hw_stopped = 1;
 					if ((info->type != PORT_16550A) &&
-							(!info->board->chip_flag)) {
+							(!info->board->must_hwid)) {
 						info->IER &= ~UART_IER_THRI;
 						outb(info->IER, info->ioaddr +
 								UART_IER);
@@ -876,7 +876,7 @@ static void mxser_change_speed(struct tty_struct *tty)
 						UART_LSR_FE;
 		}
 	}
-	if (info->board->chip_flag) {
+	if (info->board->must_hwid) {
 		mxser_set_must_xon1_value(info->ioaddr, START_CHAR(tty));
 		mxser_set_must_xoff1_value(info->ioaddr, STOP_CHAR(tty));
 		if (I_IXON(tty)) {
@@ -926,7 +926,7 @@ static void mxser_check_modem_status(struct tty_struct *tty,
 				tty->hw_stopped = 0;
 
 				if ((port->type != PORT_16550A) &&
-						(!port->board->chip_flag)) {
+						(!port->board->must_hwid)) {
 					outb(port->IER & ~UART_IER_THRI,
 						port->ioaddr + UART_IER);
 					port->IER |= UART_IER_THRI;
@@ -939,7 +939,7 @@ static void mxser_check_modem_status(struct tty_struct *tty,
 			if (!(status & UART_MSR_CTS)) {
 				tty->hw_stopped = 1;
 				if (port->type != PORT_16550A &&
-						!port->board->chip_flag) {
+						!port->board->must_hwid) {
 					port->IER &= ~UART_IER_THRI;
 					outb(port->IER, port->ioaddr +
 							UART_IER);
@@ -973,7 +973,7 @@ static int mxser_activate(struct tty_port *port, struct tty_struct *tty)
 	 * Clear the FIFO buffers and disable them
 	 * (they will be reenabled in mxser_change_speed())
 	 */
-	if (info->board->chip_flag)
+	if (info->board->must_hwid)
 		outb((UART_FCR_CLEAR_RCVR |
 			UART_FCR_CLEAR_XMIT |
 			MOXA_MUST_FCR_GDA_MODE_ENABLE), info->ioaddr + UART_FCR);
@@ -1015,7 +1015,7 @@ static int mxser_activate(struct tty_port *port, struct tty_struct *tty)
 	 */
 	info->IER = UART_IER_MSI | UART_IER_RLSI | UART_IER_RDI;
 
-	if (info->board->chip_flag)
+	if (info->board->must_hwid)
 		info->IER |= MOXA_MUST_IER_EGDAI;
 	outb(info->IER, info->ioaddr + UART_IER);	/* enable interrupts */
 
@@ -1067,7 +1067,7 @@ static void mxser_shutdown_port(struct tty_port *port)
 	outb(0x00, info->ioaddr + UART_IER);
 
 	/* clear Rx/Tx FIFO's */
-	if (info->board->chip_flag)
+	if (info->board->must_hwid)
 		outb(UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT |
 				MOXA_MUST_FCR_GDA_MODE_ENABLE,
 				info->ioaddr + UART_FCR);
@@ -1079,7 +1079,7 @@ static void mxser_shutdown_port(struct tty_port *port)
 	(void) inb(info->ioaddr + UART_RX);
 
 
-	if (info->board->chip_flag)
+	if (info->board->must_hwid)
 		SET_MOXA_MUST_NO_SOFTWARE_FLOW_CONTROL(info->ioaddr);
 
 	spin_unlock_irqrestore(&info->slock, flags);
@@ -1139,7 +1139,7 @@ static void mxser_close_port(struct tty_port *port)
 	 * line status register.
 	 */
 	info->IER &= ~UART_IER_RLSI;
-	if (info->board->chip_flag)
+	if (info->board->must_hwid)
 		info->IER &= ~MOXA_MUST_RECV_ISR;
 
 	outb(info->IER, info->ioaddr + UART_IER);
@@ -1217,7 +1217,7 @@ static int mxser_write(struct tty_struct *tty, const unsigned char *buf, int cou
 	if (info->xmit_cnt && !tty->flow.stopped) {
 		if (!tty->hw_stopped ||
 				(info->type == PORT_16550A) ||
-				(info->board->chip_flag)) {
+				(info->board->must_hwid)) {
 			spin_lock_irqsave(&info->slock, flags);
 			outb(info->IER & ~UART_IER_THRI, info->ioaddr +
 					UART_IER);
@@ -1248,7 +1248,7 @@ static int mxser_put_char(struct tty_struct *tty, unsigned char ch)
 	if (!tty->flow.stopped) {
 		if (!tty->hw_stopped ||
 				(info->type == PORT_16550A) ||
-				info->board->chip_flag) {
+				info->board->must_hwid) {
 			spin_lock_irqsave(&info->slock, flags);
 			outb(info->IER & ~UART_IER_THRI, info->ioaddr + UART_IER);
 			info->IER |= UART_IER_THRI;
@@ -1267,7 +1267,7 @@ static void mxser_flush_chars(struct tty_struct *tty)
 
 	if (info->xmit_cnt <= 0 || tty->flow.stopped || !info->port.xmit_buf ||
 			(tty->hw_stopped && info->type != PORT_16550A &&
-			 !info->board->chip_flag))
+			 !info->board->must_hwid))
 		return;
 
 	spin_lock_irqsave(&info->slock, flags);
@@ -1631,7 +1631,7 @@ static int mxser_ioctl_special(unsigned int cmd, void __user *argp)
 				if (ip->type == PORT_16550A)
 					me->fifo[p] = 1;
 
-				if (ip->board->chip_flag == MOXA_MUST_MU860_HWID) {
+				if (ip->board->must_hwid == MOXA_MUST_MU860_HWID) {
 					opmode = inb(ip->opmode_ioaddr)>>((p % 4) * 2);
 					opmode &= OP_MODE_MASK;
 				} else {
@@ -1691,7 +1691,7 @@ static int mxser_ioctl(struct tty_struct *tty,
 		int shiftbit;
 		unsigned char val, mask;
 
-		if (info->board->chip_flag != MOXA_MUST_MU860_HWID)
+		if (info->board->must_hwid != MOXA_MUST_MU860_HWID)
 			return -EFAULT;
 
 		p = tty->index % 4;
@@ -1853,7 +1853,7 @@ static void mxser_stoprx(struct tty_struct *tty)
 
 	info->ldisc_stop_rx = 1;
 	if (I_IXOFF(tty)) {
-		if (info->board->chip_flag) {
+		if (info->board->must_hwid) {
 			info->IER &= ~MOXA_MUST_RECV_ISR;
 			outb(info->IER, info->ioaddr + UART_IER);
 		} else {
@@ -1889,7 +1889,7 @@ static void mxser_unthrottle(struct tty_struct *tty)
 		if (info->x_char)
 			info->x_char = 0;
 		else {
-			if (info->board->chip_flag) {
+			if (info->board->must_hwid) {
 				info->IER |= MOXA_MUST_RECV_ISR;
 				outb(info->IER, info->ioaddr + UART_IER);
 			} else {
@@ -1958,7 +1958,7 @@ static void mxser_set_termios(struct tty_struct *tty, struct ktermios *old_termi
 	if ((old_termios->c_iflag & IXON) && !I_IXON(tty)) {
 		tty->flow.stopped = 0;
 
-		if (info->board->chip_flag) {
+		if (info->board->must_hwid) {
 			spin_lock_irqsave(&info->slock, flags);
 			mxser_disable_must_rx_software_flow_control(
 					info->ioaddr);
@@ -2068,11 +2068,11 @@ static void mxser_receive_chars(struct tty_struct *tty,
 	recv_room = tty->receive_room;
 	if (recv_room == 0 && !port->ldisc_stop_rx)
 		mxser_stoprx(tty);
-	if (port->board->chip_flag != MOXA_OTHER_UART) {
+	if (port->board->must_hwid != MOXA_OTHER_UART) {
 
 		if (*status & UART_LSR_SPECIAL)
 			goto intr_old;
-		if (port->board->chip_flag == MOXA_MUST_MU860_HWID &&
+		if (port->board->must_hwid == MOXA_MUST_MU860_HWID &&
 				(*status & MOXA_MUST_LSR_RERR))
 			goto intr_old;
 		if (*status & MOXA_MUST_LSR_RERR)
@@ -2080,7 +2080,7 @@ static void mxser_receive_chars(struct tty_struct *tty,
 
 		gdl = inb(port->ioaddr + MOXA_MUST_GDL_REGISTER);
 
-		if (port->board->chip_flag == MOXA_MUST_MU150_HWID)
+		if (port->board->must_hwid == MOXA_MUST_MU150_HWID)
 			gdl &= MOXA_MUST_GDL_MASK;
 		if (gdl >= recv_room) {
 			if (!port->ldisc_stop_rx)
@@ -2100,7 +2100,7 @@ static void mxser_receive_chars(struct tty_struct *tty,
 			break;
 
 		ch = inb(port->ioaddr + UART_RX);
-		if (port->board->chip_flag && (*status & UART_LSR_OE))
+		if (port->board->must_hwid && (*status & UART_LSR_OE))
 			outb(0x23, port->ioaddr + UART_FCR);
 		*status &= port->read_status_mask;
 		if (*status & port->ignore_status_mask) {
@@ -2137,7 +2137,7 @@ static void mxser_receive_chars(struct tty_struct *tty,
 
 		}
 
-		if (port->board->chip_flag)
+		if (port->board->must_hwid)
 			break;
 
 		*status = inb(port->ioaddr + UART_LSR);
@@ -2171,7 +2171,7 @@ static void mxser_transmit_chars(struct tty_struct *tty, struct mxser_port *port
 	if (port->xmit_cnt <= 0 || tty->flow.stopped ||
 			(tty->hw_stopped &&
 			(port->type != PORT_16550A) &&
-			(!port->board->chip_flag))) {
+			(!port->board->must_hwid))) {
 		port->IER &= ~UART_IER_THRI;
 		outb(port->IER, port->ioaddr + UART_IER);
 		return;
@@ -2267,7 +2267,7 @@ static irqreturn_t mxser_interrupt(int irq, void *dev_id)
 				if (status & UART_LSR_BI)
 					port->err_shadow |= NPPI_NOTIFY_BREAK;
 
-				if (port->board->chip_flag) {
+				if (port->board->must_hwid) {
 					if (iir == MOXA_MUST_IIR_GDA ||
 					    iir == MOXA_MUST_IIR_RDA ||
 					    iir == MOXA_MUST_IIR_RTO ||
@@ -2285,7 +2285,7 @@ static irqreturn_t mxser_interrupt(int irq, void *dev_id)
 				if (msr & UART_MSR_ANY_DELTA)
 					mxser_check_modem_status(tty, port, msr);
 
-				if (port->board->chip_flag) {
+				if (port->board->must_hwid) {
 					if (iir == 0x02 && (status &
 								UART_LSR_THRE))
 						mxser_transmit_chars(tty, port);
@@ -2357,7 +2357,7 @@ static int mxser_initbrd(struct mxser_board *brd)
 		info->ldisc_stop_rx = 0;
 
 		/* Enhance mode enabled here */
-		if (brd->chip_flag != MOXA_OTHER_UART)
+		if (brd->must_hwid != MOXA_OTHER_UART)
 			mxser_enable_must_enchance_mode(info->ioaddr);
 
 		info->type = brd->uart_type;
@@ -2452,13 +2452,13 @@ static int mxser_probe(struct pci_dev *pdev,
 	/* irq */
 	brd->irq = pdev->irq;
 
-	brd->chip_flag = mxser_must_get_hwid(brd->ports[0].ioaddr);
+	brd->must_hwid = mxser_must_get_hwid(brd->ports[0].ioaddr);
 	brd->uart_type = PORT_16550A;
 	brd->vector_mask = 0;
 
 	for (i = 0; i < brd->info->nports; i++) {
 		for (j = 0; j < UART_INFO_NUM; j++) {
-			if (Gpci_uart_info[j].type == brd->chip_flag) {
+			if (Gpci_uart_info[j].type == brd->must_hwid) {
 				brd->ports[i].max_baud =
 					Gpci_uart_info[j].max_baud;
 
@@ -2470,7 +2470,7 @@ static int mxser_probe(struct pci_dev *pdev,
 		}
 	}
 
-	if (brd->chip_flag == MOXA_MUST_MU860_HWID) {
+	if (brd->must_hwid == MOXA_MUST_MU860_HWID) {
 		for (i = 0; i < brd->info->nports; i++) {
 			if (i < 4)
 				brd->ports[i].opmode_ioaddr = ioaddress + 4;
-- 
2.32.0

