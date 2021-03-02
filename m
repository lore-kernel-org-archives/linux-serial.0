Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E1ECC4360C
	for <linux-serial@archiver.kernel.org>; Wed,  3 Mar 2021 02:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D72A764E75
	for <linux-serial@archiver.kernel.org>; Wed,  3 Mar 2021 02:20:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235977AbhCCCOA (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 2 Mar 2021 21:14:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:39620 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1835874AbhCBGYS (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 2 Mar 2021 01:24:18 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 75971B029;
        Tue,  2 Mar 2021 06:22:19 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 23/44] tty: nozomi, remove init/exit messages
Date:   Tue,  2 Mar 2021 07:21:53 +0100
Message-Id: <20210302062214.29627-23-jslaby@suse.cz>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210302062214.29627-1-jslaby@suse.cz>
References: <20210302062214.29627-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Remove useless prints from init and exit functions. The version is
artificial anyway.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/nozomi.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/tty/nozomi.c b/drivers/tty/nozomi.c
index 83490925a3e2..1ec975d66528 100644
--- a/drivers/tty/nozomi.c
+++ b/drivers/tty/nozomi.c
@@ -47,9 +47,6 @@
 
 #include <linux/delay.h>
 
-
-#define VERSION_STRING DRIVER_DESC " 2.1d"
-
 /* Default debug printout level */
 #define NOZOMI_DEBUG_LEVEL 0x00
 static int debug = NOZOMI_DEBUG_LEVEL;
@@ -89,7 +86,6 @@ do {							\
 /*    Defines */
 #define NOZOMI_NAME		"nozomi"
 #define NOZOMI_NAME_TTY		"nozomi_tty"
-#define DRIVER_DESC		"Nozomi driver"
 
 #define NTTY_TTY_MAXMINORS	256
 #define NTTY_FIFO_BUFFER_SIZE	8192
@@ -1841,8 +1837,6 @@ static __init int nozomi_init(void)
 {
 	int ret;
 
-	printk(KERN_INFO "Initializing %s\n", VERSION_STRING);
-
 	ntty_driver = alloc_tty_driver(NTTY_TTY_MAXMINORS);
 	if (!ntty_driver)
 		return -ENOMEM;
@@ -1882,7 +1876,6 @@ static __init int nozomi_init(void)
 
 static __exit void nozomi_exit(void)
 {
-	printk(KERN_INFO "Unloading %s\n", DRIVER_DESC);
 	pci_unregister_driver(&nozomi_driver);
 	tty_unregister_driver(ntty_driver);
 	put_tty_driver(ntty_driver);
@@ -1892,4 +1885,4 @@ module_init(nozomi_init);
 module_exit(nozomi_exit);
 
 MODULE_LICENSE("Dual BSD/GPL");
-MODULE_DESCRIPTION(DRIVER_DESC);
+MODULE_DESCRIPTION("Nozomi driver");
-- 
2.30.1

