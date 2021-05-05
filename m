Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CFB4C43462
	for <linux-serial@archiver.kernel.org>; Wed,  5 May 2021 09:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF8C1613C7
	for <linux-serial@archiver.kernel.org>; Wed,  5 May 2021 09:19:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbhEEJUo (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 5 May 2021 05:20:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:41380 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232406AbhEEJUd (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 5 May 2021 05:20:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E95F0B260;
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
        Arnd Bergmann <arnd@arndb.de>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Andreas Koensgen <ajk@comnets.uni-bremen.de>,
        Paul Mackerras <paulus@samba.org>,
        Rodolfo Giometti <giometti@enneenne.com>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH 18/35] tty: no checking of tty_unregister_ldisc
Date:   Wed,  5 May 2021 11:19:11 +0200
Message-Id: <20210505091928.22010-19-jslaby@suse.cz>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210505091928.22010-1-jslaby@suse.cz>
References: <20210505091928.22010-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tty_unregister_ldisc now returns 0 = success. No need to check the
return value. In fact, the users only warned if an error occured and
didn't do anything useful anyway -- the ldisc module was unloaded in any
case.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: William Hubbs <w.d.hubbs@gmail.com>
Cc: Chris Brannon <chris@the-brannons.com>
Cc: Kirk Reiser <kirk@reisers.ca>
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: Marcel Holtmann <marcel@holtmann.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Wolfgang Grandegger <wg@grandegger.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Andreas Koensgen <ajk@comnets.uni-bremen.de>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Rodolfo Giometti <giometti@enneenne.com>
Cc: Peter Ujfalusi <peter.ujfalusi@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
---
 drivers/accessibility/speakup/spk_ttyio.c |  3 +--
 drivers/bluetooth/hci_ldisc.c             |  7 +------
 drivers/misc/ti-st/st_core.c              | 12 +++---------
 drivers/net/can/slcan.c                   |  4 +---
 drivers/net/hamradio/6pack.c              |  8 +-------
 drivers/net/hamradio/mkiss.c              |  8 +-------
 drivers/net/ppp/ppp_async.c               |  3 +--
 drivers/net/ppp/ppp_synctty.c             |  3 +--
 drivers/net/slip/slip.c                   |  4 +---
 drivers/pps/clients/pps-ldisc.c           |  8 +-------
 drivers/tty/n_gsm.c                       |  5 +----
 drivers/tty/n_hdlc.c                      |  8 +-------
 sound/soc/ti/ams-delta.c                  |  4 +---
 13 files changed, 15 insertions(+), 62 deletions(-)

diff --git a/drivers/accessibility/speakup/spk_ttyio.c b/drivers/accessibility/speakup/spk_ttyio.c
index 0b7f1a87eaeb..0d1f397cd896 100644
--- a/drivers/accessibility/speakup/spk_ttyio.c
+++ b/drivers/accessibility/speakup/spk_ttyio.c
@@ -219,8 +219,7 @@ void spk_ttyio_register_ldisc(void)
 
 void spk_ttyio_unregister_ldisc(void)
 {
-	if (tty_unregister_ldisc(&spk_ttyio_ldisc_ops))
-		pr_warn("speakup: Couldn't unregister ldisc\n");
+	tty_unregister_ldisc(&spk_ttyio_ldisc_ops);
 }
 
 static int spk_ttyio_out(struct spk_synth *in_synth, const char ch)
diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 31e0c804363c..5ed2cfa7da1d 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -883,8 +883,6 @@ static int __init hci_uart_init(void)
 
 static void __exit hci_uart_exit(void)
 {
-	int err;
-
 #ifdef CONFIG_BT_HCIUART_H4
 	h4_deinit();
 #endif
@@ -916,10 +914,7 @@ static void __exit hci_uart_exit(void)
 	mrvl_deinit();
 #endif
 
-	/* Release tty registration of line discipline */
-	err = tty_unregister_ldisc(&hci_uart_ldisc);
-	if (err)
-		BT_ERR("Can't unregister HCI line discipline (%d)", err);
+	tty_unregister_ldisc(&hci_uart_ldisc);
 }
 
 module_init(hci_uart_init);
diff --git a/drivers/misc/ti-st/st_core.c b/drivers/misc/ti-st/st_core.c
index 174ae8e52805..85315e726644 100644
--- a/drivers/misc/ti-st/st_core.c
+++ b/drivers/misc/ti-st/st_core.c
@@ -872,9 +872,7 @@ int st_core_init(struct st_data_s **core_data)
 	st_gdata = kzalloc(sizeof(struct st_data_s), GFP_KERNEL);
 	if (!st_gdata) {
 		pr_err("memory allocation failed");
-		err = tty_unregister_ldisc(&st_ldisc_ops);
-		if (err)
-			pr_err("unable to un-register ldisc %ld", err);
+		tty_unregister_ldisc(&st_ldisc_ops);
 		err = -ENOMEM;
 		return err;
 	}
@@ -892,9 +890,7 @@ int st_core_init(struct st_data_s **core_data)
 	if (err) {
 		pr_err("error during st_ll initialization(%ld)", err);
 		kfree(st_gdata);
-		err = tty_unregister_ldisc(&st_ldisc_ops);
-		if (err)
-			pr_err("unable to un-register ldisc");
+		tty_unregister_ldisc(&st_ldisc_ops);
 		return err;
 	}
 
@@ -919,9 +915,7 @@ void st_core_exit(struct st_data_s *st_gdata)
 		kfree_skb(st_gdata->rx_skb);
 		kfree_skb(st_gdata->tx_skb);
 		/* TTY ldisc cleanup */
-		err = tty_unregister_ldisc(&st_ldisc_ops);
-		if (err)
-			pr_err("unable to un-register ldisc %ld", err);
+		tty_unregister_ldisc(&st_ldisc_ops);
 		/* free the global data pointer */
 		kfree(st_gdata);
 	}
