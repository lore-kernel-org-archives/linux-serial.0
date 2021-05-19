Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 093A7C43461
	for <linux-serial@archiver.kernel.org>; Wed, 19 May 2021 07:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4AB161364
	for <linux-serial@archiver.kernel.org>; Wed, 19 May 2021 07:21:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239651AbhESHXQ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 19 May 2021 03:23:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:39378 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238016AbhESHXP (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 19 May 2021 03:23:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2FA52B159;
        Wed, 19 May 2021 07:21:55 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 4/4] tty: fix kernel-doc for {start,stop}_tty
Date:   Wed, 19 May 2021 09:21:53 +0200
Message-Id: <20210519072153.3859-4-jslaby@suse.cz>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210519072153.3859-1-jslaby@suse.cz>
References: <20210519072153.3859-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Commit f9e053dcfc02 (tty: Serialize tty flow control changes with
flow_lock) renamed start_tty to __start_tty and stop_tty to __stop_tty
and introduced new start_tty and stop_tty. But it left kernel-doc
comments on the old locations:
 tty_io.c:785: warning: expecting prototype for stop_tty(). Prototype was for __stop_tty() instead
 tty_io.c:816: warning: expecting prototype for start_tty(). Prototype was for __start_tty() instead

Fix that by moving the comments to appropriate locations.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/tty_io.c | 40 +++++++++++++++++++---------------------
 1 file changed, 19 insertions(+), 21 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index ad64232cecae..26debec26b4e 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -761,6 +761,15 @@ int tty_hung_up_p(struct file *filp)
 }
 EXPORT_SYMBOL(tty_hung_up_p);
 
+void __stop_tty(struct tty_struct *tty)
+{
+	if (tty->flow.stopped)
+		return;
+	tty->flow.stopped = true;
+	if (tty->ops->stop)
+		tty->ops->stop(tty);
+}
+
 /**
  *	stop_tty	-	propagate flow control
  *	@tty: tty to stop
@@ -777,16 +786,6 @@ EXPORT_SYMBOL(tty_hung_up_p);
  *	Locking:
  *		flow.lock
  */
-
-void __stop_tty(struct tty_struct *tty)
-{
-	if (tty->flow.stopped)
-		return;
-	tty->flow.stopped = true;
-	if (tty->ops->stop)
-		tty->ops->stop(tty);
-}
-
 void stop_tty(struct tty_struct *tty)
 {
 	unsigned long flags;
@@ -797,6 +796,16 @@ void stop_tty(struct tty_struct *tty)
 }
 EXPORT_SYMBOL(stop_tty);
 
+void __start_tty(struct tty_struct *tty)
+{
+	if (!tty->flow.stopped || tty->flow.tco_stopped)
+		return;
+	tty->flow.stopped = false;
+	if (tty->ops->start)
+		tty->ops->start(tty);
+	tty_wakeup(tty);
+}
+
 /**
  *	start_tty	-	propagate flow control
  *	@tty: tty to start
@@ -808,17 +817,6 @@ EXPORT_SYMBOL(stop_tty);
  *	Locking:
  *		flow.lock
  */
-
-void __start_tty(struct tty_struct *tty)
-{
-	if (!tty->flow.stopped || tty->flow.tco_stopped)
-		return;
-	tty->flow.stopped = false;
-	if (tty->ops->start)
-		tty->ops->start(tty);
-	tty_wakeup(tty);
-}
-
 void start_tty(struct tty_struct *tty)
 {
 	unsigned long flags;
-- 
2.31.1

