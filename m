Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79196384CE6;
	Fri,  3 Jul 2026 08:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783068447; cv=none; b=GDnz03vAhtwfg3DwdFxmfZc5fPV/yVQFlT/QFGArx3LLO4RJImUOSZfD6bmuVGW4L9x5t7zhudUUPv4GtGZ+dG8ziHjoXSLEUnxLEZAwtw3TLR15QRninJt4QpYOJiF7tDApCZq1JPrmmzLaVVyVjuJ7sitxiQHlxdwLZaknpog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783068447; c=relaxed/simple;
	bh=NsYdWQCI1xOM4REpYiAnBw4NNs5FqUdCCDLBaqNApR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L13TdTJHRluyZuDX3XuzNbQaX1ULTxXCJkR7lP+Kv2uJj8RQM+csCeCH/zR0KUS5rXyEJHyJZWj9ELaWfwZP3ltTeGU2G1i0V9XYBul/GiIIWu3Uy9ZqHyXC0Tr6wtiBWPXvhWG9jvC9G2EA2Andbg98kcd9yQwdDgMiG0PDftM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Noq3bNQA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Noq3bNQA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 053F51F00A3A;
	Fri,  3 Jul 2026 08:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783068446;
	bh=6J9n7rbnh8zwJtMmv6cRJ0lfK2K5CtymunTnKfp4d4A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Noq3bNQAKCQtuAnPvoQt+GftzDOtFg/VJGwoMnxt0zgvQEcl7Z8yo7AdWd1m0hVND
	 0Lm19c5FHKDmqz1VhAk1877N+k5IJrp1cizl87fW6+aQ7olCmI6nddbjD/bSrXNXZW
	 MTFLyfidL1Y9+SE2FdY7S2/maRN7PcoVBg+KttXuzRKv02yFwxQ6JWMGFA+OZFxTm/
	 UUkWDFJWt26CPqvh13aHnBACStAng27pzzivyFjLFI5y2hcVFmGOGgfjylYKjW25f5
	 Fi1/29El5/ZSXU6cxOGqEQ6c2ipOhu371h2EcJIhZSvommWP8HE+6gvZJLHGYt+4BH
	 uH7aemwO+bZOg==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 4/4] tty: goldfish: use guard() for locks
Date: Fri,  3 Jul 2026 10:47:17 +0200
Message-ID: <20260703084717.176442-4-jirislaby@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260703084717.176442-1-jirislaby@kernel.org>
References: <20260703084717.176442-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using guard()s is cleaner and safer.

goldfish_tty_probe() is omitted due to the crossing err_unmap
goto-label. Using scoped_guard() does not look that nice there. Perhaps
if someone refactored the locked part into a separate function...

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/goldfish.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/goldfish.c b/drivers/tty/goldfish.c
index c643d76e9d1b..fa723a4ba7b3 100644
--- a/drivers/tty/goldfish.c
+++ b/drivers/tty/goldfish.c
@@ -60,10 +60,10 @@ static inline void gf_write_addr(unsigned long addr, void __iomem *portl, void _
 static void do_rw_io(struct goldfish_tty *qtty, unsigned long address,
 		     size_t count, bool is_write)
 {
-	unsigned long irq_flags;
 	void __iomem *base = qtty->base;
 
-	spin_lock_irqsave(&qtty->lock, irq_flags);
+	guard(spinlock_irqsave)(&qtty->lock);
+
 	gf_write_addr(address, base + GOLDFISH_TTY_REG_DATA_PTR,
 		      base + GOLDFISH_TTY_REG_DATA_PTR_HIGH);
 	gf_iowrite32(count, base + GOLDFISH_TTY_REG_DATA_LEN);
@@ -74,8 +74,6 @@ static void do_rw_io(struct goldfish_tty *qtty, unsigned long address,
 	else
 		gf_iowrite32(GOLDFISH_TTY_CMD_READ_BUFFER,
 		       base + GOLDFISH_TTY_REG_CMD);
-
-	spin_unlock_irqrestore(&qtty->lock, irq_flags);
 }
 
 static void goldfish_tty_rw(struct goldfish_tty *qtty, unsigned long addr,
@@ -417,7 +415,7 @@ static void goldfish_tty_remove(struct platform_device *pdev)
 {
 	struct goldfish_tty *qtty = platform_get_drvdata(pdev);
 
-	mutex_lock(&goldfish_tty_lock);
+	guard(mutex)(&goldfish_tty_lock);
 
 	unregister_console(&qtty->console);
 	tty_unregister_device(goldfish_tty_driver, qtty->console.index);
@@ -428,7 +426,6 @@ static void goldfish_tty_remove(struct platform_device *pdev)
 	goldfish_tty_current_line_count--;
 	if (goldfish_tty_current_line_count == 0)
 		goldfish_tty_delete_driver();
-	mutex_unlock(&goldfish_tty_lock);
 }
 
 #ifdef CONFIG_GOLDFISH_TTY_EARLY_CONSOLE
-- 
2.54.0

