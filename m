Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD8EC433E0
	for <linux-serial@archiver.kernel.org>; Tue,  5 Jan 2021 12:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D0D622A84
	for <linux-serial@archiver.kernel.org>; Tue,  5 Jan 2021 12:04:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729900AbhAEMDW (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 5 Jan 2021 07:03:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:38628 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726074AbhAEMDV (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 5 Jan 2021 07:03:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B8F7CAA7C;
        Tue,  5 Jan 2021 12:02:39 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 01/12] vt: move set_leds to keyboard.c
Date:   Tue,  5 Jan 2021 13:02:28 +0100
Message-Id: <20210105120239.28031-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

set_leds and compute_shiftstate are called from a single place in vt.c.
Let's combine these two into vt_set_leds_compute_shiftstate. This allows
for making keyboard_tasklet local in the next patch.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/keyboard.c | 11 ++++++++++-
 drivers/tty/vt/vt.c       |  3 +--
 include/linux/kbd_kern.h  |  8 +-------
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index 52922d21a49f..32ec4242b1f2 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -372,6 +372,12 @@ static void to_utf8(struct vc_data *vc, uint c)
 	}
 }
 
+/* FIXME: review locking for vt.c callers */
+static void set_leds(void)
+{
+	tasklet_schedule(&keyboard_tasklet);
+}
+
 /*
  * Called after returning from RAW mode or when changing consoles - recompute
  * shift_down[] and shift_state from key_down[] maybe called when keymap is
@@ -401,9 +407,12 @@ static void do_compute_shiftstate(void)
 }
 
 /* We still have to export this method to vt.c */
-void compute_shiftstate(void)
+void vt_set_leds_compute_shiftstate(void)
 {
 	unsigned long flags;
+
+	set_leds();
+
 	spin_lock_irqsave(&kbd_event_lock, flags);
 	do_compute_shiftstate();
 	spin_unlock_irqrestore(&kbd_event_lock, flags);
diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index d04a162939a4..fe4fedbc0386 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1036,8 +1036,7 @@ void redraw_screen(struct vc_data *vc, int is_switch)
 	}
 	set_cursor(vc);
 	if (is_switch) {
-		set_leds();
-		compute_shiftstate();
+		vt_set_leds_compute_shiftstate();
 		notify_update(vc);
 	}
 }
diff --git a/include/linux/kbd_kern.h b/include/linux/kbd_kern.h
index 82f29aa35062..adf98004624b 100644
--- a/include/linux/kbd_kern.h
+++ b/include/linux/kbd_kern.h
@@ -71,12 +71,6 @@ extern void (*kbd_ledfunc)(unsigned int led);
 extern int set_console(int nr);
 extern void schedule_console_callback(void);
 
-/* FIXME: review locking for vt.c callers */
-static inline void set_leds(void)
-{
-	tasklet_schedule(&keyboard_tasklet);
-}
-
 static inline int vc_kbd_mode(struct kbd_struct * kbd, int flag)
 {
 	return ((kbd->modeflags >> flag) & 1);
@@ -135,7 +129,7 @@ static inline void chg_vc_kbd_led(struct kbd_struct * kbd, int flag)
 
 struct console;
 
-void compute_shiftstate(void);
+void vt_set_leds_compute_shiftstate(void);
 
 /* defkeymap.c */
 
-- 
2.30.0

