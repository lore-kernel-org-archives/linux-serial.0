Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76645C43462
	for <linux-serial@archiver.kernel.org>; Wed,  5 May 2021 09:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 428DE613F6
	for <linux-serial@archiver.kernel.org>; Wed,  5 May 2021 09:19:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232693AbhEEJUx (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 5 May 2021 05:20:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:41932 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232479AbhEEJUi (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 5 May 2021 05:20:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C4900B151;
        Wed,  5 May 2021 09:19:40 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>, Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Samuel Iglesias Gonsalvez <siglesias@igalia.com>,
        Jens Taprogge <jens.taprogge@taprogge.org>,
        Karsten Keil <isdn@linux-pingi.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        David Lin <dtwlin@gmail.com>, Johan Hovold <johan@kernel.org>,
        Alex Elder <elder@kernel.org>, Jiri Kosina <jikos@kernel.org>,
        David Sterba <dsterba@suse.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Oliver Neukum <oneukum@suse.com>,
        Felipe Balbi <balbi@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH 26/35] tty: make tty_operations::chars_in_buffer return uint
Date:   Wed,  5 May 2021 11:19:19 +0200
Message-Id: <20210505091928.22010-27-jslaby@suse.cz>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210505091928.22010-1-jslaby@suse.cz>
References: <20210505091928.22010-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tty_operations::chars_in_buffer is another hook which is expected to
return values >= 0. So make it explicit by the return type too -- use
unsigned int.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Jeff Dike <jdike@addtoit.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Samuel Iglesias Gonsalvez <siglesias@igalia.com>
Cc: Jens Taprogge <jens.taprogge@taprogge.org>
Cc: Karsten Keil <isdn@linux-pingi.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: David Lin <dtwlin@gmail.com>
Cc: Johan Hovold <johan@kernel.org>
Cc: Alex Elder <elder@kernel.org>
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
 arch/um/drivers/line.c                 |  4 ++--
 arch/um/drivers/line.h                 |  2 +-
 drivers/char/pcmcia/synclink_cs.c      |  6 +++---
 drivers/ipack/devices/ipoctal.c        |  2 +-
 drivers/isdn/capi/capi.c               |  2 +-
 drivers/mmc/core/sdio_uart.c           |  2 +-
 drivers/net/usb/hso.c                  |  4 ++--
 drivers/s390/char/con3215.c            |  2 +-
 drivers/s390/char/sclp_rw.c            |  4 ++--
 drivers/s390/char/sclp_rw.h            |  2 +-
 drivers/s390/char/sclp_tty.c           |  5 ++---
 drivers/s390/char/sclp_vt220.c         |  5 ++---
 drivers/staging/fwserial/fwserial.c    |  6 +++---
 drivers/staging/greybus/uart.c         |  4 ++--
 drivers/tty/amiserial.c                |  2 +-
 drivers/tty/goldfish.c                 |  2 +-
 drivers/tty/hvc/hvc_console.c          |  2 +-
 drivers/tty/hvc/hvcs.c                 |  2 +-
 drivers/tty/hvc/hvsi.c                 |  2 +-
 drivers/tty/ipwireless/tty.c           |  2 +-
 drivers/tty/mips_ejtag_fdc.c           |  4 ++--
 drivers/tty/moxa.c                     | 10 +++++-----
 drivers/tty/mxser.c                    |  2 +-
 drivers/tty/n_gsm.c                    |  2 +-
 drivers/tty/nozomi.c                   |  2 +-
 drivers/tty/serial/serial_core.c       |  4 ++--
 drivers/tty/synclink_gt.c              |  6 +++---
 drivers/tty/tty_ioctl.c                |  2 +-
 drivers/tty/vcc.c                      |  4 ++--
 drivers/usb/class/cdc-acm.c            |  2 +-
 drivers/usb/gadget/function/u_serial.c |  6 +++---
 drivers/usb/host/xhci-dbgtty.c         |  4 ++--
 drivers/usb/serial/usb-serial.c        |  2 +-
 include/linux/tty.h                    |  2 +-
 include/linux/tty_driver.h             |  2 +-
 net/bluetooth/rfcomm/tty.c             |  2 +-
 36 files changed, 58 insertions(+), 60 deletions(-)

diff --git a/arch/um/drivers/line.c b/arch/um/drivers/line.c
index 2b8810ba5470..159434851417 100644
--- a/arch/um/drivers/line.c
+++ b/arch/um/drivers/line.c
@@ -60,11 +60,11 @@ unsigned int line_write_room(struct tty_struct *tty)
 	return room;
 }
 
