Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E3CC4338F
	for <linux-serial@archiver.kernel.org>; Mon, 26 Jul 2021 13:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59D2560F11
	for <linux-serial@archiver.kernel.org>; Mon, 26 Jul 2021 13:43:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234263AbhGZNDA (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 26 Jul 2021 09:03:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:60890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233995AbhGZNDA (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 26 Jul 2021 09:03:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AFD5E60241;
        Mon, 26 Jul 2021 13:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1627307008;
        bh=lAkNhK7vnVmWhNzKdij1ndDYQjyQ4JLboA/lr0q5Sko=;
        h=From:To:Cc:Subject:Date:From;
        b=lX0BeR4/pdox0YJVm+4DDjZBp2e3sRHnxlFsu5KOq8umCGqejXRkarOb3+ff6r06P
         YvWkuoy++37mgYXtzKFPZ2ILiTRC76e5yFQ6dNDdTC3XZekMa2S6HVgJJGv3bnXu0F
         H9xXuWOAAjHGHHjOUix+kXlnW80HGxVTooxy5g+g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-serial@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jordy Zomer <jordy@pwning.systems>
Subject: [PATCH 1/2] vt: keyboard: treat kbd_table as an array all the time.
Date:   Mon, 26 Jul 2021 15:43:21 +0200
Message-Id: <20210726134322.2274919-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5445; h=from:subject; bh=lAkNhK7vnVmWhNzKdij1ndDYQjyQ4JLboA/lr0q5Sko=; b=owGbwMvMwCRo6H6F97bub03G02pJDAn/dn9NL/rcfap7svNN7//BWkWnU7m++E2wsjA0z2T71/yz 5OG0jlgWBkEmBlkxRZYv23iO7q84pOhlaHsaZg4rE8gQBi5OAZjIqRsM86yvJzvoXOUPZbfREfdcfF fh0J+50xnm57a5GG+/td24rWHzteWsmj31BbFHAA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The keyboard.c code seems to like to treat the kbd_table as both an
array, and as a base to do some pointer math off of.  As they really are
the same thing, and compilers are smart enough not to make a difference
anymore, just be explicit and always use this as an array to make the
code more obvious for all to read.

Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jordy Zomer <jordy@pwning.systems>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/vt/keyboard.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index 4b0d69042ceb..e81c940a2ea1 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -1173,7 +1173,7 @@ static inline unsigned char getleds(void)
  */
 int vt_get_leds(int console, int flag)
 {
-	struct kbd_struct *kb = kbd_table + console;
+	struct kbd_struct *kb = &kbd_table[console];
 	int ret;
 	unsigned long flags;
 
@@ -1195,7 +1195,7 @@ EXPORT_SYMBOL_GPL(vt_get_leds);
  */
 void vt_set_led_state(int console, int leds)
 {
-	struct kbd_struct *kb = kbd_table + console;
+	struct kbd_struct *kb = &kbd_table[console];
 	setledstate(kb, leds);
 }
 
@@ -1214,7 +1214,7 @@ void vt_set_led_state(int console, int leds)
  */
 void vt_kbd_con_start(int console)
 {
-	struct kbd_struct *kb = kbd_table + console;
+	struct kbd_struct *kb = &kbd_table[console];
 	unsigned long flags;
 	spin_lock_irqsave(&led_lock, flags);
 	clr_vc_kbd_led(kb, VC_SCROLLOCK);
@@ -1231,7 +1231,7 @@ void vt_kbd_con_start(int console)
  */
 void vt_kbd_con_stop(int console)
 {
-	struct kbd_struct *kb = kbd_table + console;
+	struct kbd_struct *kb = &kbd_table[console];
 	unsigned long flags;
 	spin_lock_irqsave(&led_lock, flags);
 	set_vc_kbd_led(kb, VC_SCROLLOCK);
@@ -1377,7 +1377,7 @@ static void kbd_rawcode(unsigned char data)
 {
 	struct vc_data *vc = vc_cons[fg_console].d;
 
-	kbd = kbd_table + vc->vc_num;
+	kbd = &kbd_table[vc->vc_num];
 	if (kbd->kbdmode == VC_RAW)
 		put_queue(vc, data);
 }
@@ -1400,7 +1400,7 @@ static void kbd_keycode(unsigned int keycode, int down, bool hw_raw)
 		tty->driver_data = vc;
 	}
 
-	kbd = kbd_table + vc->vc_num;
+	kbd = &kbd_table[vc->vc_num];
 
 #ifdef CONFIG_SPARC
 	if (keycode == KEY_STOP)
@@ -1827,7 +1827,7 @@ int vt_do_diacrit(unsigned int cmd, void __user *udp, int perm)
  */
 int vt_do_kdskbmode(int console, unsigned int arg)
 {
-	struct kbd_struct *kb = kbd_table + console;
+	struct kbd_struct *kb = &kbd_table[console];
 	int ret = 0;
 	unsigned long flags;
 
@@ -1867,7 +1867,7 @@ int vt_do_kdskbmode(int console, unsigned int arg)
  */
 int vt_do_kdskbmeta(int console, unsigned int arg)
 {
-	struct kbd_struct *kb = kbd_table + console;
+	struct kbd_struct *kb = &kbd_table[console];
 	int ret = 0;
 	unsigned long flags;
 
@@ -2010,7 +2010,7 @@ static int vt_kdskbent(unsigned char kbdmode, unsigned char idx,
 int vt_do_kdsk_ioctl(int cmd, struct kbentry __user *user_kbe, int perm,
 						int console)
 {
-	struct kbd_struct *kb = kbd_table + console;
+	struct kbd_struct *kb = &kbd_table[console];
 	struct kbentry kbe;
 
 	if (copy_from_user(&kbe, user_kbe, sizeof(struct kbentry)))
@@ -2099,7 +2099,7 @@ int vt_do_kdgkb_ioctl(int cmd, struct kbsentry __user *user_kdgkb, int perm)
 
 int vt_do_kdskled(int console, int cmd, unsigned long arg, int perm)
 {
-	struct kbd_struct *kb = kbd_table + console;
+	struct kbd_struct *kb = &kbd_table[console];
         unsigned long flags;
 	unsigned char ucval;
 
@@ -2141,7 +2141,7 @@ int vt_do_kdskled(int console, int cmd, unsigned long arg, int perm)
 
 int vt_do_kdgkbmode(int console)
 {
-	struct kbd_struct *kb = kbd_table + console;
+	struct kbd_struct *kb = &kbd_table[console];
 	/* This is a spot read so needs no locking */
 	switch (kb->kbdmode) {
 	case VC_RAW:
@@ -2165,7 +2165,7 @@ int vt_do_kdgkbmode(int console)
  */
 int vt_do_kdgkbmeta(int console)
 {
-	struct kbd_struct *kb = kbd_table + console;
+	struct kbd_struct *kb = &kbd_table[console];
         /* Again a spot read so no locking */
 	return vc_kbd_mode(kb, VC_META) ? K_ESCPREFIX : K_METABIT;
 }
@@ -2206,7 +2206,7 @@ int vt_get_shift_state(void)
  */
 void vt_reset_keyboard(int console)
 {
-	struct kbd_struct *kb = kbd_table + console;
+	struct kbd_struct *kb = &kbd_table[console];
 	unsigned long flags;
 
 	spin_lock_irqsave(&kbd_event_lock, flags);
@@ -2236,7 +2236,7 @@ void vt_reset_keyboard(int console)
 
 int vt_get_kbd_mode_bit(int console, int bit)
 {
-	struct kbd_struct *kb = kbd_table + console;
+	struct kbd_struct *kb = &kbd_table[console];
 	return vc_kbd_mode(kb, bit);
 }
 
@@ -2251,7 +2251,7 @@ int vt_get_kbd_mode_bit(int console, int bit)
 
 void vt_set_kbd_mode_bit(int console, int bit)
 {
-	struct kbd_struct *kb = kbd_table + console;
+	struct kbd_struct *kb = &kbd_table[console];
 	unsigned long flags;
 
 	spin_lock_irqsave(&kbd_event_lock, flags);
@@ -2270,7 +2270,7 @@ void vt_set_kbd_mode_bit(int console, int bit)
 
 void vt_clr_kbd_mode_bit(int console, int bit)
 {
-	struct kbd_struct *kb = kbd_table + console;
+	struct kbd_struct *kb = &kbd_table[console];
 	unsigned long flags;
 
 	spin_lock_irqsave(&kbd_event_lock, flags);
-- 
2.32.0

