Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776D0143C7E;
	Tue, 27 Aug 2024 04:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724733822; cv=none; b=jLrSRpzAMxuhUBMc3r4yrlFkV32V/TgebuR7Nl5bYnS1Uc9ZnDuiwCSuaYPpqYVH+goIJ+qSdAaqNbus2hYkrFYTxLvYWDg2nJskLapwthwhPzVh1NXqVUkR+5dDJOLrXaBMGZr/ua69glZJKcphBS6cxV0e5GBIa3O3d/sKPB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724733822; c=relaxed/simple;
	bh=dp39GBW9ZErJu1DqQO7+qMNtwGg+EqlSaBhaAISNtsU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DpIwD8LJkCcFzryVjjDEx90qwPT32d9t6nxj+9Ub6Fl0w0XmewnMArZtuaOW9KUUnx+ZI3GEsypUj0st4pl/LPhBhJ2Zn7KHIgXtgHyviRdxRAOWpR/PaulRDvBK7ze7xPzcLQxcwtGVGscitbazRRe8LfAkuZrvAF1ea3FsIHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RSkprxwC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GALVJHOI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RSkprxwC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GALVJHOI"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724733818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=151ULJoLjYfhpZeJDTwn5PbZoaNXd1Ky9qGsR418PG8=;
	b=RSkprxwCF0twnNHyQ9hVvJ7T7xIZwIwpDJTIF6GBTaOUD3SeKjd/vJxbp41kGPDp85wrAL
	LYuKAisWM8yBo5LPvfN4l+fSbAgJWlsh71IQUfXytP63T0bKDrZkj/YoiXU+QSil5oeHve
	+0/3aZ7ZrOssb58uw8GpnMa4emsDqZDXorQ33gkaA+FFvIX4vgAM8rCFsh4ysgH6tqa+TS
	9vRpBJ6IwoR8pSiQFKfI/47L3YbSHlsXJZZlBbncuR5rYiX5weFCYGyDI5dHywcXsC/Q0M
	I9Lzg2G1SLB3LTLTNPWzD9ZRVzsbPJHIsdRDZmILfKOfOUvrwYWzs/AlwLw6SQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724733818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=151ULJoLjYfhpZeJDTwn5PbZoaNXd1Ky9qGsR418PG8=;
	b=GALVJHOI/1iE+zQFS+NOeX5O+/5dLCNOl1iPLgBHy1J2Ov2jwGuDD1bXPfwlCPZ2pltHmr
	F+MGMTvOudQHNyAQ==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-serial@vger.kernel.org
Subject: [PATCH printk v4 14/17] tty: sysfs: Add nbcon support for 'active'
Date: Tue, 27 Aug 2024 06:49:30 +0206
Message-Id: <20240827044333.88596-15-john.ogness@linutronix.de>
In-Reply-To: <20240827044333.88596-1-john.ogness@linutronix.de>
References: <20240827044333.88596-1-john.ogness@linutronix.de>
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

