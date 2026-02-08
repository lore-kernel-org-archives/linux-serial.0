Received: from devnull.danielhodges.dev (vps-2f6e086e.vps.ovh.us [135.148.138.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EF41CEAC2;
	Sun,  8 Feb 2026 00:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=135.148.138.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770510674; cv=none; b=qWHfKfqPI7KzxYKr5ViGuTTXK+7YAOGpYS7rxaWpby6R+2MFGi5jGN9CBYNcYvl+Y6h5qqR3tOR6O++VqliAx7pG7lSofqSfjsu3IzPA2MYiiCPB5r9VXKoLZ4I35fqdciw5GwuLLDtNnRVM/20GkevmWN7wXxupEiJfNbqo+fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770510674; c=relaxed/simple;
	bh=c3Fc67UyYIw03s54J4+BB08LuSpEtyN46fRCrW4s4vE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TstfpyUOWVypO7Xb7pbJksZb28ilBiDiX+co59apaHYvfhuhd5WnbDCiuDXcn2VQcwNjx9JraAeJt7Ya391wN+I5eVL8PfkqVNOlc1N696ltuW2E/NxBP1qmW9gGCeHoQby2VmpbGX+sWMpJQWsLVZzoRXHhtIAeC+OvRJBptDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=danielhodges.dev; spf=pass smtp.mailfrom=danielhodges.dev; dkim=pass (2048-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b=F3d/DdQn; dkim=permerror (0-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b=+wQu3ZBq; arc=none smtp.client-ip=135.148.138.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=danielhodges.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=danielhodges.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b="F3d/DdQn";
	dkim=permerror (0-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b="+wQu3ZBq"
DKIM-Signature: v=1; a=rsa-sha256; s=202510r; d=danielhodges.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1770510672; bh=u3AQzQjLgJSz+4RZzdBmNxZ
	GqwZ2T1MUXQaa4ZFfPbQ=; b=F3d/DdQnrxlaZLqH4wv4nKHcv5+DVBkz4sSnb8AM1SuKNv5JXZ
	FzIY7G0jcTm6ciPT7c8rbmhQsCWs31LBbXtf0APmJIJBVgZbXxlN2FLkmDlpUu7VLMcHvXmm72A
	yS4dF+0DDVa9XQbRfNqIkY82qsLrtr29HTlws1NrvYa7aBYwYQmi9PpmupOgW378MN5dBI0GL3W
	Ac/2psstV6+yZ65nW55wQA94xXpgBQmP+1Q5vCJz3TIQJn/5aK2qtVRngZDl/4l8mpMIlNJygVt
	PU8qF4TLfh61aTdtRNljA5BtxfgT78rXDfVrkc2XPfS2FtwVw/tmG1Mw0AI2LqgL00A==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202510e; d=danielhodges.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1770510672; bh=u3AQzQjLgJSz+4RZzdBmNxZ
	GqwZ2T1MUXQaa4ZFfPbQ=; b=+wQu3ZBqS8c693hH8Y7huqzcyJ5GYMJz7lqLU4D/beA6GrP9kl
	shjvFG2HMgf1PI9eumhQubaZnMZ7zDl46RBg==;
From: Daniel Hodges <git@danielhodges.dev>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Daniel Hodges <git@danielhodges.dev>,
	syzbot+c3693b491545af43db87@syzkaller.appspotmail.com,
	syzbot+03f79366754268a0f20c@syzkaller.appspotmail.com
Subject: [PATCH] vt: keyboard: add NULL check for vc_cons[fg_console].d in kbd_keycode and kbd_rawcode
Date: Sat,  7 Feb 2026 19:31:12 -0500
Message-ID: <20260208003112.6040-1-git@danielhodges.dev>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kbd_keycode() and kbd_rawcode() dereference vc_cons[fg_console].d
without checking if it is NULL. The foreground console should normally
always be allocated, but there could be a time during console setup or
teardown where this pointer could be NULL, leading to a general
protection fault.

Syzkaller triggers this by injecting USB HID input events that reach
kbd_event() while the console state may not be fully consistent. The crash
manifests as a null-ptr-deref in __queue_work when put_queue() or
puts_queue() calls tty_flip_buffer_push() on the uninitialized vc port.

Add a NULL check for vc at the start of both kbd_rawcode() and
kbd_keycode() to bail out early if the foreground console is not allocated.

Reported-by: syzbot+c3693b491545af43db87@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=c3693b491545af43db87
Reported-by: syzbot+03f79366754268a0f20c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=03f79366754268a0f20c
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Daniel Hodges <git@danielhodges.dev>
---
 drivers/tty/vt/keyboard.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index a2116e135a82..975830013d24 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -1389,6 +1389,9 @@ static void kbd_rawcode(unsigned char data)
 {
 	struct vc_data *vc = vc_cons[fg_console].d;
 
+	if (!vc)
+		return;
+
 	kbd = &kbd_table[vc->vc_num];
 	if (kbd->kbdmode == VC_RAW)
 		put_queue(vc, data);
@@ -1405,6 +1408,9 @@ static void kbd_keycode(unsigned int keycode, int down, bool hw_raw)
 	struct keyboard_notifier_param param = { .vc = vc, .value = keycode, .down = down };
 	int rc;
 
+	if (!vc)
+		return;
+
 	tty = vc->port.tty;
 
 	if (tty && (!tty->driver_data)) {
-- 
2.52.0

