Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C269347BBA;
	Wed, 19 Nov 2025 10:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763546520; cv=none; b=WNfYOIADSguyRGbvUDe6buHx7CUJEkflQ/IN3my14yu+4eNgYVT7VsecqAx0C3e2TwNSfQdhG4XT6uVEd6wr0NkX+N7ysV0owP+nmLOD5j71hhtZ6rsCfPJfUNt+b+bAPEEnK9NAhMBwDO1oiTFBGovYU01a853ZfYDC5fTQVbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763546520; c=relaxed/simple;
	bh=ctvkVb4Cz5cFYM3db5OiLbVUlzMMeDUOeX9CsDNxdlM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gBpP+tEeg9GHEjOL5BDvXPLtg1Gel6FsIAPnFXAIuMjabVhx8cwrX0+U1w0XLruQGGubC6hL65MM2Hys71KLQsCeX74ifIE1ZIgKFMJZxlPMmGEsiF8vC9Cu4HBxP5J3BFTgh72gS5auW/28o1BqiarXepJAEj3hRLCbdPIWyRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uFUrzRoy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uFUrzRoy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C83BC4CEF5;
	Wed, 19 Nov 2025 10:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763546519;
	bh=ctvkVb4Cz5cFYM3db5OiLbVUlzMMeDUOeX9CsDNxdlM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uFUrzRoyYC7zE3nDK7NyD4o8GfoilaXFe8bpLVCMmkNBCeAy05KMvh8dsJlGVAaPJ
	 dI9GkoB931yaDKgXA5+wvFSWGjd1fTjee7y/52WwM6JrpoRbS4AORpyM978Hgf0QFj
	 oX+DLm3M64Xux/4SzoI+IsD7h1F8XE9mWUlzLvIlKsOKoUZjR30QGZ9vZ8ml0gDYml
	 NU//YWWYRaRMIRnt8Fj8Egm4M/dCHgBRFXuTy9GuCdBH+0z7D4KrxpDkXtOGlTkLKI
	 zrOtZY/cR3gbgr8wBsyvb06Ozrttr5/pjzuIGvMJ/u1PfHAt/Jclnveb9+7nhOS/VK
	 CtXmGVrC7ISsA==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 08/10] tty: vt/keyboard: use guard()s
