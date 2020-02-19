Return-Path: <SRS0=V5ud=4H=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A51C34050
	for <linux-serial@archiver.kernel.org>; Wed, 19 Feb 2020 08:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2029208E4
	for <linux-serial@archiver.kernel.org>; Wed, 19 Feb 2020 08:41:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbgBSIlW (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 19 Feb 2020 03:41:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:44244 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726497AbgBSIlW (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 19 Feb 2020 03:41:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 543E5AEAC;
        Wed, 19 Feb 2020 08:41:20 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 04/24] n_hdlc: put init/exit strings directly to prints
Date:   Wed, 19 Feb 2020 09:40:58 +0100
Message-Id: <20200219084118.26491-4-jslaby@suse.cz>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200219084118.26491-1-jslaby@suse.cz>
References: <20200219084118.26491-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

These strings were put aside from prints to save some bytes after module
load or when built-in -- they were freed after module load (__init ones) or
when the driver is selected as built-in (__exit ones).

The savings are negligible, but the code readability is worse by the
order of magnitude. So put the strings where they belong. Note that it
also used to make little sense putting const data in .data (the __exit
case).

While at it, switch to pr_info, pr_err, not using the KERN_INFO and _ERR
directly.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/n_hdlc.c | 28 ++++++----------------------
 1 file changed, 6 insertions(+), 22 deletions(-)

diff --git a/drivers/tty/n_hdlc.c b/drivers/tty/n_hdlc.c
index e37dab2528a1..b651b5ba64ee 100644
--- a/drivers/tty/n_hdlc.c
+++ b/drivers/tty/n_hdlc.c
@@ -889,13 +889,6 @@ static struct n_hdlc_buf *n_hdlc_buf_get(struct n_hdlc_buf_list *buf_list)
 	return buf;
 }	/* end of n_hdlc_buf_get() */
 
-static const char hdlc_banner[] __initconst =
-	KERN_INFO "HDLC line discipline maxframe=%u\n";
-static const char hdlc_register_ok[] __initconst =
-	KERN_INFO "N_HDLC line discipline registered.\n";
-static const char hdlc_register_fail[] __initconst =
-	KERN_ERR "error registering line discipline: %d\n";
-
 static int __init n_hdlc_init(void)
 {
 	int status;
@@ -906,37 +899,28 @@ static int __init n_hdlc_init(void)
 	else if (maxframe > 65535)
 		maxframe = 65535;
 
-	printk(hdlc_banner, maxframe);
+	pr_info("HDLC line discipline maxframe=%d\n", maxframe);
 
 	status = tty_register_ldisc(N_HDLC, &n_hdlc_ldisc);
 	if (!status)
-		printk(hdlc_register_ok);
+		pr_info("N_HDLC line discipline registered.\n");
 	else
-		printk(hdlc_register_fail, status);
+		pr_err("error registering line discipline: %d\n", status);
 
 	return status;
 	
 }	/* end of init_module() */
 
-#ifdef CONFIG_SPARC
-#undef __exitdata
-#define __exitdata
-#endif
-
-static const char hdlc_unregister_ok[] __exitdata =
-	KERN_INFO "N_HDLC: line discipline unregistered\n";
-static const char hdlc_unregister_fail[] __exitdata =
-	KERN_ERR "N_HDLC: can't unregister line discipline (err = %d)\n";
-
 static void __exit n_hdlc_exit(void)
 {
 	/* Release tty registration of line discipline */
 	int status = tty_unregister_ldisc(N_HDLC);
 
 	if (status)
-		printk(hdlc_unregister_fail, status);
+		pr_err("N_HDLC: can't unregister line discipline (err = %d)\n",
+				status);
 	else
-		printk(hdlc_unregister_ok);
+		pr_info("N_HDLC: line discipline unregistered\n");
 }
 
 module_init(n_hdlc_init);
-- 
2.25.0

