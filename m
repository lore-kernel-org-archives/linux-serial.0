Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7CD346E70;
	Wed, 19 Nov 2025 10:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763546514; cv=none; b=dMWhx9bvatxm0FwmhQIocswPQLpTXWRsDecV8aC9AQG2k7CPPS/pQiCUEX4GA208/q6MHVYczWEby3fvesjgV6X6oFtHWVWDV1V0ApEX0bEhsCY99fXlgFv2AbxHixwmlHdFbGnHeuEPHUrdPL1U5zPVWgPCCPmCzYs4qiSPBtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763546514; c=relaxed/simple;
	bh=FBfLHQ3P3iL1raCnmEfum+XMNjqj6e2eQvLJgf3EJE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bsYgdGReIy1ZEF323bBjqX1su2xZ5DYKtJnHavNNGz4qsjxxYvwj6N5gkpmmldL2S6W1JP+Ng7mgG9N2gsirLIKtpLlFKby+eGwThbBMqWgPYlDcuvTev6oA9Y3gcybOlnSWQX+vuqDRQ+MXIr10Ywqipx22+8groZ0FrYUAimo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VbiBUJ9W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VbiBUJ9W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B003C4AF09;
	Wed, 19 Nov 2025 10:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763546513;
	bh=FBfLHQ3P3iL1raCnmEfum+XMNjqj6e2eQvLJgf3EJE4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VbiBUJ9WWFb49wtDA1uLmDoIzpYV8YZ3Yd0c8I/LXOoW52K/MMiDZt+CiirwAhdC5
	 Sfga4ffl+yuZNbZgBnf4dfOLm0fxpAwXV8O/FXwx7WUvj9ZRzUAnxtR8ojRMDGAoh5
	 MhPkQt9qkxRxRzI1BcSBDXtz51wUba3fjoiDWTiUd/+2tX5WyhL0OkAZw1gbh95Hdi
	 ClO5GxjHa2mYJ402yitNRnIwf5+o6nbVeo6K39/48qQliV/RIx+0JM7Sj+zM5N0lIq
	 JTvw55FFTArnEmCwBZxMpOpPDZ9Ya56VfLNdqrOlOJ4yUF2TwSkifvjVzKdKFiMvwz
	 VchqOWbumx9EA==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 05/10] tty: moxa: use guard()s
Date: Wed, 19 Nov 2025 11:01:35 +0100
Message-ID: <20251119100140.830761-6-jirislaby@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251119100140.830761-1-jirislaby@kernel.org>
References: <20251119100140.830761-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use guards in the moxa code. This improves readability, makes error
handling easier, and marks locked portions of code explicit. All that
while being sure the lock is unlocked.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/moxa.c | 169 ++++++++++++++++++++-------------------------
 1 file changed, 73 insertions(+), 96 deletions(-)

diff --git a/drivers/tty/moxa.c b/drivers/tty/moxa.c
index 329b30fac8fc..1bb2376af85c 100644
--- a/drivers/tty/moxa.c
+++ b/drivers/tty/moxa.c
@@ -487,25 +487,20 @@ static void moxa_wait_finish(void __iomem *ofsAddr)
 
 static void moxafunc(void __iomem *ofsAddr, u16 cmd, u16 arg)
 {
-        unsigned long flags;
-        spin_lock_irqsave(&moxafunc_lock, flags);
+	guard(spinlock_irqsave)(&moxafunc_lock);
 	writew(arg, ofsAddr + FuncArg);
 	writew(cmd, ofsAddr + FuncCode);
 	moxa_wait_finish(ofsAddr);
-	spin_unlock_irqrestore(&moxafunc_lock, flags);
 }
 
 static int moxafuncret(void __iomem *ofsAddr, u16 cmd, u16 arg)
 {
-        unsigned long flags;
-        u16 ret;
-        spin_lock_irqsave(&moxafunc_lock, flags);
+	guard(spinlock_irqsave)(&moxafunc_lock);
 	writew(arg, ofsAddr + FuncArg);
 	writew(cmd, ofsAddr + FuncCode);
 	moxa_wait_finish(ofsAddr);
-	ret = readw(ofsAddr + FuncArg);
-	spin_unlock_irqrestore(&moxafunc_lock, flags);
-	return ret;
+
+	return readw(ofsAddr + FuncArg);
 }
 
 static void moxa_low_water_check(void __iomem *ofsAddr)
