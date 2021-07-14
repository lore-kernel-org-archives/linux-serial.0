Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE06C11F69
	for <linux-serial@archiver.kernel.org>; Wed, 14 Jul 2021 09:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99977613B2
	for <linux-serial@archiver.kernel.org>; Wed, 14 Jul 2021 09:13:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238767AbhGNJQQ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 14 Jul 2021 05:16:16 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:57934 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238719AbhGNJQL (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 14 Jul 2021 05:16:11 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id E45FD2059D;
        Wed, 14 Jul 2021 09:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1626253996; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+VAp2Qvui8StGqN8YCrXcKbeX5kZIKKFJLqxT+6QyAw=;
        b=b6YH3fsDMVzGpAS0POWhSrrMGMqRrdVXV4xRuePf3O4Wbb4JypVwZ0VkfhKa4MNdac3WP0
        M6WBLNpLreTjCVzNg2yl+Pp7JG961hIlVNIQgH8m09CsxAie9tXa/YjqfRCOeNV7B5cVjp
        v2YRYmgg3biJIPuZb+M+3SHkmiPPx2s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1626253996;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+VAp2Qvui8StGqN8YCrXcKbeX5kZIKKFJLqxT+6QyAw=;
        b=QST6Iw6VwVcaCYLjeSpNUKpOdxd3k4Hvz/+Wqjum7ZVhWtb1kDD+FOoBrgrh9/O4dEoB/K
        ZdqVRRGDZrdrx+Dg==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id BD093A3B8A;
        Wed, 14 Jul 2021 09:13:16 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 07/11] amiserial: expand serial_isroot
Date:   Wed, 14 Jul 2021 11:13:10 +0200
Message-Id: <20210714091314.8292-7-jslaby@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210714091314.8292-1-jslaby@suse.cz>
References: <20210714091314.8292-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Having a macro (serial_isroot) for capable(CAP_SYS_ADMIN) does not save
us from anything. It rather obfuscates the code. Hence expand
serial_isroot to be explicit like every other driver is.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/amiserial.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/amiserial.c b/drivers/tty/amiserial.c
index 558c77653e21..51b51c5acf96 100644
--- a/drivers/tty/amiserial.c
+++ b/drivers/tty/amiserial.c
@@ -109,8 +109,6 @@ static struct serial_state rs_table[1];
 
 #include <linux/uaccess.h>
 
-#define serial_isroot()	(capable(CAP_SYS_ADMIN))
-
 /* some serial hardware definitions */
 #define SDR_OVRUN   (1<<15)
 #define SDR_RBF     (1<<14)
@@ -485,11 +483,11 @@ static int startup(struct tty_struct *tty, struct serial_state *info)
 
 	retval = request_irq(IRQ_AMIGA_VERTB, ser_vbl_int, 0, "serial status", info);
 	if (retval) {
-	  if (serial_isroot()) {
-	      set_bit(TTY_IO_ERROR, &tty->flags);
-	    retval = 0;
-	  }
-	  goto errout;
+		if (capable(CAP_SYS_ADMIN)) {
+			set_bit(TTY_IO_ERROR, &tty->flags);
+			retval = 0;
+		}
+		goto errout;
 	}
 
 	/* enable both Rx and Tx interrupts */
@@ -955,7 +953,7 @@ static int set_serial_info(struct tty_struct *tty, struct serial_struct *ss)
 	if (closing_wait != ASYNC_CLOSING_WAIT_NONE)
 		closing_wait = msecs_to_jiffies(closing_wait * 10);
 
-	if (!serial_isroot()) {
+	if (!capable(CAP_SYS_ADMIN)) {
 		if ((ss->baud_base != state->baud_base) ||
 		    (close_delay != port->close_delay) ||
 		    (closing_wait != port->closing_wait) ||
-- 
2.32.0

