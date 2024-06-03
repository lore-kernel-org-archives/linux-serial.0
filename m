Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4014083CD8;
	Mon,  3 Jun 2024 23:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717457104; cv=none; b=Xmk6eTV/uHGJkIQp/I2Zx0KpB/OFRzpf1tnZl5HOIMzZiQVV3WpHLrqLoXv5ERHfQbNDLr2RI5sKh2CNmKD3NkJl97cWL3kNCFD6dh14EVIjSARY2ATAeBFPBwlqZfO+nfvBpIS2tLVCUjbMnW/2ozbHool9HMIBnmLlaZ2DHvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717457104; c=relaxed/simple;
	bh=iFe7QTOJaIZ96iBr5IJNXeHec/OczXjluE+9uE64m5U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lJrVoRFOsFVWhsqvTwKcg9zQvN/GrFgKlahjsLlomwns1YticUBjJqPFyFQQ3jD7ciFpFbXvSGM0ohhGdTQdR7VadiSp8gPjd41Q0sXmuKpBiPoaacdvORy+Hwl1P0Dd22f2sRhrIGjuZj62/jwAUGuHVnX6J5FDSqxEZDhju1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RubfaJ21; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3VHXF6oe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RubfaJ21";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3VHXF6oe"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717457100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AVOojb4+PpMY1V+1K9x0e9ZnUQCXKs719BnreW8cqRo=;
	b=RubfaJ21CaXktnflUH7lDlQT0oDJ4xfHIFVQvMDtT+1w44RUsTKBxRViXeoUKY/zceV1bU
	HeKeZJZCjUGlxY6yPU4wsaIvbr4iZmKHEwbTRtw3obLvtsaflGd5f8UboRPVqulLAKb8in
	L1Fn5CZ4HvOwhDwxxfm9OwL084/7aHPe3BhdwoxV3kXlPmPB/8dYsgcy8TLx7PERR92b67
	FmijEEwoF3KWX+M5aSlP8VQpUd9jwzHKEHGThEDGmE9pAYI3umf7dUSf2IUm6pOLDJ4Szi
	wh/xDjw+FjX72Owum1j34Q4tAjE63HMzH5daPzimwddr9eoqSOFcntGa9UqVgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717457100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AVOojb4+PpMY1V+1K9x0e9ZnUQCXKs719BnreW8cqRo=;
	b=3VHXF6oejKzbZBE03RCA1YmIECu7IUwL9FS6L0OkNOAerzWOodexOCtM1ODvmzCfeJRKkM
	j4oOnwZIuGB5DFDg==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-serial@vger.kernel.org
Subject: [PATCH printk v2 15/18] tty: sysfs: Add nbcon support for 'active'
Date: Tue,  4 Jun 2024 01:30:50 +0206
Message-Id: <20240603232453.33992-16-john.ogness@linutronix.de>
In-Reply-To: <20240603232453.33992-1-john.ogness@linutronix.de>
References: <20240603232453.33992-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow the 'active' attribute to list nbcon consoles.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 drivers/tty/tty_io.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 407b0d87b7c1..c9c914bc033c 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -3567,8 +3567,13 @@ static ssize_t show_cons_active(struct device *dev,
 	for_each_console(c) {
 		if (!c->device)
 			continue;
-		if (!c->write)
-			continue;
+		if (c->flags & CON_NBCON) {
+			if (!c->write_atomic && !c->write_thread)
+				continue;
+		} else {
+			if (!c->write)
+				continue;
+		}
 		if ((c->flags & CON_ENABLED) == 0)
 			continue;
 		cs[i++] = c;
-- 
2.39.2

