Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4028C43460
	for <linux-serial@archiver.kernel.org>; Wed,  5 May 2021 09:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8307B613C7
	for <linux-serial@archiver.kernel.org>; Wed,  5 May 2021 09:19:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232596AbhEEJUp (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 5 May 2021 05:20:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:41614 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232403AbhEEJUc (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 5 May 2021 05:20:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 24B43B273;
        Wed,  5 May 2021 09:19:35 +0000 (UTC)
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
Subject: [PATCH 16/35] tty: make tty_ldisc_ops a param in tty_unregister_ldisc
Date:   Wed,  5 May 2021 11:19:09 +0200
Message-Id: <20210505091928.22010-17-jslaby@suse.cz>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210505091928.22010-1-jslaby@suse.cz>
References: <20210505091928.22010-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Make tty_unregister_ldisc symmetric to tty_register_ldisc by accepting
struct tty_ldisc_ops as a parameter instead of ldisc number. This avoids
checking of the ldisc number bounds in tty_unregister_ldisc.

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
 drivers/accessibility/speakup/spk_ttyio.c | 2 +-
 drivers/bluetooth/hci_ldisc.c             | 2 +-
 drivers/input/serio/serport.c             | 2 +-
 drivers/misc/ti-st/st_core.c              | 6 +++---
 drivers/net/caif/caif_serial.c            | 2 +-
 drivers/net/can/slcan.c                   | 2 +-
 drivers/net/hamradio/6pack.c              | 2 +-
 drivers/net/hamradio/mkiss.c              | 2 +-
 drivers/net/ppp/ppp_async.c               | 2 +-
 drivers/net/ppp/ppp_synctty.c             | 2 +-
 drivers/net/slip/slip.c                   | 2 +-
 drivers/pps/clients/pps-ldisc.c           | 2 +-
 drivers/tty/n_gsm.c                       | 4 ++--
 drivers/tty/n_hdlc.c                      | 3 +--
 drivers/tty/n_null.c                      | 2 +-
 drivers/tty/tty_ldisc.c                   | 9 +++------
 include/linux/tty.h                       | 2 +-
 net/nfc/nci/uart.c                        | 2 +-
 sound/soc/ti/ams-delta.c                  | 2 +-
 19 files changed, 24 insertions(+), 28 deletions(-)

diff --git a/drivers/accessibility/speakup/spk_ttyio.c b/drivers/accessibility/speakup/spk_ttyio.c
index 8faa27bae6bf..0b7f1a87eaeb 100644
--- a/drivers/accessibility/speakup/spk_ttyio.c
+++ b/drivers/accessibility/speakup/spk_ttyio.c
@@ -219,7 +219,7 @@ void spk_ttyio_register_ldisc(void)
 
 void spk_ttyio_unregister_ldisc(void)
 {
-	if (tty_unregister_ldisc(N_SPEAKUP))
+	if (tty_unregister_ldisc(&spk_ttyio_ldisc_ops))
 		pr_warn("speakup: Couldn't unregister ldisc\n");
 }
 
diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index ee32006e8fc9..31e0c804363c 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -917,7 +917,7 @@ static void __exit hci_uart_exit(void)
 #endif
 
 	/* Release tty registration of line discipline */
-	err = tty_unregister_ldisc(N_HCI);
+	err = tty_unregister_ldisc(&hci_uart_ldisc);
 	if (err)
 		BT_ERR("Can't unregister HCI line discipline (%d)", err);
 }
diff --git a/drivers/input/serio/serport.c b/drivers/input/serio/serport.c
index 870b1d2606fc..7fbbe00e3553 100644
--- a/drivers/input/serio/serport.c
+++ b/drivers/input/serio/serport.c
@@ -304,7 +304,7 @@ static int __init serport_init(void)
 
 static void __exit serport_exit(void)
 {
-	tty_unregister_ldisc(N_MOUSE);
+	tty_unregister_ldisc(&serport_ldisc);
 }
 
 module_init(serport_init);
diff --git a/drivers/misc/ti-st/st_core.c b/drivers/misc/ti-st/st_core.c
index a4f5d02940c7..174ae8e52805 100644
--- a/drivers/misc/ti-st/st_core.c
+++ b/drivers/misc/ti-st/st_core.c
@@ -872,7 +872,7 @@ int st_core_init(struct st_data_s **core_data)
 	st_gdata = kzalloc(sizeof(struct st_data_s), GFP_KERNEL);
 	if (!st_gdata) {
 		pr_err("memory allocation failed");
-		err = tty_unregister_ldisc(N_TI_WL);
+		err = tty_unregister_ldisc(&st_ldisc_ops);
 		if (err)
 			pr_err("unable to un-register ldisc %ld", err);
 		err = -ENOMEM;
@@ -892,7 +892,7 @@ int st_core_init(struct st_data_s **core_data)
 	if (err) {
 		pr_err("error during st_ll initialization(%ld)", err);
 		kfree(st_gdata);
-		err = tty_unregister_ldisc(N_TI_WL);
+		err = tty_unregister_ldisc(&st_ldisc_ops);
 		if (err)
 			pr_err("unable to un-register ldisc");
 		return err;
@@ -919,7 +919,7 @@ void st_core_exit(struct st_data_s *st_gdata)
 		kfree_skb(st_gdata->rx_skb);
 		kfree_skb(st_gdata->tx_skb);
 		/* TTY ldisc cleanup */
-		err = tty_unregister_ldisc(N_TI_WL);
+		err = tty_unregister_ldisc(&st_ldisc_ops);
 		if (err)
 			pr_err("unable to un-register ldisc %ld", err);
 		/* free the global data pointer */
diff --git a/drivers/net/caif/caif_serial.c b/drivers/net/caif/caif_serial.c
index 2407a0f6656d..d0c24dba4a86 100644
--- a/drivers/net/caif/caif_serial.c
+++ b/drivers/net/caif/caif_serial.c
@@ -447,7 +447,7 @@ static void __exit caif_ser_exit(void)
 	spin_unlock(&ser_lock);
 	ser_release(NULL);
 	cancel_work_sync(&ser_release_work);
-	tty_unregister_ldisc(N_CAIF);
+	tty_unregister_ldisc(&caif_ldisc);
 	debugfs_remove_recursive(debugfsdir);
 }
 
diff --git a/drivers/net/can/slcan.c b/drivers/net/can/slcan.c
index e3f528c82242..03a2dbd3c367 100644
--- a/drivers/net/can/slcan.c
+++ b/drivers/net/can/slcan.c
@@ -784,7 +784,7 @@ static void __exit slcan_exit(void)
 	kfree(slcan_devs);
 	slcan_devs = NULL;
 
-	i = tty_unregister_ldisc(N_SLCAN);
+	i = tty_unregister_ldisc(&slc_ldisc);
 	if (i)
 		printk(KERN_ERR "slcan: can't unregister ldisc (err %d)\n", i);
 }
diff --git a/drivers/net/hamradio/6pack.c b/drivers/net/hamradio/6pack.c
index 4db1d3c4d771..aac24f9caceb 100644
--- a/drivers/net/hamradio/6pack.c
+++ b/drivers/net/hamradio/6pack.c
@@ -781,7 +781,7 @@ static void __exit sixpack_exit_driver(void)
 {
 	int ret;
 
-	if ((ret = tty_unregister_ldisc(N_6PACK)))
+	if ((ret = tty_unregister_ldisc(&sp_ldisc)))
 		printk(msg_unregfail, ret);
 }
 
diff --git a/drivers/net/hamradio/mkiss.c b/drivers/net/hamradio/mkiss.c
index 1eb87a5a9394..750c6afc9302 100644
--- a/drivers/net/hamradio/mkiss.c
+++ b/drivers/net/hamradio/mkiss.c
@@ -967,7 +967,7 @@ static void __exit mkiss_exit_driver(void)
 {
 	int ret;
 
-	if ((ret = tty_unregister_ldisc(N_AX25)))
+	if ((ret = tty_unregister_ldisc(&ax_ldisc)))
 		printk(msg_unregfail, ret);
 }
 
diff --git a/drivers/net/ppp/ppp_async.c b/drivers/net/ppp/ppp_async.c
index 4bfb66c40c86..b2d454d01eba 100644
--- a/drivers/net/ppp/ppp_async.c
+++ b/drivers/net/ppp/ppp_async.c
@@ -1016,7 +1016,7 @@ static void async_lcp_peek(struct asyncppp *ap, unsigned char *data,
 
 static void __exit ppp_async_cleanup(void)
 {
-	if (tty_unregister_ldisc(N_PPP) != 0)
+	if (tty_unregister_ldisc(&ppp_ldisc) != 0)
 		printk(KERN_ERR "failed to unregister PPP line discipline\n");
 }
 
diff --git a/drivers/net/ppp/ppp_synctty.c b/drivers/net/ppp/ppp_synctty.c
index 0942d3ee48e0..ca403bde56fb 100644
--- a/drivers/net/ppp/ppp_synctty.c
+++ b/drivers/net/ppp/ppp_synctty.c
@@ -727,7 +727,7 @@ ppp_sync_input(struct syncppp *ap, const unsigned char *buf,
 static void __exit
 ppp_sync_cleanup(void)
 {
-	if (tty_unregister_ldisc(N_SYNC_PPP) != 0)
+	if (tty_unregister_ldisc(&ppp_sync_ldisc) != 0)
 		printk(KERN_ERR "failed to unregister Sync PPP line discipline\n");
 }
 
diff --git a/drivers/net/slip/slip.c b/drivers/net/slip/slip.c
index 938ac0ec0305..867efff40a0e 100644
--- a/drivers/net/slip/slip.c
+++ b/drivers/net/slip/slip.c
@@ -1360,7 +1360,7 @@ static void __exit slip_exit(void)
 	kfree(slip_devs);
 	slip_devs = NULL;
 
-	i = tty_unregister_ldisc(N_SLIP);
+	i = tty_unregister_ldisc(&sl_ldisc);
 	if (i != 0)
 		printk(KERN_ERR "SLIP: can't unregister line discipline (err = %d)\n", i);
 }
diff --git a/drivers/pps/clients/pps-ldisc.c b/drivers/pps/clients/pps-ldisc.c
index 2a88e678d0b8..91b947f37774 100644
--- a/drivers/pps/clients/pps-ldisc.c
+++ b/drivers/pps/clients/pps-ldisc.c
@@ -131,7 +131,7 @@ static void __exit pps_tty_cleanup(void)
 {
 	int err;
 
-	err = tty_unregister_ldisc(N_PPS);
+	err = tty_unregister_ldisc(&pps_ldisc_ops);
 	if (err)
 		pr_err("can't unregister PPS line discipline\n");
 	else
diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index cce2ef04caeb..db7d4a30af91 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -3280,13 +3280,13 @@ static int __init gsm_init(void)
 err_put_driver:
 	put_tty_driver(gsm_tty_driver);
 err_unreg_ldisc:
-	tty_unregister_ldisc(N_GSM0710);
+	tty_unregister_ldisc(&tty_ldisc_packet);
 	return status;
 }
 
 static void __exit gsm_exit(void)
 {
-	int status = tty_unregister_ldisc(N_GSM0710);
+	int status = tty_unregister_ldisc(&tty_ldisc_packet);
 	if (status != 0)
 		pr_err("n_gsm: can't unregister line discipline (err = %d)\n",
 								status);
diff --git a/drivers/tty/n_hdlc.c b/drivers/tty/n_hdlc.c
index 2256039911f5..c2afbfe0a1d5 100644
--- a/drivers/tty/n_hdlc.c
+++ b/drivers/tty/n_hdlc.c
@@ -822,8 +822,7 @@ static int __init n_hdlc_init(void)
 
 static void __exit n_hdlc_exit(void)
 {
-	/* Release tty registration of line discipline */
-	int status = tty_unregister_ldisc(N_HDLC);
+	int status = tty_unregister_ldisc(&n_hdlc_ldisc);
 
 	if (status)
 		pr_err("N_HDLC: can't unregister line discipline (err = %d)\n",
diff --git a/drivers/tty/n_null.c b/drivers/tty/n_null.c
index ee229c812dce..f913b665af72 100644
--- a/drivers/tty/n_null.c
+++ b/drivers/tty/n_null.c
@@ -57,7 +57,7 @@ static int __init n_null_init(void)
 
 static void __exit n_null_exit(void)
 {
-	tty_unregister_ldisc(N_NULL);
+	tty_unregister_ldisc(&null_ldisc);
 }
 
 module_init(n_null_init);
diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
index 9aff04bee4cd..d02deeb5e584 100644
--- a/drivers/tty/tty_ldisc.c
+++ b/drivers/tty/tty_ldisc.c
@@ -87,19 +87,16 @@ EXPORT_SYMBOL(tty_register_ldisc);
  *		takes tty_ldiscs_lock to guard against ldisc races
  */
 
-int tty_unregister_ldisc(int disc)
+int tty_unregister_ldisc(struct tty_ldisc_ops *ldisc)
 {
 	unsigned long flags;
 	int ret = 0;
 
-	if (disc < N_TTY || disc >= NR_LDISCS)
-		return -EINVAL;
-
 	raw_spin_lock_irqsave(&tty_ldiscs_lock, flags);
-	if (tty_ldiscs[disc]->refcount)
+	if (tty_ldiscs[ldisc->num]->refcount)
 		ret = -EBUSY;
 	else
-		tty_ldiscs[disc] = NULL;
+		tty_ldiscs[ldisc->num] = NULL;
 	raw_spin_unlock_irqrestore(&tty_ldiscs_lock, flags);
 
 	return ret;
diff --git a/include/linux/tty.h b/include/linux/tty.h
index 95c632299fb4..6a72d0ff6391 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -637,7 +637,7 @@ static inline int tty_port_users(struct tty_port *port)
 }
 
 extern int tty_register_ldisc(struct tty_ldisc_ops *new_ldisc);
-extern int tty_unregister_ldisc(int disc);
+extern int tty_unregister_ldisc(struct tty_ldisc_ops *ldisc);
 extern int tty_set_ldisc(struct tty_struct *tty, int disc);
 extern int tty_ldisc_receive_buf(struct tty_ldisc *ld, const unsigned char *p,
 				 const char *f, int count);
diff --git a/net/nfc/nci/uart.c b/net/nfc/nci/uart.c
index 648c26b4bad8..502e7a3f8948 100644
--- a/net/nfc/nci/uart.c
+++ b/net/nfc/nci/uart.c
@@ -462,7 +462,7 @@ static int __init nci_uart_init(void)
 
 static void __exit nci_uart_exit(void)
 {
-	tty_unregister_ldisc(N_NCI);
+	tty_unregister_ldisc(&nci_uart_ldisc);
 }
 
 module_init(nci_uart_init);
diff --git a/sound/soc/ti/ams-delta.c b/sound/soc/ti/ams-delta.c
index fcbb791bf27a..e89548e48364 100644
--- a/sound/soc/ti/ams-delta.c
+++ b/sound/soc/ti/ams-delta.c
@@ -583,7 +583,7 @@ static int ams_delta_remove(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = platform_get_drvdata(pdev);
 
-	if (tty_unregister_ldisc(N_V253) != 0)
+	if (tty_unregister_ldisc(&cx81801_ops) != 0)
 		dev_warn(&pdev->dev,
 			"failed to unregister V253 line discipline\n");
 
-- 
2.31.1