Date: Wed, 19 Nov 2025 11:01:38 +0100
Message-ID: <20251119100140.830761-9-jirislaby@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251119100140.830761-1-jirislaby@kernel.org>
References: <20251119100140.830761-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use guards in the vt/keyboard code. This improves readability, makes
error handling easier, and marks locked portions of code explicit. All
that while being sure the lock is unlocked.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/vt/keyboard.c | 210 ++++++++++++++------------------------
 1 file changed, 74 insertions(+), 136 deletions(-)

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index 487518a696e6..d65fc60dd7be 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -424,8 +424,6 @@ static void do_compute_shiftstate(void)
 /* We still have to export this method to vt.c */
 void vt_set_leds_compute_shiftstate(void)
 {
-	unsigned long flags;
-
 	/*
 	 * When VT is switched, the keyboard led needs to be set once.
 	 * Ensure that after the switch is completed, the state of the
@@ -434,9 +432,8 @@ void vt_set_leds_compute_shiftstate(void)
 	vt_switch = true;
 	set_leds();
 
-	spin_lock_irqsave(&kbd_event_lock, flags);
+	guard(spinlock_irqsave)(&kbd_event_lock);
 	do_compute_shiftstate();
-	spin_unlock_irqrestore(&kbd_event_lock, flags);
 }
 
 /*
@@ -625,13 +622,12 @@ static void fn_compose(struct vc_data *vc)
 
 static void fn_spawn_con(struct vc_data *vc)
 {
-	spin_lock(&vt_spawn_con.lock);
+	guard(spinlock)(&vt_spawn_con.lock);
 	if (vt_spawn_con.pid)
 		if (kill_pid(vt_spawn_con.pid, vt_spawn_con.sig, 1)) {
 			put_pid(vt_spawn_con.pid);
 			vt_spawn_con.pid = NULL;
 		}
-	spin_unlock(&vt_spawn_con.lock);
 }
 
 static void fn_SAK(struct vc_data *vc)
@@ -762,13 +758,9 @@ static void k_fn(struct vc_data *vc, unsigned char value, char up_flag)
 		return;
 
 	if ((unsigned)value < ARRAY_SIZE(func_table)) {
-		unsigned long flags;
-
-		spin_lock_irqsave(&func_buf_lock, flags);
+		guard(spinlock_irqsave)(&func_buf_lock);
 		if (func_table[value])
 			puts_queue(vc, func_table[value]);
-		spin_unlock_irqrestore(&func_buf_lock, flags);
-
 	} else
 		pr_err("k_fn called with value=%d\n", value);
 }
@@ -1140,8 +1132,7 @@ static unsigned char getledstate(void)
 
 void setledstate(struct kbd_struct *kb, unsigned int led)
 {
-        unsigned long flags;
-        spin_lock_irqsave(&led_lock, flags);
+	guard(spinlock_irqsave)(&led_lock);
 	if (!(led & ~7)) {
 		ledioctl = led;
 		kb->ledmode = LED_SHOW_IOCTL;
@@ -1149,7 +1140,6 @@ void setledstate(struct kbd_struct *kb, unsigned int led)
 		kb->ledmode = LED_SHOW_FLAGS;
 
 	set_leds();
-	spin_unlock_irqrestore(&led_lock, flags);
 }
 
 static inline unsigned char getleds(void)
@@ -1172,14 +1162,9 @@ static inline unsigned char getleds(void)
 int vt_get_leds(unsigned int console, int flag)
 {
 	struct kbd_struct *kb = &kbd_table[console];
-	int ret;
-	unsigned long flags;
 
-	spin_lock_irqsave(&led_lock, flags);
-	ret = vc_kbd_led(kb, flag);
-	spin_unlock_irqrestore(&led_lock, flags);
-
-	return ret;
+	guard(spinlock_irqsave)(&led_lock);
+	return vc_kbd_led(kb, flag);
 }
 EXPORT_SYMBOL_GPL(vt_get_leds);
 
@@ -1213,11 +1198,10 @@ void vt_set_led_state(unsigned int console, int leds)
 void vt_kbd_con_start(unsigned int console)
 {
 	struct kbd_struct *kb = &kbd_table[console];
-	unsigned long flags;
-	spin_lock_irqsave(&led_lock, flags);
+
+	guard(spinlock_irqsave)(&led_lock);
 	clr_vc_kbd_led(kb, VC_SCROLLOCK);
 	set_leds();
-	spin_unlock_irqrestore(&led_lock, flags);
 }
 
 /**
@@ -1230,11 +1214,10 @@ void vt_kbd_con_start(unsigned int console)
 void vt_kbd_con_stop(unsigned int console)
 {
 	struct kbd_struct *kb = &kbd_table[console];
-	unsigned long flags;
-	spin_lock_irqsave(&led_lock, flags);
+
+	guard(spinlock_irqsave)(&led_lock);
 	set_vc_kbd_led(kb, VC_SCROLLOCK);
 	set_leds();
-	spin_unlock_irqrestore(&led_lock, flags);
 }
 
 /*
@@ -1246,12 +1229,11 @@ void vt_kbd_con_stop(unsigned int console)
 static void kbd_bh(struct tasklet_struct *unused)
 {
 	unsigned int leds;
-	unsigned long flags;
 
-	spin_lock_irqsave(&led_lock, flags);
-	leds = getleds();
-	leds |= (unsigned int)kbd->lockstate << 8;
-	spin_unlock_irqrestore(&led_lock, flags);
+	scoped_guard(spinlock_irqsave, &led_lock) {
+		leds = getleds();
+		leds |= (unsigned int)kbd->lockstate << 8;
+	}
 
 	if (vt_switch) {
 		ledstate = ~leds;
@@ -1525,15 +1507,13 @@ static void kbd_event(struct input_handle *handle, unsigned int event_type,
 		      unsigned int event_code, int value)
 {
 	/* We are called with interrupts disabled, just take the lock */
-	spin_lock(&kbd_event_lock);
-
-	if (event_type == EV_MSC && event_code == MSC_RAW &&
-			kbd_is_hw_raw(handle->dev))
-		kbd_rawcode(value);
-	if (event_type == EV_KEY && event_code <= KEY_MAX)
-		kbd_keycode(event_code, value, kbd_is_hw_raw(handle->dev));
-
-	spin_unlock(&kbd_event_lock);
+	scoped_guard(spinlock, &kbd_event_lock) {
+		if (event_type == EV_MSC && event_code == MSC_RAW &&
+				kbd_is_hw_raw(handle->dev))
+			kbd_rawcode(value);
+		if (event_type == EV_KEY && event_code <= KEY_MAX)
+			kbd_keycode(event_code, value, kbd_is_hw_raw(handle->dev));
+	}
 
 	tasklet_schedule(&keyboard_tasklet);
 	do_poke_blanked_console = 1;
@@ -1680,7 +1660,6 @@ int __init kbd_init(void)
  */
 int vt_do_diacrit(unsigned int cmd, void __user *udp, int perm)
 {
-	unsigned long flags;
 	int asize;
 
 	switch (cmd) {
@@ -1696,18 +1675,14 @@ int vt_do_diacrit(unsigned int cmd, void __user *udp, int perm)
 
 		/* Lock the diacriticals table, make a copy and then
 		   copy it after we unlock */
-		spin_lock_irqsave(&kbd_event_lock, flags);
-
-		asize = accent_table_size;
-		for (i = 0; i < asize; i++) {
-			dia[i].diacr = conv_uni_to_8bit(
-						accent_table[i].diacr);
-			dia[i].base = conv_uni_to_8bit(
-						accent_table[i].base);
-			dia[i].result = conv_uni_to_8bit(
-						accent_table[i].result);
+		scoped_guard(spinlock_irqsave, &kbd_event_lock) {
+			asize = accent_table_size;
+			for (i = 0; i < asize; i++) {
+				dia[i].diacr = conv_uni_to_8bit(accent_table[i].diacr);
+				dia[i].base = conv_uni_to_8bit(accent_table[i].base);
+				dia[i].result = conv_uni_to_8bit(accent_table[i].result);
+			}
 		}
-		spin_unlock_irqrestore(&kbd_event_lock, flags);
 
 		if (put_user(asize, &a->kb_cnt))
 			return -EFAULT;
@@ -1726,12 +1701,10 @@ int vt_do_diacrit(unsigned int cmd, void __user *udp, int perm)
 
 		/* Lock the diacriticals table, make a copy and then
 		   copy it after we unlock */
-		spin_lock_irqsave(&kbd_event_lock, flags);
-
-		asize = accent_table_size;
-		memcpy(buf, accent_table, asize * sizeof(struct kbdiacruc));
-
-		spin_unlock_irqrestore(&kbd_event_lock, flags);
+		scoped_guard(spinlock_irqsave, &kbd_event_lock) {
+			asize = accent_table_size;
+			memcpy(buf, accent_table, asize * sizeof(struct kbdiacruc));
+		}
 
 		if (put_user(asize, &a->kb_cnt))
 			return -EFAULT;
@@ -1762,7 +1735,7 @@ int vt_do_diacrit(unsigned int cmd, void __user *udp, int perm)
 				return PTR_ERR(dia);
 		}
 
-		spin_lock_irqsave(&kbd_event_lock, flags);
+		guard(spinlock_irqsave)(&kbd_event_lock);
 		accent_table_size = ct;
 		for (i = 0; i < ct; i++) {
 			accent_table[i].diacr =
@@ -1772,7 +1745,6 @@ int vt_do_diacrit(unsigned int cmd, void __user *udp, int perm)
 			accent_table[i].result =
 					conv_8bit_to_uni(dia[i].result);
 		}
-		spin_unlock_irqrestore(&kbd_event_lock, flags);
 
 		return 0;
 	}
@@ -1797,13 +1769,12 @@ int vt_do_diacrit(unsigned int cmd, void __user *udp, int perm)
 						ct, sizeof(struct kbdiacruc));
 			if (IS_ERR(buf))
 				return PTR_ERR(buf);
-		} 
-		spin_lock_irqsave(&kbd_event_lock, flags);
+		}
+		guard(spinlock_irqsave)(&kbd_event_lock);
 		if (ct)
 			memcpy(accent_table, buf,
 					ct * sizeof(struct kbdiacruc));
 		accent_table_size = ct;
