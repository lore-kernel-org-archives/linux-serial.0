Return-Path: <SRS0=FKk9=EE=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A91C2D0A3
	for <linux-serial@archiver.kernel.org>; Thu, 29 Oct 2020 11:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACFDB20796
	for <linux-serial@archiver.kernel.org>; Thu, 29 Oct 2020 11:33:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbgJ2Lc2 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 29 Oct 2020 07:32:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:57128 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727398AbgJ2Lc1 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 29 Oct 2020 07:32:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 14DC9B21A;
        Thu, 29 Oct 2020 11:32:24 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 06/17] vt: keyboard, extract vt_kdgkbent and vt_kdskbent
Date:   Thu, 29 Oct 2020 12:32:11 +0100
Message-Id: <20201029113222.32640-6-jslaby@suse.cz>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201029113222.32640-1-jslaby@suse.cz>
References: <20201029113222.32640-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Split vt_do_kdsk_ioctl into three functions:
* getter (KDGKBENT/vt_kdgkbent)
* setter (KDSKBENT/vt_kdskbent)
* switch-case helper (vt_do_kdsk_ioctl)

This eliminates the need of ugly one-letter macros as we use parameters
now:
* i aka tmp.kb_index -> idx
* s aka tmp.kb_table -> map
* v aka tmp.kb_value -> val

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/keyboard.c | 189 ++++++++++++++++++++------------------
 1 file changed, 102 insertions(+), 87 deletions(-)

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index 4545afd3ef2f..c1709b8dbb52 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -1897,114 +1897,129 @@ int vt_do_kbkeycode_ioctl(int cmd, struct kbkeycode __user *user_kbkc,
 	return kc;
 }
 
-#define i (tmp.kb_index)
-#define s (tmp.kb_table)
-#define v (tmp.kb_value)
-
-int vt_do_kdsk_ioctl(int cmd, struct kbentry __user *user_kbe, int perm,
-						int console)
+static unsigned short vt_kdgkbent(unsigned char kbdmode, unsigned char idx,
+		unsigned char map)
 {
-	struct kbd_struct *kb = kbd_table + console;
-	struct kbentry tmp;
-	ushort *key_map, *new_map, val, ov;
+	unsigned short *key_map, val;
 	unsigned long flags;
 
-	if (copy_from_user(&tmp, user_kbe, sizeof(struct kbentry)))
-		return -EFAULT;
+	/* Ensure another thread doesn't free it under us */
+	spin_lock_irqsave(&kbd_event_lock, flags);
+	key_map = key_maps[map];
+	if (key_map) {
+		val = U(key_map[idx]);
+		if (kbdmode != VC_UNICODE && KTYP(val) >= NR_TYPES)
+			val = K_HOLE;
+	} else
+		val = idx ? K_HOLE : K_NOSUCHMAP;
+	spin_unlock_irqrestore(&kbd_event_lock, flags);
 
-	if (!capable(CAP_SYS_TTY_CONFIG))
-		perm = 0;
+	return val;
+}
 
