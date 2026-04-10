Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD35D33B97B;
	Fri, 10 Apr 2026 06:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775804293; cv=none; b=r1n1iNKyNdd2I2KnChabBzAeptSDj4akSD8gURqYjSoTSHsYnWPb0Dz4+WEwgV4fVmRstS5zpdgkBDybOrwvACXghMsnkE+QSD9/ntshQRYsUUqckUj75VjtDxoQ02pBxGlvBYj5E1I0P9+JHWoFpGtts0QRV4Gn+wxvmeHkHd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775804293; c=relaxed/simple;
	bh=xA2gW7wXpn4YxPI2D7P4luml1/C25uBDzOPNKO049lI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qdkLQKnT3dLvuSrZG+Fysd2QRuQ5twK9FWonglucOQbaYrIIuwzeJAPB1X7txiRywQNSWKd6oqzczSz60Gsh0Sr6ZLycXurMnBwH0HHqbUXSasA6o1vg3cbL37OxJM8hmaVnPqOMtHxtlkooA84DUi6XVbqv3Wyxv+dPjqRJwzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=brqA+cWm; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="brqA+cWm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1775804232;
	bh=bdXbOBSdiYNaooYWFEjMRJAOXCpHyOyigp3X/npyfoc=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=brqA+cWmlGXt6NOKj85Aa6cUKc6wFbvhIQBHoWl/aSICVgVooCyw6Cbc3HoeMmal+
	 muprxPI/u4UmAuPUmG5Tck3+D1LTwln6uLsezD9KB6ao7NTJ7fDg0bfs9ZmYRJ/3NC
	 nLcOhgee3+1AMVyUTZx4SOMxphhham3vO2gXMi7g=
X-QQ-mid: zesmtpip2t1775804212t30b9b0a3
X-QQ-Originating-IP: HN6CtUCoopqpY+ZjzgN1uhPZN7+SvdCNayGlbl+ifzI=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 10 Apr 2026 14:56:50 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 9673448165968515217
EX-QQ-RecipientCnt: 9
From: Wentao Guan <guanwentao@uniontech.com>
To: syzbot+098cefc0911c68db5dab@syzkaller.appspotmail.com
Cc: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	Wentao Guan <guanwentao@uniontech.com>,
	stable@kernel.org,
	syzbot+702b7f311487703dbb18@syzkaller.appspotmail.com
Subject: [PATCH RFC] vt: tty: use krefs to fix a potential UAF between kbd_keycode and con_shutdown
Date: Fri, 10 Apr 2026 14:55:46 +0800
Message-Id: <20260410065546.2106592-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <69d56a91.050a0220.28fc4.0003.GAE@google.com>
References: <69d56a91.050a0220.28fc4.0003.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: OapYA5sB218sEpuTm9BEfqB+nrc2XuX6TDUv7AJ6E3QhUtSLCpVVpiEb
	3YJ6kaWtk2/miyvwOnazMvqdkha6ZOeQ/kNj5tkiV0K1+4PITo1yQDUXtHmsYXPOiihaRip
	l6ANOI0e+5/alyzFz37rY0BPw+laHQnOPHSw0AeAgV6hU3vVjEwJuGj/YthQ4FUUWs0aw7M
	WvJPGPZv7wl0qGrPnwqEilC7UZXs7q3BoNdvfYxFEbmcSmrnOQ2nBkN6FrgvgPOBYwblqJ3
	g7d5pPDtGrmHz5Z9nDFeigDcpokgGkm8hrNCEBPqtBHGnmaiAu00N2cJqKoD+kxbqSbbEQt
	5vKXM0KbgO4HT3wo8d2lb5Anl7KhqorHLW0uUgE02NGTEB8sNIzKhg9l3y+dJxFn4ubsNNT
	6OhBN3NmZzPkSlais/8lCmvSAgPgX4tolN1OJAl8cuA+n6uWHVkuvYKOaHK2bdOh9yJUvp2
	DMnoGfVGas0RxHQKWIiR1s1Zu4/1rNsno2HOXcxj37FPW0lez7JGc1mRh4Ble4xUnhLS2PR
	ggjhXVN/0Nl+fg+QvB+UbDroygYMSeVxvBnWhY2EqWcycXLlTkmiBhFJLTIPq+nGU4xFQi9
	L4TcefLq8B9DHcD5dMzSm+zhuWE41IKhp2RNrOE/WByKmCWMHPUdyXGQKH3IJFcXZqoNJym
	FH1oWILJ+KnygkgNINHShp52hqtliUDZuKtuLKnhG/abXxBz2GMYfVNKB5qHMJ2X6phfi3k
	om5FGXk2rE+S6QomlKq9nk9FwWMi42VSnPd0Br9xpoxWi/oa8WMvXM6Z5JT95b7UF+e5hey
	EhfsAUcr9k/A+0sVVyTqedOy2VEwbHClArUx8VCq+kWi4UIcXTUyU01k86Aes9v12G05khy
	+RMv1+nKdR5Cj6w1XbAPEE3MjbhF3uNjkQS7n/4g1QeP7r9IomPxGrWGyKMME5pbyhrqTuB
	4hkRVtCmbNKaNJJASjf6GyIJieTVqqevO066SHTTqNpSO4hQslONdLWzVxa8+s1Rxr70koo
	UZjg4+/zli3r1D62uqWWs+c0QmjyTA+puw7eDfMkmX/FujmLH7
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0

syzbot report an KASAN: slab-use-after-free Read in kbd_event (2),
which allocated by alloc_tty_struct->tty_init_dev, accessed by kbd_keycode,
released by tty_release_struct:
tty_release_struct->release_tty->tty->ops->shutdown->con_shutdown.
accessed by
kbd_keycode drivers/tty/vt/keyboard.c:1435
kbd_event+0x3330/0x40d0 drivers/tty/vt/keyboard.c:1515

