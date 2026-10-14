Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DCE53CA6D;
	Wed, 14 Oct 2026 14:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791988270; cv=none; b=cp2F2dh/7xO1BOQjTeh8eCb4lfBfE4Rj4EPX5znMpd3JKDjPrjRYo2z0ImAy1tJ85emEXjRfrULE7pasviFLYAq2U2m8ftYSxtwZWcyZkpJkuGdz1yyq30ioTUobqvBkS63btMnJMcNbkZheTAQB+asWidbqclM/uIoAZhGuOb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791988270; c=relaxed/simple;
	bh=hyilG20mp+XnLj/3lAEhVhlkR8b20X2hA3TZAObYtSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cJdEs2rBvXdb/+2sQub3T460uuL7fIfL8xCGNXd+exAbVikRDibRjOiMD4tkfuu7PUtmWZPequq1eeSt/NEhSujqEEk+1ZX/bKWMzMAruUWSQ6iphlhJvXc0hXVBh04DYyp97nHUqtPRyAUirgpR3g/K7jw3HLxkwWGdRSCm2o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nvBbCT2e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nvBbCT2e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E78AD1F000C4;
	Wed, 14 Oct 2026 14:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791988269;
	bh=w+RKbY8SslnL+CJpoN7wytSAuSNSgN6XS5KDsZ/4/v8=;
	h=From:To:Cc:Subject:Date;
	b=nvBbCT2eSrtikZX+/vZ4QzZEkQZY+ug71dspcf7O2v6IFSPewBjSqbOqyR5IyXzyW
	 ni6WbgdImcirxfJYziIRxklRruJCoKiAXo/X0CaVF3rPVsOuQ3H1pKpvNzMyDm9g+H
	 zfR/3RQLsNMXGrOgLRb/I9PKCS35kS0WltifcKW0VQhdG8cMBUmTpDPtmA180cskSZ
	 OslpSagUHwMrDowBZhFz0wNpkfkj3BKPEVYk9dYQX0eqysPdyPfBqsihrxzfNH7mOR
	 5v5Z5C1mSKTs6KMTLeqKyknw9NUqQvzHLPR1JNBHewWqAATAzM1zHRA5nT2drgR2GU
	 umYu6iUlEYyKQ==
From: Thorsten Blum <blum@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Johan Hovold <johan@kernel.org>,
	Karl Mehltretter <kmehltretter@gmail.com>,
	John Ogness <john.ogness@linutronix.de>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Thorsten Blum <blum@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH 1/2] serial: core: Use isdigit() in uart_parse_options()
Date: Wed, 14 Oct 2026 16:30:32 +0200
Message-ID: <20261014143034.104950-3-blum@kernel.org>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=886; i=blum@kernel.org; h=from:subject; bh=hyilG20mp+XnLj/3lAEhVhlkR8b20X2hA3TZAObYtSQ=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFnnJ3EHzG2I4zYr/NL6cJbZ1LnO/BNdg0Ifvfk8VUG+p jnRqN27o5SFQYyLQVZMkeXBrB8zfEtrKjeZROyEmcPKBDKEgYtTACYi1MLIMHtDS26N5lfvrYn/ t4o4Hr/ygrvCnH2raqrQUxsr81dyhYwMN+9PbyxbpX5k7UR33hkzbFQmJNopVDDymW79O6t0lko TNwA=
X-Developer-Key: i=blum@kernel.org; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit

Use isdigit() to replace the open-coded implementation.

Signed-off-by: Thorsten Blum <blum@kernel.org>
---
 drivers/tty/serial/serial_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 6332ed545c89..6509f65dec36 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -14,6 +14,7 @@
 #include <linux/sched/signal.h>
 #include <linux/init.h>
 #include <linux/console.h>
+#include <linux/ctype.h>
 #include <linux/gpio/consumer.h>
 #include <linux/kernel.h>
 #include <linux/of.h>
@@ -2211,7 +2212,7 @@ uart_parse_options(const char *options, int *baud, int *parity,
 	const char *s = options;
 
 	*baud = simple_strtoul(s, NULL, 10);
-	while (*s >= '0' && *s <= '9')
+	while (isdigit(*s))
 		s++;
 	if (*s)
 		*parity = *s++;