-		spin_unlock_irqrestore(&kbd_event_lock, flags);
 		return 0;
 	}
 	}
@@ -1821,33 +1792,29 @@ int vt_do_diacrit(unsigned int cmd, void __user *udp, int perm)
 int vt_do_kdskbmode(unsigned int console, unsigned int arg)
 {
 	struct kbd_struct *kb = &kbd_table[console];
-	int ret = 0;
-	unsigned long flags;
 
-	spin_lock_irqsave(&kbd_event_lock, flags);
+	guard(spinlock_irqsave)(&kbd_event_lock);
 	switch(arg) {
 	case K_RAW:
 		kb->kbdmode = VC_RAW;
-		break;
+		return 0;
 	case K_MEDIUMRAW:
 		kb->kbdmode = VC_MEDIUMRAW;
-		break;
+		return 0;
 	case K_XLATE:
 		kb->kbdmode = VC_XLATE;
 		do_compute_shiftstate();
-		break;
+		return 0;
 	case K_UNICODE:
 		kb->kbdmode = VC_UNICODE;
 		do_compute_shiftstate();
-		break;
+		return 0;
 	case K_OFF:
 		kb->kbdmode = VC_OFF;
-		break;
+		return 0;
 	default:
-		ret = -EINVAL;
+		return -EINVAL;
 	}
-	spin_unlock_irqrestore(&kbd_event_lock, flags);
-	return ret;
 }
 
 /**
@@ -1861,22 +1828,18 @@ int vt_do_kdskbmode(unsigned int console, unsigned int arg)
 int vt_do_kdskbmeta(unsigned int console, unsigned int arg)
 {
 	struct kbd_struct *kb = &kbd_table[console];
-	int ret = 0;
-	unsigned long flags;
 
-	spin_lock_irqsave(&kbd_event_lock, flags);
+	guard(spinlock_irqsave)(&kbd_event_lock);
 	switch(arg) {
 	case K_METABIT:
 		clr_vc_kbd_mode(kb, VC_META);
-		break;
+		return 0;
 	case K_ESCPREFIX:
 		set_vc_kbd_mode(kb, VC_META);
-		break;
+		return 0;
 	default:
-		ret = -EINVAL;
+		return -EINVAL;
 	}
-	spin_unlock_irqrestore(&kbd_event_lock, flags);
-	return ret;
 }
 
 int vt_do_kbkeycode_ioctl(int cmd, struct kbkeycode __user *user_kbkc, int perm)
@@ -1905,31 +1868,28 @@ int vt_do_kbkeycode_ioctl(int cmd, struct kbkeycode __user *user_kbkc, int perm)
 static unsigned short vt_kdgkbent(unsigned char kbdmode, unsigned char idx,
 		unsigned char map)
 {
-	unsigned short *key_map, val;
-	unsigned long flags;
+	unsigned short *key_map;
 
 	/* Ensure another thread doesn't free it under us */