@@ -1002,11 +997,11 @@ static int moxa_init_board(struct moxa_board_conf *brd, struct device *dev)
 	if (ret)
 		goto err_free;
 
-	spin_lock_bh(&moxa_lock);
-	brd->ready = 1;
-	if (!timer_pending(&moxaTimer))
-		mod_timer(&moxaTimer, jiffies + HZ / 50);
-	spin_unlock_bh(&moxa_lock);
+	scoped_guard(spinlock_bh, &moxa_lock) {
+		brd->ready = 1;
+		if (!timer_pending(&moxaTimer))
+			mod_timer(&moxaTimer, jiffies + HZ / 50);
+	}
 
 	first_idx = (brd - moxa_boards) * MAX_PORTS_PER_BOARD;
 	for (i = 0; i < brd->numPorts; i++)
@@ -1026,29 +1021,29 @@ static void moxa_board_deinit(struct moxa_board_conf *brd)
 {
 	unsigned int a, opened, first_idx;
 
-	mutex_lock(&moxa_openlock);
-	spin_lock_bh(&moxa_lock);
-	brd->ready = 0;
-	spin_unlock_bh(&moxa_lock);
-
-	/* pci hot-un-plug support */
-	for (a = 0; a < brd->numPorts; a++)
-		if (tty_port_initialized(&brd->ports[a].port))
-			tty_port_tty_hangup(&brd->ports[a].port, false);
-
-	for (a = 0; a < MAX_PORTS_PER_BOARD; a++)
-		tty_port_destroy(&brd->ports[a].port);
+	scoped_guard(mutex, &moxa_openlock) {
+		scoped_guard(spinlock_bh, &moxa_lock)
+			brd->ready = 0;
 
-	while (1) {
-		opened = 0;
+		/* pci hot-un-plug support */
 		for (a = 0; a < brd->numPorts; a++)
 			if (tty_port_initialized(&brd->ports[a].port))
-				opened++;
-		mutex_unlock(&moxa_openlock);
-		if (!opened)
-			break;
-		msleep(50);
-		mutex_lock(&moxa_openlock);
+				tty_port_tty_hangup(&brd->ports[a].port, false);
+
+		for (a = 0; a < MAX_PORTS_PER_BOARD; a++)
+			tty_port_destroy(&brd->ports[a].port);
+
+		while (1) {
+			opened = 0;
+			for (a = 0; a < brd->numPorts; a++)
+				if (tty_port_initialized(&brd->ports[a].port))
+					opened++;
+			if (!opened)
+				break;
+			mutex_unlock(&moxa_openlock);
+			msleep(50);
+			mutex_lock(&moxa_openlock);
+		}
 	}
 
 	first_idx = (brd - moxa_boards) * MAX_PORTS_PER_BOARD;
@@ -1206,12 +1201,9 @@ static void moxa_shutdown(struct tty_port *port)
 static bool moxa_carrier_raised(struct tty_port *port)
 {
 	struct moxa_port *ch = container_of(port, struct moxa_port, port);
-	int dcd;
 
-	spin_lock_irq(&port->lock);
-	dcd = ch->DCDState;
-	spin_unlock_irq(&port->lock);
-	return dcd;
+	guard(spinlock_irq)(&port->lock);
+	return ch->DCDState;
 }
 
 static void moxa_dtr_rts(struct tty_port *port, bool active)
@@ -1225,37 +1217,31 @@ static int moxa_open(struct tty_struct *tty, struct file *filp)
 {
 	struct moxa_board_conf *brd;
 	struct moxa_port *ch;
-	int port;
-
-	port = tty->index;
-	if (mutex_lock_interruptible(&moxa_openlock))
-		return -ERESTARTSYS;
-	brd = &moxa_boards[port / MAX_PORTS_PER_BOARD];
-	if (!brd->ready) {
-		mutex_unlock(&moxa_openlock);
-		return -ENODEV;
-	}
+	int port = tty->index;
 
-	if (port % MAX_PORTS_PER_BOARD >= brd->numPorts) {
-		mutex_unlock(&moxa_openlock);
-		return -ENODEV;
-	}
-
-	ch = &brd->ports[port % MAX_PORTS_PER_BOARD];
-	ch->port.count++;
-	tty->driver_data = ch;
-	tty_port_tty_set(&ch->port, tty);
-	mutex_lock(&ch->port.mutex);
-	if (!tty_port_initialized(&ch->port)) {
-		ch->statusflags = 0;
-		moxa_set_tty_param(tty, &tty->termios);
-		MoxaPortLineCtrl(ch, true, true);
-		MoxaPortEnable(ch);
-		MoxaSetFifo(ch, ch->type == PORT_16550A);
-		tty_port_set_initialized(&ch->port, true);
+	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &moxa_openlock) {
+		brd = &moxa_boards[port / MAX_PORTS_PER_BOARD];
+		if (!brd->ready)
+			return -ENODEV;
+
+		if (port % MAX_PORTS_PER_BOARD >= brd->numPorts)
+			return -ENODEV;
+
+		ch = &brd->ports[port % MAX_PORTS_PER_BOARD];
+		ch->port.count++;
+		tty->driver_data = ch;
+		tty_port_tty_set(&ch->port, tty);
+
+		guard(mutex)(&ch->port.mutex);
+		if (!tty_port_initialized(&ch->port)) {
+			ch->statusflags = 0;
+			moxa_set_tty_param(tty, &tty->termios);
+			MoxaPortLineCtrl(ch, true, true);
+			MoxaPortEnable(ch);
+			MoxaSetFifo(ch, ch->type == PORT_16550A);
+			tty_port_set_initialized(&ch->port, true);
+		}
 	}
-	mutex_unlock(&ch->port.mutex);
-	mutex_unlock(&moxa_openlock);
 
 	return tty_port_block_til_ready(&ch->port, tty, filp);
 }
@@ -1270,15 +1256,13 @@ static void moxa_close(struct tty_struct *tty, struct file *filp)
 static ssize_t moxa_write(struct tty_struct *tty, const u8 *buf, size_t count)
 {
 	struct moxa_port *ch = tty->driver_data;
-	unsigned long flags;
 	int len;
 
 	if (ch == NULL)
 		return 0;
 
-	spin_lock_irqsave(&moxa_lock, flags);
-	len = MoxaPortWriteData(tty, buf, count);
-	spin_unlock_irqrestore(&moxa_lock, flags);
+	scoped_guard(spinlock_irqsave, &moxa_lock)
+		len = MoxaPortWriteData(tty, buf, count);
 
 	set_bit(LOWWAIT, &ch->statusflags);
 	return len;
@@ -1349,12 +1333,10 @@ static int moxa_tiocmset(struct tty_struct *tty,
 	bool dtr_active, rts_active;
 	struct moxa_port *ch;
 
-	mutex_lock(&moxa_openlock);
+	guard(mutex)(&moxa_openlock);
 	ch = tty->driver_data;
-	if (!ch) {
-		mutex_unlock(&moxa_openlock);
+	if (!ch)
 		return -EINVAL;
-	}
 
 	MoxaPortGetLineOut(ch, &dtr_active, &rts_active);
 	if (set & TIOCM_RTS)
@@ -1366,7 +1348,7 @@ static int moxa_tiocmset(struct tty_struct *tty,
 	if (clear & TIOCM_DTR)
 		dtr_active = false;
 	MoxaPortLineCtrl(ch, dtr_active, rts_active);
-	mutex_unlock(&moxa_openlock);
+
 	return 0;
 }
 
@@ -1415,18 +1397,17 @@ static void moxa_hangup(struct tty_struct *tty)
 
 static void moxa_new_dcdstate(struct moxa_port *p, u8 dcd)
 {
-	unsigned long flags;
 	dcd = !!dcd;
 
-	spin_lock_irqsave(&p->port.lock, flags);
-	if (dcd != p->DCDState) {
-        	p->DCDState = dcd;
-        	spin_unlock_irqrestore(&p->port.lock, flags);
-		if (!dcd)
-			tty_port_tty_hangup(&p->port, true);
+	scoped_guard(spinlock_irqsave, &p->port.lock) {
+		if (dcd == p->DCDState)
+			return;
+
+		p->DCDState = dcd;
 	}
-	else
-		spin_unlock_irqrestore(&p->port.lock, flags);
+
+	if (!dcd)
+		tty_port_tty_hangup(&p->port, true);
 }
 
 static int moxa_poll_port(struct moxa_port *p, unsigned int handle,
@@ -1494,7 +1475,7 @@ static void moxa_poll(struct timer_list *unused)
 	u16 __iomem *ip;
 	unsigned int card, port, served = 0;
 
-	spin_lock(&moxa_lock);
+	guard(spinlock)(&moxa_lock);
 	for (card = 0; card < MAX_BOARDS; card++) {
 		brd = &moxa_boards[card];
 		if (!brd->ready)
@@ -1525,7 +1506,6 @@ static void moxa_poll(struct timer_list *unused)
 
 	if (served)
 		mod_timer(&moxaTimer, jiffies + HZ / 50);
-	spin_unlock(&moxa_lock);
 }
 
 /******************************************************************************/
@@ -1861,13 +1841,11 @@ static int MoxaPortSetTermio(struct moxa_port *port, struct ktermios *termio,
 	baud = MoxaPortSetBaud(port, baud);
 
 	if (termio->c_iflag & (IXON | IXOFF | IXANY)) {
-	        spin_lock_irq(&moxafunc_lock);
+		guard(spinlock_irq)(&moxafunc_lock);
 		writeb(termio->c_cc[VSTART], ofsAddr + FuncArg);
 		writeb(termio->c_cc[VSTOP], ofsAddr + FuncArg1);
 		writeb(FC_SetXonXoff, ofsAddr + FuncCode);
 		moxa_wait_finish(ofsAddr);
-		spin_unlock_irq(&moxafunc_lock);
-
 	}
 	return baud;
 }
@@ -2098,13 +2076,13 @@ static int moxa_get_serial_info(struct tty_struct *tty,
 
 	if (!info)
 		return -ENODEV;
-	mutex_lock(&info->port.mutex);
+	guard(mutex)(&info->port.mutex);
 	ss->type = info->type;
 	ss->line = info->port.tty->index;
 	ss->flags = info->port.flags;
 	ss->baud_base = 921600;
 	ss->close_delay = jiffies_to_msecs(info->port.close_delay) / 10;
-	mutex_unlock(&info->port.mutex);
+
 	return 0;
 }
 
@@ -2120,13 +2098,12 @@ static int moxa_set_serial_info(struct tty_struct *tty,
 
 	close_delay = msecs_to_jiffies(ss->close_delay * 10);
 
-	mutex_lock(&info->port.mutex);
+	guard(mutex)(&info->port.mutex);
 	if (!capable(CAP_SYS_ADMIN)) {
 		if (close_delay != info->port.close_delay ||
 		    ss->type != info->type ||
 		    ((ss->flags & ~ASYNC_USR_MASK) !=
 		     (info->port.flags & ~ASYNC_USR_MASK))) {
-			mutex_unlock(&info->port.mutex);
 			return -EPERM;
 		}
 	} else {
@@ -2136,7 +2113,7 @@ static int moxa_set_serial_info(struct tty_struct *tty,
 
 		info->type = ss->type;
 	}
-	mutex_unlock(&info->port.mutex);
+
 	return 0;
 }
 
-- 
2.51.1

