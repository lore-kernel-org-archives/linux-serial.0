Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7218C48BE8
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1806611CE
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:15:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233127AbhFRGRy (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 18 Jun 2021 02:17:54 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:46730 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232959AbhFRGRl (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 18 Jun 2021 02:17:41 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 4B5181FDFF;
        Fri, 18 Jun 2021 06:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623996922; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HVNftH2elFpyV4ZFJ0ppe+gUsXfPcwSN+vuhKzxbcNg=;
        b=vacjIbXq6NajWAl9FyZNIhZcvCLbvKGLhZ+FBlFB/0PjFdglJfJJksFpAYb/9iX+OIocM6
        g2Q2IgLPtHfsFPo/cGStVa17gw10HymoMcV0gqVnPnPI+1HfJAUOUuRQR8MTKJz7ZzUHS+
        SKZ3RPRcaKR9QPLem/zV9I0Wf9hde0U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623996922;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HVNftH2elFpyV4ZFJ0ppe+gUsXfPcwSN+vuhKzxbcNg=;
        b=hBB0Q23ptgX+iMII4IhZsukCCWrSAUkarHN02OtAdop0EJMc+HvlWaiYUjD1h1de+nHo+v
        XFOvYbh7NTsrVnAA==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 25C68A3BA2;
        Fri, 18 Jun 2021 06:15:22 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 24/70] mxser: remove MOXA_ASPP_MON and friends
Date:   Fri, 18 Jun 2021 08:14:30 +0200
Message-Id: <20210618061516.662-25-jslaby@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618061516.662-1-jslaby@suse.cz>
References: <20210618061516.662-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

1) MOXA_ASPP_MON_EXT is broken at least since commit ecbbfd44a08f (TTY:
   move tty buffers to tty_port) in 2012.
2) The ioctl definitions were never exposed to userspace, so noone should
   actually be reliably using them.
3) They're not even mentioned in any of the mxser utilities.

So remove all these mxser-special ioctls: MOXA_ASPP_MON,
MOXA_ASPP_MON_EXT, and MOXA_SDS_RSTICOUNTER.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/mxser.c | 184 --------------------------------------------
 1 file changed, 184 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index cf3b8f9f7e1e..68c2f2346dcf 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -63,11 +63,8 @@
 #define RS485_4WIRE_MODE	3
 #define OP_MODE_MASK		3
 
-#define MOXA_SDS_RSTICOUNTER	(MOXA + 69)
 #define MOXA_ASPP_OQUEUE	(MOXA + 70)
-#define MOXA_ASPP_MON		(MOXA + 73)
 #define MOXA_ASPP_LSTATUS	(MOXA + 74)
-#define MOXA_ASPP_MON_EXT	(MOXA + 75)
 
 /* --------------------------------------------------- */
 
@@ -77,11 +74,6 @@
 #define NPPI_NOTIFY_SW_OVERRUN	0x08
 #define NPPI_NOTIFY_BREAK	0x10
 
