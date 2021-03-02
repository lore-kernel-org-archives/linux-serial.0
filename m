Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D565AC433E9
	for <linux-serial@archiver.kernel.org>; Wed,  3 Mar 2021 02:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6FE76023B
	for <linux-serial@archiver.kernel.org>; Wed,  3 Mar 2021 02:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348532AbhCCCRU (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 2 Mar 2021 21:17:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:39966 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1835905AbhCBGZf (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 2 Mar 2021 01:25:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BC774B03B;
        Tue,  2 Mar 2021 06:22:21 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 36/44] tty: localise ptychar and make it const
Date:   Tue,  2 Mar 2021 07:22:06 +0100
Message-Id: <20210302062214.29627-36-jslaby@suse.cz>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210302062214.29627-1-jslaby@suse.cz>
References: <20210302062214.29627-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

ptychar was not const, so mark it as such. And move this variable to the
only place where it's used.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/tty_io.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index c8cbf08b6dcf..7cf57e6cadbf 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -1196,8 +1196,6 @@ int tty_send_xchar(struct tty_struct *tty, char ch)
 	return 0;
 }
 
-static char ptychar[] = "pqrstuvwxyzabcde";
-
 /**
  *	pty_line_name	-	generate name for a pty
  *	@driver: the tty driver in use
@@ -1211,6 +1209,7 @@ static char ptychar[] = "pqrstuvwxyzabcde";
  */
 static void pty_line_name(struct tty_driver *driver, int index, char *p)
 {
+	static const char ptychar[] = "pqrstuvwxyzabcde";
 	int i = index + driver->name_base;
 	/* ->name is initialized to "ttyp", but "tty" is expected */
 	sprintf(p, "%s%c%x",
-- 
2.30.1