-	switch (cmd) {
-	case KDGKBENT:
-		/* Ensure another thread doesn't free it under us */
+static int vt_kdskbent(unsigned char kbdmode, unsigned char idx,
+		unsigned char map, unsigned short val)
+{
+	unsigned long flags;
+	unsigned short *key_map, *new_map, oldval;
+
+	if (!idx && val == K_NOSUCHMAP) {
 		spin_lock_irqsave(&kbd_event_lock, flags);
-		key_map = key_maps[s];
-		if (key_map) {
-		    val = U(key_map[i]);
-		    if (kb->kbdmode != VC_UNICODE && KTYP(val) >= NR_TYPES)
-			val = K_HOLE;
-		} else
-		    val = (i ? K_HOLE : K_NOSUCHMAP);
-		spin_unlock_irqrestore(&kbd_event_lock, flags);
-		return put_user(val, &user_kbe->kb_value);
-	case KDSKBENT:
-		if (!perm)
-			return -EPERM;
-		if (!i && v == K_NOSUCHMAP) {
-			spin_lock_irqsave(&kbd_event_lock, flags);
-			/* deallocate map */
-			key_map = key_maps[s];
-			if (s && key_map) {
-			    key_maps[s] = NULL;
-			    if (key_map[0] == U(K_ALLOCATED)) {
-					kfree(key_map);
-					keymap_count--;
-			    }
+		/* deallocate map */
+		key_map = key_maps[map];
+		if (map && key_map) {
+			key_maps[map] = NULL;
+			if (key_map[0] == U(K_ALLOCATED)) {
+				kfree(key_map);
+				keymap_count--;
 			}
-			spin_unlock_irqrestore(&kbd_event_lock, flags);
-			break;
 		}
+		spin_unlock_irqrestore(&kbd_event_lock, flags);
 
-		if (KTYP(v) < NR_TYPES) {
-		    if (KVAL(v) > max_vals[KTYP(v)])
-				return -EINVAL;
-		} else
-		    if (kb->kbdmode != VC_UNICODE)
-				return -EINVAL;
+		return 0;
+	}
 
-		/* ++Geert: non-PC keyboards may generate keycode zero */
+	if (KTYP(val) < NR_TYPES) {
+		if (KVAL(val) > max_vals[KTYP(val)])
+			return -EINVAL;
+	} else if (kbdmode != VC_UNICODE)
+		return -EINVAL;
+
+	/* ++Geert: non-PC keyboards may generate keycode zero */
 #if !defined(__mc68000__) && !defined(__powerpc__)
-		/* assignment to entry 0 only tests validity of args */
-		if (!i)
-			break;
+	/* assignment to entry 0 only tests validity of args */
+	if (!idx)
+		return 0;
 #endif
 
-		new_map = kmalloc(sizeof(plain_map), GFP_KERNEL);
-		if (!new_map)
-			return -ENOMEM;
-		spin_lock_irqsave(&kbd_event_lock, flags);
-		key_map = key_maps[s];
-		if (key_map == NULL) {
-			int j;
-
-			if (keymap_count >= MAX_NR_OF_USER_KEYMAPS &&
-			    !capable(CAP_SYS_RESOURCE)) {
-				spin_unlock_irqrestore(&kbd_event_lock, flags);
-				kfree(new_map);
-				return -EPERM;
-			}
-			key_maps[s] = new_map;
-			key_map = new_map;
-			key_map[0] = U(K_ALLOCATED);
-			for (j = 1; j < NR_KEYS; j++)
-				key_map[j] = U(K_HOLE);
-			keymap_count++;
-		} else
-			kfree(new_map);
+	new_map = kmalloc(sizeof(plain_map), GFP_KERNEL);
+	if (!new_map)
+		return -ENOMEM;
 
-		ov = U(key_map[i]);
-		if (v == ov)
-			goto out;
-		/*
-		 * Attention Key.
-		 */
-		if (((ov == K_SAK) || (v == K_SAK)) && !capable(CAP_SYS_ADMIN)) {
+	spin_lock_irqsave(&kbd_event_lock, flags);
+	key_map = key_maps[map];
+	if (key_map == NULL) {
+		int j;
+
+		if (keymap_count >= MAX_NR_OF_USER_KEYMAPS &&
+		    !capable(CAP_SYS_RESOURCE)) {
 			spin_unlock_irqrestore(&kbd_event_lock, flags);
+			kfree(new_map);
 			return -EPERM;
 		}
-		key_map[i] = U(v);
-		if (!s && (KTYP(ov) == KT_SHIFT || KTYP(v) == KT_SHIFT))
-			do_compute_shiftstate();
-out:
+		key_maps[map] = new_map;
+		key_map = new_map;
+		key_map[0] = U(K_ALLOCATED);
+		for (j = 1; j < NR_KEYS; j++)
+			key_map[j] = U(K_HOLE);
+		keymap_count++;
+	} else
+		kfree(new_map);
+
+	oldval = U(key_map[idx]);
+	if (val == oldval)
+		goto out;
+
+	/* Attention Key */
+	if ((oldval == K_SAK || val == K_SAK) && !capable(CAP_SYS_ADMIN)) {
 		spin_unlock_irqrestore(&kbd_event_lock, flags);
-		break;
+		return -EPERM;
+	}
+
+	key_map[idx] = U(val);
+	if (!map && (KTYP(oldval) == KT_SHIFT || KTYP(val) == KT_SHIFT))
+		do_compute_shiftstate();
+out:
+	spin_unlock_irqrestore(&kbd_event_lock, flags);
+
+	return 0;
+}
+
+int vt_do_kdsk_ioctl(int cmd, struct kbentry __user *user_kbe, int perm,
+						int console)
+{
+	struct kbd_struct *kb = kbd_table + console;
+	struct kbentry kbe;
+
+	if (copy_from_user(&kbe, user_kbe, sizeof(struct kbentry)))
+		return -EFAULT;
+
+	if (!capable(CAP_SYS_TTY_CONFIG))
+		perm = 0;
+
+	switch (cmd) {
+	case KDGKBENT:
+		return put_user(vt_kdgkbent(kb->kbdmode, kbe.kb_index,
+					kbe.kb_table),
+				&user_kbe->kb_value);
+	case KDSKBENT:
+		if (!perm)
+			return -EPERM;
+		return vt_kdskbent(kb->kbdmode, kbe.kb_index, kbe.kb_table,
+				kbe.kb_value);
 	}
 	return 0;
 }
-#undef i
-#undef s
-#undef v
 
 /* FIXME: This one needs untangling */
 int vt_do_kdgkb_ioctl(int cmd, struct kbsentry __user *user_kdgkb, int perm)
-- 
2.29.1