-#define NPPI_NOTIFY_CTSHOLD         0x01	/* Tx hold by CTS low */
-#define NPPI_NOTIFY_DSRHOLD         0x02	/* Tx hold by DSR low */
-#define NPPI_NOTIFY_XOFFHOLD        0x08	/* Tx hold by Xoff received */
-#define NPPI_NOTIFY_XOFFXENT        0x10	/* Xoff Sent */
-
 /*
  * Follow just what Moxa Must chip defines.
  *
@@ -290,31 +282,6 @@ struct mxser_log {
 	unsigned long txcnt[MXSER_PORTS];
 };
 
-struct mxser_mon {
-	unsigned long rxcnt;
-	unsigned long txcnt;
-	unsigned long up_rxcnt;
-	unsigned long up_txcnt;
-	int modem_status;
-	unsigned char hold_reason;
-};
-
-struct mxser_mon_ext {
-	unsigned long rx_cnt[32];
-	unsigned long tx_cnt[32];
-	unsigned long up_rxcnt[32];
-	unsigned long up_txcnt[32];
-	int modem_status[32];
-
-	long baudrate[32];
-	int databits[32];
-	int stopbits[32];
-	int parity[32];
-	int flowctrl[32];
-	int fifo[32];
-	int iftype[32];
-};
-
 struct mxser_board;
 
 struct mxser_port {
@@ -352,8 +319,6 @@ struct mxser_port {
 
 	struct ktermios normal_termios;
 
-	struct mxser_mon mon_data;
-
 	spinlock_t slock;
 };
 
@@ -616,22 +581,6 @@ static void process_txrx_fifo(struct mxser_port *info)
 			}
 }
 
-static unsigned char mxser_get_msr(int baseaddr, int mode, int port)
-{
-	static unsigned char mxser_msr[MXSER_PORTS + 1];
-	unsigned char status = 0;
-
-	status = inb(baseaddr + UART_MSR);
-
-	mxser_msr[port] &= 0x0F;
-	mxser_msr[port] |= status;
-	status = mxser_msr[port];
-	if (mode)
-		mxser_msr[port] = 0;
-
-	return status;
-}
-
 static int mxser_carrier_raised(struct tty_port *port)
 {
 	struct mxser_port *mp = container_of(port, struct mxser_port, port);
@@ -903,7 +852,6 @@ static void mxser_check_modem_status(struct tty_struct *tty,
 		port->icount.dcd++;
 	if (status & UART_MSR_DCTS)
 		port->icount.cts++;
-	port->mon_data.modem_status = status;
 	wake_up_interruptible(&port->port.delta_msr_wait);
 
 	if (tty_port_check_carrier(&port->port) && (status & UART_MSR_DDCD)) {
@@ -1544,93 +1492,6 @@ static int mxser_ioctl_special(unsigned int cmd, void __user *argp)
 			}
 		return 0;
 	}
-	case MOXA_ASPP_MON_EXT: {
-		struct mxser_mon_ext *me; /* it's 2k, stack unfriendly */
-		unsigned int cflag, iflag, p;
-		u8 opmode;
-
-		me = kzalloc(sizeof(*me), GFP_KERNEL);
-		if (!me)
-			return -ENOMEM;
-
-		for (i = 0, p = 0; i < MXSER_BOARDS; i++) {
-			for (j = 0; j < MXSER_PORTS_PER_BOARD; j++, p++) {
-				if (p >= ARRAY_SIZE(me->rx_cnt)) {
-					i = MXSER_BOARDS;
-					break;
-				}
-				ip = &mxser_boards[i].ports[j];
-				port = &ip->port;
-
-				mutex_lock(&port->mutex);
-				if (!ip->ioaddr) {
-					mutex_unlock(&port->mutex);
-					continue;
-				}
-
-				spin_lock_irq(&ip->slock);
-				status = mxser_get_msr(ip->ioaddr, 0, p);
-
-				if (status & UART_MSR_TERI)
-					ip->icount.rng++;
-				if (status & UART_MSR_DDSR)
-					ip->icount.dsr++;
-				if (status & UART_MSR_DDCD)
-					ip->icount.dcd++;
-				if (status & UART_MSR_DCTS)
-					ip->icount.cts++;
-
-				ip->mon_data.modem_status = status;
-				me->rx_cnt[p] = ip->mon_data.rxcnt;
-				me->tx_cnt[p] = ip->mon_data.txcnt;
-				me->up_rxcnt[p] = ip->mon_data.up_rxcnt;
-				me->up_txcnt[p] = ip->mon_data.up_txcnt;
-				me->modem_status[p] =
-					ip->mon_data.modem_status;
-				spin_unlock_irq(&ip->slock);
-
-				tty = tty_port_tty_get(&ip->port);
-
-				if (!tty) {
-					cflag = ip->normal_termios.c_cflag;
-					iflag = ip->normal_termios.c_iflag;
-					me->baudrate[p] = tty_termios_baud_rate(&ip->normal_termios);
-				} else {
-					cflag = tty->termios.c_cflag;
-					iflag = tty->termios.c_iflag;
-					me->baudrate[p] = tty_get_baud_rate(tty);
-				}
-				tty_kref_put(tty);
-
-				me->databits[p] = cflag & CSIZE;
-				me->stopbits[p] = cflag & CSTOPB;
-				me->parity[p] = cflag & (PARENB | PARODD |
-						CMSPAR);
-
-				if (cflag & CRTSCTS)
-					me->flowctrl[p] |= 0x03;
-
-				if (iflag & (IXON | IXOFF))
-					me->flowctrl[p] |= 0x0C;
-
-				if (ip->type == PORT_16550A)
-					me->fifo[p] = 1;
-
-				if (ip->board->must_hwid == MOXA_MUST_MU860_HWID) {
-					opmode = inb(ip->opmode_ioaddr)>>((p % 4) * 2);
-					opmode &= OP_MODE_MASK;
-				} else {
-					opmode = RS232_MODE;
-				}
-				me->iftype[p] = opmode;
-				mutex_unlock(&port->mutex);
-			}
-		}
-		if (copy_to_user(argp, me, sizeof(*me)))
-			ret = -EFAULT;
-		kfree(me);
-		return ret;
-	}
 	default:
 		return -ENOIOCTLCMD;
 	}
