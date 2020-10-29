Return-Path: <SRS0=FKk9=EE=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C73FC2D0A3
	for <linux-serial@archiver.kernel.org>; Thu, 29 Oct 2020 11:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 200B82072C
	for <linux-serial@archiver.kernel.org>; Thu, 29 Oct 2020 11:32:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbgJ2Lcr (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 29 Oct 2020 07:32:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:57254 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727614AbgJ2Lc2 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 29 Oct 2020 07:32:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7EFD2B81F;
        Thu, 29 Oct 2020 11:32:26 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 16/17] vt: keyboard, use find_next_bit in kbd_match
Date:   Thu, 29 Oct 2020 12:32:21 +0100
Message-Id: <20201029113222.32640-16-jslaby@suse.cz>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201029113222.32640-1-jslaby@suse.cz>
References: <20201029113222.32640-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Instead of a 'for' loop with 'test_bit's to find a bit in a range, use
find_next_bit to achieve the same in a simpler and faster manner.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/keyboard.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index dea2f25a5d9f..149f1791d7ec 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -1535,18 +1535,16 @@ static void kbd_event(struct input_handle *handle, unsigned int event_type,
 
 static bool kbd_match(struct input_handler *handler, struct input_dev *dev)
 {
-	int i;
-
 	if (test_bit(EV_SND, dev->evbit))
 		return true;
 
 	if (test_bit(EV_KEY, dev->evbit)) {
-		for (i = KEY_RESERVED; i < BTN_MISC; i++)
-			if (test_bit(i, dev->keybit))
-				return true;
-		for (i = KEY_BRL_DOT1; i <= KEY_BRL_DOT10; i++)
-			if (test_bit(i, dev->keybit))
-				return true;
+		if (find_next_bit(dev->keybit, BTN_MISC, KEY_RESERVED) <
+				BTN_MISC)
+			return true;
+		if (find_next_bit(dev->keybit, KEY_BRL_DOT10 + 1,
+					KEY_BRL_DOT1) <= KEY_BRL_DOT10)
+			return true;
 	}
 
 	return false;
-- 
2.29.1

