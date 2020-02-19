Return-Path: <SRS0=V5ud=4H=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61789C3404D
	for <linux-serial@archiver.kernel.org>; Wed, 19 Feb 2020 08:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44A7C208E4
	for <linux-serial@archiver.kernel.org>; Wed, 19 Feb 2020 08:42:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727274AbgBSImF (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 19 Feb 2020 03:42:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:44310 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726767AbgBSIl0 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 19 Feb 2020 03:41:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id ED0E4AD88;
        Wed, 19 Feb 2020 08:41:24 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 18/24] n_hdlc: remove unneeded ifdef
Date:   Wed, 19 Feb 2020 09:41:12 +0100
Message-Id: <20200219084118.26491-18-jslaby@suse.cz>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200219084118.26491-1-jslaby@suse.cz>
References: <20200219084118.26491-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

TTY_NO_WRITE_SPLIT is (always) defined in linux/tty.h, so no need to
check for it.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/n_hdlc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/n_hdlc.c b/drivers/tty/n_hdlc.c
index c4fe09124185..cf8485beaccd 100644
--- a/drivers/tty/n_hdlc.c
+++ b/drivers/tty/n_hdlc.c
@@ -244,10 +244,8 @@ static int n_hdlc_tty_open (struct tty_struct *tty)
 	tty->disc_data = n_hdlc;
 	tty->receive_room = 65536;
 	
-#if defined(TTY_NO_WRITE_SPLIT)
 	/* change tty_io write() to not split large writes into 8K chunks */
 	set_bit(TTY_NO_WRITE_SPLIT,&tty->flags);
-#endif
 	
 	/* flush receive data from driver */
 	tty_driver_flush_buffer(tty);
-- 
2.25.0

