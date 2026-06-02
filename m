Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034E42F12DA;
	Tue,  2 Jun 2026 06:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780380998; cv=none; b=lIkbMhlT4KzkbsFUUkFzdnz9VCmoppybtH/76rm3EDM7JUFmjhyGfFTWavyyJHoyU16mtlHdWoeyvz90v4gB4OELG1nOokSh2Xz9siLnFJ2rtgim6jnYwrgXkPDnmAODmU+58mFvfARItCDnMlY2zIVa8GESBnmiXEx+JAZYX8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780380998; c=relaxed/simple;
	bh=TxAT14KY4V1e54Go+z7yx/OEh2avM/VxqfRDgcnwgTg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jf6uvW0SBBGbUPNLhRk2CZpdqgVriPG0inkv7QieAgy58GshgOzw2KZnkpStIGVbbHzbtHPEjTY50mtJaXv5DdyuzOZ0LxHVWr72WpfeUEr5mpmi4NTMibH2HOq3ngBMUkA5mwbUnzYeRFQL/6mGUTdtBn/YVW9SYZpGgaoAqtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=YD/Xam4C; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="YD/Xam4C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1780380950;
	bh=W4zMZbGM1u4rQ2i2xJ/N1vSmOkBH7Zl1+jBay0q+cA8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=YD/Xam4ClE3i4uAnf22BuQpJg4up/0GlHie7u2jsa/Kv91jtSt2nwWzdUKEtaZ7DW
	 T+92DYeGdQgQBo+31AWLMMkoa5IilXd/hKJLvfVF6PE0nyh227meGgYZVtIUE8plz4
	 53clw1YPPBVOptVzBiXI5a1IrwdpyxXVpLkiJiFQ=
X-QQ-mid: esmtpgz13t1780380944tcc8df94a
X-QQ-Originating-IP: Vbq9PzMEP8DCnlnpR3zfX0Nyff9rMlnSSgrnIAbVszY=
Received: from uos-PC ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 02 Jun 2026 14:15:42 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 7898087461314096188
EX-QQ-RecipientCnt: 7
From: Morduan Zang <zhangdandan@uniontech.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	syzbot+2932e8970a6398db95c3@syzkaller.appspotmail.com,
	Zhan Jun <zhanjun@uniontech.com>
Subject: [PATCH] tty: vt: hold tty reference for keyboard callbacks
Date: Tue,  2 Jun 2026 14:15:39 +0800
Message-ID: <5186FF3C10B2F8A0+20260602061539.1500845-1-zhangdandan@uniontech.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: Ns4o82esMDeg3Aga0uoCq2CdXzq7gY6QPdCZJp860kE4ZViMm2UmEYLB
	/LfHtqEYC6BPCG8nHVbUDHLsy5ofGapCJOV5c1SYK3pGq9Bq5zcuQ6F65pu4QikMr9wFi73
	PASIIRG3rWVVCOJcZlLt+SwISBuLepGVPM0CoHejDM8zBDGaMFaCB446Mzw1NKida13i2/9
	GzmkoiPh/NiGrKRoRbbWyBzDjJl+3d4g7TwriAFr7exqUoGj8a+QH8kq29K9+GBiY2EVYtO
	fZsLnn5m9Yq3xzqV9DTayn1UKQiUfJSsXKHglMPY7193nMv6smJUUlVUXkbjfb4qutgIkD8
	3P/1uyDI03maMdMosnEufoMOKQbLEo/iEdyn7s5VgsiSYSfDrsntr3Xh9gtX5I9KpZeosVQ
	lW1xu45rVIFmGVlTDvNQwJJRxk7Bp2ZaMgoah2pbR/LWLcga/spOC00dkYjqeO7fkl7N9OK
	JZFZh50xM8cod7tulRvJH9kK4JrnDGsad6lOM045fWYcc/A22LDdHvCQ5s/rLgEvzqmrn12
	aPaTNAt5T3TnE29ReOQO65hwU2ko60u11uz6RAH4ztHEZkNULNGjoUT7OERW8IukFZr/wAG
	I6Bh0rLKv9b7A3c5Kj+rVNO/fveVNlVyRjoa9/gsUl7EjUefgiJiTpXHVAuVGQ2k7ZcgpuH
	XON5vQ+f0KAhuH4c/JaS6nVgLPqxSoHn5z9hnX2+T/yHBIQxh4fFAXEvmYECaxvmrh9zXtd
	ELIk3sv0z3ua7TP2CKJvzRy+R+0NNzQkroyhF7rQXrfbc7ua8Ur+zK/Z4SasuiA9QCRcDyg
	woQRXW1A9Rq/8tmFb9aR3vdSGh3xTvwLX3smIZ7LIchh3cXzpGK2PbIqWs4VbnlHPnw3xj7
	bNau8vbCiV+jquNLjoiomJahP+RRbQWCI6F8AHTr+BwsepDzccS2UoRDpyTPoxkmvXoVq5k
	4UjOLmV+wQOz5hn7OSVe+CskRYDxIyv+mIvmyL0RBTBEF4t/jgRBee5ahTYht92KaAB5kHl
	kdh8dGBR1gg5PSE6Ur0dmeihYaZi3iImt28JaAfw6tSAZip5dc8vgqWdxOywaDx+JLbgaEA
	UnehDliUdSaqsi1S8SV9wk=
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0

