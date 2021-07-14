Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A2ABC11F68
	for <linux-serial@archiver.kernel.org>; Wed, 14 Jul 2021 09:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09E19613B2
	for <linux-serial@archiver.kernel.org>; Wed, 14 Jul 2021 09:13:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238725AbhGNJQR (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 14 Jul 2021 05:16:17 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:57936 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238721AbhGNJQM (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 14 Jul 2021 05:16:12 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 4A0FA205A0;
        Wed, 14 Jul 2021 09:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1626253997; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bHGfMeUXs8p1cLbGby6jhmJq6dYDqeI/JYGDlozOImk=;
        b=PPKn46yiUCOSH1Dm73Wc40ccUh6BbDbnvm83G5XK3PiK7fTUKmd5TbGTT22BXcOqY9k/m5
        4Izeyn/V2+K0xdVSe2gPWn8/Vv8O3+vHSH92LB26QlPwn7voVoCdVC9rTqKjO3edn0oiUh
        bKhBkih1ZWq35dgvlplUoFTqYfLPebk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1626253997;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bHGfMeUXs8p1cLbGby6jhmJq6dYDqeI/JYGDlozOImk=;
        b=2aT2X6NqcMBcyCkeyzcpZeusKOd7yepKHChBQo41co9OGY2eFoVeOYPbVrXsiORMQZocL3
        g6Gykl7Pj8G/deAw==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 23676A3B8A;
        Wed, 14 Jul 2021 09:13:17 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 09/11] amiserial: pack and sort includes
Date:   Wed, 14 Jul 2021 11:13:12 +0200
Message-Id: <20210714091314.8292-9-jslaby@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210714091314.8292-1-jslaby@suse.cz>
References: <20210714091314.8292-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The #include directives are in different places in amiserial:
1) there is no reason for that, and
2) it makes hard to judge what is included and what is not.

Therefore, move all the includes to a single place and sort them.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/amiserial.c | 50 ++++++++++++++++++-----------------------
 1 file changed, 22 insertions(+), 28 deletions(-)

diff --git a/drivers/tty/amiserial.c b/drivers/tty/amiserial.c
index 4658df1b5623..0a76e70a0b96 100644
--- a/drivers/tty/amiserial.c
+++ b/drivers/tty/amiserial.c
@@ -22,8 +22,6 @@
  *
  */
 
-#include <linux/delay.h>
-
 /* Set of debugging defines */
 
 #undef SERIAL_DEBUG_INTR
@@ -35,40 +33,38 @@
  * End of serial driver configuration section.
  */
 
-#include <linux/module.h>
-
-#include <linux/types.h>
-#include <linux/serial.h>
-#include <linux/serial_reg.h>
-#include <linux/errno.h>
-#include <linux/signal.h>
-#include <linux/sched.h>
-#include <linux/kernel.h>
-#include <linux/timer.h>
-#include <linux/interrupt.h>
-#include <linux/tty.h>
-#include <linux/tty_flip.h>
+#include <linux/bitops.h>
 #include <linux/circ_buf.h>
 #include <linux/console.h>
-#include <linux/major.h>
-#include <linux/string.h>
+#include <linux/delay.h>
+#include <linux/errno.h>
 #include <linux/fcntl.h>
-#include <linux/ptrace.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
 #include <linux/ioport.h>
+#include <linux/kernel.h>
+#include <linux/major.h>
 #include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/ptrace.h>
 #include <linux/seq_file.h>
+#include <linux/serial.h>
+#include <linux/serial_reg.h>
+#include <linux/sched.h>
+#include <linux/signal.h>
 #include <linux/slab.h>
-#include <linux/init.h>
-#include <linux/bitops.h>
-#include <linux/platform_device.h>
-
-#include <asm/setup.h>
-
-
-#include <asm/irq.h>
+#include <linux/string.h>
+#include <linux/timer.h>
+#include <linux/tty_flip.h>
+#include <linux/tty.h>
+#include <linux/types.h>
+#include <linux/uaccess.h>
 
 #include <asm/amigahw.h>
 #include <asm/amigaints.h>
+#include <asm/irq.h>
+#include <asm/setup.h>
 
 struct serial_state {
 	struct tty_port		tport;
@@ -105,8 +101,6 @@ static struct serial_state rs_table[1];
 
 #define NR_PORTS ARRAY_SIZE(rs_table)
 
-#include <linux/uaccess.h>
-
 /* some serial hardware definitions */
 #define SDR_OVRUN   (1<<15)
 #define SDR_RBF     (1<<14)
-- 
2.32.0

