Return-Path: <SRS0=mTc+=Y5=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA862C5DF61
	for <linux-serial@archiver.kernel.org>; Tue,  5 Nov 2019 19:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EFD2217F5
	for <linux-serial@archiver.kernel.org>; Tue,  5 Nov 2019 19:28:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VErl8XtE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389691AbfKET2L (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 5 Nov 2019 14:28:11 -0500
Received: from mail-wr1-f74.google.com ([209.85.221.74]:33497 "EHLO
        mail-wr1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390769AbfKET2K (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 5 Nov 2019 14:28:10 -0500
Received: by mail-wr1-f74.google.com with SMTP id a15so12870849wrr.0
        for <linux-serial@vger.kernel.org>; Tue, 05 Nov 2019 11:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=E+oDLnvIU7ENQAAPOrl1GRNeFvZb4Uwtj09d81ZI488=;
        b=VErl8XtEJEmYa0mmi0nMARpyworR+b/H1/iZm+TmNqbcDcZ+Rwdfs4986J141qrhsm
         G3orYKTxARu//JawK6hb4rgoFPjZsqj+Kdffe9VlPBP86gEIEcaY+b/k/u5eCd3YVJL+
         OMuzT9ga5d1K7DgVyTqSThWNMa755G2mCbW2QvpfcHEOk9cSWRT10dI20dJj3ZWGpXIU
         BjFEeMiVhES9MzJiI7niINcwOhiTiVrxWbJn7qGdT69NOOs1c1mKUFUAvHYkwyoIe39r
         bkil/z7WXT6LH4uNNNaKtOs6GhdNTFbb1mDlktMxJvf5yacaAaHyzV3zCC5c3jmAkdyR
         rGpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=E+oDLnvIU7ENQAAPOrl1GRNeFvZb4Uwtj09d81ZI488=;
        b=Rq3VBneIVPx3P9dPHyXcUpqILT0BGTsdVfaGdcoBKCRcte6/MLfHqyqBYs2sG8ELeT
         XqYf555l1VoTFsVV1d063O3NP684g213R/cmGkoWYHOVjYmSPrbex0fk94w1qxf+w/+J
         fcw+TvQjjBrgD7jd0ePtOAAFW6J2fPt5LI5yuxPCTVXszv9IpBSgo3gc7BUvZud8nv6q
         ELQ+aS8Zalasg2n7fKYQXnz/zGocfpsE+zbCZtqDZx1e1JCvh316W4xet/xU5JMKeU6b
         tElNSfF4E2cLf8J5M71O+9qJEBKpmQNv8LlWtRqBhrWUUFb6SFveFp0oT9BiuZmF0osv
         kFGQ==
X-Gm-Message-State: APjAAAUvnRKM1roSn0NOoRVFx4WwXGweutjuhXNikDPY+6C0bjVTDIcP
        DaeGTwPXrbce2t9SFu6wNP9aF2cgjes6
X-Google-Smtp-Source: APXvYqxsgD3FEIfPCc7Ih+WXaIat3cU89p7LOm8i2xB6ZJoiozIfgzitb+ZL/xu0IcF3kRfh24HlkiAfkr0X
X-Received: by 2002:a5d:5091:: with SMTP id a17mr28815974wrt.249.1572982085767;
 Tue, 05 Nov 2019 11:28:05 -0800 (PST)
Date:   Tue,  5 Nov 2019 19:27:49 +0000
In-Reply-To: <CAMuHMdUm+s4UaBrtxvXaLg1EUmsoYYG=6JvnWzC0ivbyzdMBZw@mail.gmail.com>
Message-Id: <20191105192749.67533-1-pterjan@google.com>
Mime-Version: 1.0
References: <CAMuHMdUm+s4UaBrtxvXaLg1EUmsoYYG=6JvnWzC0ivbyzdMBZw@mail.gmail.com>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
Subject: [PATCH v4] Remove every trace of SERIAL_MAGIC
From:   Pascal Terjan <pterjan@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     Pascal Terjan <pterjan@google.com>, linux-serial@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This means removing support for checking magic in amiserial.c
(SERIAL_PARANOIA_CHECK option), which was checking a magic field which
doesn't currently exist in the struct. That code hasn't built at least
since git.

Removing the definition from the header is safe anyway as that code was
from another driver and not including it.

Signed-off-by: Pascal Terjan <pterjan@google.com>
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
v4 removes the now empty comment block listing configuration options as
suggested.

 Documentation/process/magic-number.rst        |  1 -
 .../it_IT/process/magic-number.rst            |  1 -
 .../zh_CN/process/magic-number.rst            |  1 -
 drivers/net/wan/z85230.h                      |  2 -
 drivers/tty/amiserial.c                       | 84 -------------------
 5 files changed, 89 deletions(-)

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
index 8330fd809a05..13f63c01c589 100644
--- a/drivers/tty/amiserial.c
+++ b/drivers/tty/amiserial.c
@@ -22,18 +22,8 @@
  *
  */
 
-/*
- * Serial driver configuration section.  Here are the various options:
- *
- * SERIAL_PARANOIA_CHECK
- * 		Check the magic number for the async_structure where
- * 		ever possible.
- */
-
 #include <linux/delay.h>
 
-#undef SERIAL_PARANOIA_CHECK
-
 /* Set of debugging defines */
 
 #undef SERIAL_DEBUG_INTR
@@ -132,28 +122,6 @@ static struct serial_state rs_table[1];
 
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
@@ -189,9 +157,6 @@ static void rs_stop(struct tty_struct *tty)
 	struct serial_state *info = tty->driver_data;
 	unsigned long flags;
 
-	if (serial_paranoia_check(info, tty->name, "rs_stop"))
-		return;
-
 	local_irq_save(flags);
 	if (info->IER & UART_IER_THRI) {
 		info->IER &= ~UART_IER_THRI;
@@ -209,9 +174,6 @@ static void rs_start(struct tty_struct *tty)
 	struct serial_state *info = tty->driver_data;
 	unsigned long flags;
 
-	if (serial_paranoia_check(info, tty->name, "rs_start"))
-		return;
-
 	local_irq_save(flags);
 	if (info->xmit.head != info->xmit.tail
 	    && info->xmit.buf
@@ -783,9 +745,6 @@ static int rs_put_char(struct tty_struct *tty, unsigned char ch)
 
 	info = tty->driver_data;
 
-	if (serial_paranoia_check(info, tty->name, "rs_put_char"))
-		return 0;
-
 	if (!info->xmit.buf)
 		return 0;
 
@@ -808,9 +767,6 @@ static void rs_flush_chars(struct tty_struct *tty)
 	struct serial_state *info = tty->driver_data;
 	unsigned long flags;
 
-	if (serial_paranoia_check(info, tty->name, "rs_flush_chars"))
-		return;
-
 	if (info->xmit.head == info->xmit.tail
 	    || tty->stopped
 	    || tty->hw_stopped
@@ -833,9 +789,6 @@ static int rs_write(struct tty_struct * tty, const unsigned char *buf, int count
 	struct serial_state *info = tty->driver_data;
 	unsigned long flags;
 
-	if (serial_paranoia_check(info, tty->name, "rs_write"))
-		return 0;
-
 	if (!info->xmit.buf)
 		return 0;
 
@@ -878,8 +831,6 @@ static int rs_write_room(struct tty_struct *tty)
 {
 	struct serial_state *info = tty->driver_data;
 
-	if (serial_paranoia_check(info, tty->name, "rs_write_room"))
-		return 0;
 	return CIRC_SPACE(info->xmit.head, info->xmit.tail, SERIAL_XMIT_SIZE);
 }
 
@@ -887,8 +838,6 @@ static int rs_chars_in_buffer(struct tty_struct *tty)
 {
 	struct serial_state *info = tty->driver_data;
 
-	if (serial_paranoia_check(info, tty->name, "rs_chars_in_buffer"))
-		return 0;
 	return CIRC_CNT(info->xmit.head, info->xmit.tail, SERIAL_XMIT_SIZE);
 }
 
@@ -897,8 +846,6 @@ static void rs_flush_buffer(struct tty_struct *tty)
 	struct serial_state *info = tty->driver_data;
 	unsigned long flags;
 
-	if (serial_paranoia_check(info, tty->name, "rs_flush_buffer"))
-		return;
 	local_irq_save(flags);
 	info->xmit.head = info->xmit.tail = 0;
 	local_irq_restore(flags);
@@ -914,9 +861,6 @@ static void rs_send_xchar(struct tty_struct *tty, char ch)
 	struct serial_state *info = tty->driver_data;
         unsigned long flags;
 
-	if (serial_paranoia_check(info, tty->name, "rs_send_xchar"))
-		return;
-
 	info->x_char = ch;
 	if (ch) {
 		/* Make sure transmit interrupts are on */
@@ -952,9 +896,6 @@ static void rs_throttle(struct tty_struct * tty)
 	printk("throttle %s ....\n", tty_name(tty));
 #endif
 
-	if (serial_paranoia_check(info, tty->name, "rs_throttle"))
-		return;
-
 	if (I_IXOFF(tty))
 		rs_send_xchar(tty, STOP_CHAR(tty));
 
@@ -974,9 +915,6 @@ static void rs_unthrottle(struct tty_struct * tty)
 	printk("unthrottle %s ....\n", tty_name(tty));
 #endif
 
-	if (serial_paranoia_check(info, tty->name, "rs_unthrottle"))
-		return;
-
 	if (I_IXOFF(tty)) {
 		if (info->x_char)
 			info->x_char = 0;
@@ -1109,8 +1047,6 @@ static int rs_tiocmget(struct tty_struct *tty)
 	unsigned char control, status;
 	unsigned long flags;
 
-	if (serial_paranoia_check(info, tty->name, "rs_ioctl"))
-		return -ENODEV;
 	if (tty_io_error(tty))
 		return -EIO;
 
@@ -1131,8 +1067,6 @@ static int rs_tiocmset(struct tty_struct *tty, unsigned int set,
 	struct serial_state *info = tty->driver_data;
 	unsigned long flags;
 
-	if (serial_paranoia_check(info, tty->name, "rs_ioctl"))
-		return -ENODEV;
 	if (tty_io_error(tty))
 		return -EIO;
 
@@ -1155,12 +1089,8 @@ static int rs_tiocmset(struct tty_struct *tty, unsigned int set,
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
@@ -1212,9 +1142,6 @@ static int rs_ioctl(struct tty_struct *tty,
 	DEFINE_WAIT(wait);
 	int ret;
 
-	if (serial_paranoia_check(info, tty->name, "rs_ioctl"))
-		return -ENODEV;
-
 	if ((cmd != TIOCSERCONFIG) &&
 	    (cmd != TIOCMIWAIT) && (cmd != TIOCGICOUNT)) {
 		if (tty_io_error(tty))
@@ -1333,9 +1260,6 @@ static void rs_close(struct tty_struct *tty, struct file * filp)
 	struct serial_state *state = tty->driver_data;
 	struct tty_port *port = &state->tport;
 
-	if (serial_paranoia_check(state, tty->name, "rs_close"))
-		return;
-
 	if (tty_port_close_start(port, tty, filp) == 0)
 		return;
 
@@ -1379,9 +1303,6 @@ static void rs_wait_until_sent(struct tty_struct *tty, int timeout)
 	unsigned long orig_jiffies, char_time;
 	int lsr;
 
-	if (serial_paranoia_check(info, tty->name, "rs_wait_until_sent"))
-		return;
-
 	if (info->xmit_fifo_size == 0)
 		return; /* Just in case.... */
 
@@ -1440,9 +1361,6 @@ static void rs_hangup(struct tty_struct *tty)
 {
 	struct serial_state *info = tty->driver_data;
 
-	if (serial_paranoia_check(info, tty->name, "rs_hangup"))
-		return;
-
 	rs_flush_buffer(tty);
 	shutdown(tty, info);
 	info->tport.count = 0;
@@ -1467,8 +1385,6 @@ static int rs_open(struct tty_struct *tty, struct file * filp)
 	port->tty = tty;
 	tty->driver_data = info;
 	tty->port = port;
-	if (serial_paranoia_check(info, tty->name, "rs_open"))
-		return -ENODEV;
 
 	port->low_latency = (port->flags & ASYNC_LOW_LATENCY) ? 1 : 0;
 
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

