Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E8FEC433DB
	for <linux-serial@archiver.kernel.org>; Wed,  3 Mar 2021 02:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D48286023B
	for <linux-serial@archiver.kernel.org>; Wed,  3 Mar 2021 02:20:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240220AbhCCCQT (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 2 Mar 2021 21:16:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:39614 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1835883AbhCBGYe (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 2 Mar 2021 01:24:34 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 81407B039;
        Tue,  2 Mar 2021 06:22:21 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org, Jiri Kosina <jikos@kernel.org>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 34/44] tty: do not check tty_unregister_driver's return value
Date:   Tue,  2 Mar 2021 07:22:04 +0100
Message-Id: <20210302062214.29627-34-jslaby@suse.cz>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210302062214.29627-1-jslaby@suse.cz>
References: <20210302062214.29627-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

These drivers check tty_unregister_driver return value. But they don't
handle a failure correctly (they free the driver in any case). So stop
checking tty_unregister_driver return value and remove also the prints.

In the next patch, tty_unregister_driver's return type will be switched
to void.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Chris Zankel <chris@zankel.net>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: linux-xtensa@linux-xtensa.org
Cc: Jiri Kosina <jikos@kernel.org>
Cc: David Sterba <dsterba@suse.com>
---
 arch/xtensa/platforms/iss/console.c | 6 +-----
 drivers/tty/amiserial.c             | 8 ++------
 drivers/tty/ipwireless/tty.c        | 7 +------
 drivers/tty/moxa.c                  | 4 +---
 drivers/tty/serial/kgdb_nmi.c       | 4 +---
 drivers/tty/synclink_gt.c           | 5 +----
 6 files changed, 7 insertions(+), 27 deletions(-)

diff --git a/arch/xtensa/platforms/iss/console.c b/arch/xtensa/platforms/iss/console.c
index 1e215cf5ad03..a3dda25a4e45 100644
--- a/arch/xtensa/platforms/iss/console.c
+++ b/arch/xtensa/platforms/iss/console.c
@@ -171,11 +171,7 @@ static int __init rs_init(void)
 
 static __exit void rs_exit(void)
 {
-	int error;
-
-	if ((error = tty_unregister_driver(serial_driver)))
-		pr_err("ISS_SERIAL: failed to unregister serial driver (%d)\n",
-		       error);
+	tty_unregister_driver(serial_driver);
 	put_tty_driver(serial_driver);
 	tty_port_destroy(&serial_port);
 }
diff --git a/drivers/tty/amiserial.c b/drivers/tty/amiserial.c
index 18b78ea110ef..0c8157fab17f 100644
--- a/drivers/tty/amiserial.c
+++ b/drivers/tty/amiserial.c
@@ -1622,21 +1622,17 @@ static int __init amiga_serial_probe(struct platform_device *pdev)
 
 static int __exit amiga_serial_remove(struct platform_device *pdev)
 {
-	int error;
 	struct serial_state *state = platform_get_drvdata(pdev);
 
 	/* printk("Unloading %s: version %s\n", serial_name, serial_version); */
-	error = tty_unregister_driver(serial_driver);
-	if (error)
-		printk("SERIAL: failed to unregister serial driver (%d)\n",
-		       error);
+	tty_unregister_driver(serial_driver);
 	put_tty_driver(serial_driver);
 	tty_port_destroy(&state->tport);
 
 	free_irq(IRQ_AMIGA_TBE, state);
 	free_irq(IRQ_AMIGA_RBF, state);
 
-	return error;
+	return 0;
 }
 
 static struct platform_driver amiga_serial_driver = {
diff --git a/drivers/tty/ipwireless/tty.c b/drivers/tty/ipwireless/tty.c
index 6dacbc5e286c..1836746991b5 100644
--- a/drivers/tty/ipwireless/tty.c
+++ b/drivers/tty/ipwireless/tty.c
@@ -596,13 +596,8 @@ int ipwireless_tty_init(void)
 
 void ipwireless_tty_release(void)
 {
-	int ret;
-
-	ret = tty_unregister_driver(ipw_tty_driver);
+	tty_unregister_driver(ipw_tty_driver);
 	put_tty_driver(ipw_tty_driver);
-	if (ret != 0)
-		printk(KERN_ERR IPWIRELESS_PCCARD_NAME
-			": tty_unregister_driver failed with code %d\n", ret);
 }
 
 int ipwireless_tty_is_modem(struct ipw_tty *tty)
diff --git a/drivers/tty/moxa.c b/drivers/tty/moxa.c
index 9f13f7d49dd7..32eb6b5e510f 100644
--- a/drivers/tty/moxa.c
+++ b/drivers/tty/moxa.c
@@ -1118,9 +1118,7 @@ static void __exit moxa_exit(void)
 
 	del_timer_sync(&moxaTimer);
 
-	if (tty_unregister_driver(moxaDriver))
-		printk(KERN_ERR "Couldn't unregister MOXA Intellio family "
-				"serial driver\n");
+	tty_unregister_driver(moxaDriver);
 	put_tty_driver(moxaDriver);
 }
 
diff --git a/drivers/tty/serial/kgdb_nmi.c b/drivers/tty/serial/kgdb_nmi.c
index 6004c0c1d173..db059b66438e 100644
--- a/drivers/tty/serial/kgdb_nmi.c
+++ b/drivers/tty/serial/kgdb_nmi.c
@@ -373,9 +373,7 @@ int kgdb_unregister_nmi_console(void)
 	if (ret)
 		return ret;
 
-	ret = tty_unregister_driver(kgdb_nmi_tty_driver);
-	if (ret)
-		return ret;
+	tty_unregister_driver(kgdb_nmi_tty_driver);
 	put_tty_driver(kgdb_nmi_tty_driver);
 
 	return 0;
diff --git a/drivers/tty/synclink_gt.c b/drivers/tty/synclink_gt.c
index 644173786bf0..4727a41158b0 100644
--- a/drivers/tty/synclink_gt.c
+++ b/drivers/tty/synclink_gt.c
@@ -3705,7 +3705,6 @@ static const struct tty_operations ops = {
 
 static void slgt_cleanup(void)
 {
-	int rc;
 	struct slgt_info *info;
 	struct slgt_info *tmp;
 
@@ -3714,9 +3713,7 @@ static void slgt_cleanup(void)
 	if (serial_driver) {
 		for (info=slgt_device_list ; info != NULL ; info=info->next_device)
 			tty_unregister_device(serial_driver, info->line);
-		rc = tty_unregister_driver(serial_driver);
-		if (rc)
-			DBGERR(("tty_unregister_driver error=%d\n", rc));
+		tty_unregister_driver(serial_driver);
 		put_tty_driver(serial_driver);
 	}
 
-- 
2.30.1

