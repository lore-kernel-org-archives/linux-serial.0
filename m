Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7101FC4361B
	for <linux-serial@archiver.kernel.org>; Wed,  5 May 2021 09:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B16D61401
	for <linux-serial@archiver.kernel.org>; Wed,  5 May 2021 09:19:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232667AbhEEJUv (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 5 May 2021 05:20:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:41396 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232467AbhEEJUh (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 5 May 2021 05:20:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EC914B26A;
        Wed,  5 May 2021 09:19:38 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Samuel Iglesias Gonsalvez <siglesias@igalia.com>,
        Jens Taprogge <jens.taprogge@taprogge.org>,
        Karsten Keil <isdn@linux-pingi.de>,
        Scott Branden <scott.branden@broadcom.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        David Lin <dtwlin@gmail.com>, Johan Hovold <johan@kernel.org>,
        Alex Elder <elder@kernel.org>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Jiri Kosina <jikos@kernel.org>,
        David Sterba <dsterba@suse.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Oliver Neukum <oneukum@suse.com>,
        Felipe Balbi <balbi@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH 22/35] tty: make tty_operations::write_room return uint
Date:   Wed,  5 May 2021 11:19:15 +0200
Message-Id: <20210505091928.22010-23-jslaby@suse.cz>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210505091928.22010-1-jslaby@suse.cz>
References: <20210505091928.22010-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Line disciplines expect a positive value or zero returned from
tty->ops->write_room (invoked by tty_write_room). So make this
assumption explicit by using unsigned int as a return value. Both of
tty->ops->write_room and tty_write_room.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Helge Deller <deller@gmx.de>
Cc: Jeff Dike <jdike@addtoit.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Chris Zankel <chris@zankel.net>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Samuel Iglesias Gonsalvez <siglesias@igalia.com>
Cc: Jens Taprogge <jens.taprogge@taprogge.org>
Cc: Karsten Keil <isdn@linux-pingi.de>
Cc: Scott Branden <scott.branden@broadcom.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: David Lin <dtwlin@gmail.com>
Cc: Johan Hovold <johan@kernel.org>
Cc: Alex Elder <elder@kernel.org>
Cc: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: David Sterba <dsterba@suse.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Oliver Neukum <oneukum@suse.com>
Cc: Felipe Balbi <balbi@kernel.org>
Cc: Mathias Nyman <mathias.nyman@intel.com>
Cc: Marcel Holtmann <marcel@holtmann.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
---
 arch/alpha/kernel/srmcons.c            | 2 +-
 arch/m68k/emu/nfcon.c                  | 2 +-
 arch/parisc/kernel/pdc_cons.c          | 2 +-
 arch/um/drivers/line.c                 | 6 +++---
 arch/um/drivers/line.h                 | 2 +-
 arch/xtensa/platforms/iss/console.c    | 2 +-
 drivers/char/pcmcia/synclink_cs.c      | 2 +-
 drivers/char/ttyprintk.c               | 2 +-
 drivers/ipack/devices/ipoctal.c        | 2 +-
 drivers/isdn/capi/capi.c               | 6 +++---
 drivers/misc/bcm-vk/bcm_vk_tty.c       | 2 +-
 drivers/mmc/core/sdio_uart.c           | 2 +-
 drivers/net/usb/hso.c                  | 4 ++--
 drivers/s390/char/con3215.c            | 2 +-
 drivers/s390/char/sclp_tty.c           | 4 ++--
 drivers/s390/char/sclp_vt220.c         | 4 ++--
 drivers/s390/char/tty3270.c            | 2 +-
 drivers/staging/fwserial/fwserial.c    | 6 +++---
 drivers/staging/gdm724x/gdm_tty.c      | 2 +-
 drivers/staging/greybus/uart.c         | 2 +-
 drivers/tty/amiserial.c                | 2 +-
 drivers/tty/ehv_bytechan.c             | 4 ++--
 drivers/tty/goldfish.c                 | 2 +-
 drivers/tty/hvc/hvc_console.c          | 2 +-
 drivers/tty/hvc/hvcs.c                 | 2 +-
 drivers/tty/hvc/hvsi.c                 | 4 ++--
 drivers/tty/ipwireless/tty.c           | 2 +-
 drivers/tty/mips_ejtag_fdc.c           | 4 ++--
 drivers/tty/moxa.c                     | 8 ++++----
 drivers/tty/mxser.c                    | 2 +-
 drivers/tty/n_gsm.c                    | 2 +-
 drivers/tty/nozomi.c                   | 4 ++--
 drivers/tty/pty.c                      | 2 +-
 drivers/tty/serial/kgdb_nmi.c          | 2 +-
 drivers/tty/serial/serial_core.c       | 4 ++--
 drivers/tty/synclink_gt.c              | 6 +++---
 drivers/tty/tty_ioctl.c                | 2 +-
 drivers/tty/ttynull.c                  | 2 +-
 drivers/tty/vcc.c                      | 4 ++--
 drivers/tty/vt/vt.c                    | 2 +-
 drivers/usb/class/cdc-acm.c            | 2 +-
 drivers/usb/gadget/function/u_serial.c | 6 +++---
 drivers/usb/host/xhci-dbgtty.c         | 4 ++--
 drivers/usb/serial/usb-serial.c        | 2 +-
 include/linux/tty.h                    | 2 +-
 include/linux/tty_driver.h             | 4 ++--
 net/bluetooth/rfcomm/tty.c             | 2 +-
 47 files changed, 71 insertions(+), 71 deletions(-)

diff --git a/arch/alpha/kernel/srmcons.c b/arch/alpha/kernel/srmcons.c
index 438b10c44d73..2110b7e7f988 100644
--- a/arch/alpha/kernel/srmcons.c
+++ b/arch/alpha/kernel/srmcons.c
@@ -142,7 +142,7 @@ srmcons_write(struct tty_struct *tty,
 	return count;
 }
 
-static int
+static unsigned int
 srmcons_write_room(struct tty_struct *tty)
 {
 	return 512;
diff --git a/arch/m68k/emu/nfcon.c b/arch/m68k/emu/nfcon.c
index 57e8c8fb5eba..92636c89d65b 100644
--- a/arch/m68k/emu/nfcon.c
+++ b/arch/m68k/emu/nfcon.c
@@ -85,7 +85,7 @@ static int nfcon_tty_put_char(struct tty_struct *tty, unsigned char ch)
 	return 1;
 }
 
-static int nfcon_tty_write_room(struct tty_struct *tty)
+static unsigned int nfcon_tty_write_room(struct tty_struct *tty)
 {
 	return 64;
 }
diff --git a/arch/parisc/kernel/pdc_cons.c b/arch/parisc/kernel/pdc_cons.c
index 7ed404c60a9e..fe2ed0bbd07e 100644
--- a/arch/parisc/kernel/pdc_cons.c
+++ b/arch/parisc/kernel/pdc_cons.c
@@ -103,7 +103,7 @@ static int pdc_console_tty_write(struct tty_struct *tty, const unsigned char *bu
 	return count;
 }
 
-static int pdc_console_tty_write_room(struct tty_struct *tty)
+static unsigned int pdc_console_tty_write_room(struct tty_struct *tty)
 {
 	return 32768; /* no limit, no buffer used */
 }
diff --git a/arch/um/drivers/line.c b/arch/um/drivers/line.c
index 1c70a31e7c5b..2b8810ba5470 100644
--- a/arch/um/drivers/line.c
+++ b/arch/um/drivers/line.c
@@ -32,7 +32,7 @@ static irqreturn_t line_interrupt(int irq, void *data)
  *
  * Should be called while holding line->lock (this does not modify data).
  */
-static int write_room(struct line *line)
+static unsigned int write_room(struct line *line)
 {
 	int n;
 
@@ -47,11 +47,11 @@ static int write_room(struct line *line)
 	return n - 1;
 }
 
-int line_write_room(struct tty_struct *tty)
+unsigned int line_write_room(struct tty_struct *tty)
 {
 	struct line *line = tty->driver_data;
 	unsigned long flags;
-	int room;
+	unsigned int room;
 
 	spin_lock_irqsave(&line->lock, flags);
 	room = write_room(line);
diff --git a/arch/um/drivers/line.h b/arch/um/drivers/line.h
index 01d21e76144f..861edf329569 100644
--- a/arch/um/drivers/line.h
+++ b/arch/um/drivers/line.h
@@ -70,7 +70,7 @@ extern void line_set_termios(struct tty_struct *tty, struct ktermios * old);
 extern int line_chars_in_buffer(struct tty_struct *tty);
 extern void line_flush_buffer(struct tty_struct *tty);
 extern void line_flush_chars(struct tty_struct *tty);
-extern int line_write_room(struct tty_struct *tty);
+extern unsigned int line_write_room(struct tty_struct *tty);
 extern void line_throttle(struct tty_struct *tty);
 extern void line_unthrottle(struct tty_struct *tty);
 
diff --git a/arch/xtensa/platforms/iss/console.c b/arch/xtensa/platforms/iss/console.c
index a3dda25a4e45..98ac3a7fdb0a 100644
--- a/arch/xtensa/platforms/iss/console.c
+++ b/arch/xtensa/platforms/iss/console.c
@@ -100,7 +100,7 @@ static void rs_flush_chars(struct tty_struct *tty)
 {
 }
 
-static int rs_write_room(struct tty_struct *tty)
+static unsigned int rs_write_room(struct tty_struct *tty)
 {
 	/* Let's say iss can always accept 2K characters.. */
 	return 2 * 1024;
diff --git a/drivers/char/pcmcia/synclink_cs.c b/drivers/char/pcmcia/synclink_cs.c
index b4707bc3aee8..e4b2c68f44f5 100644
--- a/drivers/char/pcmcia/synclink_cs.c
+++ b/drivers/char/pcmcia/synclink_cs.c
@@ -1609,7 +1609,7 @@ static int mgslpc_write(struct tty_struct * tty,
 
 /* Return the count of free bytes in transmit buffer
  */
-static int mgslpc_write_room(struct tty_struct *tty)
+static unsigned int mgslpc_write_room(struct tty_struct *tty)
 {
 	MGSLPC_INFO *info = (MGSLPC_INFO *)tty->driver_data;
 	int ret;
diff --git a/drivers/char/ttyprintk.c b/drivers/char/ttyprintk.c
index 93f5d11c830b..e93b0af92339 100644
--- a/drivers/char/ttyprintk.c
+++ b/drivers/char/ttyprintk.c
@@ -132,7 +132,7 @@ static int tpk_write(struct tty_struct *tty,
 /*
  * TTY operations write_room function.
  */
-static int tpk_write_room(struct tty_struct *tty)
+static unsigned int tpk_write_room(struct tty_struct *tty)
 {
 	return TPK_MAX_ROOM;
 }
diff --git a/drivers/ipack/devices/ipoctal.c b/drivers/ipack/devices/ipoctal.c
index 3940714e4397..ea0f1aeaaa06 100644
--- a/drivers/ipack/devices/ipoctal.c
+++ b/drivers/ipack/devices/ipoctal.c
@@ -460,7 +460,7 @@ static int ipoctal_write_tty(struct tty_struct *tty,
 	return char_copied;
 }
 
-static int ipoctal_write_room(struct tty_struct *tty)
+static unsigned int ipoctal_write_room(struct tty_struct *tty)
 {
 	struct ipoctal_channel *channel = tty->driver_data;
 
diff --git a/drivers/isdn/capi/capi.c b/drivers/isdn/capi/capi.c
index fdf87acccd06..c50c454006b3 100644
--- a/drivers/isdn/capi/capi.c
+++ b/drivers/isdn/capi/capi.c
@@ -1175,14 +1175,14 @@ static void capinc_tty_flush_chars(struct tty_struct *tty)
 	handle_minor_recv(mp);
 }
 
-static int capinc_tty_write_room(struct tty_struct *tty)
+static unsigned int capinc_tty_write_room(struct tty_struct *tty)
 {
 	struct capiminor *mp = tty->driver_data;
-	int room;
+	unsigned int room;
 
 	room = CAPINC_MAX_SENDQUEUE-skb_queue_len(&mp->outqueue);
 	room *= CAPI_MAX_BLKSIZE;
-	pr_debug("capinc_tty_write_room = %d\n", room);
+	pr_debug("capinc_tty_write_room = %u\n", room);
 	return room;
 }
 
diff --git a/drivers/misc/bcm-vk/bcm_vk_tty.c b/drivers/misc/bcm-vk/bcm_vk_tty.c
index 4d02692ecfc7..dae9eeed84a2 100644
--- a/drivers/misc/bcm-vk/bcm_vk_tty.c
+++ b/drivers/misc/bcm-vk/bcm_vk_tty.c
@@ -214,7 +214,7 @@ static int bcm_vk_tty_write(struct tty_struct *tty,
 	return count;
 }
 
-static int bcm_vk_tty_write_room(struct tty_struct *tty)
+static unsigned int bcm_vk_tty_write_room(struct tty_struct *tty)
 {
 	struct bcm_vk *vk = dev_get_drvdata(tty->dev);
 
diff --git a/drivers/mmc/core/sdio_uart.c b/drivers/mmc/core/sdio_uart.c
index dbcac2b7f2fe..c8f4eca7aad4 100644
--- a/drivers/mmc/core/sdio_uart.c
+++ b/drivers/mmc/core/sdio_uart.c
@@ -797,7 +797,7 @@ static int sdio_uart_write(struct tty_struct *tty, const unsigned char *buf,
 	return ret;
 }
 
-static int sdio_uart_write_room(struct tty_struct *tty)
+static unsigned int sdio_uart_write_room(struct tty_struct *tty)
 {
 	struct sdio_uart_port *port = tty->driver_data;
 	return FIFO_SIZE - kfifo_len(&port->xmit_fifo);
diff --git a/drivers/net/usb/hso.c b/drivers/net/usb/hso.c
index 3ef4b2841402..bb8bb85308ab 100644
--- a/drivers/net/usb/hso.c
+++ b/drivers/net/usb/hso.c
@@ -1357,10 +1357,10 @@ static int hso_serial_write(struct tty_struct *tty, const unsigned char *buf,
 }
 
 /* how much room is there for writing */
-static int hso_serial_write_room(struct tty_struct *tty)
+static unsigned int hso_serial_write_room(struct tty_struct *tty)
 {
 	struct hso_serial *serial = tty->driver_data;
-	int room;
+	unsigned int room;
 	unsigned long flags;
 
 	spin_lock_irqsave(&serial->serial_lock, flags);
diff --git a/drivers/s390/char/con3215.c b/drivers/s390/char/con3215.c
index 1fd5bca9fa20..c9fd4a05931a 100644
--- a/drivers/s390/char/con3215.c
+++ b/drivers/s390/char/con3215.c
@@ -924,7 +924,7 @@ static void tty3215_close(struct tty_struct *tty, struct file * filp)
 /*
  * Returns the amount of free space in the output buffer.
  */
-static int tty3215_write_room(struct tty_struct *tty)
+static unsigned int tty3215_write_room(struct tty_struct *tty)
 {
 	struct raw3215_info *raw = tty->driver_data;
 
diff --git a/drivers/s390/char/sclp_tty.c b/drivers/s390/char/sclp_tty.c
index 4456ceb23bd2..ea1e43fd16bc 100644
--- a/drivers/s390/char/sclp_tty.c
+++ b/drivers/s390/char/sclp_tty.c
@@ -86,12 +86,12 @@ sclp_tty_close(struct tty_struct *tty, struct file *filp)
  * a string of newlines. Every newline creates a new message which
  * needs 82 bytes.
  */
-static int
+static unsigned int
 sclp_tty_write_room (struct tty_struct *tty)
 {
 	unsigned long flags;
 	struct list_head *l;
-	int count;
+	unsigned int count;
 
 	spin_lock_irqsave(&sclp_tty_lock, flags);
 	count = 0;
diff --git a/drivers/s390/char/sclp_vt220.c b/drivers/s390/char/sclp_vt220.c
index 7f4445b0f819..b621adee35f0 100644
--- a/drivers/s390/char/sclp_vt220.c
+++ b/drivers/s390/char/sclp_vt220.c
@@ -609,12 +609,12 @@ sclp_vt220_flush_chars(struct tty_struct *tty)
  * to change as output buffers get emptied, or if the output flow
  * control is acted.
  */
-static int
+static unsigned int
 sclp_vt220_write_room(struct tty_struct *tty)
 {
 	unsigned long flags;
 	struct list_head *l;
-	int count;
+	unsigned int count;
 
 	spin_lock_irqsave(&sclp_vt220_lock, flags);
 	count = 0;
diff --git a/drivers/s390/char/tty3270.c b/drivers/s390/char/tty3270.c
index 1b68564799fa..82d4c961ed06 100644
--- a/drivers/s390/char/tty3270.c
+++ b/drivers/s390/char/tty3270.c
@@ -1071,7 +1071,7 @@ static void tty3270_cleanup(struct tty_struct *tty)
 /*
  * We always have room.
  */
-static int
+static unsigned int
 tty3270_write_room(struct tty_struct *tty)
 {
 	return INT_MAX;
diff --git a/drivers/staging/fwserial/fwserial.c b/drivers/staging/fwserial/fwserial.c
index 4245532d2fe0..a151cd76d24e 100644
--- a/drivers/staging/fwserial/fwserial.c
+++ b/drivers/staging/fwserial/fwserial.c
@@ -1113,16 +1113,16 @@ static int fwtty_write(struct tty_struct *tty, const unsigned char *buf, int c)
 	return (n < 0) ? 0 : n;
 }
 
-static int fwtty_write_room(struct tty_struct *tty)
+static unsigned int fwtty_write_room(struct tty_struct *tty)
 {
 	struct fwtty_port *port = tty->driver_data;
-	int n;
+	unsigned int n;
 
 	spin_lock_bh(&port->lock);
 	n = dma_fifo_avail(&port->tx_fifo);
 	spin_unlock_bh(&port->lock);
 
-	fwtty_dbg(port, "%d\n", n);
+	fwtty_dbg(port, "%u\n", n);
 
 	return n;
 }
diff --git a/drivers/staging/gdm724x/gdm_tty.c b/drivers/staging/gdm724x/gdm_tty.c
index 0ccc8c24e754..279de2cd9c4a 100644
--- a/drivers/staging/gdm724x/gdm_tty.c
+++ b/drivers/staging/gdm724x/gdm_tty.c
@@ -183,7 +183,7 @@ static int gdm_tty_write(struct tty_struct *tty, const unsigned char *buf,
 	return len;
 }
 
-static int gdm_tty_write_room(struct tty_struct *tty)
+static unsigned int gdm_tty_write_room(struct tty_struct *tty)
 {
 	struct gdm *gdm = tty->driver_data;
 
diff --git a/drivers/staging/greybus/uart.c b/drivers/staging/greybus/uart.c
index b1e63f7798b0..529eccb99b6c 100644
--- a/drivers/staging/greybus/uart.c
+++ b/drivers/staging/greybus/uart.c
@@ -440,7 +440,7 @@ static int gb_tty_write(struct tty_struct *tty, const unsigned char *buf,
 	return count;
 }
 
-static int gb_tty_write_room(struct tty_struct *tty)
+static unsigned int gb_tty_write_room(struct tty_struct *tty)
 {
 	struct gb_tty *gb_tty = tty->driver_data;
 	unsigned long flags;
diff --git a/drivers/tty/amiserial.c b/drivers/tty/amiserial.c
index a4b8876091d2..ee1f4d72cd5e 100644
--- a/drivers/tty/amiserial.c
+++ b/drivers/tty/amiserial.c
@@ -827,7 +827,7 @@ static int rs_write(struct tty_struct * tty, const unsigned char *buf, int count
 	return ret;
 }
 
-static int rs_write_room(struct tty_struct *tty)
+static unsigned int rs_write_room(struct tty_struct *tty)
 {
 	struct serial_state *info = tty->driver_data;
 
diff --git a/drivers/tty/ehv_bytechan.c b/drivers/tty/ehv_bytechan.c
index 3c6dd06ec5fb..445e5ff9b36d 100644
--- a/drivers/tty/ehv_bytechan.c
+++ b/drivers/tty/ehv_bytechan.c
@@ -536,11 +536,11 @@ static void ehv_bc_tty_close(struct tty_struct *ttys, struct file *filp)
  * how much write room the driver can guarantee will be sent OR BUFFERED.  This
  * driver MUST honor the return value.
  */
-static int ehv_bc_tty_write_room(struct tty_struct *ttys)
+static unsigned int ehv_bc_tty_write_room(struct tty_struct *ttys)
 {
 	struct ehv_bc_data *bc = ttys->driver_data;
 	unsigned long flags;
-	int count;
+	unsigned int count;
 
 	spin_lock_irqsave(&bc->lock, flags);
 	count = CIRC_SPACE(bc->head, bc->tail, BUF_SIZE);
diff --git a/drivers/tty/goldfish.c b/drivers/tty/goldfish.c
index cd23a4b05c8f..e4f9a60dcc18 100644
--- a/drivers/tty/goldfish.c
+++ b/drivers/tty/goldfish.c
@@ -193,7 +193,7 @@ static int goldfish_tty_write(struct tty_struct *tty, const unsigned char *buf,
 	return count;
 }
 
-static int goldfish_tty_write_room(struct tty_struct *tty)
+static unsigned int goldfish_tty_write_room(struct tty_struct *tty)
 {
 	return 0x10000;
 }
diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_console.c
index cdcc64ea2554..a3725eb69cd3 100644
--- a/drivers/tty/hvc/hvc_console.c
+++ b/drivers/tty/hvc/hvc_console.c
@@ -586,7 +586,7 @@ static void hvc_set_winsz(struct work_struct *work)
  * how much write room the driver can guarantee will be sent OR BUFFERED.  This
  * driver MUST honor the return value.
  */
-static int hvc_write_room(struct tty_struct *tty)
+static unsigned int hvc_write_room(struct tty_struct *tty)
 {
 	struct hvc_struct *hp = tty->driver_data;
 
diff --git a/drivers/tty/hvc/hvcs.c b/drivers/tty/hvc/hvcs.c
index 197988c55e0c..f43f2f94d8bd 100644
--- a/drivers/tty/hvc/hvcs.c
+++ b/drivers/tty/hvc/hvcs.c
@@ -1376,7 +1376,7 @@ static int hvcs_write(struct tty_struct *tty,
  * absolutely WILL BUFFER if we can't send it.  This driver MUST honor the
  * return value, hence the reason for hvcs_struct buffering.
  */
-static int hvcs_write_room(struct tty_struct *tty)
+static unsigned int hvcs_write_room(struct tty_struct *tty)
 {
 	struct hvcs_struct *hvcsd = tty->driver_data;
 
diff --git a/drivers/tty/hvc/hvsi.c b/drivers/tty/hvc/hvsi.c
index e8c58f9bd263..0a56f44e6b12 100644
--- a/drivers/tty/hvc/hvsi.c
+++ b/drivers/tty/hvc/hvsi.c
@@ -890,7 +890,7 @@ static void hvsi_write_worker(struct work_struct *work)
 	spin_unlock_irqrestore(&hp->lock, flags);
 }
 
-static int hvsi_write_room(struct tty_struct *tty)
+static unsigned int hvsi_write_room(struct tty_struct *tty)
 {
 	struct hvsi_struct *hp = tty->driver_data;
 
@@ -929,7 +929,7 @@ static int hvsi_write(struct tty_struct *tty,
 	 * will see there is no room in outbuf and return.
 	 */
 	while ((count > 0) && (hvsi_write_room(tty) > 0)) {
-		int chunksize = min(count, hvsi_write_room(tty));
+		int chunksize = min_t(int, count, hvsi_write_room(tty));
 
 		BUG_ON(hp->n_outbuf < 0);
 		memcpy(hp->outbuf + hp->n_outbuf, source, chunksize);
diff --git a/drivers/tty/ipwireless/tty.c b/drivers/tty/ipwireless/tty.c
index 99bb2f149ff5..ab562838313b 100644
--- a/drivers/tty/ipwireless/tty.c
+++ b/drivers/tty/ipwireless/tty.c
@@ -228,7 +228,7 @@ static int ipw_write(struct tty_struct *linux_tty,
 	return count;
 }
 
-static int ipw_write_room(struct tty_struct *linux_tty)
+static unsigned int ipw_write_room(struct tty_struct *linux_tty)
 {
 	struct ipw_tty *tty = linux_tty->driver_data;
 	int room;
diff --git a/drivers/tty/mips_ejtag_fdc.c b/drivers/tty/mips_ejtag_fdc.c
index a8e19b4833bf..f427e8e154d7 100644
--- a/drivers/tty/mips_ejtag_fdc.c
+++ b/drivers/tty/mips_ejtag_fdc.c
@@ -840,11 +840,11 @@ static int mips_ejtag_fdc_tty_write(struct tty_struct *tty,
 	return total;
 }
 
-static int mips_ejtag_fdc_tty_write_room(struct tty_struct *tty)
+static unsigned int mips_ejtag_fdc_tty_write_room(struct tty_struct *tty)
 {
 	struct mips_ejtag_fdc_tty_port *dport = tty->driver_data;
 	struct mips_ejtag_fdc_tty *priv = dport->driver;
-	int room;
+	unsigned int room;
 
 	/* Report the space in the xmit buffer */
 	spin_lock(&dport->xmit_lock);
diff --git a/drivers/tty/moxa.c b/drivers/tty/moxa.c
index 847ad3dac107..e4fe9315de29 100644
--- a/drivers/tty/moxa.c
+++ b/drivers/tty/moxa.c
@@ -188,7 +188,7 @@ module_param(ttymajor, int, 0);
 static int moxa_open(struct tty_struct *, struct file *);
 static void moxa_close(struct tty_struct *, struct file *);
 static int moxa_write(struct tty_struct *, const unsigned char *, int);
-static int moxa_write_room(struct tty_struct *);
+static unsigned int moxa_write_room(struct tty_struct *);
 static void moxa_flush_buffer(struct tty_struct *);
 static int moxa_chars_in_buffer(struct tty_struct *);
 static void moxa_set_termios(struct tty_struct *, struct ktermios *);
@@ -218,7 +218,7 @@ static int MoxaPortWriteData(struct tty_struct *, const unsigned char *, int);
 static int MoxaPortReadData(struct moxa_port *);
 static int MoxaPortTxQueue(struct moxa_port *);
 static int MoxaPortRxQueue(struct moxa_port *);
-static int MoxaPortTxFree(struct moxa_port *);
+static unsigned int MoxaPortTxFree(struct moxa_port *);
 static void MoxaPortTxDisable(struct moxa_port *);
 static void MoxaPortTxEnable(struct moxa_port *);
 static int moxa_get_serial_info(struct tty_struct *, struct serial_struct *);
@@ -1217,7 +1217,7 @@ static int moxa_write(struct tty_struct *tty,
 	return len;
 }
 
-static int moxa_write_room(struct tty_struct *tty)
+static unsigned int moxa_write_room(struct tty_struct *tty)
 {
 	struct moxa_port *ch;
 
@@ -1992,7 +1992,7 @@ static int MoxaPortTxQueue(struct moxa_port *port)
 	return (wptr - rptr) & mask;
 }
 
-static int MoxaPortTxFree(struct moxa_port *port)
+static unsigned int MoxaPortTxFree(struct moxa_port *port)
 {
 	void __iomem *ofsAddr = port->tableAddr;
 	u16 rptr, wptr, mask;
diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index 85271e109014..5851a45d828c 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -1183,7 +1183,7 @@ static void mxser_flush_chars(struct tty_struct *tty)
 	spin_unlock_irqrestore(&info->slock, flags);
 }
 
-static int mxser_write_room(struct tty_struct *tty)
+static unsigned int mxser_write_room(struct tty_struct *tty)
 {
 	struct mxser_port *info = tty->driver_data;
 	int ret;
diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 157b26ef6259..06f0c6d39620 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -3056,7 +3056,7 @@ static int gsmtty_write(struct tty_struct *tty, const unsigned char *buf,
 	return sent;
 }
 
-static int gsmtty_write_room(struct tty_struct *tty)
+static unsigned int gsmtty_write_room(struct tty_struct *tty)
 {
 	struct gsm_dlci *dlci = tty->driver_data;
 	if (dlci->state == DLCI_CLOSED)
diff --git a/drivers/tty/nozomi.c b/drivers/tty/nozomi.c
index 9a2d78ace49b..c55475a9a184 100644
--- a/drivers/tty/nozomi.c
+++ b/drivers/tty/nozomi.c
@@ -1636,10 +1636,10 @@ static int ntty_write(struct tty_struct *tty, const unsigned char *buffer,
  * If the port is unplugged report lots of room and let the bits
  * dribble away so we don't block anything.
  */
-static int ntty_write_room(struct tty_struct *tty)
+static unsigned int ntty_write_room(struct tty_struct *tty)
 {
 	struct port *port = tty->driver_data;
-	int room = 4096;
+	unsigned int room = 4096;
 	const struct nozomi *dc = get_dc_by_tty(tty);
 
 	if (dc)
diff --git a/drivers/tty/pty.c b/drivers/tty/pty.c
index 3e7b5c811f9b..eb8556b19592 100644
--- a/drivers/tty/pty.c
+++ b/drivers/tty/pty.c
@@ -136,7 +136,7 @@ static int pty_write(struct tty_struct *tty, const unsigned char *buf, int c)
  *	the other device.
  */
 
-static int pty_write_room(struct tty_struct *tty)
+static unsigned int pty_write_room(struct tty_struct *tty)
 {
 	if (tty->flow.stopped)
 		return 0;
diff --git a/drivers/tty/serial/kgdb_nmi.c b/drivers/tty/serial/kgdb_nmi.c
index db059b66438e..b193bbc666d4 100644
--- a/drivers/tty/serial/kgdb_nmi.c
+++ b/drivers/tty/serial/kgdb_nmi.c
@@ -298,7 +298,7 @@ static void kgdb_nmi_tty_hangup(struct tty_struct *tty)
 	tty_port_hangup(&priv->port);
 }
 
-static int kgdb_nmi_tty_write_room(struct tty_struct *tty)
+static unsigned int kgdb_nmi_tty_write_room(struct tty_struct *tty)
 {
 	/* Actually, we can handle any amount as we use polled writes. */
 	return 2048;
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 87f7127b57e6..cb46a65a5dd8 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -616,12 +616,12 @@ static int uart_write(struct tty_struct *tty,
 	return ret;
 }
 
-static int uart_write_room(struct tty_struct *tty)
+static unsigned int uart_write_room(struct tty_struct *tty)
 {
 	struct uart_state *state = tty->driver_data;
 	struct uart_port *port;
 	unsigned long flags;
-	int ret;
+	unsigned int ret;
 
 	port = uart_port_lock(state, flags);
 	ret = uart_circ_chars_free(&state->xmit);
diff --git a/drivers/tty/synclink_gt.c b/drivers/tty/synclink_gt.c
index 1555dccc28af..583aa8342112 100644
--- a/drivers/tty/synclink_gt.c
+++ b/drivers/tty/synclink_gt.c
@@ -868,15 +868,15 @@ static void wait_until_sent(struct tty_struct *tty, int timeout)
 	DBGINFO(("%s wait_until_sent exit\n", info->device_name));
 }
 
-static int write_room(struct tty_struct *tty)
+static unsigned int write_room(struct tty_struct *tty)
 {
 	struct slgt_info *info = tty->driver_data;
-	int ret;
+	unsigned int ret;
 
 	if (sanity_check(info, tty->name, "write_room"))
 		return 0;
 	ret = (info->tx_active) ? 0 : HDLC_MAX_FRAME_SIZE;
-	DBGINFO(("%s write_room=%d\n", info->device_name, ret));
+	DBGINFO(("%s write_room=%u\n", info->device_name, ret));
 	return ret;
 }
 
diff --git a/drivers/tty/tty_ioctl.c b/drivers/tty/tty_ioctl.c
index 07c88ccfb17a..d8834784b586 100644
--- a/drivers/tty/tty_ioctl.c
+++ b/drivers/tty/tty_ioctl.c
@@ -73,7 +73,7 @@ EXPORT_SYMBOL(tty_chars_in_buffer);
  *	returned and data may be lost as there will be no flow control.
  */
  
-int tty_write_room(struct tty_struct *tty)
+unsigned int tty_write_room(struct tty_struct *tty)
 {
 	if (tty->ops->write_room)
 		return tty->ops->write_room(tty);
diff --git a/drivers/tty/ttynull.c b/drivers/tty/ttynull.c
index 17f05b7eb6d3..af3311a24917 100644
--- a/drivers/tty/ttynull.c
+++ b/drivers/tty/ttynull.c
@@ -35,7 +35,7 @@ static int ttynull_write(struct tty_struct *tty, const unsigned char *buf,
 	return count;
 }
 
-static int ttynull_write_room(struct tty_struct *tty)
+static unsigned int ttynull_write_room(struct tty_struct *tty)
 {
 	return 65536;
 }
diff --git a/drivers/tty/vcc.c b/drivers/tty/vcc.c
index 0a3a71e14df4..d82ce3bb82c3 100644
--- a/drivers/tty/vcc.c
+++ b/drivers/tty/vcc.c
@@ -870,10 +870,10 @@ static int vcc_write(struct tty_struct *tty, const unsigned char *buf,
 	return total_sent ? total_sent : rv;
 }
 
-static int vcc_write_room(struct tty_struct *tty)
+static unsigned int vcc_write_room(struct tty_struct *tty)
 {
 	struct vcc_port *port;
-	u64 num;
+	unsigned int num;
 
 	port = vcc_get_ne(tty->index);
 	if (unlikely(!port)) {
diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 706f066eb711..96c130714930 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -3263,7 +3263,7 @@ static int con_put_char(struct tty_struct *tty, unsigned char ch)
 	return do_con_write(tty, &ch, 1);
 }
 
-static int con_write_room(struct tty_struct *tty)
+static unsigned int con_write_room(struct tty_struct *tty)
 {
 	if (tty->flow.stopped)
 		return 0;
diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
index ca7a61190dd9..76b7fd234238 100644
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -838,7 +838,7 @@ static int acm_tty_write(struct tty_struct *tty,
 	return count;
 }
 
-static int acm_tty_write_room(struct tty_struct *tty)
+static unsigned int acm_tty_write_room(struct tty_struct *tty)
 {
 	struct acm *acm = tty->driver_data;
 	/*
diff --git a/drivers/usb/gadget/function/u_serial.c b/drivers/usb/gadget/function/u_serial.c
index 1e59204ec7aa..676a920d9d6b 100644
--- a/drivers/usb/gadget/function/u_serial.c
+++ b/drivers/usb/gadget/function/u_serial.c
@@ -774,18 +774,18 @@ static void gs_flush_chars(struct tty_struct *tty)
 	spin_unlock_irqrestore(&port->port_lock, flags);
 }
 
-static int gs_write_room(struct tty_struct *tty)
+static unsigned int gs_write_room(struct tty_struct *tty)
 {
 	struct gs_port	*port = tty->driver_data;
 	unsigned long	flags;
-	int		room = 0;
+	unsigned int room = 0;
 
 	spin_lock_irqsave(&port->port_lock, flags);
 	if (port->port_usb)
 		room = kfifo_avail(&port->port_write_buf);
 	spin_unlock_irqrestore(&port->port_lock, flags);
 
-	pr_vdebug("gs_write_room: (%d,%p) room=%d\n",
+	pr_vdebug("gs_write_room: (%d,%p) room=%u\n",
 		port->port_num, tty, room);
 
 	return room;
diff --git a/drivers/usb/host/xhci-dbgtty.c b/drivers/usb/host/xhci-dbgtty.c
index ae4e4ab638b5..cd3ab35dd689 100644
--- a/drivers/usb/host/xhci-dbgtty.c
+++ b/drivers/usb/host/xhci-dbgtty.c
@@ -240,11 +240,11 @@ static void dbc_tty_flush_chars(struct tty_struct *tty)
 	spin_unlock_irqrestore(&port->port_lock, flags);
 }
 
-static int dbc_tty_write_room(struct tty_struct *tty)
+static unsigned int dbc_tty_write_room(struct tty_struct *tty)
 {
 	struct dbc_port		*port = tty->driver_data;
 	unsigned long		flags;
-	int			room = 0;
+	unsigned int		room;
 
 	spin_lock_irqsave(&port->port_lock, flags);
 	room = kfifo_avail(&port->write_fifo);
diff --git a/drivers/usb/serial/usb-serial.c b/drivers/usb/serial/usb-serial.c
index 98b33b1b5357..055096831daf 100644
--- a/drivers/usb/serial/usb-serial.c
+++ b/drivers/usb/serial/usb-serial.c
@@ -376,7 +376,7 @@ static int serial_write(struct tty_struct *tty, const unsigned char *buf,
 	return retval;
 }
 
-static int serial_write_room(struct tty_struct *tty)
+static unsigned int serial_write_room(struct tty_struct *tty)
 {
 	struct usb_serial_port *port = tty->driver_data;
 
diff --git a/include/linux/tty.h b/include/linux/tty.h
index e18a4f1ac39d..d18fc34d3054 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -459,7 +459,7 @@ extern void tty_write_message(struct tty_struct *tty, char *msg);
 extern int tty_send_xchar(struct tty_struct *tty, char ch);
 extern int tty_put_char(struct tty_struct *tty, unsigned char c);
 extern int tty_chars_in_buffer(struct tty_struct *tty);
-extern int tty_write_room(struct tty_struct *tty);
+extern unsigned int tty_write_room(struct tty_struct *tty);
 extern void tty_driver_flush_buffer(struct tty_struct *tty);
 extern void tty_throttle(struct tty_struct *tty);
 extern void tty_unthrottle(struct tty_struct *tty);
diff --git a/include/linux/tty_driver.h b/include/linux/tty_driver.h
index 653fa5af3a22..ea5b15c72764 100644
--- a/include/linux/tty_driver.h
+++ b/include/linux/tty_driver.h
@@ -89,7 +89,7 @@
  *
  *	Note: Do not call this function directly, call tty_driver_flush_chars
  * 
- * int  (*write_room)(struct tty_struct *tty);
+ * unsigned int  (*write_room)(struct tty_struct *tty);
  *
  * 	This routine returns the numbers of characters the tty driver
  * 	will accept for queuing to be written.  This number is subject
@@ -256,7 +256,7 @@ struct tty_operations {
 		      const unsigned char *buf, int count);
 	int  (*put_char)(struct tty_struct *tty, unsigned char ch);
 	void (*flush_chars)(struct tty_struct *tty);
-	int  (*write_room)(struct tty_struct *tty);
+	unsigned int (*write_room)(struct tty_struct *tty);
 	int  (*chars_in_buffer)(struct tty_struct *tty);
 	int  (*ioctl)(struct tty_struct *tty,
 		    unsigned int cmd, unsigned long arg);
diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
index a58584949a95..a5e3d957f20f 100644
--- a/net/bluetooth/rfcomm/tty.c
+++ b/net/bluetooth/rfcomm/tty.c
@@ -807,7 +807,7 @@ static int rfcomm_tty_write(struct tty_struct *tty, const unsigned char *buf, in
 	return sent;
 }
 
-static int rfcomm_tty_write_room(struct tty_struct *tty)
+static unsigned int rfcomm_tty_write_room(struct tty_struct *tty)
 {
 	struct rfcomm_dev *dev = (struct rfcomm_dev *) tty->driver_data;
 	int room = 0;
-- 
2.31.1