-int line_chars_in_buffer(struct tty_struct *tty)
+unsigned int line_chars_in_buffer(struct tty_struct *tty)
 {
 	struct line *line = tty->driver_data;
 	unsigned long flags;
-	int ret;
+	unsigned int ret;
 
 	spin_lock_irqsave(&line->lock, flags);
 	/* write_room subtracts 1 for the needed NULL, so we readd it.*/
diff --git a/arch/um/drivers/line.h b/arch/um/drivers/line.h
index 861edf329569..3325e2bc64e4 100644
--- a/arch/um/drivers/line.h
+++ b/arch/um/drivers/line.h
@@ -67,7 +67,7 @@ extern int line_setup(char **conf, unsigned nlines, char **def,
 extern int line_write(struct tty_struct *tty, const unsigned char *buf,
 		      int len);
 extern void line_set_termios(struct tty_struct *tty, struct ktermios * old);
-extern int line_chars_in_buffer(struct tty_struct *tty);
+extern unsigned int line_chars_in_buffer(struct tty_struct *tty);
 extern void line_flush_buffer(struct tty_struct *tty);
 extern void line_flush_chars(struct tty_struct *tty);
 extern unsigned int line_write_room(struct tty_struct *tty);
diff --git a/drivers/char/pcmcia/synclink_cs.c b/drivers/char/pcmcia/synclink_cs.c
index e4b2c68f44f5..9f7420bc5026 100644
--- a/drivers/char/pcmcia/synclink_cs.c
+++ b/drivers/char/pcmcia/synclink_cs.c
@@ -1637,10 +1637,10 @@ static unsigned int mgslpc_write_room(struct tty_struct *tty)
 
 /* Return the count of bytes in transmit buffer
  */
-static int mgslpc_chars_in_buffer(struct tty_struct *tty)
+static unsigned int mgslpc_chars_in_buffer(struct tty_struct *tty)
 {
 	MGSLPC_INFO *info = (MGSLPC_INFO *)tty->driver_data;
-	int rc;
+	unsigned int rc;
 
 	if (debug_level >= DEBUG_LEVEL_INFO)
 		printk("%s(%d):mgslpc_chars_in_buffer(%s)\n",
@@ -1655,7 +1655,7 @@ static int mgslpc_chars_in_buffer(struct tty_struct *tty)
 		rc = info->tx_count;
 
 	if (debug_level >= DEBUG_LEVEL_INFO)
-		printk("%s(%d):mgslpc_chars_in_buffer(%s)=%d\n",
+		printk("%s(%d):mgslpc_chars_in_buffer(%s)=%u\n",
 			 __FILE__, __LINE__, info->device_name, rc);
 
 	return rc;
diff --git a/drivers/ipack/devices/ipoctal.c b/drivers/ipack/devices/ipoctal.c
index ea0f1aeaaa06..0a3b89c17d08 100644
--- a/drivers/ipack/devices/ipoctal.c
+++ b/drivers/ipack/devices/ipoctal.c
@@ -467,7 +467,7 @@ static unsigned int ipoctal_write_room(struct tty_struct *tty)
 	return PAGE_SIZE - channel->nb_bytes;
 }
 
-static int ipoctal_chars_in_buffer(struct tty_struct *tty)
+static unsigned int ipoctal_chars_in_buffer(struct tty_struct *tty)
 {
 	struct ipoctal_channel *channel = tty->driver_data;
 
diff --git a/drivers/isdn/capi/capi.c b/drivers/isdn/capi/capi.c
index c50c454006b3..dae80197ad9c 100644
--- a/drivers/isdn/capi/capi.c
+++ b/drivers/isdn/capi/capi.c
@@ -1186,7 +1186,7 @@ static unsigned int capinc_tty_write_room(struct tty_struct *tty)
 	return room;
 }
 
-static int capinc_tty_chars_in_buffer(struct tty_struct *tty)
+static unsigned int capinc_tty_chars_in_buffer(struct tty_struct *tty)
 {
 	struct capiminor *mp = tty->driver_data;
 
diff --git a/drivers/mmc/core/sdio_uart.c b/drivers/mmc/core/sdio_uart.c
index c8f4eca7aad4..c36242b86b1d 100644
--- a/drivers/mmc/core/sdio_uart.c
+++ b/drivers/mmc/core/sdio_uart.c
@@ -803,7 +803,7 @@ static unsigned int sdio_uart_write_room(struct tty_struct *tty)
 	return FIFO_SIZE - kfifo_len(&port->xmit_fifo);
 }
 
-static int sdio_uart_chars_in_buffer(struct tty_struct *tty)
+static unsigned int sdio_uart_chars_in_buffer(struct tty_struct *tty)
 {
 	struct sdio_uart_port *port = tty->driver_data;
 	return kfifo_len(&port->xmit_fifo);
diff --git a/drivers/net/usb/hso.c b/drivers/net/usb/hso.c
index bb8bb85308ab..c7563ed3ac31 100644
--- a/drivers/net/usb/hso.c
+++ b/drivers/net/usb/hso.c
@@ -1404,11 +1404,11 @@ static void hso_serial_set_termios(struct tty_struct *tty, struct ktermios *old)
 }
 
 /* how many characters in the buffer */
-static int hso_serial_chars_in_buffer(struct tty_struct *tty)
+static unsigned int hso_serial_chars_in_buffer(struct tty_struct *tty)
 {
 	struct hso_serial *serial = tty->driver_data;
-	int chars;
 	unsigned long flags;
+	unsigned int chars;
 
 	/* sanity check */
 	if (serial == NULL)
diff --git a/drivers/s390/char/con3215.c b/drivers/s390/char/con3215.c
index c9fd4a05931a..8821927ef875 100644
--- a/drivers/s390/char/con3215.c
+++ b/drivers/s390/char/con3215.c
@@ -980,7 +980,7 @@ static void tty3215_flush_chars(struct tty_struct *tty)
 /*
  * Returns the number of characters in the output buffer
  */
-static int tty3215_chars_in_buffer(struct tty_struct *tty)
+static unsigned int tty3215_chars_in_buffer(struct tty_struct *tty)
 {
 	struct raw3215_info *raw = tty->driver_data;
 
diff --git a/drivers/s390/char/sclp_rw.c b/drivers/s390/char/sclp_rw.c
index d6c84e354df5..5a1bf6eaa9d9 100644
--- a/drivers/s390/char/sclp_rw.c
+++ b/drivers/s390/char/sclp_rw.c
@@ -325,10 +325,10 @@ sclp_buffer_space(struct sclp_buffer *buffer)
 /*
  * Return number of characters in buffer
  */
-int
+unsigned int
 sclp_chars_in_buffer(struct sclp_buffer *buffer)
 {
-	int count;
+	unsigned int count;
 
 	count = buffer->char_sum;
 	if (buffer->current_line != NULL)
diff --git a/drivers/s390/char/sclp_rw.h b/drivers/s390/char/sclp_rw.h
index 93d706e4935c..b4506be79246 100644
--- a/drivers/s390/char/sclp_rw.h
+++ b/drivers/s390/char/sclp_rw.h
@@ -86,7 +86,7 @@ void *sclp_unmake_buffer(struct sclp_buffer *);
 int sclp_buffer_space(struct sclp_buffer *);
 int sclp_write(struct sclp_buffer *buffer, const unsigned char *, int);
 int sclp_emit_buffer(struct sclp_buffer *,void (*)(struct sclp_buffer *,int));
-int sclp_chars_in_buffer(struct sclp_buffer *);
+unsigned int sclp_chars_in_buffer(struct sclp_buffer *);
 
 #ifdef CONFIG_SCLP_CONSOLE
 void sclp_console_pm_event(enum sclp_pm_event sclp_pm_event);
diff --git a/drivers/s390/char/sclp_tty.c b/drivers/s390/char/sclp_tty.c
index ea1e43fd16bc..162127ff7845 100644
--- a/drivers/s390/char/sclp_tty.c
+++ b/drivers/s390/char/sclp_tty.c
@@ -280,16 +280,15 @@ sclp_tty_flush_chars(struct tty_struct *tty)
  * characters in the write buffer (will not be written as long as there is a
  * final line feed missing).
  */
-static int
+static unsigned int
 sclp_tty_chars_in_buffer(struct tty_struct *tty)
 {
 	unsigned long flags;
 	struct list_head *l;
 	struct sclp_buffer *t;
-	int count;
+	unsigned int count = 0;
 
 	spin_lock_irqsave(&sclp_tty_lock, flags);
-	count = 0;
 	if (sclp_ttybuf != NULL)
 		count = sclp_chars_in_buffer(sclp_ttybuf);
 	list_for_each(l, &sclp_tty_outqueue) {
diff --git a/drivers/s390/char/sclp_vt220.c b/drivers/s390/char/sclp_vt220.c
index b621adee35f0..24eb3a0b0a9a 100644
--- a/drivers/s390/char/sclp_vt220.c
+++ b/drivers/s390/char/sclp_vt220.c
@@ -629,16 +629,15 @@ sclp_vt220_write_room(struct tty_struct *tty)
 /*
  * Return number of buffered chars.
  */
-static int
+static unsigned int
 sclp_vt220_chars_in_buffer(struct tty_struct *tty)
 {
 	unsigned long flags;
 	struct list_head *l;
 	struct sclp_vt220_request *r;
-	int count;
+	unsigned int count = 0;
 
 	spin_lock_irqsave(&sclp_vt220_lock, flags);
-	count = 0;
 	if (sclp_vt220_current_request != NULL)
 		count = sclp_vt220_chars_stored(sclp_vt220_current_request);
 	list_for_each(l, &sclp_vt220_outqueue) {
diff --git a/drivers/staging/fwserial/fwserial.c b/drivers/staging/fwserial/fwserial.c
index a151cd76d24e..d2b286ea27c5 100644
--- a/drivers/staging/fwserial/fwserial.c
+++ b/drivers/staging/fwserial/fwserial.c
@@ -1127,16 +1127,16 @@ static unsigned int fwtty_write_room(struct tty_struct *tty)
 	return n;
 }
 
-static int fwtty_chars_in_buffer(struct tty_struct *tty)
+static unsigned int fwtty_chars_in_buffer(struct tty_struct *tty)
 {
 	struct fwtty_port *port = tty->driver_data;
-	int n;
+	unsigned int n;
 
 	spin_lock_bh(&port->lock);
 	n = dma_fifo_level(&port->tx_fifo);
 	spin_unlock_bh(&port->lock);
 
-	fwtty_dbg(port, "%d\n", n);
+	fwtty_dbg(port, "%u\n", n);
 
 	return n;
 }
diff --git a/drivers/staging/greybus/uart.c b/drivers/staging/greybus/uart.c
index 529eccb99b6c..ccfaa0f21b9c 100644
--- a/drivers/staging/greybus/uart.c
+++ b/drivers/staging/greybus/uart.c
@@ -457,11 +457,11 @@ static unsigned int gb_tty_write_room(struct tty_struct *tty)
 	return room;
 }
 
-static int gb_tty_chars_in_buffer(struct tty_struct *tty)
+static unsigned int gb_tty_chars_in_buffer(struct tty_struct *tty)
 {
 	struct gb_tty *gb_tty = tty->driver_data;
 	unsigned long flags;
-	int chars;
+	unsigned int chars;
 
 	spin_lock_irqsave(&gb_tty->write_lock, flags);
 	chars = kfifo_len(&gb_tty->write_fifo);
diff --git a/drivers/tty/amiserial.c b/drivers/tty/amiserial.c
index ee1f4d72cd5e..5ec19c48fb7a 100644
--- a/drivers/tty/amiserial.c
+++ b/drivers/tty/amiserial.c
@@ -834,7 +834,7 @@ static unsigned int rs_write_room(struct tty_struct *tty)
 	return CIRC_SPACE(info->xmit.head, info->xmit.tail, SERIAL_XMIT_SIZE);
 }
 
-static int rs_chars_in_buffer(struct tty_struct *tty)
+static unsigned int rs_chars_in_buffer(struct tty_struct *tty)
 {
 	struct serial_state *info = tty->driver_data;
 
diff --git a/drivers/tty/goldfish.c b/drivers/tty/goldfish.c
index e4f9a60dcc18..ccb683a6e6f5 100644
--- a/drivers/tty/goldfish.c
+++ b/drivers/tty/goldfish.c
@@ -198,7 +198,7 @@ static unsigned int goldfish_tty_write_room(struct tty_struct *tty)
 	return 0x10000;
 }
 
-static int goldfish_tty_chars_in_buffer(struct tty_struct *tty)
+static unsigned int goldfish_tty_chars_in_buffer(struct tty_struct *tty)
 {
 	struct goldfish_tty *qtty = &goldfish_ttys[tty->index];
 	void __iomem *base = qtty->base;
diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_console.c
index a3725eb69cd3..d0f0253fb93e 100644
--- a/drivers/tty/hvc/hvc_console.c
+++ b/drivers/tty/hvc/hvc_console.c
@@ -596,7 +596,7 @@ static unsigned int hvc_write_room(struct tty_struct *tty)
 	return hp->outbuf_size - hp->n_outbuf;
 }
 
-static int hvc_chars_in_buffer(struct tty_struct *tty)
+static unsigned int hvc_chars_in_buffer(struct tty_struct *tty)
 {
 	struct hvc_struct *hp = tty->driver_data;
 
diff --git a/drivers/tty/hvc/hvcs.c b/drivers/tty/hvc/hvcs.c
index f43f2f94d8bd..fe5e6b4f43de 100644
--- a/drivers/tty/hvc/hvcs.c
+++ b/drivers/tty/hvc/hvcs.c
@@ -1386,7 +1386,7 @@ static unsigned int hvcs_write_room(struct tty_struct *tty)
 	return HVCS_BUFF_LEN - hvcsd->chars_in_buffer;
 }
 
-static int hvcs_chars_in_buffer(struct tty_struct *tty)
+static unsigned int hvcs_chars_in_buffer(struct tty_struct *tty)
 {
 	struct hvcs_struct *hvcsd = tty->driver_data;
 
diff --git a/drivers/tty/hvc/hvsi.c b/drivers/tty/hvc/hvsi.c
index 0a56f44e6b12..bfc15279d5bc 100644
--- a/drivers/tty/hvc/hvsi.c
+++ b/drivers/tty/hvc/hvsi.c
@@ -897,7 +897,7 @@ static unsigned int hvsi_write_room(struct tty_struct *tty)
 	return N_OUTBUF - hp->n_outbuf;
 }
 
-static int hvsi_chars_in_buffer(struct tty_struct *tty)
+static unsigned int hvsi_chars_in_buffer(struct tty_struct *tty)
 {
 	struct hvsi_struct *hp = tty->driver_data;
 
diff --git a/drivers/tty/ipwireless/tty.c b/drivers/tty/ipwireless/tty.c
index ab562838313b..e01ca68f24f4 100644
--- a/drivers/tty/ipwireless/tty.c
+++ b/drivers/tty/ipwireless/tty.c
@@ -270,7 +270,7 @@ static int ipwireless_set_serial_info(struct tty_struct *linux_tty,
 	return 0;	/* Keeps the PCMCIA scripts happy. */
 }
 
-static int ipw_chars_in_buffer(struct tty_struct *linux_tty)
+static unsigned int ipw_chars_in_buffer(struct tty_struct *linux_tty)
 {
 	struct ipw_tty *tty = linux_tty->driver_data;
 
diff --git a/drivers/tty/mips_ejtag_fdc.c b/drivers/tty/mips_ejtag_fdc.c
index f427e8e154d7..3b5915b94fac 100644
--- a/drivers/tty/mips_ejtag_fdc.c
+++ b/drivers/tty/mips_ejtag_fdc.c
@@ -854,10 +854,10 @@ static unsigned int mips_ejtag_fdc_tty_write_room(struct tty_struct *tty)
 	return room;
 }
 
-static int mips_ejtag_fdc_tty_chars_in_buffer(struct tty_struct *tty)
+static unsigned int mips_ejtag_fdc_tty_chars_in_buffer(struct tty_struct *tty)
 {
 	struct mips_ejtag_fdc_tty_port *dport = tty->driver_data;
-	int chars;
+	unsigned int chars;
 
 	/* Report the number of bytes in the xmit buffer */
 	spin_lock(&dport->xmit_lock);
diff --git a/drivers/tty/moxa.c b/drivers/tty/moxa.c
index e4fe9315de29..64b18177c790 100644
--- a/drivers/tty/moxa.c
+++ b/drivers/tty/moxa.c
@@ -190,7 +190,7 @@ static void moxa_close(struct tty_struct *, struct file *);
 static int moxa_write(struct tty_struct *, const unsigned char *, int);
 static unsigned int moxa_write_room(struct tty_struct *);
 static void moxa_flush_buffer(struct tty_struct *);
-static int moxa_chars_in_buffer(struct tty_struct *);
+static unsigned int moxa_chars_in_buffer(struct tty_struct *);
 static void moxa_set_termios(struct tty_struct *, struct ktermios *);
 static void moxa_stop(struct tty_struct *);
 static void moxa_start(struct tty_struct *);
@@ -216,7 +216,7 @@ static int MoxaPortLineStatus(struct moxa_port *);
 static void MoxaPortFlushData(struct moxa_port *, int);
 static int MoxaPortWriteData(struct tty_struct *, const unsigned char *, int);
 static int MoxaPortReadData(struct moxa_port *);
-static int MoxaPortTxQueue(struct moxa_port *);
+static unsigned int MoxaPortTxQueue(struct moxa_port *);
 static int MoxaPortRxQueue(struct moxa_port *);
 static unsigned int MoxaPortTxFree(struct moxa_port *);
 static void MoxaPortTxDisable(struct moxa_port *);
@@ -1239,10 +1239,10 @@ static void moxa_flush_buffer(struct tty_struct *tty)
 	tty_wakeup(tty);
 }
 
-static int moxa_chars_in_buffer(struct tty_struct *tty)
+static unsigned int moxa_chars_in_buffer(struct tty_struct *tty)
 {
 	struct moxa_port *ch = tty->driver_data;
-	int chars;
+	unsigned int chars;
 
 	chars = MoxaPortTxQueue(ch);
 	if (chars)
@@ -1981,7 +1981,7 @@ static int MoxaPortReadData(struct moxa_port *port)
 }
 
 
-static int MoxaPortTxQueue(struct moxa_port *port)
+static unsigned int MoxaPortTxQueue(struct moxa_port *port)
 {
 	void __iomem *ofsAddr = port->tableAddr;
 	u16 rptr, wptr, mask;
diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index 5851a45d828c..a74e6146a748 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -1192,7 +1192,7 @@ static unsigned int mxser_write_room(struct tty_struct *tty)
 	return ret < 0 ? 0 : ret;
 }
 
-static int mxser_chars_in_buffer(struct tty_struct *tty)
+static unsigned int mxser_chars_in_buffer(struct tty_struct *tty)
 {
 	struct mxser_port *info = tty->driver_data;
 	return info->xmit_cnt;
diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 06f0c6d39620..bd24dc0d7e96 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -3064,7 +3064,7 @@ static unsigned int gsmtty_write_room(struct tty_struct *tty)
 	return TX_SIZE - kfifo_len(&dlci->fifo);
 }
 
-static int gsmtty_chars_in_buffer(struct tty_struct *tty)
+static unsigned int gsmtty_chars_in_buffer(struct tty_struct *tty)
 {
 	struct gsm_dlci *dlci = tty->driver_data;
 	if (dlci->state == DLCI_CLOSED)
diff --git a/drivers/tty/nozomi.c b/drivers/tty/nozomi.c
index c55475a9a184..62c16731ccd8 100644
--- a/drivers/tty/nozomi.c
+++ b/drivers/tty/nozomi.c
@@ -1776,7 +1776,7 @@ static void ntty_throttle(struct tty_struct *tty)
 }
 
 /* Returns number of chars in buffer, called by tty layer */
-static s32 ntty_chars_in_buffer(struct tty_struct *tty)
+static unsigned int ntty_chars_in_buffer(struct tty_struct *tty)
 {
 	struct port *port = tty->driver_data;
 	struct nozomi *dc = get_dc_by_tty(tty);
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index cb46a65a5dd8..d29329eb52f4 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -629,12 +629,12 @@ static unsigned int uart_write_room(struct tty_struct *tty)
 	return ret;
 }
 
-static int uart_chars_in_buffer(struct tty_struct *tty)
+static unsigned int uart_chars_in_buffer(struct tty_struct *tty)
 {
 	struct uart_state *state = tty->driver_data;
 	struct uart_port *port;
 	unsigned long flags;
-	int ret;
+	unsigned int ret;
 
 	port = uart_port_lock(state, flags);
 	ret = uart_circ_chars_pending(&state->xmit);
diff --git a/drivers/tty/synclink_gt.c b/drivers/tty/synclink_gt.c
index 583aa8342112..cf87dc66087b 100644
--- a/drivers/tty/synclink_gt.c
+++ b/drivers/tty/synclink_gt.c
@@ -1254,14 +1254,14 @@ static int synclink_gt_proc_show(struct seq_file *m, void *v)
 /*
  * return count of bytes in transmit buffer
  */
-static int chars_in_buffer(struct tty_struct *tty)
+static unsigned int chars_in_buffer(struct tty_struct *tty)
 {
 	struct slgt_info *info = tty->driver_data;
-	int count;
+	unsigned int count;
 	if (sanity_check(info, tty->name, "chars_in_buffer"))
 		return 0;
 	count = tbuf_bytes(info);
-	DBGINFO(("%s chars_in_buffer()=%d\n", info->device_name, count));
+	DBGINFO(("%s chars_in_buffer()=%u\n", info->device_name, count));
 	return count;
 }
 
diff --git a/drivers/tty/tty_ioctl.c b/drivers/tty/tty_ioctl.c
index d8834784b586..aa9ecc8be990 100644
--- a/drivers/tty/tty_ioctl.c
+++ b/drivers/tty/tty_ioctl.c
@@ -54,7 +54,7 @@
  *	to be no queue on the device.
  */
 
-int tty_chars_in_buffer(struct tty_struct *tty)
+unsigned int tty_chars_in_buffer(struct tty_struct *tty)
 {
 	if (tty->ops->chars_in_buffer)
 		return tty->ops->chars_in_buffer(tty);
diff --git a/drivers/tty/vcc.c b/drivers/tty/vcc.c
index d82ce3bb82c3..e883b8f12099 100644
--- a/drivers/tty/vcc.c
+++ b/drivers/tty/vcc.c
@@ -888,10 +888,10 @@ static unsigned int vcc_write_room(struct tty_struct *tty)
 	return num;
 }
 
-static int vcc_chars_in_buffer(struct tty_struct *tty)
+static unsigned int vcc_chars_in_buffer(struct tty_struct *tty)
 {
 	struct vcc_port *port;
-	u64 num;
+	unsigned int num;
 
 	port = vcc_get_ne(tty->index);
 	if (unlikely(!port)) {
diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
index 76b7fd234238..81199efe0312 100644
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -848,7 +848,7 @@ static unsigned int acm_tty_write_room(struct tty_struct *tty)
 	return acm_wb_is_avail(acm) ? acm->writesize : 0;
 }
 
-static int acm_tty_chars_in_buffer(struct tty_struct *tty)
+static unsigned int acm_tty_chars_in_buffer(struct tty_struct *tty)
 {
 	struct acm *acm = tty->driver_data;
 	/*
diff --git a/drivers/usb/gadget/function/u_serial.c b/drivers/usb/gadget/function/u_serial.c
index 676a920d9d6b..bffef8e47dac 100644
--- a/drivers/usb/gadget/function/u_serial.c
+++ b/drivers/usb/gadget/function/u_serial.c
@@ -791,17 +791,17 @@ static unsigned int gs_write_room(struct tty_struct *tty)
 	return room;
 }
 
-static int gs_chars_in_buffer(struct tty_struct *tty)
+static unsigned int gs_chars_in_buffer(struct tty_struct *tty)
 {
 	struct gs_port	*port = tty->driver_data;
 	unsigned long	flags;
-	int		chars = 0;
+	unsigned int	chars;
 
 	spin_lock_irqsave(&port->port_lock, flags);
 	chars = kfifo_len(&port->port_write_buf);
 	spin_unlock_irqrestore(&port->port_lock, flags);
 
-	pr_vdebug("gs_chars_in_buffer: (%d,%p) chars=%d\n",
+	pr_vdebug("gs_chars_in_buffer: (%d,%p) chars=%u\n",
 		port->port_num, tty, chars);
 
 	return chars;
diff --git a/drivers/usb/host/xhci-dbgtty.c b/drivers/usb/host/xhci-dbgtty.c
index cd3ab35dd689..bef104511352 100644
--- a/drivers/usb/host/xhci-dbgtty.c
+++ b/drivers/usb/host/xhci-dbgtty.c
@@ -253,11 +253,11 @@ static unsigned int dbc_tty_write_room(struct tty_struct *tty)
 	return room;
 }
 
-static int dbc_tty_chars_in_buffer(struct tty_struct *tty)
+static unsigned int dbc_tty_chars_in_buffer(struct tty_struct *tty)
 {
 	struct dbc_port		*port = tty->driver_data;
 	unsigned long		flags;
-	int			chars = 0;
+	unsigned int		chars;
 
 	spin_lock_irqsave(&port->port_lock, flags);
 	chars = kfifo_len(&port->write_fifo);
diff --git a/drivers/usb/serial/usb-serial.c b/drivers/usb/serial/usb-serial.c
index 055096831daf..eeb441c77207 100644
--- a/drivers/usb/serial/usb-serial.c
+++ b/drivers/usb/serial/usb-serial.c
@@ -385,7 +385,7 @@ static unsigned int serial_write_room(struct tty_struct *tty)
 	return port->serial->type->write_room(tty);
 }
 
-static int serial_chars_in_buffer(struct tty_struct *tty)
+static unsigned int serial_chars_in_buffer(struct tty_struct *tty)
 {
 	struct usb_serial_port *port = tty->driver_data;
 	struct usb_serial *serial = port->serial;
diff --git a/include/linux/tty.h b/include/linux/tty.h
index d18fc34d3054..5cf6b2e7331b 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -458,7 +458,7 @@ extern void tty_unregister_device(struct tty_driver *driver, unsigned index);
 extern void tty_write_message(struct tty_struct *tty, char *msg);
 extern int tty_send_xchar(struct tty_struct *tty, char ch);
 extern int tty_put_char(struct tty_struct *tty, unsigned char c);
-extern int tty_chars_in_buffer(struct tty_struct *tty);
+extern unsigned int tty_chars_in_buffer(struct tty_struct *tty);
 extern unsigned int tty_write_room(struct tty_struct *tty);
 extern void tty_driver_flush_buffer(struct tty_struct *tty);
 extern void tty_throttle(struct tty_struct *tty);
diff --git a/include/linux/tty_driver.h b/include/linux/tty_driver.h
index ea5b15c72764..a4694bb125cc 100644
--- a/include/linux/tty_driver.h
+++ b/include/linux/tty_driver.h
@@ -257,7 +257,7 @@ struct tty_operations {
 	int  (*put_char)(struct tty_struct *tty, unsigned char ch);
 	void (*flush_chars)(struct tty_struct *tty);
 	unsigned int (*write_room)(struct tty_struct *tty);
-	int  (*chars_in_buffer)(struct tty_struct *tty);
+	unsigned int (*chars_in_buffer)(struct tty_struct *tty);
 	int  (*ioctl)(struct tty_struct *tty,
 		    unsigned int cmd, unsigned long arg);
 	long (*compat_ioctl)(struct tty_struct *tty,
diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
index a5e3d957f20f..c76dcc0f679b 100644
--- a/net/bluetooth/rfcomm/tty.c
+++ b/net/bluetooth/rfcomm/tty.c
@@ -1010,7 +1010,7 @@ static void rfcomm_tty_unthrottle(struct tty_struct *tty)
 	rfcomm_dlc_unthrottle(dev->dlc);
 }
 
-static int rfcomm_tty_chars_in_buffer(struct tty_struct *tty)
+static unsigned int rfcomm_tty_chars_in_buffer(struct tty_struct *tty)
 {
 	struct rfcomm_dev *dev = (struct rfcomm_dev *) tty->driver_data;
 
-- 
2.31.1