@@ -1729,13 +1590,6 @@ static int mxser_ioctl(struct tty_struct *tty,
 				mxser_cflags_changed(info, arg, &cnow));
 	case MOXA_HighSpeedOn:
 		return put_user(info->baud_base != 115200 ? 1 : 0, (int __user *)argp);
-	case MOXA_SDS_RSTICOUNTER:
-		spin_lock_irq(&info->slock);
-		info->mon_data.rxcnt = 0;
-		info->mon_data.txcnt = 0;
-		spin_unlock_irq(&info->slock);
-		return 0;
-
 	case MOXA_ASPP_OQUEUE:{
 		int len, lsr;
 
@@ -1747,37 +1601,6 @@ static int mxser_ioctl(struct tty_struct *tty,
 
 		return put_user(len, (int __user *)argp);
 	}
-	case MOXA_ASPP_MON: {
-		int mcr, status;
-
-		spin_lock_irq(&info->slock);
-		status = mxser_get_msr(info->ioaddr, 1, tty->index);
-		mxser_check_modem_status(tty, info, status);
-
-		mcr = inb(info->ioaddr + UART_MCR);
-		spin_unlock_irq(&info->slock);
-
-		if (mcr & MOXA_MUST_MCR_XON_FLAG)
-			info->mon_data.hold_reason &= ~NPPI_NOTIFY_XOFFHOLD;
-		else
-			info->mon_data.hold_reason |= NPPI_NOTIFY_XOFFHOLD;
-
-		if (mcr & MOXA_MUST_MCR_TX_XON)
-			info->mon_data.hold_reason &= ~NPPI_NOTIFY_XOFFXENT;
-		else
-			info->mon_data.hold_reason |= NPPI_NOTIFY_XOFFXENT;
-
-		if (tty->hw_stopped)
-			info->mon_data.hold_reason |= NPPI_NOTIFY_CTSHOLD;
-		else
-			info->mon_data.hold_reason &= ~NPPI_NOTIFY_CTSHOLD;
-
-		if (copy_to_user(argp, &info->mon_data,
-				sizeof(struct mxser_mon)))
-			return -EFAULT;
-
-		return 0;
-	}
 	case MOXA_ASPP_LSTATUS: {
 		if (put_user(info->err_shadow, (unsigned char __user *)argp))
 			return -EFAULT;
@@ -2135,8 +1958,6 @@ static u8 mxser_receive_chars(struct tty_struct *tty,
 		status = mxser_receive_chars_old(tty, port, status, &cnt);
 
 	mxvar_log.rxcnt[tty->index] += cnt;
-	port->mon_data.rxcnt += cnt;
-	port->mon_data.up_rxcnt += cnt;
 
 	tty_flip_buffer_push(&port->port);
 
@@ -2151,8 +1972,6 @@ static void mxser_transmit_chars(struct tty_struct *tty, struct mxser_port *port
 		outb(port->x_char, port->ioaddr + UART_TX);
 		port->x_char = 0;
 		mxvar_log.txcnt[tty->index]++;
-		port->mon_data.txcnt++;
-		port->mon_data.up_txcnt++;
 		port->icount.tx++;
 		return;
 	}
@@ -2180,8 +1999,6 @@ static void mxser_transmit_chars(struct tty_struct *tty, struct mxser_port *port
 	} while (--count > 0);
 	mxvar_log.txcnt[tty->index] += (cnt - port->xmit_cnt);
 
-	port->mon_data.txcnt += (cnt - port->xmit_cnt);
-	port->mon_data.up_txcnt += (cnt - port->xmit_cnt);
 	port->icount.tx += (cnt - port->xmit_cnt);
 
 	if (port->xmit_cnt < WAKEUP_CHARS)
@@ -2355,7 +2172,6 @@ static int mxser_initbrd(struct mxser_board *brd)
 		info->port.close_delay = 5 * HZ / 10;
 		info->port.closing_wait = 30 * HZ;
 		info->normal_termios = mxvar_sdriver->init_termios;
-		memset(&info->mon_data, 0, sizeof(struct mxser_mon));
 		info->err_shadow = 0;
 		spin_lock_init(&info->slock);
 
-- 
2.32.0

