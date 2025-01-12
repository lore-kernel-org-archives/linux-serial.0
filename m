Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEEF1547E8;
	Sun, 12 Jan 2025 13:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736690293; cv=none; b=Tgtzzbtpjn5YjRkdCgjyXX/jazIBqZywwE7WbAmZ22Rjz8Ew9SmyPAQ9z408M3wxDPgB3DFN74+WwAtCFd87ireFDN5/mrC9j8kCJR4cyUMGpIO+3TVoP0Y9NHiTd2axhpTbMPikMQDnbvupu4CvsRqboaaX3zidr/TBapTDH1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736690293; c=relaxed/simple;
	bh=LbBgLopdOAaqmyGugRv8CC8BhQIYCl85IeTG0PF+4bE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rzRJrWURn2Y7ruXpdzgPakQa1Yjks6p8QG+P2DT3DQs3sGGbgyEkUisYk8kgyX/FA438A7UvXuPug11WI/fyUxR0J1Ml8QEpACTvJu9dQOj8K2m2BMaj03VSzAnQxqPw3AS+QqQ03wrKsrqFhaXxM8jzhEc3wd+VfxbEG5eMKYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=nHRAgVBZ; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="nHRAgVBZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=PNJ62D9s6I5X3su0K6IGOvEFFWT4AW0bmQe1c8LYqcw=; b=nHRAgVBZSh1foZHg
	tHMNaKrdS1mVrsPQ6enBWk3yeGuwUphfWbfuaSTNxqVwRaWgj0dbYV7oorsluA3hjorOfY9VqDR4v
	Rjzsw6KLEdF8cKPVfyOtT2EnZZiTosyw3zhmCd4osESSlBE/+LYjo85B8JSPz593t9vI/BFSYKlWS
	mBaVFRkHOqT8xV3CehRHtihY+bin+dLq4xBGSTxwssJ0CnMrov4CgxpHCbhAY9oez7Kig4gSZGjPa
	t7LXM5f2YL+yoLuQL1Vff8jE1pjFhPLJKYt32XRqHeE0NTHoRsLprCd2tgNSyRZxa61hL+IHAfKY8
	zOIrhFdzc2PXdj17pQ==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tWyTa-009jIv-02;
	Sun, 12 Jan 2025 13:58:02 +0000
From: linux@treblig.org
To: jason.wessel@windriver.com,
	danielt@kernel.org,
	dianders@chromium.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-serial@vger.kernel.org,
	kgdb-bugreport@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] serial: kgdb_nmi: Remove unused knock code
Date: Sun, 12 Jan 2025 13:57:59 +0000
Message-ID: <20250112135759.105541-1-linux@treblig.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

kgdb_nmi_poll_knock() has been unused since it was added in 2013 in
commit 0c57dfcc6c1d ("tty/serial: Add kgdb_nmi driver")

Remove it, the static helpers, and module parameters it used.

(The comment explaining why it might be used sounds sensible, but
it's never been wired up, perhaps it's worth doing somewhere?)

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/tty/serial/kgdb_nmi.c | 101 ----------------------------------
 include/linux/kgdb.h          |   2 -
 2 files changed, 103 deletions(-)

diff --git a/drivers/tty/serial/kgdb_nmi.c b/drivers/tty/serial/kgdb_nmi.c
index e93850f6447a..2833708e369f 100644
--- a/drivers/tty/serial/kgdb_nmi.c
+++ b/drivers/tty/serial/kgdb_nmi.c
@@ -27,18 +27,6 @@
 #include <linux/kgdb.h>
 #include <linux/kdb.h>
 
-static int kgdb_nmi_knock = 1;
-module_param_named(knock, kgdb_nmi_knock, int, 0600);
-MODULE_PARM_DESC(knock, "if set to 1 (default), the special '$3#33' command " \
-			"must be used to enter the debugger; when set to 0, " \
-			"hitting return key is enough to enter the debugger; " \
-			"when set to -1, the debugger is entered immediately " \
-			"upon NMI");
-
-static char *kgdb_nmi_magic = "$3#33";
-module_param_named(magic, kgdb_nmi_magic, charp, 0600);
-MODULE_PARM_DESC(magic, "magic sequence to enter NMI debugger (default $3#33)");
-
 static atomic_t kgdb_nmi_num_readers = ATOMIC_INIT(0);
 
 static int kgdb_nmi_console_setup(struct console *co, char *options)
