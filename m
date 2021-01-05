Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66CC4C433DB
	for <linux-serial@archiver.kernel.org>; Tue,  5 Jan 2021 12:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16D8B22AAE
	for <linux-serial@archiver.kernel.org>; Tue,  5 Jan 2021 12:03:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729896AbhAEMDW (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 5 Jan 2021 07:03:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:38640 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729883AbhAEMDV (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 5 Jan 2021 07:03:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id ED6CEAD26;
        Tue,  5 Jan 2021 12:02:39 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 02/12] vt: keyboard, make keyboard_tasklet local
Date:   Tue,  5 Jan 2021 13:02:29 +0100
Message-Id: <20210105120239.28031-2-jslaby@suse.cz>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210105120239.28031-1-jslaby@suse.cz>
References: <20210105120239.28031-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Now that the last extern user of the tasklet (set_leds) is in
keyboard.c, we can make keyboard_tasklet local to this unit too.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/keyboard.c | 5 +++--
 include/linux/kbd_kern.h  | 2 --
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index 32ec4242b1f2..9f2eaa104ebc 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -131,6 +131,9 @@ static const unsigned char max_vals[] = {
 
 static const int NR_TYPES = ARRAY_SIZE(max_vals);
 
+static void kbd_bh(unsigned long dummy);
+static DECLARE_TASKLET_DISABLED_OLD(keyboard_tasklet, kbd_bh);
+
 static struct input_handler kbd_handler;
 static DEFINE_SPINLOCK(kbd_event_lock);
 static DEFINE_SPINLOCK(led_lock);
@@ -1258,8 +1261,6 @@ static void kbd_bh(unsigned long dummy)
 	}
 }
 
-DECLARE_TASKLET_DISABLED_OLD(keyboard_tasklet, kbd_bh);
-
 #if defined(CONFIG_X86) || defined(CONFIG_IA64) || defined(CONFIG_ALPHA) ||\
     defined(CONFIG_MIPS) || defined(CONFIG_PPC) || defined(CONFIG_SPARC) ||\
     defined(CONFIG_PARISC) || defined(CONFIG_SUPERH) ||\
diff --git a/include/linux/kbd_kern.h b/include/linux/kbd_kern.h
index adf98004624b..c40811d79769 100644
--- a/include/linux/kbd_kern.h
+++ b/include/linux/kbd_kern.h
@@ -6,8 +6,6 @@
 #include <linux/interrupt.h>
 #include <linux/keyboard.h>
 
-extern struct tasklet_struct keyboard_tasklet;
-
 extern char *func_table[MAX_NR_FUNC];
 
 /*
-- 
2.30.0

