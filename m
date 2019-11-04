Return-Path: <SRS0=XcX2=Y4=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62060CA9EB5
	for <linux-serial@archiver.kernel.org>; Mon,  4 Nov 2019 19:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D5932089C
	for <linux-serial@archiver.kernel.org>; Mon,  4 Nov 2019 19:35:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qNfk7m2c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729486AbfKDTfk (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 4 Nov 2019 14:35:40 -0500
Received: from mail-vs1-f73.google.com ([209.85.217.73]:44868 "EHLO
        mail-vs1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728648AbfKDTfk (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 4 Nov 2019 14:35:40 -0500
Received: by mail-vs1-f73.google.com with SMTP id d75so2965351vsc.11
        for <linux-serial@vger.kernel.org>; Mon, 04 Nov 2019 11:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=yisbEcSz/LoCirQsA0dA4cexvGCv+dbGpxg+r+YmpUs=;
        b=qNfk7m2cHIHm4NUjpHDKHrxDSsY4pm7GwdOahoNwQVp23ydEEeW1edhkLHqo4l+NU8
         LLr0tbH6wSNdqe1lBnfrp/CqNQDOX/xQ2uAchPWhKICXJrif0TEAVeQy2cyYkckyImdW
         ny01h2pOyLhzMInjTy/fqhkPBZXULSe6W9vWXnDhdyGJegRhTZN1N/HqOl3KVDxW+M1L
         oLSNifyY3z8m4Znvs8EELruZaMp0lo3jnuZdBSwk2P+aEqzIvt+u0dAGsh+cR8+ZjQxx
         IbOPNzyysKOv4SOeghLCpweBE2XV6I983J65AGoxke/KFYAK6P11dpY2sWCnlknUop+N
         Ga7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=yisbEcSz/LoCirQsA0dA4cexvGCv+dbGpxg+r+YmpUs=;
        b=le7bmTZMTZTokzcSgeRpAD4QNsQHy00niKsFxux6gVrlnRxkF4DnCUDQi7wlSNBNyH
         n6Qwf1d6ZbHML+d7YC64OszlwfD9qpJU86ZqUyu8DiVMxPAv22d+s9n5I+w9B9i9GyPo
         3fWOtgddaitw7okCfJkR4PA5DgPRRtW8jfC+Khyk8UKQ6gPh5vEB3u4XgTAxTIJGA1Mj
         SE3B+w+jClxCCNdJxKLtguQ6ACfQOofYxXvZzHeR/I1GJsnDkYZo4knQ2Y/yhd7r9knj
         /xhvw59LfD6Uczw6ALIR2tDCCkARDR0+ZSz2ZSfrPuGiinuPtWiPE9F87jMAp8m80StM
         eWmw==
X-Gm-Message-State: APjAAAWTO9yEVEkaiG81+wd3EECYBkz/tLw7DtWhlzxmdwsdAUh9LT3C
        A+kQo5W3dSYxItmsnXUfyRTzmOv5RSPh
X-Google-Smtp-Source: APXvYqzDSr7DbIGlSRM7sgn3UZU8c9MCKBBheDsa0TrC+wLa7yN3iwH7uHCxeo4JL1PsGyuL511vh2d5RI8m
X-Received: by 2002:ab0:1d4:: with SMTP id 78mr13056443ual.6.1572896137326;
 Mon, 04 Nov 2019 11:35:37 -0800 (PST)
Date:   Mon,  4 Nov 2019 19:35:25 +0000
In-Reply-To: <20191004132256.GA715053@kroah.com>
Message-Id: <20191104193525.229055-1-pterjan@google.com>
Mime-Version: 1.0
References: <20191004132256.GA715053@kroah.com>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
Subject: [PATCH v3] Remove every trace of SERIAL_MAGIC
From:   Pascal Terjan <pterjan@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     Pascal Terjan <pterjan@google.com>, linux-serial@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This means removing support for some debugging code in amiserial.c
(SERIAL_PARANOIA_CHECK option), which was checking a magic field which
doesn't currently exist in the struct. That code hasn't built at least
since git.

Removing the definition from the header is safe anyway as that code was
from another driver and not including it.

Signed-off-by: Pascal Terjan <pterjan@google.com>
---
No code change in v3, only a less confusing description.

 Documentation/process/magic-number.rst        |  1 -
 .../it_IT/process/magic-number.rst            |  1 -
 .../zh_CN/process/magic-number.rst            |  1 -
 drivers/net/wan/z85230.h                      |  2 -
 drivers/tty/amiserial.c                       | 81 +------------------
 5 files changed, 1 insertion(+), 85 deletions(-)

diff --git a/Documentation/process/magic-number.rst b/Documentation/process/magic-number.rst
index 547bbf28e615..eee9b44553b3 100644
--- a/Documentation/process/magic-number.rst
+++ b/Documentation/process/magic-number.rst
@@ -81,7 +81,6 @@ FF_MAGIC              0x4646           fc_info                  ``drivers/net/ip
 ISICOM_MAGIC          0x4d54           isi_port                 ``include/linux/isicom.h``
 PTY_MAGIC             0x5001                                    ``drivers/char/pty.c``
 PPP_MAGIC             0x5002           ppp                      ``include/linux/if_pppvar.h``
-SERIAL_MAGIC          0x5301           async_struct             ``include/linux/serial.h``
 SSTATE_MAGIC          0x5302           serial_state             ``include/linux/serial.h``
 SLIP_MAGIC            0x5302           slip                     ``drivers/net/slip.h``
 STRIP_MAGIC           0x5303           strip                    ``drivers/net/strip.c``
diff --git a/Documentation/translations/it_IT/process/magic-number.rst b/Documentation/translations/it_IT/process/magic-number.rst
index ed1121d0ba84..783e0de314a0 100644
--- a/Documentation/translations/it_IT/process/magic-number.rst
+++ b/Documentation/translations/it_IT/process/magic-number.rst
@@ -87,7 +87,6 @@ FF_MAGIC              0x4646           fc_info                  ``drivers/net/ip
 ISICOM_MAGIC          0x4d54           isi_port                 ``include/linux/isicom.h``
 PTY_MAGIC             0x5001                                    ``drivers/char/pty.c``
 PPP_MAGIC             0x5002           ppp                      ``include/linux/if_pppvar.h``
-SERIAL_MAGIC          0x5301           async_struct             ``include/linux/serial.h``
 SSTATE_MAGIC          0x5302           serial_state             ``include/linux/serial.h``
 SLIP_MAGIC            0x5302           slip                     ``drivers/net/slip.h``
 STRIP_MAGIC           0x5303           strip                    ``drivers/net/strip.c``
diff --git a/Documentation/translations/zh_CN/process/magic-number.rst b/Documentation/translations/zh_CN/process/magic-number.rst
index 15c592518194..e4c225996af0 100644
--- a/Documentation/translations/zh_CN/process/magic-number.rst
+++ b/Documentation/translations/zh_CN/process/magic-number.rst
@@ -70,7 +70,6 @@ FF_MAGIC              0x4646           fc_info                  ``drivers/net/ip
 ISICOM_MAGIC          0x4d54           isi_port                 ``include/linux/isicom.h``
 PTY_MAGIC             0x5001                                    ``drivers/char/pty.c``
 PPP_MAGIC             0x5002           ppp                      ``include/linux/if_pppvar.h``
-SERIAL_MAGIC          0x5301           async_struct             ``include/linux/serial.h``
 SSTATE_MAGIC          0x5302           serial_state             ``include/linux/serial.h``
 SLIP_MAGIC            0x5302           slip                     ``drivers/net/slip.h``
 STRIP_MAGIC           0x5303           strip                    ``drivers/net/strip.c``
diff --git a/drivers/net/wan/z85230.h b/drivers/net/wan/z85230.h
index 32ae710d4f40..1081d171e477 100644
--- a/drivers/net/wan/z85230.h
+++ b/drivers/net/wan/z85230.h
@@ -421,8 +421,6 @@ extern struct z8530_irqhandler z8530_sync, z8530_async, z8530_nop;
  *	Asynchronous Interfacing
  */
 
-#define SERIAL_MAGIC 0x5301
-
 /*
  * The size of the serial xmit buffer is 1 page, or 4096 bytes
  */
diff --git a/drivers/tty/amiserial.c b/drivers/tty/amiserial.c
index 8330fd809a05..0af81a82df8f 100644
--- a/drivers/tty/amiserial.c
+++ b/drivers/tty/amiserial.c
@@ -23,17 +23,12 @@
  */
 
 /*
- * Serial driver configuration section.  Here are the various options:
+ * Serial driver configuration section.
  *
- * SERIAL_PARANOIA_CHECK
- * 		Check the magic number for the async_structure where
- * 		ever possible.
  */
 
 #include <linux/delay.h>
 
-#undef SERIAL_PARANOIA_CHECK
-
 /* Set of debugging defines */
 
 #undef SERIAL_DEBUG_INTR
@@ -132,28 +127,6 @@ static struct serial_state rs_table[1];
 
 #define serial_isroot()	(capable(CAP_SYS_ADMIN))
 
-
-static inline int serial_paranoia_check(struct serial_state *info,
-					char *name, const char *routine)
-{
-#ifdef SERIAL_PARANOIA_CHECK
-	static const char *badmagic =
-		"Warning: bad magic number for serial struct (%s) in %s\n";
-	static const char *badinfo =
-		"Warning: null async_struct for (%s) in %s\n";
-
-	if (!info) {
-		printk(badinfo, name, routine);
-		return 1;
-	}
-	if (info->magic != SERIAL_MAGIC) {
-		printk(badmagic, name, routine);
-		return 1;
-	}
-#endif
-	return 0;
-}
-
 /* some serial hardware definitions */
 #define SDR_OVRUN   (1<<15)
 #define SDR_RBF     (1<<14)
@@ -189,9 +162,6 @@ static void rs_stop(struct tty_struct *tty)
 	struct serial_state *info = tty->driver_data;
 	unsigned long flags;
 
-	if (serial_paranoia_check(info, tty->name, "rs_stop"))
-		return;
-
 	local_irq_save(flags);
 	if (info->IER & UART_IER_THRI) {
 		info->IER &= ~UART_IER_THRI;
@@ -209,9 +179,6 @@ static void rs_start(struct tty_struct *tty)
 	struct serial_state *info = tty->driver_data;
 	unsigned long flags;
 
-	if (serial_paranoia_check(info, tty->name, "rs_start"))
-		return;
-
 	local_irq_save(flags);
 	if (info->xmit.head != info->xmit.tail
 	    && info->xmit.buf
@@ -783,9 +750,6 @@ static int rs_put_char(struct tty_struct *tty, unsigned char ch)
 
 	info = tty->driver_data;
 
-	if (serial_paranoia_check(info, tty->name, "rs_put_char"))
-		return 0;
-
 	if (!info->xmit.buf)
 		return 0;
 
@@ -808,9 +772,6 @@ static void rs_flush_chars(struct tty_struct *tty)
 	struct serial_state *info = tty->driver_data;
 	unsigned long flags;
 
-	if (serial_paranoia_check(info, tty->name, "rs_flush_chars"))
-		return;
-
 	if (info->xmit.head == info->xmit.tail
 	    || tty->stopped
 	    || tty->hw_stopped
@@ -833,9 +794,6 @@ static int rs_write(struct tty_struct * tty, const unsigned char *buf, int count
 	struct serial_state *info = tty->driver_data;
 	unsigned long flags;
 
-	if (serial_paranoia_check(info, tty->name, "rs_write"))
-		return 0;
-
 	if (!info->xmit.buf)
 		return 0;
 
@@ -878,8 +836,6 @@ static int rs_write_room(struct tty_struct *tty)
 {
 	struct serial_state *info = tty->driver_data;
 
-	if (serial_paranoia_check(info, tty->name, "rs_write_room"))
-		return 0;
 	return CIRC_SPACE(info->xmit.head, info->xmit.tail, SERIAL_XMIT_SIZE);
 }
 
@@ -887,8 +843,6 @@ static int rs_chars_in_buffer(struct tty_struct *tty)
 {
 	struct serial_state *info = tty->driver_data;
 
-	if (serial_paranoia_check(info, tty->name, "rs_chars_in_buffer"))
-		return 0;
 	return CIRC_CNT(info->xmit.head, info->xmit.tail, SERIAL_XMIT_SIZE);
 }
 
@@ -897,8 +851,6 @@ static void rs_flush_buffer(struct tty_struct *tty)
 	struct serial_state *info = tty->driver_data;
 	unsigned long flags;
 
-	if (serial_paranoia_check(info, tty->name, "rs_flush_buffer"))
-		return;
 	local_irq_save(flags);
 	info->xmit.head = info->xmit.tail = 0;
 	local_irq_restore(flags);
@@ -914,9 +866,6 @@ static void rs_send_xchar(struct tty_struct *tty, char ch)
 	struct serial_state *info = tty->driver_data;
         unsigned long flags;
 
-	if (serial_paranoia_check(info, tty->name, "rs_send_xchar"))
-		return;
-
 	info->x_char = ch;
 	if (ch) {
 		/* Make sure transmit interrupts are on */
@@ -952,9 +901,6 @@ static void rs_throttle(struct tty_struct * tty)
 	printk("throttle %s ....\n", tty_name(tty));
 #endif
 
-	if (serial_paranoia_check(info, tty->name, "rs_throttle"))
-		return;
-
 	if (I_IXOFF(tty))
 		rs_send_xchar(tty, STOP_CHAR(tty));
 
@@ -974,9 +920,6 @@ static void rs_unthrottle(struct tty_struct * tty)
 	printk("unthrottle %s ....\n", tty_name(tty));
 #endif
 
-	if (serial_paranoia_check(info, tty->name, "rs_unthrottle"))
-		return;
-
 	if (I_IXOFF(tty)) {
 		if (info->x_char)
 			info->x_char = 0;
@@ -1109,8 +1052,6 @@ static int rs_tiocmget(struct tty_struct *tty)
 	unsigned char control, status;
 	unsigned long flags;
 
-	if (serial_paranoia_check(info, tty->name, "rs_ioctl"))
-		return -ENODEV;
 	if (tty_io_error(tty))
 		return -EIO;
 
@@ -1131,8 +1072,6 @@ static int rs_tiocmset(struct tty_struct *tty, unsigned int set,
 	struct serial_state *info = tty->driver_data;
 	unsigned long flags;
 
-	if (serial_paranoia_check(info, tty->name, "rs_ioctl"))
-		return -ENODEV;
 	if (tty_io_error(tty))
 		return -EIO;
 
@@ -1155,12 +1094,8 @@ static int rs_tiocmset(struct tty_struct *tty, unsigned int set,
  */
 static int rs_break(struct tty_struct *tty, int break_state)
 {
-	struct serial_state *info = tty->driver_data;
 	unsigned long flags;
 
-	if (serial_paranoia_check(info, tty->name, "rs_break"))
-		return -EINVAL;
-
 	local_irq_save(flags);
 	if (break_state == -1)
 	  custom.adkcon = AC_SETCLR | AC_UARTBRK;
@@ -1212,9 +1147,6 @@ static int rs_ioctl(struct tty_struct *tty,
 	DEFINE_WAIT(wait);
 	int ret;
 
-	if (serial_paranoia_check(info, tty->name, "rs_ioctl"))
-		return -ENODEV;
-
 	if ((cmd != TIOCSERCONFIG) &&
 	    (cmd != TIOCMIWAIT) && (cmd != TIOCGICOUNT)) {
 		if (tty_io_error(tty))
@@ -1333,9 +1265,6 @@ static void rs_close(struct tty_struct *tty, struct file * filp)
 	struct serial_state *state = tty->driver_data;
 	struct tty_port *port = &state->tport;
 
-	if (serial_paranoia_check(state, tty->name, "rs_close"))
-		return;
-
 	if (tty_port_close_start(port, tty, filp) == 0)
 		return;
 
@@ -1379,9 +1308,6 @@ static void rs_wait_until_sent(struct tty_struct *tty, int timeout)
 	unsigned long orig_jiffies, char_time;
 	int lsr;
 
-	if (serial_paranoia_check(info, tty->name, "rs_wait_until_sent"))
-		return;
-
 	if (info->xmit_fifo_size == 0)
 		return; /* Just in case.... */
 
@@ -1440,9 +1366,6 @@ static void rs_hangup(struct tty_struct *tty)
 {
 	struct serial_state *info = tty->driver_data;
 
-	if (serial_paranoia_check(info, tty->name, "rs_hangup"))
-		return;
-
 	rs_flush_buffer(tty);
 	shutdown(tty, info);
 	info->tport.count = 0;
@@ -1467,8 +1390,6 @@ static int rs_open(struct tty_struct *tty, struct file * filp)
 	port->tty = tty;
 	tty->driver_data = info;
 	tty->port = port;
-	if (serial_paranoia_check(info, tty->name, "rs_open"))
-		return -ENODEV;
 
 	port->low_latency = (port->flags & ASYNC_LOW_LATENCY) ? 1 : 0;
 
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

