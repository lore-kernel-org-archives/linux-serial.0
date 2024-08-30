Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1FA1B86DB;
	Fri, 30 Aug 2024 15:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725031771; cv=none; b=hfHcjr4GtHw+L4WGJqUjNYmA0PnCeF2U4aZdqDx0EzrqSMMm5vWCIUgkT36iqkvdpDt03u0YA6XU39NG8FXd5cfEfJRmr6U7oFuxSS2n2sJosNbd24xKr30E53l8LkbpU/gUmKl7T1UUSzseusjmajhTPosNF69aaRKTotneP+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725031771; c=relaxed/simple;
	bh=dp39GBW9ZErJu1DqQO7+qMNtwGg+EqlSaBhaAISNtsU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ub/yCdqzxQMwgxseTzOZXAd3oLvm1kASUQAzf1SjX/JcN7hDEEcW16ondbeoOvvimTxbGu/bSgjwyVuJ4ramCfCd+gPs+szuWQ+7XNILp2zhoKf0Rcv0iqR1Lj4lwnIbhhSx9NrDet2aQY4Xk3QDGZtYV9/nwLf+z2QAb/QvP4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=C9dZHlPx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sVXpqmL5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C9dZHlPx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sVXpqmL5"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725031761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=151ULJoLjYfhpZeJDTwn5PbZoaNXd1Ky9qGsR418PG8=;
	b=C9dZHlPxu+QbqZzAnS8/GuRaberIOWWy9iyajTeFJLV0bfCu7abkbUNVjCckG3j/YSdvKS
	uSUj+93it8AuVOnEWaSCSnDrQBptEI30YKkKbvGkJQ4bEqMqzdQ4XCnINKnOljQumsruLk
	qvBmmv47GkvJ5UsPtph6uyO4lTRODgp1LTC2lJtbXYehQ1+Z4taDCgfZb5bm7KrUKYCyEg
	XVeDqXsJAB1O6dNC3Wr1PhdQBFX479mxIUf1B1Fk9jSB+J5WcRt/zCPV7BxW/Sr2wttLGM
	/GiEBXOqCe3aQVglB8dBnFdlQabNkRZrUoYfUL/WICBiOCqTDKg44qryFdJzvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725031761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=151ULJoLjYfhpZeJDTwn5PbZoaNXd1Ky9qGsR418PG8=;
	b=sVXpqmL5PqNY5f9ydlM2jLIUMe5u5oZ8FgudnXjLT6khdLsgLq/Bc7Ep7Jwe0kzhySqpbG
	+BjuZDHgmsLtymCQ==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-serial@vger.kernel.org
Subject: [PATCH printk v5 14/17] tty: sysfs: Add nbcon support for 'active'
Date: Fri, 30 Aug 2024 17:35:13 +0206
Message-Id: <20240830152916.10136-15-john.ogness@linutronix.de>
In-Reply-To: <20240830152916.10136-1-john.ogness@linutronix.de>
References: <20240830152916.10136-1-john.ogness@linutronix.de>
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

