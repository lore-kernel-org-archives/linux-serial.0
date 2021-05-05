Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F29C433B4
	for <linux-serial@archiver.kernel.org>; Wed,  5 May 2021 09:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C2F6613C7
	for <linux-serial@archiver.kernel.org>; Wed,  5 May 2021 09:20:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232802AbhEEJVC (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 5 May 2021 05:21:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:42070 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232505AbhEEJUk (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 5 May 2021 05:20:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CB801B281;
        Wed,  5 May 2021 09:19:41 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>,
        Karsten Keil <isdn@linux-pingi.de>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 30/35] tty: remove empty tty_operations::flush_buffer
Date:   Wed,  5 May 2021 11:19:23 +0200
Message-Id: <20210505091928.22010-31-jslaby@suse.cz>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210505091928.22010-1-jslaby@suse.cz>
References: <20210505091928.22010-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tty_operations::flush_buffer is optional. If it doesn't exist, nothing
is called. So remove almost¹ empty flush_buffer implementations.

¹ capi had an useless pr_debug in it.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Karsten Keil <isdn@linux-pingi.de>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
---
 drivers/isdn/capi/capi.c    | 6 ------
 drivers/s390/char/tty3270.c | 6 ------
 2 files changed, 12 deletions(-)

diff --git a/drivers/isdn/capi/capi.c b/drivers/isdn/capi/capi.c
index dae80197ad9c..6d99b93bb09e 100644
--- a/drivers/isdn/capi/capi.c
+++ b/drivers/isdn/capi/capi.c
@@ -1249,11 +1249,6 @@ static int capinc_tty_break_ctl(struct tty_struct *tty, int state)
 	return 0;
 }
 
-static void capinc_tty_flush_buffer(struct tty_struct *tty)
-{
-	pr_debug("capinc_tty_flush_buffer\n");
-}
-
 static void capinc_tty_set_ldisc(struct tty_struct *tty)
 {
 	pr_debug("capinc_tty_set_ldisc\n");
@@ -1279,7 +1274,6 @@ static const struct tty_operations capinc_ops = {
 	.start = capinc_tty_start,
 	.hangup = capinc_tty_hangup,
 	.break_ctl = capinc_tty_break_ctl,
-	.flush_buffer = capinc_tty_flush_buffer,
 	.set_ldisc = capinc_tty_set_ldisc,
 	.send_xchar = capinc_tty_send_xchar,
 	.install = capinc_tty_install,
diff --git a/drivers/s390/char/tty3270.c b/drivers/s390/char/tty3270.c
index ba1fbce63fee..adc33846bf8e 100644
--- a/drivers/s390/char/tty3270.c
+++ b/drivers/s390/char/tty3270.c
@@ -1756,11 +1756,6 @@ tty3270_flush_chars(struct tty_struct *tty)
 	}
 }
 
-static void
-tty3270_flush_buffer(struct tty_struct *tty)
-{
-}
-
 /*
  * Check for visible/invisible input switches
  */
@@ -1881,7 +1876,6 @@ static const struct tty_operations tty3270_ops = {
 	.put_char = tty3270_put_char,
 	.flush_chars = tty3270_flush_chars,
 	.write_room = tty3270_write_room,
-	.flush_buffer = tty3270_flush_buffer,
 	.throttle = tty3270_throttle,
 	.unthrottle = tty3270_unthrottle,
 	.hangup = tty3270_hangup,
-- 
2.31.1

