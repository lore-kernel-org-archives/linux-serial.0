Return-Path: <SRS0=FKk9=EE=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87305C55178
	for <linux-serial@archiver.kernel.org>; Thu, 29 Oct 2020 11:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 376672076E
	for <linux-serial@archiver.kernel.org>; Thu, 29 Oct 2020 11:32:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbgJ2Lcr (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 29 Oct 2020 07:32:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:57256 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727621AbgJ2Lc2 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 29 Oct 2020 07:32:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B59E1B823;
        Thu, 29 Oct 2020 11:32:26 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 17/17] vt: keyboard, use tty_insert_flip_string in puts_queue
Date:   Thu, 29 Oct 2020 12:32:22 +0100
Message-Id: <20201029113222.32640-17-jslaby@suse.cz>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201029113222.32640-1-jslaby@suse.cz>
References: <20201029113222.32640-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

'puts_queue' currently loops over characters and employs the full tty
buffer machinery for every character. Do the buffer allocation only once
and copy all the character at once. This is achieved using
tty_insert_flip_string instead of loop+tty_insert_flip_char.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/keyboard.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index 149f1791d7ec..56b5e8f8fe88 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -324,12 +324,9 @@ static void put_queue(struct vc_data *vc, int ch)
 	tty_schedule_flip(&vc->port);
 }
 
-static void puts_queue(struct vc_data *vc, char *cp)
+static void puts_queue(struct vc_data *vc, const char *cp)
 {
-	while (*cp) {
-		tty_insert_flip_char(&vc->port, *cp, 0);
-		cp++;
-	}
+	tty_insert_flip_string(&vc->port, cp, strlen(cp));
 	tty_schedule_flip(&vc->port);
 }
 
-- 
2.29.1