diff --git a/drivers/net/can/slcan.c b/drivers/net/can/slcan.c
index 03a2dbd3c367..d42ec7d1bc14 100644
--- a/drivers/net/can/slcan.c
+++ b/drivers/net/can/slcan.c
@@ -784,9 +784,7 @@ static void __exit slcan_exit(void)
 	kfree(slcan_devs);
 	slcan_devs = NULL;
 
-	i = tty_unregister_ldisc(&slc_ldisc);
-	if (i)
-		printk(KERN_ERR "slcan: can't unregister ldisc (err %d)\n", i);
+	tty_unregister_ldisc(&slc_ldisc);
 }
 
 module_init(slcan_init);
diff --git a/drivers/net/hamradio/6pack.c b/drivers/net/hamradio/6pack.c
index aac24f9caceb..686c38c46113 100644
--- a/drivers/net/hamradio/6pack.c
+++ b/drivers/net/hamradio/6pack.c
@@ -774,15 +774,9 @@ static int __init sixpack_init_driver(void)
 	return status;
 }
 
-static const char msg_unregfail[] = KERN_ERR \
-	"6pack: can't unregister line discipline (err = %d)\n";
-
 static void __exit sixpack_exit_driver(void)
 {
-	int ret;
-
-	if ((ret = tty_unregister_ldisc(&sp_ldisc)))
-		printk(msg_unregfail, ret);
+	tty_unregister_ldisc(&sp_ldisc);
 }
 
 /* encode an AX.25 packet into 6pack */
diff --git a/drivers/net/hamradio/mkiss.c b/drivers/net/hamradio/mkiss.c
index 750c6afc9302..e3294a0a9800 100644
--- a/drivers/net/hamradio/mkiss.c
+++ b/drivers/net/hamradio/mkiss.c
@@ -960,15 +960,9 @@ static int __init mkiss_init_driver(void)
 	return status;
 }
 
-static const char msg_unregfail[] = KERN_ERR \
-	"mkiss: can't unregister line discipline (err = %d)\n";
-
 static void __exit mkiss_exit_driver(void)
 {
-	int ret;
-
-	if ((ret = tty_unregister_ldisc(&ax_ldisc)))
-		printk(msg_unregfail, ret);
+	tty_unregister_ldisc(&ax_ldisc);
 }
 
 MODULE_AUTHOR("Ralf Baechle DL5RB <ralf@linux-mips.org>");
