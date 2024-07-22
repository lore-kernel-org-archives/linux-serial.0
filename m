Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2627616F903;
	Mon, 22 Jul 2024 17:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721668794; cv=none; b=guHYAUs3swjqPfvk/8NPz2Kbs5Dd2vDz18FMMcl0XdlJpx2AhnTsDkBVHXj6YcqdOGQexosuzE71r6KHWwesIzzCPC8iehImrnUSmwLmCAF9oFYSZM2Iio7Vr//cS2h2i3naeCzg+8YLwKNuhNycExT0KqjQJlf3idBUKKLNxp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721668794; c=relaxed/simple;
	bh=GA0FHsOuyzgGhTea4jgXklRGbAD3dnv/ZQqXWojJ8gA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mdIyse4kKot59vgrfOM9qea2Bpf+8zOjHj+QJRLIrppjQq8GFQ0QkJp2DoqYtNTkFKbEp6TSfCON7gcbRqs1PiGE2+Ow+P9ia6GNwBaZT2WeCV44j69pz8xkeDsRTFx6vZsoLpflS+oPnI2DzEGBJNWoiFSNsi6bS6US2b7aqy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hscES2pM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5gEWP+k8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hscES2pM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5gEWP+k8"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1721668785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pSvfpE6goL/87JMNQ367S+Uq3TCC1GnMITarxZW2fNs=;
	b=hscES2pMy9HgoeDGXcrcMmkr1+qVCf2u2H+LjM7DZNHXhqFBG/UME9KlDbRBJ3gS5QAQGa
	InE9bVsKn0anouM1zJmo7B6YDH67hs+09TBk6RWIENOjJACPNdieRs62hxFPTy+EaffIMm
	wZvcg8olExe+kT9M3G4Pf5sOHyNisJoQK5bfCuSgf1LYNNyRai4JbBmL/IihissOxpq+dl
	O2Sd8/5l2zRFaHQlrcpdtkMXAHM/j6+M1ZbcFgrXkg3ymRPnEqeXPSMBqJHCy+e252x6qm
	/7dr167XBWod0qvxU8ec9yBJWa7DTFLwp2zUUM5b1T33hGlxbQMnnZ7yhnauRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1721668785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pSvfpE6goL/87JMNQ367S+Uq3TCC1GnMITarxZW2fNs=;
	b=5gEWP+k8QbKpoMCQiDgw/q9wgTUiSPQ7tjQ350PrpYYnx9CG6qHlvcEF/ptbz2jeo/zCcJ
	GbfqpMvTdLmKnzDQ==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-serial@vger.kernel.org
Subject: [PATCH printk v3 16/19] tty: sysfs: Add nbcon support for 'active'
Date: Mon, 22 Jul 2024 19:25:36 +0206
Message-Id: <20240722171939.3349410-17-john.ogness@linutronix.de>
In-Reply-To: <20240722171939.3349410-1-john.ogness@linutronix.de>
References: <20240722171939.3349410-1-john.ogness@linutronix.de>
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

