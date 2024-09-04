Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E85C1D88BA;
	Wed,  4 Sep 2024 12:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725451545; cv=none; b=TVwFKZRb1996wXP7L7SfJLZEzkU1wk2AQWjvTWfvVMnv5T0JGa4kVGMIIAQV++7yWApt8z3tX4ut14c341XH8VPAjirIHS+owPbNoiTJZYnrdfpZBrxMhusCwzFAUuGarqcSJF77PQ1VRFlwzc4bNCQvGbNyPogOZvS2j0TZUy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725451545; c=relaxed/simple;
	bh=dp39GBW9ZErJu1DqQO7+qMNtwGg+EqlSaBhaAISNtsU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=njjq2YKRstt029Aq3iEUaciVl90hZ0c6GHOyvwrqs5Bvh8jCiL1wcyWzVXsgKubyXRyDGBmaMgFw7Mw7MmAf1n8rNECJf3fsBddMK6aLzWNCR/4tu1i0tUrjV4hZNaQCg/GjDEUKWCgN/ehPTxJsQ815EJm3DHelYqEIl9S7/uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1SzDRKNJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6K1/pMB7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1SzDRKNJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6K1/pMB7"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725451542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=151ULJoLjYfhpZeJDTwn5PbZoaNXd1Ky9qGsR418PG8=;
	b=1SzDRKNJ4W3WsTY+R2KSTcwd/Wd+KZ2pTqlHDuhZz5VQzKMFKSCseR7KfrvIqUMIiUNG+a
	CM6GSSSjoZfLHheC8PTRCsWGtAw2ZB+fjLt0QXSHFIpUu7Z/oER0zUvDGVKerh8dUcXLQO
	Di+x2ZdJCgJny2LtDBbbWmMpjUNam3XPP3olOPrS/hvD+H3CLTluxATItTlpzCM0NuK8fa
	Ab9UyZem8i4JfT+7veuSZ/tR22jbcz/k4Jzsv1J7A0NTDcNJzIhmx8EFXLlUNhAofR0/jb
	OvSkbf836CQKzSBHvJWrd9+1u1Pi0ytZORX53kfKyDYC6qaoYqGhAC+2oSG6+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725451542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=151ULJoLjYfhpZeJDTwn5PbZoaNXd1Ky9qGsR418PG8=;
	b=6K1/pMB7Nj2LY5K54JvzWKOjaTZG+bgAbb3+uenpsRmK3gb0aB5Ca5w5BUqj82vQJKW35+
	rEEPmoEZtitjqdAQ==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-serial@vger.kernel.org
Subject: [PATCH printk v6 14/17] tty: sysfs: Add nbcon support for 'active'
Date: Wed,  4 Sep 2024 14:11:33 +0206
Message-Id: <20240904120536.115780-15-john.ogness@linutronix.de>
In-Reply-To: <20240904120536.115780-1-john.ogness@linutronix.de>
References: <20240904120536.115780-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow the 'active' attribute to list nbcon consoles.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 drivers/tty/tty_io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 407b0d87b7c1..9140825e810f 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -3567,7 +3567,7 @@ static ssize_t show_cons_active(struct device *dev,
 	for_each_console(c) {
 		if (!c->device)
 			continue;
-		if (!c->write)
+		if (!(c->flags & CON_NBCON) && !c->write)
 			continue;
 		if ((c->flags & CON_ENABLED) == 0)
 			continue;
-- 
2.39.2