Use tty_port_tty_get to get a tty ref in kbd_keycode to prevent the UAF,
tty_release_struct use console_lock not protect access tty_struct from
kbd_keycode or another function, so convert it to tty_port_tty_set in
con_install, con_shutdown.

The change is similar as
commit 4a90f09b20f4622dcbff1f0e1e6bae1704f8ad8c ("tty: usb-serial krefs").

Maybe reproduce in:
CPU A		CPU B		CPU C
open /dev/tty
		close /dev/tty
				tty!=NULL
		release_tty()
				access tty_struct

Cc: stable@kernel.org
Reported-by: syzbot+098cefc0911c68db5dab@syzkaller.appspotmail.com
Closes: https://syzbot.org/bug?extid=098cefc0911c68db5dab
Reported-by: syzbot+702b7f311487703dbb18@syzkaller.appspotmail.com
Closes: https://syzbot.org/bug?extid=702b7f311487703dbb18
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
 drivers/tty/vt/keyboard.c | 20 +++++++++++++-------
 drivers/tty/vt/vt.c       |  5 ++---
 2 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index 13bc048f45e86..173c447525ff8 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -517,6 +517,10 @@ static void fn_hold(struct vc_data *vc)
 	 * Note: SCROLLOCK will be set (cleared) by stop_tty (start_tty);
 	 * these routines are also activated by ^S/^Q.
 	 * (And SCROLLOCK can also be set by the ioctl KDSKBLED.)
+	 *
+	 * kbd_keycode(), only from kbd_keycode via k_handler[], already holds a
+	 * reference to the tty via tty_port_tty_get(), so we can safely
+	 * access port->tty here without an extra kref.
 	 */
 	if (tty->flow.stopped)
 		start_tty(tty);
@@ -1378,7 +1382,7 @@ static void kbd_keycode(unsigned int keycode, int down, bool hw_raw)
 	struct keyboard_notifier_param param = { .vc = vc, .value = keycode, .down = down };
 	int rc;
 
-	tty = vc->port.tty;
+	tty = tty_port_tty_get(&vc->port);
 
 	if (tty && (!tty->driver_data)) {
 		/* No driver data? Strange. Okay we fix it then. */
@@ -1438,7 +1442,7 @@ static void kbd_keycode(unsigned int keycode, int down, bool hw_raw)
 		 * characters get aren't echoed locally. This makes key repeat
 		 * usable with slow applications and under heavy loads.
 		 */
-		return;
+		goto out;
 	}
 
 	param.shift = shift_final = (shift_state | kbd->slockstate) ^ kbd->lockstate;
@@ -1452,7 +1456,7 @@ static void kbd_keycode(unsigned int keycode, int down, bool hw_raw)
 					   KBD_UNBOUND_KEYCODE, &param);
 		do_compute_shiftstate();
 		kbd->slockstate = 0;
-		return;
+		goto out;
 	}
 
 	if (keycode < NR_KEYS)
@@ -1460,7 +1464,7 @@ static void kbd_keycode(unsigned int keycode, int down, bool hw_raw)
 	else if (keycode >= KEY_BRL_DOT1 && keycode <= KEY_BRL_DOT8)
 		keysym = U(K(KT_BRL, keycode - KEY_BRL_DOT1 + 1));
 	else
-		return;
+		goto out;
 
 	type = KTYP(keysym);
 
@@ -1471,7 +1475,7 @@ static void kbd_keycode(unsigned int keycode, int down, bool hw_raw)
 		if (rc != NOTIFY_STOP)
 			if (down && !(raw_mode || kbd->kbdmode == VC_OFF))
 				k_unicode(vc, keysym, !down);
-		return;
+		goto out;
 	}
 
 	type -= 0xf0;
@@ -1489,10 +1493,10 @@ static void kbd_keycode(unsigned int keycode, int down, bool hw_raw)
 	rc = atomic_notifier_call_chain(&keyboard_notifier_list,
 					KBD_KEYSYM, &param);
 	if (rc == NOTIFY_STOP)
-		return;
+		goto out;
 
 	if ((raw_mode || kbd->kbdmode == VC_OFF) && type != KT_SPEC && type != KT_SHIFT)
-		return;
+		goto out;
 
 	(*k_handler[type])(vc, KVAL(keysym), !down);
 
@@ -1501,6 +1505,8 @@ static void kbd_keycode(unsigned int keycode, int down, bool hw_raw)
 
 	if (type != KT_SLOCK)
 		kbd->slockstate = 0;
+out:
+	tty_kref_put(tty);
 }
 
 static void kbd_event(struct input_handle *handle, unsigned int event_type,
diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index e2df99e3d4580..acded112cae2b 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -3661,7 +3661,7 @@ static int con_install(struct tty_driver *driver, struct tty_struct *tty)
 		return ret;
 
 	tty->driver_data = vc;
-	vc->port.tty = tty;
+	tty_port_tty_set(&vc->port, tty);
 	tty_port_get(&vc->port);
 
 	if (!tty->winsize.ws_row && !tty->winsize.ws_col) {
@@ -3693,8 +3693,7 @@ static void con_shutdown(struct tty_struct *tty)
 	struct vc_data *vc = tty->driver_data;
 	BUG_ON(vc == NULL);
 
-	guard(console_lock)();
-	vc->port.tty = NULL;
+	tty_port_tty_set(&vc->port, NULL);
 }
 
 static void con_cleanup(struct tty_struct *tty)
-- 
2.30.2