diff --git a/drivers/net/ppp/ppp_async.c b/drivers/net/ppp/ppp_async.c
index b2d454d01eba..29a93d6bfe37 100644
--- a/drivers/net/ppp/ppp_async.c
+++ b/drivers/net/ppp/ppp_async.c
@@ -1016,8 +1016,7 @@ static void async_lcp_peek(struct asyncppp *ap, unsigned char *data,
 
 static void __exit ppp_async_cleanup(void)
 {
-	if (tty_unregister_ldisc(&ppp_ldisc) != 0)
-		printk(KERN_ERR "failed to unregister PPP line discipline\n");
+	tty_unregister_ldisc(&ppp_ldisc);
 }
 
 module_init(ppp_async_init);
diff --git a/drivers/net/ppp/ppp_synctty.c b/drivers/net/ppp/ppp_synctty.c
index ca403bde56fb..af3e048695b6 100644
--- a/drivers/net/ppp/ppp_synctty.c
+++ b/drivers/net/ppp/ppp_synctty.c
@@ -727,8 +727,7 @@ ppp_sync_input(struct syncppp *ap, const unsigned char *buf,
 static void __exit
 ppp_sync_cleanup(void)
 {
-	if (tty_unregister_ldisc(&ppp_sync_ldisc) != 0)
-		printk(KERN_ERR "failed to unregister Sync PPP line discipline\n");
+	tty_unregister_ldisc(&ppp_sync_ldisc);
 }
 
 module_init(ppp_sync_init);
diff --git a/drivers/net/slip/slip.c b/drivers/net/slip/slip.c
index 867efff40a0e..dc84cb844319 100644
--- a/drivers/net/slip/slip.c
+++ b/drivers/net/slip/slip.c
@@ -1360,9 +1360,7 @@ static void __exit slip_exit(void)
 	kfree(slip_devs);
 	slip_devs = NULL;
 
-	i = tty_unregister_ldisc(&sl_ldisc);
-	if (i != 0)
-		printk(KERN_ERR "SLIP: can't unregister line discipline (err = %d)\n", i);
+	tty_unregister_ldisc(&sl_ldisc);
 }
 
 module_init(slip_init);
diff --git a/drivers/pps/clients/pps-ldisc.c b/drivers/pps/clients/pps-ldisc.c
index 91b947f37774..d73c4c2ed4e1 100644
--- a/drivers/pps/clients/pps-ldisc.c
+++ b/drivers/pps/clients/pps-ldisc.c
@@ -129,13 +129,7 @@ static int __init pps_tty_init(void)
 
 static void __exit pps_tty_cleanup(void)
 {
-	int err;
-
-	err = tty_unregister_ldisc(&pps_ldisc_ops);
-	if (err)
-		pr_err("can't unregister PPS line discipline\n");
-	else
-		pr_info("PPS line discipline removed\n");
+	tty_unregister_ldisc(&pps_ldisc_ops);
 }
 
 module_init(pps_tty_init);
diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index db7d4a30af91..157b26ef6259 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -3286,10 +3286,7 @@ static int __init gsm_init(void)
 
 static void __exit gsm_exit(void)
 {
-	int status = tty_unregister_ldisc(&tty_ldisc_packet);
-	if (status != 0)
-		pr_err("n_gsm: can't unregister line discipline (err = %d)\n",
-								status);
+	tty_unregister_ldisc(&tty_ldisc_packet);
 	tty_unregister_driver(gsm_tty_driver);
 	put_tty_driver(gsm_tty_driver);
 }
diff --git a/drivers/tty/n_hdlc.c b/drivers/tty/n_hdlc.c
index c2afbfe0a1d5..d899ee4e0116 100644
--- a/drivers/tty/n_hdlc.c
+++ b/drivers/tty/n_hdlc.c
@@ -822,13 +822,7 @@ static int __init n_hdlc_init(void)
 
 static void __exit n_hdlc_exit(void)
 {
-	int status = tty_unregister_ldisc(&n_hdlc_ldisc);
-
-	if (status)
-		pr_err("N_HDLC: can't unregister line discipline (err = %d)\n",
-				status);
-	else
-		pr_info("N_HDLC: line discipline unregistered\n");
+	tty_unregister_ldisc(&n_hdlc_ldisc);
 }
 
 module_init(n_hdlc_init);
diff --git a/sound/soc/ti/ams-delta.c b/sound/soc/ti/ams-delta.c
index e89548e48364..ecd24d412a9b 100644
--- a/sound/soc/ti/ams-delta.c
+++ b/sound/soc/ti/ams-delta.c
@@ -583,9 +583,7 @@ static int ams_delta_remove(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = platform_get_drvdata(pdev);
 
-	if (tty_unregister_ldisc(&cx81801_ops) != 0)
-		dev_warn(&pdev->dev,
-			"failed to unregister V253 line discipline\n");
+	tty_unregister_ldisc(&cx81801_ops);
 
 	snd_soc_unregister_card(card);
 	card->dev = NULL;
-- 
2.31.1

