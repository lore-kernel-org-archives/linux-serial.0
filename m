Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 851D3C4338F
	for <linux-serial@archiver.kernel.org>; Mon, 26 Jul 2021 13:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F19D60F11
	for <linux-serial@archiver.kernel.org>; Mon, 26 Jul 2021 13:43:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233961AbhGZNDJ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 26 Jul 2021 09:03:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:60966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233970AbhGZNDI (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 26 Jul 2021 09:03:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3191160E08;
        Mon, 26 Jul 2021 13:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1627307016;
        bh=Z7luSsBKo+vKZ+wNEkeorNXjVJpdTMQxsxikgpRhDy8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dd8PtS14ZH3SvAZEhLRnGcRhbaLuxMg353rqMEWty7/CFKK/4FAcqXdzDf5UBLDOv
         jruEnuUZHJYRY6Lw2PR7VZ8ZpYwkxMFEnGvXSrOO8thvEoAg2nTEWwhDrdlHBbvhHw
         Ei/dLgQ96I2JbG691i4ttQQIvlSSVfq0MgkI/xnk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-serial@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jordy Zomer <jordy@pwning.systems>
Subject: [PATCH 2/2] vt: keyboard.c: make console an unsigned int
Date:   Mon, 26 Jul 2021 15:43:22 +0200
Message-Id: <20210726134322.2274919-2-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210726134322.2274919-1-gregkh@linuxfoundation.org>
References: <20210726134322.2274919-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7926; h=from:subject; bh=Z7luSsBKo+vKZ+wNEkeorNXjVJpdTMQxsxikgpRhDy8=; b=owGbwMvMwCRo6H6F97bub03G02pJDAn/dv/8zOlaP0H+2pl1D4VzC8svmpa1OoZza/L0zbP6UCt2 iFeuI5aFQZCJQVZMkeXLNp6j+ysOKXoZ2p6GmcPKBDKEgYtTACZiuJFhnmmAjYdWys4lWocOe78tz6 mMCD/0gWHBDofbHBH/bWe9ijvpkmY1beX/PMsKAA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The console variable is used everywhere in some fun pointer path and
array indexes and for some reason isn't always declared as unsigned.
This plays havoc with some static analysis tools so mark the variable as
unsigned so we "know" we can not wrap the arrays backwards here.

Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reported-by: Jordy Zomer <jordy@pwning.systems>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/vt/keyboard.c | 30 +++++++++++++++---------------
 include/linux/vt_kern.h   | 30 +++++++++++++++---------------
 2 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index e81c940a2ea1..c7fbbcdcc346 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -1171,7 +1171,7 @@ static inline unsigned char getleds(void)
  *
  *	Check the status of a keyboard led flag and report it back
  */
-int vt_get_leds(int console, int flag)
+int vt_get_leds(unsigned int console, int flag)
 {
 	struct kbd_struct *kb = &kbd_table[console];
 	int ret;
@@ -1193,7 +1193,7 @@ EXPORT_SYMBOL_GPL(vt_get_leds);
  *	Set the LEDs on a console. This is a wrapper for the VT layer
  *	so that we can keep kbd knowledge internal
  */
-void vt_set_led_state(int console, int leds)
+void vt_set_led_state(unsigned int console, int leds)
 {
 	struct kbd_struct *kb = &kbd_table[console];
 	setledstate(kb, leds);
@@ -1212,7 +1212,7 @@ void vt_set_led_state(int console, int leds)
  *	don't hold the lock. We probably need to split out an LED lock
  *	but not during an -rc release!
  */
-void vt_kbd_con_start(int console)
+void vt_kbd_con_start(unsigned int console)
 {
 	struct kbd_struct *kb = &kbd_table[console];
 	unsigned long flags;
@@ -1229,7 +1229,7 @@ void vt_kbd_con_start(int console)
  *	Handle console stop. This is a wrapper for the VT layer
  *	so that we can keep kbd knowledge internal
  */
-void vt_kbd_con_stop(int console)
+void vt_kbd_con_stop(unsigned int console)
 {
 	struct kbd_struct *kb = &kbd_table[console];
 	unsigned long flags;
@@ -1825,7 +1825,7 @@ int vt_do_diacrit(unsigned int cmd, void __user *udp, int perm)
  *	Update the keyboard mode bits while holding the correct locks.
  *	Return 0 for success or an error code.
  */
-int vt_do_kdskbmode(int console, unsigned int arg)
+int vt_do_kdskbmode(unsigned int console, unsigned int arg)
 {
 	struct kbd_struct *kb = &kbd_table[console];
 	int ret = 0;
@@ -1865,7 +1865,7 @@ int vt_do_kdskbmode(int console, unsigned int arg)
  *	Update the keyboard meta bits while holding the correct locks.
  *	Return 0 for success or an error code.
  */
-int vt_do_kdskbmeta(int console, unsigned int arg)
+int vt_do_kdskbmeta(unsigned int console, unsigned int arg)
 {
 	struct kbd_struct *kb = &kbd_table[console];
 	int ret = 0;
@@ -2008,7 +2008,7 @@ static int vt_kdskbent(unsigned char kbdmode, unsigned char idx,
 }
 
 int vt_do_kdsk_ioctl(int cmd, struct kbentry __user *user_kbe, int perm,
-						int console)
+						unsigned int console)
 {
 	struct kbd_struct *kb = &kbd_table[console];
 	struct kbentry kbe;
@@ -2097,7 +2097,7 @@ int vt_do_kdgkb_ioctl(int cmd, struct kbsentry __user *user_kdgkb, int perm)
 	return ret;
 }
 
-int vt_do_kdskled(int console, int cmd, unsigned long arg, int perm)
+int vt_do_kdskled(unsigned int console, int cmd, unsigned long arg, int perm)
 {
 	struct kbd_struct *kb = &kbd_table[console];
         unsigned long flags;
@@ -2139,7 +2139,7 @@ int vt_do_kdskled(int console, int cmd, unsigned long arg, int perm)
         return -ENOIOCTLCMD;
 }
 
-int vt_do_kdgkbmode(int console)
+int vt_do_kdgkbmode(unsigned int console)
 {
 	struct kbd_struct *kb = &kbd_table[console];
 	/* This is a spot read so needs no locking */
@@ -2163,7 +2163,7 @@ int vt_do_kdgkbmode(int console)
  *
  *	Report the meta flag status of this console
  */
-int vt_do_kdgkbmeta(int console)
+int vt_do_kdgkbmeta(unsigned int console)
 {
 	struct kbd_struct *kb = &kbd_table[console];
         /* Again a spot read so no locking */
@@ -2176,7 +2176,7 @@ int vt_do_kdgkbmeta(int console)
  *
  *	Restore the unicode console state to its default
  */
-void vt_reset_unicode(int console)
+void vt_reset_unicode(unsigned int console)
 {
 	unsigned long flags;
 
@@ -2204,7 +2204,7 @@ int vt_get_shift_state(void)
  *	Reset the keyboard bits for a console as part of a general console
  *	reset event
  */
-void vt_reset_keyboard(int console)
+void vt_reset_keyboard(unsigned int console)
 {
 	struct kbd_struct *kb = &kbd_table[console];
 	unsigned long flags;
@@ -2234,7 +2234,7 @@ void vt_reset_keyboard(int console)
  *	caller must be sure that there are no synchronization needs
  */
 
-int vt_get_kbd_mode_bit(int console, int bit)
+int vt_get_kbd_mode_bit(unsigned int console, int bit)
 {
 	struct kbd_struct *kb = &kbd_table[console];
 	return vc_kbd_mode(kb, bit);
@@ -2249,7 +2249,7 @@ int vt_get_kbd_mode_bit(int console, int bit)
  *	caller must be sure that there are no synchronization needs
  */
 
-void vt_set_kbd_mode_bit(int console, int bit)
+void vt_set_kbd_mode_bit(unsigned int console, int bit)
 {
 	struct kbd_struct *kb = &kbd_table[console];
 	unsigned long flags;
@@ -2268,7 +2268,7 @@ void vt_set_kbd_mode_bit(int console, int bit)
  *	caller must be sure that there are no synchronization needs
  */
 
-void vt_clr_kbd_mode_bit(int console, int bit)
+void vt_clr_kbd_mode_bit(unsigned int console, int bit)
 {
 	struct kbd_struct *kb = &kbd_table[console];
 	unsigned long flags;
diff --git a/include/linux/vt_kern.h b/include/linux/vt_kern.h
index 0da94a6dee15..b5ab452fca5b 100644
--- a/include/linux/vt_kern.h
+++ b/include/linux/vt_kern.h
@@ -148,26 +148,26 @@ void hide_boot_cursor(bool hide);
 
 /* keyboard  provided interfaces */
 int vt_do_diacrit(unsigned int cmd, void __user *up, int eperm);
-int vt_do_kdskbmode(int console, unsigned int arg);
-int vt_do_kdskbmeta(int console, unsigned int arg);
+int vt_do_kdskbmode(unsigned int console, unsigned int arg);
+int vt_do_kdskbmeta(unsigned int console, unsigned int arg);
 int vt_do_kbkeycode_ioctl(int cmd, struct kbkeycode __user *user_kbkc,
 			  int perm);
 int vt_do_kdsk_ioctl(int cmd, struct kbentry __user *user_kbe, int perm,
-		     int console);
+		     unsigned int console);
 int vt_do_kdgkb_ioctl(int cmd, struct kbsentry __user *user_kdgkb, int perm);
-int vt_do_kdskled(int console, int cmd, unsigned long arg, int perm);
-int vt_do_kdgkbmode(int console);
-int vt_do_kdgkbmeta(int console);
-void vt_reset_unicode(int console);
+int vt_do_kdskled(unsigned int console, int cmd, unsigned long arg, int perm);
+int vt_do_kdgkbmode(unsigned int console);
+int vt_do_kdgkbmeta(unsigned int console);
+void vt_reset_unicode(unsigned int console);
 int vt_get_shift_state(void);
-void vt_reset_keyboard(int console);
-int vt_get_leds(int console, int flag);
-int vt_get_kbd_mode_bit(int console, int bit);
-void vt_set_kbd_mode_bit(int console, int bit);
-void vt_clr_kbd_mode_bit(int console, int bit);
-void vt_set_led_state(int console, int leds);
-void vt_kbd_con_start(int console);
-void vt_kbd_con_stop(int console);
+void vt_reset_keyboard(unsigned int console);
+int vt_get_leds(unsigned int console, int flag);
+int vt_get_kbd_mode_bit(unsigned int console, int bit);
+void vt_set_kbd_mode_bit(unsigned int console, int bit);
+void vt_clr_kbd_mode_bit(unsigned int console, int bit);
+void vt_set_led_state(unsigned int console, int leds);
+void vt_kbd_con_start(unsigned int console);
+void vt_kbd_con_stop(unsigned int console);
 
 void vc_scrolldelta_helper(struct vc_data *c, int lines,
 		unsigned int rolled_over, void *_base, unsigned int size);
-- 
2.32.0

