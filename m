Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D676C43618
	for <linux-serial@archiver.kernel.org>; Wed,  5 May 2021 09:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0409F613C7
	for <linux-serial@archiver.kernel.org>; Wed,  5 May 2021 09:19:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232644AbhEEJUu (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 5 May 2021 05:20:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:41876 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232471AbhEEJUh (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 5 May 2021 05:20:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 988C9B275;
        Wed,  5 May 2021 09:19:36 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 21/35] ti-st: use tty_write_room
Date:   Wed,  5 May 2021 11:19:14 +0200
Message-Id: <20210505091928.22010-22-jslaby@suse.cz>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210505091928.22010-1-jslaby@suse.cz>
References: <20210505091928.22010-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Don't access tty->ops->write_room directly, use tty_write_room helper
instead.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 drivers/misc/ti-st/st_core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/ti-st/st_core.c b/drivers/misc/ti-st/st_core.c
index 05c015140cad..7f6976a9f508 100644
--- a/drivers/misc/ti-st/st_core.c
+++ b/drivers/misc/ti-st/st_core.c
@@ -52,13 +52,12 @@ static void remove_channel_from_table(struct st_data_s *st_gdata,
  */
 int st_get_uart_wr_room(struct st_data_s *st_gdata)
 {
-	struct tty_struct *tty;
 	if (unlikely(st_gdata == NULL || st_gdata->tty == NULL)) {
 		pr_err("tty unavailable to perform write");
 		return -1;
 	}
-	tty = st_gdata->tty;
-	return tty->ops->write_room(tty);
+
+	return tty_write_room(st_gdata->tty);
 }
 
 /*
-- 
2.31.1