From: Zhan Jun <zhanjun@uniontech.com>

syzbot reported a use-after-free in stop_tty() when the VT
keyboard path handles the hold key.

The keyboard event path reads vc->port.tty under kbd_event_lock,
but con_shutdown() clears the pointer under console_lock and the tty
can be released after the final close. The keyboard lock therefore
does not protect the tty lifetime.

Let the VT port own a tty reference by using tty_port_tty_set() when
installing and shutting down the console tty. Use tty_port_tty_get()
in the keyboard paths before dereferencing vc->port.tty and drop the
reference after the last use.

Reported-by: syzbot+2932e8970a6398db95c3@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/6a1dde0d.bd48a97d.14881d.0005.GAE@google.com/
Signed-off-by: Zhan Jun <zhanjun@uniontech.com>
---
 drivers/tty/vt/keyboard.c | 17 ++++++++++++-----
 drivers/tty/vt/vt.c       |  4 ++--
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index dfdea0842149..19f8df9706ee 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -509,9 +509,13 @@ static void fn_show_ptregs(struct vc_data *vc)
 
 static void fn_hold(struct vc_data *vc)
 {
-	struct tty_struct *tty = vc->port.tty;
+	struct tty_struct *tty;
+
+	if (rep)
+		return;
 
-	if (rep || !tty)
+	tty = tty_port_tty_get(&vc->port);
+	if (!tty)
 		return;
 
 	/*
@@ -523,6 +527,8 @@ static void fn_hold(struct vc_data *vc)
 		start_tty(tty);
 	else
 		stop_tty(tty);
+
+	tty_kref_put(tty);
 }
 
 static void fn_num(struct vc_data *vc)
@@ -1431,9 +1437,8 @@ static void kbd_keycode(unsigned int keycode, int down, bool hw_raw)
 	struct keyboard_notifier_param param = { .vc = vc, .value = keycode, .down = down };
 	int rc;
 
-	tty = vc->port.tty;
-
-	if (tty && (!tty->driver_data)) {
+	tty = tty_port_tty_get(&vc->port);
+	if (tty && !tty->driver_data) {
 		/* No driver data? Strange. Okay we fix it then. */
 		tty->driver_data = vc;
 	}
@@ -1486,6 +1491,7 @@ static void kbd_keycode(unsigned int keycode, int down, bool hw_raw)
 	if (rep &&
 	    (!vc_kbd_mode(kbd, VC_REPEAT) ||
 	     (tty && !L_ECHO(tty) && tty_chars_in_buffer(tty)))) {
+		tty_kref_put(tty);
 		/*
 		 * Don't repeat a key if the input buffers are not empty and the
 		 * characters get aren't echoed locally. This makes key repeat
@@ -1493,6 +1499,7 @@ static void kbd_keycode(unsigned int keycode, int down, bool hw_raw)
 		 */
 		return;
 	}
+	tty_kref_put(tty);
 
 	param.shift = shift_final = (shift_state | kbd->slockstate) ^ kbd->lockstate;
 	param.ledstate = kbd->ledflagstate;
diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index e99636ab9db5..ae191a1eaa05 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -3755,7 +3755,7 @@ static int con_install(struct tty_driver *driver, struct tty_struct *tty)
 		return ret;
 
 	tty->driver_data = vc;
-	vc->port.tty = tty;
+	tty_port_tty_set(&vc->port, tty);
 	tty_port_get(&vc->port);
 
 	if (!tty->winsize.ws_row && !tty->winsize.ws_col) {
@@ -3788,7 +3788,7 @@ static void con_shutdown(struct tty_struct *tty)
 	BUG_ON(vc == NULL);
 
 	guard(console_lock)();
-	vc->port.tty = NULL;
+	tty_port_tty_set(&vc->port, NULL);
 }
 
 static void con_cleanup(struct tty_struct *tty)
-- 
2.50.1