-	spin_lock_irqsave(&kbd_event_lock, flags);
+	guard(spinlock_irqsave)(&kbd_event_lock);
 	key_map = key_maps[map];
 	if (key_map) {
-		val = U(key_map[idx]);
+		unsigned short val = U(key_map[idx]);
 		if (kbdmode != VC_UNICODE && KTYP(val) >= NR_TYPES)
-			val = K_HOLE;
-	} else
-		val = idx ? K_HOLE : K_NOSUCHMAP;
-	spin_unlock_irqrestore(&kbd_event_lock, flags);
+			return K_HOLE;
+		return val;
+	}
 
-	return val;
+	return idx ? K_HOLE : K_NOSUCHMAP;
 }
 
 static int vt_kdskbent(unsigned char kbdmode, unsigned char idx,
 		unsigned char map, unsigned short val)
 {
-	unsigned long flags;
 	unsigned short *key_map, oldval;
 
 	if (!idx && val == K_NOSUCHMAP) {
-		spin_lock_irqsave(&kbd_event_lock, flags);
+		guard(spinlock_irqsave)(&kbd_event_lock);
 		/* deallocate map */
 		key_map = key_maps[map];
 		if (map && key_map) {
@@ -1939,7 +1899,6 @@ static int vt_kdskbent(unsigned char kbdmode, unsigned char idx,
 				keymap_count--;
 			}
 		}
-		spin_unlock_irqrestore(&kbd_event_lock, flags);
 
 		return 0;
 	}
@@ -1961,16 +1920,14 @@ static int vt_kdskbent(unsigned char kbdmode, unsigned char idx,
 	if (!new_map)
 		return -ENOMEM;
 
-	spin_lock_irqsave(&kbd_event_lock, flags);
+	guard(spinlock_irqsave)(&kbd_event_lock);
 	key_map = key_maps[map];
 	if (key_map == NULL) {
 		int j;
 
-		if (keymap_count >= MAX_NR_OF_USER_KEYMAPS &&
-		    !capable(CAP_SYS_RESOURCE)) {
-			spin_unlock_irqrestore(&kbd_event_lock, flags);
+		if (keymap_count >= MAX_NR_OF_USER_KEYMAPS && !capable(CAP_SYS_RESOURCE))
 			return -EPERM;
-		}
+
 		key_map = key_maps[map] = no_free_ptr(new_map);
 		key_map[0] = U(K_ALLOCATED);
 		for (j = 1; j < NR_KEYS; j++)
@@ -1980,19 +1937,15 @@ static int vt_kdskbent(unsigned char kbdmode, unsigned char idx,
 
 	oldval = U(key_map[idx]);
 	if (val == oldval)
-		goto out;
+		return 0;
 
 	/* Attention Key */
-	if ((oldval == K_SAK || val == K_SAK) && !capable(CAP_SYS_ADMIN)) {
-		spin_unlock_irqrestore(&kbd_event_lock, flags);
+	if ((oldval == K_SAK || val == K_SAK) && !capable(CAP_SYS_ADMIN))
 		return -EPERM;
-	}
 
 	key_map[idx] = U(val);
 	if (!map && (KTYP(oldval) == KT_SHIFT || KTYP(val) == KT_SHIFT))
 		do_compute_shiftstate();
-out:
-	spin_unlock_irqrestore(&kbd_event_lock, flags);
 
 	return 0;
 }
@@ -2038,7 +1991,6 @@ static char *vt_kdskbsent(char *kbs, unsigned char cur)
 int vt_do_kdgkb_ioctl(int cmd, struct kbsentry __user *user_kdgkb, int perm)
 {
 	unsigned char kb_func;
-	unsigned long flags;
 
 	if (get_user(kb_func, &user_kdgkb->kb_func))
 		return -EFAULT;
@@ -2054,9 +2006,8 @@ int vt_do_kdgkb_ioctl(int cmd, struct kbsentry __user *user_kdgkb, int perm)
 		if (!kbs)
 			return -ENOMEM;
 
-		spin_lock_irqsave(&func_buf_lock, flags);
-		len = strscpy(kbs, func_table[kb_func] ? : "", len);
-		spin_unlock_irqrestore(&func_buf_lock, flags);
+		scoped_guard(spinlock_irqsave, &func_buf_lock)
+			len = strscpy(kbs, func_table[kb_func] ? : "", len);
 
 		if (len < 0)
 			return -ENOSPC;
@@ -2075,9 +2026,8 @@ int vt_do_kdgkb_ioctl(int cmd, struct kbsentry __user *user_kdgkb, int perm)
 		if (IS_ERR(kbs))
 			return PTR_ERR(kbs);
 
-		spin_lock_irqsave(&func_buf_lock, flags);
+		guard(spinlock_irqsave)(&func_buf_lock);
 		kbs = vt_kdskbsent(kbs, kb_func);
-		spin_unlock_irqrestore(&func_buf_lock, flags);
 
 		return 0;
 	}
@@ -2088,16 +2038,14 @@ int vt_do_kdgkb_ioctl(int cmd, struct kbsentry __user *user_kdgkb, int perm)
 int vt_do_kdskled(unsigned int console, int cmd, unsigned long arg, int perm)
 {
 	struct kbd_struct *kb = &kbd_table[console];
-        unsigned long flags;
 	unsigned char ucval;
 
         switch(cmd) {
 	/* the ioctls below read/set the flags usually shown in the leds */
 	/* don't use them - they will go away without warning */
 	case KDGKBLED:
-                spin_lock_irqsave(&kbd_event_lock, flags);
-		ucval = kb->ledflagstate | (kb->default_ledflagstate << 4);
-                spin_unlock_irqrestore(&kbd_event_lock, flags);
+		scoped_guard(spinlock_irqsave, &kbd_event_lock)
+			ucval = kb->ledflagstate | (kb->default_ledflagstate << 4);
 		return put_user(ucval, (char __user *)arg);
 
 	case KDSKBLED:
@@ -2105,11 +2053,11 @@ int vt_do_kdskled(unsigned int console, int cmd, unsigned long arg, int perm)
 			return -EPERM;
 		if (arg & ~0x77)
 			return -EINVAL;
-                spin_lock_irqsave(&led_lock, flags);
-		kb->ledflagstate = (arg & 7);
-		kb->default_ledflagstate = ((arg >> 4) & 7);
-		set_leds();
-                spin_unlock_irqrestore(&led_lock, flags);
+		scoped_guard(spinlock_irqsave, &led_lock) {
+			kb->ledflagstate = (arg & 7);
+			kb->default_ledflagstate = ((arg >> 4) & 7);
+			set_leds();
+		}
 		return 0;
 
 	/* the ioctls below only set the lights, not the functions */
@@ -2166,11 +2114,8 @@ int vt_do_kdgkbmeta(unsigned int console)
  */
 void vt_reset_unicode(unsigned int console)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&kbd_event_lock, flags);
+	guard(spinlock_irqsave)(&kbd_event_lock);
 	kbd_table[console].kbdmode = default_utf8 ? VC_UNICODE : VC_XLATE;
-	spin_unlock_irqrestore(&kbd_event_lock, flags);
 }
 
 /**
@@ -2195,22 +2140,19 @@ int vt_get_shift_state(void)
 void vt_reset_keyboard(unsigned int console)
 {
 	struct kbd_struct *kb = &kbd_table[console];
-	unsigned long flags;
 
-	spin_lock_irqsave(&kbd_event_lock, flags);
+	guard(spinlock_irqsave)(&kbd_event_lock);
 	set_vc_kbd_mode(kb, VC_REPEAT);
 	clr_vc_kbd_mode(kb, VC_CKMODE);
 	clr_vc_kbd_mode(kb, VC_APPLIC);
 	clr_vc_kbd_mode(kb, VC_CRLF);
 	kb->lockstate = 0;
 	kb->slockstate = 0;
-	spin_lock(&led_lock);
+	guard(spinlock)(&led_lock);
 	kb->ledmode = LED_SHOW_FLAGS;
 	kb->ledflagstate = kb->default_ledflagstate;
-	spin_unlock(&led_lock);
 	/* do not do set_leds here because this causes an endless tasklet loop
 	   when the keyboard hasn't been initialized yet */
-	spin_unlock_irqrestore(&kbd_event_lock, flags);
 }
 
 /**
@@ -2240,11 +2182,9 @@ int vt_get_kbd_mode_bit(unsigned int console, int bit)
 void vt_set_kbd_mode_bit(unsigned int console, int bit)
 {
 	struct kbd_struct *kb = &kbd_table[console];
-	unsigned long flags;
 
-	spin_lock_irqsave(&kbd_event_lock, flags);
+	guard(spinlock_irqsave)(&kbd_event_lock);
 	set_vc_kbd_mode(kb, bit);
-	spin_unlock_irqrestore(&kbd_event_lock, flags);
 }
 
 /**
@@ -2259,9 +2199,7 @@ void vt_set_kbd_mode_bit(unsigned int console, int bit)
 void vt_clr_kbd_mode_bit(unsigned int console, int bit)
 {
 	struct kbd_struct *kb = &kbd_table[console];
-	unsigned long flags;
 
-	spin_lock_irqsave(&kbd_event_lock, flags);
+	guard(spinlock_irqsave)(&kbd_event_lock);
 	clr_vc_kbd_mode(kb, bit);
-	spin_unlock_irqrestore(&kbd_event_lock, flags);
 }
-- 
2.51.1

