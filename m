Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 471A7C43611
	for <linux-serial@archiver.kernel.org>; Wed,  5 May 2021 09:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 151F8613F0
	for <linux-serial@archiver.kernel.org>; Wed,  5 May 2021 09:19:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232555AbhEEJUl (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 5 May 2021 05:20:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:41350 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232389AbhEEJUc (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 5 May 2021 05:20:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 56395B268;
        Wed,  5 May 2021 09:19:34 +0000 (UTC)
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
        Rodolfo Giometti <giometti@enneenne.com>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH 14/35] tty: set tty_ldisc_ops::num statically
Date:   Wed,  5 May 2021 11:19:07 +0200
Message-Id: <20210505091928.22010-15-jslaby@suse.cz>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210505091928.22010-1-jslaby@suse.cz>
References: <20210505091928.22010-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

There is no reason to pass the ldisc number to tty_register_ldisc
separately. Just set it in the already defined tty_ldisc_ops in all the
ldiscs.

This simplifies tty_register_ldisc a bit too (no need to set the num
member there).

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
Cc: Rodolfo Giometti <giometti@enneenne.com>
Cc: Peter Ujfalusi <peter.ujfalusi@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
---
 drivers/accessibility/speakup/spk_ttyio.c | 3 ++-
 drivers/bluetooth/hci_ldisc.c             | 3 ++-
 drivers/input/serio/serport.c             | 3 ++-
 drivers/misc/ti-st/st_core.c              | 3 ++-
 drivers/net/caif/caif_serial.c            | 3 ++-
 drivers/net/can/slcan.c                   | 3 ++-
 drivers/net/hamradio/6pack.c              | 4 +++-
 drivers/net/hamradio/mkiss.c              | 3 ++-
 drivers/net/ppp/ppp_async.c               | 3 ++-
 drivers/net/ppp/ppp_synctty.c             | 3 ++-
 drivers/net/slip/slip.c                   | 3 ++-
 drivers/pps/clients/pps-ldisc.c           | 3 ++-
 drivers/tty/n_gsm.c                       | 3 ++-
 drivers/tty/n_hdlc.c                      | 3 ++-
 drivers/tty/n_null.c                      | 3 ++-
 drivers/tty/n_tty.c                       | 3 ++-
 drivers/tty/tty_ldisc.c                   | 7 +++----
 include/linux/tty.h                       | 2 +-
 net/nfc/nci/uart.c                        | 3 ++-
 sound/soc/ti/ams-delta.c                  | 3 ++-
 20 files changed, 41 insertions(+), 23 deletions(-)

diff --git a/drivers/accessibility/speakup/spk_ttyio.c b/drivers/accessibility/speakup/spk_ttyio.c
index b7fd094700d9..8faa27bae6bf 100644
--- a/drivers/accessibility/speakup/spk_ttyio.c
+++ b/drivers/accessibility/speakup/spk_ttyio.c
@@ -105,6 +105,7 @@ static int spk_ttyio_receive_buf2(struct tty_struct *tty,
 
 static struct tty_ldisc_ops spk_ttyio_ldisc_ops = {
 	.owner          = THIS_MODULE,
+	.num		= N_SPEAKUP,
 	.name           = "speakup_ldisc",
 	.open           = spk_ttyio_ldisc_open,
 	.close          = spk_ttyio_ldisc_close,
@@ -212,7 +213,7 @@ static int spk_ttyio_initialise_ldisc(struct spk_synth *synth)
 
 void spk_ttyio_register_ldisc(void)
 {
-	if (tty_register_ldisc(N_SPEAKUP, &spk_ttyio_ldisc_ops))
+	if (tty_register_ldisc(&spk_ttyio_ldisc_ops))
 		pr_warn("speakup: Error registering line discipline. Most synths won't work.\n");
 }
 
diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index e785851a92c1..ee32006e8fc9 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -821,6 +821,7 @@ static __poll_t hci_uart_tty_poll(struct tty_struct *tty,
 
 static struct tty_ldisc_ops hci_uart_ldisc = {
 	.owner		= THIS_MODULE,
+	.num		= N_HCI,
 	.name		= "n_hci",
 	.open		= hci_uart_tty_open,
 	.close		= hci_uart_tty_close,
@@ -840,7 +841,7 @@ static int __init hci_uart_init(void)
 	BT_INFO("HCI UART driver ver %s", VERSION);
 
 	/* Register the tty discipline */
-	err = tty_register_ldisc(N_HCI, &hci_uart_ldisc);
+	err = tty_register_ldisc(&hci_uart_ldisc);
 	if (err) {
 		BT_ERR("HCI line discipline registration failed. (%d)", err);
 		return err;
diff --git a/drivers/input/serio/serport.c b/drivers/input/serio/serport.c
index ff3715315592..870b1d2606fc 100644
--- a/drivers/input/serio/serport.c
+++ b/drivers/input/serio/serport.c
@@ -274,6 +274,7 @@ static void serport_ldisc_write_wakeup(struct tty_struct * tty)
 
 static struct tty_ldisc_ops serport_ldisc = {
 	.owner =	THIS_MODULE,
+	.num =		N_MOUSE,
 	.name =		"input",
 	.open =		serport_ldisc_open,
 	.close =	serport_ldisc_close,
@@ -294,7 +295,7 @@ static struct tty_ldisc_ops serport_ldisc = {
 static int __init serport_init(void)
 {
 	int retval;
-	retval = tty_register_ldisc(N_MOUSE, &serport_ldisc);
+	retval = tty_register_ldisc(&serport_ldisc);
 	if (retval)
 		printk(KERN_ERR "serport.c: Error registering line discipline.\n");
 
diff --git a/drivers/misc/ti-st/st_core.c b/drivers/misc/ti-st/st_core.c
index 239a75502cd6..a4f5d02940c7 100644
--- a/drivers/misc/ti-st/st_core.c
+++ b/drivers/misc/ti-st/st_core.c
@@ -845,6 +845,7 @@ static void st_tty_flush_buffer(struct tty_struct *tty)
 }
 
 static struct tty_ldisc_ops st_ldisc_ops = {
+	.num = N_TI_WL,
 	.name = "n_st",
 	.open = st_tty_open,
 	.close = st_tty_close,
@@ -860,7 +861,7 @@ int st_core_init(struct st_data_s **core_data)
 	struct st_data_s *st_gdata;
 	long err;
 
-	err = tty_register_ldisc(N_TI_WL, &st_ldisc_ops);
+	err = tty_register_ldisc(&st_ldisc_ops);
 	if (err) {
 		pr_err("error registering %d line discipline %ld",
 			   N_TI_WL, err);
diff --git a/drivers/net/caif/caif_serial.c b/drivers/net/caif/caif_serial.c
index b0566588ce33..2407a0f6656d 100644
--- a/drivers/net/caif/caif_serial.c
+++ b/drivers/net/caif/caif_serial.c
@@ -382,6 +382,7 @@ static void ldisc_close(struct tty_struct *tty)
 /* The line discipline structure. */
 static struct tty_ldisc_ops caif_ldisc = {
 	.owner =	THIS_MODULE,
+	.num =		N_CAIF,
 	.name =		"n_caif",
 	.open =		ldisc_open,
 	.close =	ldisc_close,
@@ -431,7 +432,7 @@ static int __init caif_ser_init(void)
 {
 	int ret;
 
-	ret = tty_register_ldisc(N_CAIF, &caif_ldisc);
+	ret = tty_register_ldisc(&caif_ldisc);
 	if (ret < 0)
 		pr_err("cannot register CAIF ldisc=%d err=%d\n", N_CAIF, ret);
 
diff --git a/drivers/net/can/slcan.c b/drivers/net/can/slcan.c
index 7dc3e79cb5c4..e3f528c82242 100644
--- a/drivers/net/can/slcan.c
+++ b/drivers/net/can/slcan.c
@@ -698,6 +698,7 @@ static int slcan_ioctl(struct tty_struct *tty, struct file *file,
 
 static struct tty_ldisc_ops slc_ldisc = {
 	.owner		= THIS_MODULE,
+	.num		= N_SLCAN,
 	.name		= "slcan",
 	.open		= slcan_open,
 	.close		= slcan_close,
@@ -722,7 +723,7 @@ static int __init slcan_init(void)
 		return -ENOMEM;
 
 	/* Fill in our line protocol discipline, and register it */
-	status = tty_register_ldisc(N_SLCAN, &slc_ldisc);
+	status = tty_register_ldisc(&slc_ldisc);
 	if (status)  {
 		printk(KERN_ERR "slcan: can't register line discipline\n");
 		kfree(slcan_devs);
diff --git a/drivers/net/hamradio/6pack.c b/drivers/net/hamradio/6pack.c
index c0a80f04dd8e..4db1d3c4d771 100644
--- a/drivers/net/hamradio/6pack.c
+++ b/drivers/net/hamradio/6pack.c
@@ -744,6 +744,7 @@ static int sixpack_ioctl(struct tty_struct *tty, struct file *file,
 
 static struct tty_ldisc_ops sp_ldisc = {
 	.owner		= THIS_MODULE,
+	.num		= N_6PACK,
 	.name		= "6pack",
 	.open		= sixpack_open,
 	.close		= sixpack_close,
@@ -766,7 +767,8 @@ static int __init sixpack_init_driver(void)
 	printk(msg_banner);
 
 	/* Register the provided line protocol discipline */
-	if ((status = tty_register_ldisc(N_6PACK, &sp_ldisc)) != 0)
+	status = tty_register_ldisc(&sp_ldisc);
+	if (status)
 		printk(msg_regfail, status);
 
 	return status;
diff --git a/drivers/net/hamradio/mkiss.c b/drivers/net/hamradio/mkiss.c
index fc05ded48178..1eb87a5a9394 100644
--- a/drivers/net/hamradio/mkiss.c
+++ b/drivers/net/hamradio/mkiss.c
@@ -933,6 +933,7 @@ static void mkiss_write_wakeup(struct tty_struct *tty)
 
 static struct tty_ldisc_ops ax_ldisc = {
 	.owner		= THIS_MODULE,
+	.num		= N_AX25,
 	.name		= "mkiss",
 	.open		= mkiss_open,
 	.close		= mkiss_close,
@@ -952,7 +953,7 @@ static int __init mkiss_init_driver(void)
 
 	printk(banner);
 
-	status = tty_register_ldisc(N_AX25, &ax_ldisc);
+	status = tty_register_ldisc(&ax_ldisc);
 	if (status != 0)
 		printk(msg_regfail, status);
 
diff --git a/drivers/net/ppp/ppp_async.c b/drivers/net/ppp/ppp_async.c
index 9f08bd19551f..4bfb66c40c86 100644
--- a/drivers/net/ppp/ppp_async.c
+++ b/drivers/net/ppp/ppp_async.c
@@ -372,6 +372,7 @@ ppp_asynctty_wakeup(struct tty_struct *tty)
 
 static struct tty_ldisc_ops ppp_ldisc = {
 	.owner  = THIS_MODULE,
+	.num	= N_PPP,
 	.name	= "ppp",
 	.open	= ppp_asynctty_open,
 	.close	= ppp_asynctty_close,
@@ -389,7 +390,7 @@ ppp_async_init(void)
 {
 	int err;
 
-	err = tty_register_ldisc(N_PPP, &ppp_ldisc);
+	err = tty_register_ldisc(&ppp_ldisc);
 	if (err != 0)
 		printk(KERN_ERR "PPP_async: error %d registering line disc.\n",
 		       err);
diff --git a/drivers/net/ppp/ppp_synctty.c b/drivers/net/ppp/ppp_synctty.c
index c82c4e6df4cb..0942d3ee48e0 100644
--- a/drivers/net/ppp/ppp_synctty.c
+++ b/drivers/net/ppp/ppp_synctty.c
@@ -365,6 +365,7 @@ ppp_sync_wakeup(struct tty_struct *tty)
 
 static struct tty_ldisc_ops ppp_sync_ldisc = {
 	.owner	= THIS_MODULE,
+	.num	= N_SYNC_PPP,
 	.name	= "pppsync",
 	.open	= ppp_sync_open,
 	.close	= ppp_sync_close,
@@ -382,7 +383,7 @@ ppp_sync_init(void)
 {
 	int err;
 
-	err = tty_register_ldisc(N_SYNC_PPP, &ppp_sync_ldisc);
+	err = tty_register_ldisc(&ppp_sync_ldisc);
 	if (err != 0)
 		printk(KERN_ERR "PPP_sync: error %d registering line disc.\n",
 		       err);
diff --git a/drivers/net/slip/slip.c b/drivers/net/slip/slip.c
index 4dda49e61745..938ac0ec0305 100644
--- a/drivers/net/slip/slip.c
+++ b/drivers/net/slip/slip.c
@@ -1263,6 +1263,7 @@ static int sl_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 
 static struct tty_ldisc_ops sl_ldisc = {
 	.owner 		= THIS_MODULE,
+	.num		= N_SLIP,
 	.name 		= "slip",
 	.open 		= slip_open,
 	.close	 	= slip_close,
@@ -1298,7 +1299,7 @@ static int __init slip_init(void)
 		return -ENOMEM;
 
 	/* Fill in our line protocol discipline, and register it */
-	status = tty_register_ldisc(N_SLIP, &sl_ldisc);
+	status = tty_register_ldisc(&sl_ldisc);
 	if (status != 0) {
 		printk(KERN_ERR "SLIP: can't register line discipline (err = %d)\n", status);
 		kfree(slip_devs);
diff --git a/drivers/pps/clients/pps-ldisc.c b/drivers/pps/clients/pps-ldisc.c
index bf26cc56b863..2a88e678d0b8 100644
--- a/drivers/pps/clients/pps-ldisc.c
+++ b/drivers/pps/clients/pps-ldisc.c
@@ -112,12 +112,13 @@ static int __init pps_tty_init(void)
 
 	/* Init PPS_TTY data */
 	pps_ldisc_ops.owner = THIS_MODULE;
+	pps_ldisc_ops.num = N_PPS;
 	pps_ldisc_ops.name = "pps_tty";
 	pps_ldisc_ops.dcd_change = pps_tty_dcd_change;
 	pps_ldisc_ops.open = pps_tty_open;
 	pps_ldisc_ops.close = pps_tty_close;
 
-	err = tty_register_ldisc(N_PPS, &pps_ldisc_ops);
+	err = tty_register_ldisc(&pps_ldisc_ops);
 	if (err)
 		pr_err("can't register PPS line discipline\n");
 	else
diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 477403ecc445..654e439ff6c8 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -2857,6 +2857,7 @@ static int gsm_create_network(struct gsm_dlci *dlci, struct gsm_netconfig *nc)
 /* Line discipline for real tty */
 static struct tty_ldisc_ops tty_ldisc_packet = {
 	.owner		 = THIS_MODULE,
+	.num		 = N_GSM0710,
 	.name            = "n_gsm",
 	.open            = gsmld_open,
 	.close           = gsmld_close,
@@ -3242,7 +3243,7 @@ static const struct tty_operations gsmtty_ops = {
 static int __init gsm_init(void)
 {
 	/* Fill in our line protocol discipline, and register it */
-	int status = tty_register_ldisc(N_GSM0710, &tty_ldisc_packet);
+	int status = tty_register_ldisc(&tty_ldisc_packet);
 	if (status != 0) {
 		pr_err("n_gsm: can't register line discipline (err = %d)\n",
 								status);
diff --git a/drivers/tty/n_hdlc.c b/drivers/tty/n_hdlc.c
index 62b1d1a6e0f1..2256039911f5 100644
--- a/drivers/tty/n_hdlc.c
+++ b/drivers/tty/n_hdlc.c
@@ -788,6 +788,7 @@ static struct n_hdlc_buf *n_hdlc_buf_get(struct n_hdlc_buf_list *buf_list)
 
 static struct tty_ldisc_ops n_hdlc_ldisc = {
 	.owner		= THIS_MODULE,
+	.num		= N_HDLC,
 	.name		= "hdlc",
 	.open		= n_hdlc_tty_open,
 	.close		= n_hdlc_tty_close,
@@ -807,7 +808,7 @@ static int __init n_hdlc_init(void)
 	/* range check maxframe arg */
 	maxframe = clamp(maxframe, 4096, MAX_HDLC_FRAME_SIZE);
 
-	status = tty_register_ldisc(N_HDLC, &n_hdlc_ldisc);
+	status = tty_register_ldisc(&n_hdlc_ldisc);
 	if (!status)
 		pr_info("N_HDLC line discipline registered with maxframe=%d\n",
 				maxframe);
diff --git a/drivers/tty/n_null.c b/drivers/tty/n_null.c
index 2ff373d2f98d..ee229c812dce 100644
--- a/drivers/tty/n_null.c
+++ b/drivers/tty/n_null.c
@@ -40,6 +40,7 @@ static void n_null_receivebuf(struct tty_struct *tty,
 
 static struct tty_ldisc_ops null_ldisc = {
 	.owner		=	THIS_MODULE,
+	.num		=	N_NULL,
 	.name		=	"n_null",
 	.open		=	n_null_open,
 	.close		=	n_null_close,
@@ -50,7 +51,7 @@ static struct tty_ldisc_ops null_ldisc = {
 
 static int __init n_null_init(void)
 {
-	BUG_ON(tty_register_ldisc(N_NULL, &null_ldisc));
+	BUG_ON(tty_register_ldisc(&null_ldisc));
 	return 0;
 }
 
diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 8ce712eec026..2fe27905c398 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -2424,6 +2424,7 @@ static int n_tty_ioctl(struct tty_struct *tty, struct file *file,
 
 static struct tty_ldisc_ops n_tty_ops = {
 	.owner		 = THIS_MODULE,
+	.num		 = N_TTY,
 	.name            = "n_tty",
 	.open            = n_tty_open,
 	.close           = n_tty_close,
@@ -2455,5 +2456,5 @@ EXPORT_SYMBOL_GPL(n_tty_inherit_ops);
 
 void __init n_tty_init(void)
 {
-	tty_register_ldisc(N_TTY, &n_tty_ops);
+	tty_register_ldisc(&n_tty_ops);
 }
diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
index 03f414172f34..9aff04bee4cd 100644
--- a/drivers/tty/tty_ldisc.c
+++ b/drivers/tty/tty_ldisc.c
@@ -59,17 +59,16 @@ static struct tty_ldisc_ops *tty_ldiscs[NR_LDISCS];
  *		takes tty_ldiscs_lock to guard against ldisc races
  */
 
-int tty_register_ldisc(int disc, struct tty_ldisc_ops *new_ldisc)
+int tty_register_ldisc(struct tty_ldisc_ops *new_ldisc)
 {
 	unsigned long flags;
 	int ret = 0;
 
-	if (disc < N_TTY || disc >= NR_LDISCS)
+	if (new_ldisc->num < N_TTY || new_ldisc->num >= NR_LDISCS)
 		return -EINVAL;
 
 	raw_spin_lock_irqsave(&tty_ldiscs_lock, flags);
-	tty_ldiscs[disc] = new_ldisc;
-	new_ldisc->num = disc;
+	tty_ldiscs[new_ldisc->num] = new_ldisc;
 	new_ldisc->refcount = 0;
 	raw_spin_unlock_irqrestore(&tty_ldiscs_lock, flags);
 
diff --git a/include/linux/tty.h b/include/linux/tty.h
index 283ac5f29052..95c632299fb4 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -636,7 +636,7 @@ static inline int tty_port_users(struct tty_port *port)
 	return port->count + port->blocked_open;
 }
 
-extern int tty_register_ldisc(int disc, struct tty_ldisc_ops *new_ldisc);
+extern int tty_register_ldisc(struct tty_ldisc_ops *new_ldisc);
 extern int tty_unregister_ldisc(int disc);
 extern int tty_set_ldisc(struct tty_struct *tty, int disc);
 extern int tty_ldisc_receive_buf(struct tty_ldisc *ld, const unsigned char *p,
diff --git a/net/nfc/nci/uart.c b/net/nfc/nci/uart.c
index 98102ef64004..648c26b4bad8 100644
--- a/net/nfc/nci/uart.c
+++ b/net/nfc/nci/uart.c
@@ -442,6 +442,7 @@ EXPORT_SYMBOL_GPL(nci_uart_set_config);
 
 static struct tty_ldisc_ops nci_uart_ldisc = {
 	.owner		= THIS_MODULE,
+	.num		= N_NCI,
 	.name		= "n_nci",
 	.open		= nci_uart_tty_open,
 	.close		= nci_uart_tty_close,
@@ -456,7 +457,7 @@ static struct tty_ldisc_ops nci_uart_ldisc = {
 
 static int __init nci_uart_init(void)
 {
-	return tty_register_ldisc(N_NCI, &nci_uart_ldisc);
+	return tty_register_ldisc(&nci_uart_ldisc);
 }
 
 static void __exit nci_uart_exit(void)
diff --git a/sound/soc/ti/ams-delta.c b/sound/soc/ti/ams-delta.c
index 55a6736a378e..fcbb791bf27a 100644
--- a/sound/soc/ti/ams-delta.c
+++ b/sound/soc/ti/ams-delta.c
@@ -396,6 +396,7 @@ static void cx81801_wakeup(struct tty_struct *tty)
 
 static struct tty_ldisc_ops cx81801_ops = {
 	.name = "cx81801",
+	.num = N_V253,
 	.owner = THIS_MODULE,
 	.open = cx81801_open,
 	.close = cx81801_close,
@@ -503,7 +504,7 @@ static int ams_delta_cx20442_init(struct snd_soc_pcm_runtime *rtd)
 	}
 
 	/* Register optional line discipline for over the modem control */
-	ret = tty_register_ldisc(N_V253, &cx81801_ops);
+	ret = tty_register_ldisc(&cx81801_ops);
 	if (ret) {
 		dev_warn(card->dev,
 				"Failed to register line discipline, "
-- 
2.31.1