@@ -95,95 +83,6 @@ struct kgdb_nmi_tty_priv {
 
 static struct tty_port *kgdb_nmi_port;
 
-static void kgdb_tty_recv(int ch)
-{
-	struct kgdb_nmi_tty_priv *priv;
-	char c = ch;
-
-	if (!kgdb_nmi_port || ch < 0)
-		return;
-	/*
-	 * Can't use port->tty->driver_data as tty might be not there. Timer
-	 * will check for tty and will get the ref, but here we don't have to
-	 * do that, and actually, we can't: we're in NMI context, no locks are
-	 * possible.
-	 */
-	priv = container_of(kgdb_nmi_port, struct kgdb_nmi_tty_priv, port);
-	kfifo_in(&priv->fifo, &c, 1);
-}
-
-static int kgdb_nmi_poll_one_knock(void)
-{
-	static int n;
-	int c;
-	const char *magic = kgdb_nmi_magic;
-	size_t m = strlen(magic);
-	bool printch = false;
-
-	c = dbg_io_ops->read_char();
-	if (c == NO_POLL_CHAR)
-		return c;
-
-	if (!kgdb_nmi_knock && (c == '\r' || c == '\n')) {
-		return 1;
-	} else if (c == magic[n]) {
-		n = (n + 1) % m;
-		if (!n)
-			return 1;
-		printch = true;
-	} else {
-		n = 0;
-	}
-
-	if (atomic_read(&kgdb_nmi_num_readers)) {
-		kgdb_tty_recv(c);
-		return 0;
-	}
-
-	if (printch) {
-		kdb_printf("%c", c);
-		return 0;
-	}
-
-	kdb_printf("\r%s %s to enter the debugger> %*s",
-		   kgdb_nmi_knock ? "Type" : "Hit",
-		   kgdb_nmi_knock ? magic  : "<return>", (int)m, "");
-	while (m--)
-		kdb_printf("\b");
-	return 0;
-}
-
-/**
- * kgdb_nmi_poll_knock - Check if it is time to enter the debugger
- *
- * "Serial ports are often noisy, especially when muxed over another port (we
- * often use serial over the headset connector). Noise on the async command
- * line just causes characters that are ignored, on a command line that blocked
- * execution noise would be catastrophic." -- Colin Cross
- *
- * So, this function implements KGDB/KDB knocking on the serial line: we won't
- * enter the debugger until we receive a known magic phrase (which is actually
- * "$3#33", known as "escape to KDB" command. There is also a relaxed variant
- * of knocking, i.e. just pressing the return key is enough to enter the
- * debugger. And if knocking is disabled, the function always returns 1.
- */
-bool kgdb_nmi_poll_knock(void)
-{
-	if (kgdb_nmi_knock < 0)
-		return true;
-
-	while (1) {
-		int ret;
-
-		ret = kgdb_nmi_poll_one_knock();
-		if (ret == NO_POLL_CHAR)
-			return false;
-		else if (ret == 1)
-			break;
-	}
-	return true;
-}
-
 /*
  * The tasklet is cheap, it does not cause wakeups when reschedules itself,
  * instead it waits for the next tick.
diff --git a/include/linux/kgdb.h b/include/linux/kgdb.h
index 76e891ee9e37..51ef131e66b7 100644
--- a/include/linux/kgdb.h
+++ b/include/linux/kgdb.h
@@ -309,11 +309,9 @@ extern unsigned long kgdb_arch_pc(int exception, struct pt_regs *regs);
 #ifdef CONFIG_SERIAL_KGDB_NMI
 extern int kgdb_register_nmi_console(void);
 extern int kgdb_unregister_nmi_console(void);
-extern bool kgdb_nmi_poll_knock(void);
 #else
 static inline int kgdb_register_nmi_console(void) { return 0; }
 static inline int kgdb_unregister_nmi_console(void) { return 0; }
-static inline bool kgdb_nmi_poll_knock(void) { return true; }
 #endif
 
 extern int kgdb_register_io_module(struct kgdb_io *local_kgdb_io_ops);
-- 
2.47.1

