Return-Path: <SRS0=FKk9=EE=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C452FC2D0A3
	for <linux-serial@archiver.kernel.org>; Thu, 29 Oct 2020 11:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 726AE2072C
	for <linux-serial@archiver.kernel.org>; Thu, 29 Oct 2020 11:33:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbgJ2Ldl (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 29 Oct 2020 07:33:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:57064 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727253AbgJ2LcZ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 29 Oct 2020 07:32:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CE5D5B215;
        Thu, 29 Oct 2020 11:32:23 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 05/17] vt: keyboard, clean up max_vals
Date:   Thu, 29 Oct 2020 12:32:10 +0100
Message-Id: <20201029113222.32640-5-jslaby@suse.cz>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201029113222.32640-1-jslaby@suse.cz>
References: <20201029113222.32640-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Define one limit per line and index them by their index, so that it is
clear what is what.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/keyboard.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index 9e45feb15a3e..4545afd3ef2f 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -111,10 +111,22 @@ static struct kbd_struct kbd_table[MAX_NR_CONSOLES];
 static struct kbd_struct *kbd = kbd_table;
 
 /* maximum values each key_handler can handle */
-static const int max_vals[] = {
-	255, ARRAY_SIZE(func_table) - 1, ARRAY_SIZE(fn_handler) - 1, NR_PAD - 1,
-	NR_DEAD - 1, 255, 3, NR_SHIFT - 1, 255, NR_ASCII - 1, NR_LOCK - 1,
-	255, NR_LOCK - 1, 255, NR_BRL - 1
+static const unsigned char max_vals[] = {
+	[ KT_LATIN	] = 255,
+	[ KT_FN		] = ARRAY_SIZE(func_table) - 1,
+	[ KT_SPEC	] = ARRAY_SIZE(fn_handler) - 1,
+	[ KT_PAD	] = NR_PAD - 1,
+	[ KT_DEAD	] = NR_DEAD - 1,
+	[ KT_CONS	] = 255,
+	[ KT_CUR	] = 3,
+	[ KT_SHIFT	] = NR_SHIFT - 1,
+	[ KT_META	] = 255,
+	[ KT_ASCII	] = NR_ASCII - 1,
+	[ KT_LOCK	] = NR_LOCK - 1,
+	[ KT_LETTER	] = 255,
+	[ KT_SLOCK	] = NR_LOCK - 1,
+	[ KT_DEAD2	] = 255,
+	[ KT_BRL	] = NR_BRL - 1,
 };
 
 static const int NR_TYPES = ARRAY_SIZE(max_vals);
-- 
2.29.1

