Return-Path: <SRS0=TTKI=74=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7311AC433E0
	for <linux-serial@archiver.kernel.org>; Mon, 15 Jun 2020 07:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B02920738
	for <linux-serial@archiver.kernel.org>; Mon, 15 Jun 2020 07:51:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbgFOHvm (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 15 Jun 2020 03:51:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:39996 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728814AbgFOHtP (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 15 Jun 2020 03:49:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id AF005B001;
        Mon, 15 Jun 2020 07:49:16 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 09/38] vt: get rid of VT10.ID macros
Date:   Mon, 15 Jun 2020 09:48:41 +0200
Message-Id: <20200615074910.19267-9-jslaby@suse.cz>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200615074910.19267-1-jslaby@suse.cz>
References: <20200615074910.19267-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

VT100ID is unused, but defined twice. Kill it.

VT102ID is used only in respond_ID. Define there a variable with proper
type and use that instead. Then drop both defines of VT102ID too.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/vt.c     | 11 ++++-------
 include/linux/console.h |  6 ------
 2 files changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 49c9d1e4067c..8d9e532f050a 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1397,12 +1397,6 @@ enum { EPecma = 0, EPdec, EPeq, EPgt, EPlt};
 #define kbdapplic	VC_APPLIC
 #define lnm		VC_CRLF
 
-/*
- * this is what the terminal answers to a ESC-Z or csi0c query.
- */
-#define VT100ID "\033[?1;2c"
-#define VT102ID "\033[?6c"
-
 const unsigned char color_table[] = { 0, 4, 2, 6, 1, 5, 3, 7,
 				       8,12,10,14, 9,13,11,15 };
 
@@ -1835,7 +1829,10 @@ static inline void status_report(struct tty_struct *tty)
 
 static inline void respond_ID(struct tty_struct *tty)
 {
-	respond_string(VT102ID, strlen(VT102ID), tty->port);
+	/* terminal answer to an ESC-Z or csi0c query. */
+	static const char vt102_id[] = "\033[?6c";
+
+	respond_string(vt102_id, strlen(vt102_id), tty->port);
 }
 
 void mouse_report(struct tty_struct *tty, int butt, int mrx, int mry)
diff --git a/include/linux/console.h b/include/linux/console.h
index 964b67912b04..0670d3491e0e 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -24,12 +24,6 @@ struct module;
 struct tty_struct;
 struct notifier_block;
 
-/*
- * this is what the terminal answers to a ESC-Z or csi0c query.
- */
-#define VT100ID "\033[?1;2c"
-#define VT102ID "\033[?6c"
-
 enum con_scroll {
 	SM_UP,
 	SM_DOWN,
-- 
2.27.0

