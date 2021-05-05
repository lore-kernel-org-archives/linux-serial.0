Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB44C43470
	for <linux-serial@archiver.kernel.org>; Wed,  5 May 2021 09:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EA23613F6
	for <linux-serial@archiver.kernel.org>; Wed,  5 May 2021 09:19:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232376AbhEEJUj (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 5 May 2021 05:20:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:41422 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232359AbhEEJUa (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 5 May 2021 05:20:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BCA68B25B;
        Wed,  5 May 2021 09:19:32 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>,
        William Hubbs <w.d.hubbs@gmail.com>,
        Chris Brannon <chris@the-brannons.com>,
        Kirk Reiser <kirk@reisers.ca>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Andreas Koensgen <ajk@comnets.uni-bremen.de>,
        Paul Mackerras <paulus@samba.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>
Subject: [PATCH 11/35] tty: make fp of tty_ldisc_ops::receive_buf{,2} const
Date:   Wed,  5 May 2021 11:19:04 +0200
Message-Id: <20210505091928.22010-12-jslaby@suse.cz>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210505091928.22010-1-jslaby@suse.cz>
References: <20210505091928.22010-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Char pointer (cp) passed to tty_ldisc_ops::receive_buf{,2} is const.
There is no reason for flag pointer (fp) not to be too. So switch it in
the definition and all uses.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: William Hubbs <w.d.hubbs@gmail.com>
Cc: Chris Brannon <chris@the-brannons.com>
Cc: Kirk Reiser <kirk@reisers.ca>
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: Marcel Holtmann <marcel@holtmann.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Wolfgang Grandegger <wg@grandegger.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Andreas Koensgen <ajk@comnets.uni-bremen.de>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Peter Ujfalusi <peter.ujfalusi@gmail.com>
---
 drivers/accessibility/speakup/spk_ttyio.c |  3 ++-
 drivers/bluetooth/hci_ldisc.c             |  2 +-
 drivers/input/serio/serport.c             |  3 ++-
 drivers/misc/ti-st/st_core.c              |  2 +-
 drivers/net/caif/caif_serial.c            |  2 +-
 drivers/net/can/slcan.c                   |  3 ++-
 drivers/net/hamradio/6pack.c              |  2 +-
 drivers/net/hamradio/mkiss.c              |  2 +-
 drivers/net/ppp/ppp_async.c               |  6 +++---
 drivers/net/ppp/ppp_synctty.c             |  6 +++---
 drivers/net/slip/slip.c                   |  2 +-
 drivers/tty/n_gsm.c                       |  2 +-
 drivers/tty/n_hdlc.c                      |  2 +-
 drivers/tty/n_null.c                      |  2 +-
 drivers/tty/n_tty.c                       | 16 ++++++++--------
 drivers/tty/tty_buffer.c                  |  4 ++--
 include/linux/tty.h                       |  2 +-
 include/linux/tty_ldisc.h                 |  4 ++--
 net/nfc/nci/uart.c                        |  2 +-
 sound/soc/codecs/cx20442.c                |  4 ++--
 sound/soc/ti/ams-delta.c                  |  4 ++--
 21 files changed, 39 insertions(+), 36 deletions(-)

diff --git a/drivers/accessibility/speakup/spk_ttyio.c b/drivers/accessibility/speakup/spk_ttyio.c
index 2e39fcf492d8..b7fd094700d9 100644
--- a/drivers/accessibility/speakup/spk_ttyio.c
+++ b/drivers/accessibility/speakup/spk_ttyio.c
@@ -72,7 +72,8 @@ static void spk_ttyio_ldisc_close(struct tty_struct *tty)
 }
 
 static int spk_ttyio_receive_buf2(struct tty_struct *tty,
-				  const unsigned char *cp, char *fp, int count)
+				  const unsigned char *cp,
+				  const char *fp, int count)
 {
 	struct spk_ldisc_data *ldisc_data = tty->disc_data;
 	struct spk_synth *synth = ldisc_data->synth;
diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 71a4ca505e09..e785851a92c1 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -593,7 +593,7 @@ static void hci_uart_tty_wakeup(struct tty_struct *tty)
  * Return Value:    None
  */
 static void hci_uart_tty_receive(struct tty_struct *tty, const u8 *data,
-				 char *flags, int count)
+				 const char *flags, int count)
 {
 	struct hci_uart *hu = tty->disc_data;
 
diff --git a/drivers/input/serio/serport.c b/drivers/input/serio/serport.c
index 33e9d9bfd036..ff3715315592 100644
--- a/drivers/input/serio/serport.c
+++ b/drivers/input/serio/serport.c
@@ -114,7 +114,8 @@ static void serport_ldisc_close(struct tty_struct *tty)
  * 'interrupt' routine.
  */
 
-static void serport_ldisc_receive(struct tty_struct *tty, const unsigned char *cp, char *fp, int count)
+static void serport_ldisc_receive(struct tty_struct *tty,
+		const unsigned char *cp, const char *fp, int count)
 {
 	struct serport *serport = (struct serport*) tty->disc_data;
 	unsigned long flags;
diff --git a/drivers/misc/ti-st/st_core.c b/drivers/misc/ti-st/st_core.c
index 071844b58073..239a75502cd6 100644
--- a/drivers/misc/ti-st/st_core.c
+++ b/drivers/misc/ti-st/st_core.c
@@ -798,7 +798,7 @@ static void st_tty_close(struct tty_struct *tty)
 }
 
 static void st_tty_receive(struct tty_struct *tty, const unsigned char *data,
-			   char *tty_flags, int count)
+			   const char *tty_flags, int count)
 {
 #ifdef VERBOSE
 	print_hex_dump(KERN_DEBUG, ">in>", DUMP_PREFIX_NONE,
diff --git a/drivers/net/caif/caif_serial.c b/drivers/net/caif/caif_serial.c
index da6fffb4d5a8..fb3ca4e11fe5 100644
--- a/drivers/net/caif/caif_serial.c
+++ b/drivers/net/caif/caif_serial.c
@@ -159,7 +159,7 @@ static inline void debugfs_tx(struct ser_device *ser, const u8 *data, int size)
 #endif
 
 static void ldisc_receive(struct tty_struct *tty, const u8 *data,
-			char *flags, int count)
+			const char *flags, int count)
 {
 	struct sk_buff *skb = NULL;
 	struct ser_device *ser;
diff --git a/drivers/net/can/slcan.c b/drivers/net/can/slcan.c
index 31ba6664503d..7dc3e79cb5c4 100644
--- a/drivers/net/can/slcan.c
+++ b/drivers/net/can/slcan.c
@@ -467,7 +467,8 @@ static void slc_setup(struct net_device *dev)
  */
 
 static void slcan_receive_buf(struct tty_struct *tty,
-			      const unsigned char *cp, char *fp, int count)
+			      const unsigned char *cp, const char *fp,
+			      int count)
 {
 	struct slcan *sl = (struct slcan *) tty->disc_data;
 
diff --git a/drivers/net/hamradio/6pack.c b/drivers/net/hamradio/6pack.c
index 80f41945709f..c0a80f04dd8e 100644
--- a/drivers/net/hamradio/6pack.c
+++ b/drivers/net/hamradio/6pack.c
@@ -428,7 +428,7 @@ static void sixpack_write_wakeup(struct tty_struct *tty)
  * and sent on to some IP layer for further processing.
  */
 static void sixpack_receive_buf(struct tty_struct *tty,
-	const unsigned char *cp, char *fp, int count)
+	const unsigned char *cp, const char *fp, int count)
 {
 	struct sixpack *sp;
 	int count1;
diff --git a/drivers/net/hamradio/mkiss.c b/drivers/net/hamradio/mkiss.c
index 65154224d5b8..fc05ded48178 100644
--- a/drivers/net/hamradio/mkiss.c
+++ b/drivers/net/hamradio/mkiss.c
@@ -871,7 +871,7 @@ static int mkiss_ioctl(struct tty_struct *tty, struct file *file,
  * and sent on to the AX.25 layer for further processing.
  */
 static void mkiss_receive_buf(struct tty_struct *tty, const unsigned char *cp,
-	char *fp, int count)
+	const char *fp, int count)
 {
 	struct mkiss *ax = mkiss_get(tty);
 
diff --git a/drivers/net/ppp/ppp_async.c b/drivers/net/ppp/ppp_async.c
index 8b41aa3fb64e..9f08bd19551f 100644
--- a/drivers/net/ppp/ppp_async.c
+++ b/drivers/net/ppp/ppp_async.c
@@ -98,7 +98,7 @@ static int ppp_async_send(struct ppp_channel *chan, struct sk_buff *skb);
 static int ppp_async_push(struct asyncppp *ap);
 static void ppp_async_flush_output(struct asyncppp *ap);
 static void ppp_async_input(struct asyncppp *ap, const unsigned char *buf,
-			    char *flags, int count);
+			    const char *flags, int count);
 static int ppp_async_ioctl(struct ppp_channel *chan, unsigned int cmd,
 			   unsigned long arg);
 static void ppp_async_process(struct tasklet_struct *t);
@@ -340,7 +340,7 @@ ppp_asynctty_poll(struct tty_struct *tty, struct file *file, poll_table *wait)
 /* May sleep, don't call from interrupt level or with interrupts disabled */
 static void
 ppp_asynctty_receive(struct tty_struct *tty, const unsigned char *buf,
-		  char *cflags, int count)
+		  const char *cflags, int count)
 {
 	struct asyncppp *ap = ap_get(tty);
 	unsigned long flags;
@@ -829,7 +829,7 @@ process_input_packet(struct asyncppp *ap)
 
 static void
 ppp_async_input(struct asyncppp *ap, const unsigned char *buf,
-		char *flags, int count)
+		const char *flags, int count)
 {
 	struct sk_buff *skb;
 	int c, i, j, n, s, f;
diff --git a/drivers/net/ppp/ppp_synctty.c b/drivers/net/ppp/ppp_synctty.c
index 576b6a93bf23..c82c4e6df4cb 100644
--- a/drivers/net/ppp/ppp_synctty.c
+++ b/drivers/net/ppp/ppp_synctty.c
@@ -94,7 +94,7 @@ static void ppp_sync_process(struct tasklet_struct *t);
 static int ppp_sync_push(struct syncppp *ap);
 static void ppp_sync_flush_output(struct syncppp *ap);
 static void ppp_sync_input(struct syncppp *ap, const unsigned char *buf,
-			   char *flags, int count);
+			   const char *flags, int count);
 
 static const struct ppp_channel_ops sync_ops = {
 	.start_xmit = ppp_sync_send,
@@ -333,7 +333,7 @@ ppp_sync_poll(struct tty_struct *tty, struct file *file, poll_table *wait)
 /* May sleep, don't call from interrupt level or with interrupts disabled */
 static void
 ppp_sync_receive(struct tty_struct *tty, const unsigned char *buf,
-		  char *cflags, int count)
+		  const char *cflags, int count)
 {
 	struct syncppp *ap = sp_get(tty);
 	unsigned long flags;
@@ -665,7 +665,7 @@ ppp_sync_flush_output(struct syncppp *ap)
  */
 static void
 ppp_sync_input(struct syncppp *ap, const unsigned char *buf,
-		char *flags, int count)
+		const char *flags, int count)
 {
 	struct sk_buff *skb;
 	unsigned char *p;
diff --git a/drivers/net/slip/slip.c b/drivers/net/slip/slip.c
index 1ab124eba8eb..4dda49e61745 100644
--- a/drivers/net/slip/slip.c
+++ b/drivers/net/slip/slip.c
@@ -685,7 +685,7 @@ static void sl_setup(struct net_device *dev)
  */
 
 static void slip_receive_buf(struct tty_struct *tty, const unsigned char *cp,
-							char *fp, int count)
+		const char *fp, int count)
 {
 	struct slip *sl = tty->disc_data;
 
diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 5fea02cfb0cc..477403ecc445 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -2424,7 +2424,7 @@ static void gsmld_detach_gsm(struct tty_struct *tty, struct gsm_mux *gsm)
 }
 
 static void gsmld_receive_buf(struct tty_struct *tty, const unsigned char *cp,
-			      char *fp, int count)
+			      const char *fp, int count)
 {
 	struct gsm_mux *gsm = tty->disc_data;
 	char flags = TTY_NORMAL;
diff --git a/drivers/tty/n_hdlc.c b/drivers/tty/n_hdlc.c
index b0f33e8ac819..62b1d1a6e0f1 100644
--- a/drivers/tty/n_hdlc.c
+++ b/drivers/tty/n_hdlc.c
@@ -358,7 +358,7 @@ static void n_hdlc_tty_wakeup(struct tty_struct *tty)
  * interpreted as one HDLC frame.
  */
 static void n_hdlc_tty_receive(struct tty_struct *tty, const __u8 *data,
-			       char *flags, int count)
+			       const char *flags, int count)
 {
 	register struct n_hdlc *n_hdlc = tty->disc_data;
 	register struct n_hdlc_buf *buf;
diff --git a/drivers/tty/n_null.c b/drivers/tty/n_null.c
index b8f67b5f1ef8..2ff373d2f98d 100644
--- a/drivers/tty/n_null.c
+++ b/drivers/tty/n_null.c
@@ -33,7 +33,7 @@ static ssize_t n_null_write(struct tty_struct *tty, struct file *file,
 }
 
 static void n_null_receivebuf(struct tty_struct *tty,
-				 const unsigned char *cp, char *fp,
+				 const unsigned char *cp, const char *fp,
 				 int cnt)
 {
 }
diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 0d93be26c678..c32318da5190 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -1474,7 +1474,7 @@ n_tty_receive_char_lnext(struct tty_struct *tty, unsigned char c, char flag)
 
 static void
 n_tty_receive_buf_real_raw(struct tty_struct *tty, const unsigned char *cp,
-			   char *fp, int count)
+			   const char *fp, int count)
 {
 	struct n_tty_data *ldata = tty->disc_data;
 	size_t n, head;
@@ -1494,7 +1494,7 @@ n_tty_receive_buf_real_raw(struct tty_struct *tty, const unsigned char *cp,
 
 static void
 n_tty_receive_buf_raw(struct tty_struct *tty, const unsigned char *cp,
-		      char *fp, int count)
+		      const char *fp, int count)
 {
 	struct n_tty_data *ldata = tty->disc_data;
 	char flag = TTY_NORMAL;
@@ -1511,7 +1511,7 @@ n_tty_receive_buf_raw(struct tty_struct *tty, const unsigned char *cp,
 
 static void
 n_tty_receive_buf_closing(struct tty_struct *tty, const unsigned char *cp,
-			  char *fp, int count)
+			  const char *fp, int count)
 {
 	char flag = TTY_NORMAL;
 
@@ -1524,7 +1524,7 @@ n_tty_receive_buf_closing(struct tty_struct *tty, const unsigned char *cp,
 }
 
 static void n_tty_receive_buf_standard(struct tty_struct *tty,
-		const unsigned char *cp, char *fp, int count)
+		const unsigned char *cp, const char *fp, int count)
 {
 	struct n_tty_data *ldata = tty->disc_data;
 	char flag = TTY_NORMAL;
@@ -1562,7 +1562,7 @@ static void n_tty_receive_buf_standard(struct tty_struct *tty,
 }
 
 static void __receive_buf(struct tty_struct *tty, const unsigned char *cp,
-			  char *fp, int count)
+			  const char *fp, int count)
 {
 	struct n_tty_data *ldata = tty->disc_data;
 	bool preops = I_ISTRIP(tty) || (I_IUCLC(tty) && L_IEXTEN(tty));
@@ -1629,7 +1629,7 @@ static void __receive_buf(struct tty_struct *tty, const unsigned char *cp,
  */
 static int
 n_tty_receive_buf_common(struct tty_struct *tty, const unsigned char *cp,
-			 char *fp, int count, int flow)
+			 const char *fp, int count, int flow)
 {
 	struct n_tty_data *ldata = tty->disc_data;
 	int room, n, rcvd = 0, overflow;
@@ -1698,13 +1698,13 @@ n_tty_receive_buf_common(struct tty_struct *tty, const unsigned char *cp,
 }
 
 static void n_tty_receive_buf(struct tty_struct *tty, const unsigned char *cp,
-			      char *fp, int count)
+			      const char *fp, int count)
 {
 	n_tty_receive_buf_common(tty, cp, fp, count, 0);
 }
 
 static int n_tty_receive_buf2(struct tty_struct *tty, const unsigned char *cp,
-			      char *fp, int count)
+			      const char *fp, int count)
 {
 	return n_tty_receive_buf_common(tty, cp, fp, count, 1);
 }
diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
index 9733469a14b2..55b1f1711341 100644
--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -455,7 +455,7 @@ EXPORT_SYMBOL_GPL(tty_prepare_flip_string);
  *	Returns the number of bytes processed
  */
 int tty_ldisc_receive_buf(struct tty_ldisc *ld, const unsigned char *p,
-			  char *f, int count)
+			  const char *f, int count)
 {
 	if (ld->ops->receive_buf2)
 		count = ld->ops->receive_buf2(ld->tty, p, f, count);
@@ -472,7 +472,7 @@ static int
 receive_buf(struct tty_port *port, struct tty_buffer *head, int count)
 {
 	unsigned char *p = char_buf_ptr(head, head->read);
-	char	      *f = NULL;
+	const char *f = NULL;
 	int n;
 
 	if (~head->flags & TTYB_NORMAL)
diff --git a/include/linux/tty.h b/include/linux/tty.h
index e5d6b1f28823..5aad2220266c 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -628,7 +628,7 @@ extern int tty_register_ldisc(int disc, struct tty_ldisc_ops *new_ldisc);
 extern int tty_unregister_ldisc(int disc);
 extern int tty_set_ldisc(struct tty_struct *tty, int disc);
 extern int tty_ldisc_receive_buf(struct tty_ldisc *ld, const unsigned char *p,
-				 char *f, int count);
+				 const char *f, int count);
 
 /* n_tty.c */
 extern void n_tty_inherit_ops(struct tty_ldisc_ops *ops);
diff --git a/include/linux/tty_ldisc.h b/include/linux/tty_ldisc.h
index 31284b55bd4f..c20ca6a75b4c 100644
--- a/include/linux/tty_ldisc.h
+++ b/include/linux/tty_ldisc.h
@@ -201,11 +201,11 @@ struct tty_ldisc_ops {
 	 * The following routines are called from below.
 	 */
 	void	(*receive_buf)(struct tty_struct *, const unsigned char *cp,
-			       char *fp, int count);
+			       const char *fp, int count);
 	void	(*write_wakeup)(struct tty_struct *);
 	void	(*dcd_change)(struct tty_struct *, unsigned int);
 	int	(*receive_buf2)(struct tty_struct *, const unsigned char *cp,
-				char *fp, int count);
+				const char *fp, int count);
 
 	struct  module *owner;
 
diff --git a/net/nfc/nci/uart.c b/net/nfc/nci/uart.c
index 1248faf4d6df..98102ef64004 100644
--- a/net/nfc/nci/uart.c
+++ b/net/nfc/nci/uart.c
@@ -308,7 +308,7 @@ static int nci_uart_default_recv_buf(struct nci_uart *nu, const u8 *data,
  * Return Value:    None
  */
 static void nci_uart_tty_receive(struct tty_struct *tty, const u8 *data,
-				 char *flags, int count)
+				 const char *flags, int count)
 {
 	struct nci_uart *nu = (void *)tty->disc_data;
 
diff --git a/sound/soc/codecs/cx20442.c b/sound/soc/codecs/cx20442.c
index 61dfa86d444d..ec8d6e74b467 100644
--- a/sound/soc/codecs/cx20442.c
+++ b/sound/soc/codecs/cx20442.c
@@ -259,8 +259,8 @@ static int v253_hangup(struct tty_struct *tty)
 }
 
 /* Line discipline .receive_buf() */
-static void v253_receive(struct tty_struct *tty,
-				const unsigned char *cp, char *fp, int count)
+static void v253_receive(struct tty_struct *tty, const unsigned char *cp,
+		const char *fp, int count)
 {
 	struct snd_soc_component *component = tty->disc_data;
 	struct cx20442_priv *cx20442;
diff --git a/sound/soc/ti/ams-delta.c b/sound/soc/ti/ams-delta.c
index aba0017e870b..55a6736a378e 100644
--- a/sound/soc/ti/ams-delta.c
+++ b/sound/soc/ti/ams-delta.c
@@ -337,8 +337,8 @@ static int cx81801_hangup(struct tty_struct *tty)
 }
 
 /* Line discipline .receive_buf() */
-static void cx81801_receive(struct tty_struct *tty,
-				const unsigned char *cp, char *fp, int count)
+static void cx81801_receive(struct tty_struct *tty, const unsigned char *cp,
+		const char *fp, int count)
 {
 	struct snd_soc_component *component = tty->disc_data;
 	const unsigned char *c;
-- 
2.31.1

