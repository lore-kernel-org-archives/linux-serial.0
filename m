Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B52C3DE42A;
	Fri, 10 Apr 2026 15:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775834448; cv=none; b=E+Sdw5UwsXp8n0lCxTjib8g6TQ+aV3MyAVP+ZVWnSPiR/xRsbLXufWAaUu+uNCtgH5ZyrIgl1E2yDPKIeZICiruMS1PeV+SYkU8anHnq44p5xL+DISW6VejsecxPgiB/6urlWgjDGhwG6lHEB8x218DQXJZCDL5iLXNVj4DTmMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775834448; c=relaxed/simple;
	bh=QveXexA4o7SM9TI5LRX3Uh2TZeTp9LlHWhBIWjkh37c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r/BdXLQWSdLiFLBrayZOVfi5//sxiKwskysKCLn50aHaAo68UqCF/FogedoD7pNlpfhzc+sNn/C5mvE2DvSJEemb0DmXdb2XvXVpwILSKoyQFx40MGbTkOJe8obfic9hjCSG3Ennn3nzq4XbrhRBgw6TLsnntSv0JbVWc47vGDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=unyzzCnG; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="unyzzCnG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject
	:Cc:To:From:subject:date:message-id:reply-to;
	bh=hBXgaigVMOcZAj/jA49x+8oTS2DDyRSbq9xTUIlauvY=; b=unyzzCnGM7z1+QHAFSXLIjk57d
	fWF5XoDl7AVg70XiRW7W+zXQqCFAaBM/tjROanesL9wP4/MkuJ/fAuqbV3lY6STwkl0w1NA4SlVP5
	0egi2i4+cZEUROM2nVJ8aDCThzv/hP117zRMzeml1VVCFZPVsWHkfndGQd0/f2c2RgeI=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1wBDf3-000000008Ub-3TnZ;
	Fri, 10 Apr 2026 11:20:46 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: hugo@hugovil.com,
	biju.das.jz@bp.renesas.com,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: [PATCH 5/5] serial: core: prevent division by zero by always returning non-zero baud rate
Date: Fri, 10 Apr 2026 11:20:13 -0400
Message-ID: <20260410152022.2146488-6-hugo@hugovil.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260410152022.2146488-1-hugo@hugovil.com>
References: <20260410152022.2146488-1-hugo@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam_score: -1.0
X-Spam_bar: -

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

If a device has a minimum baud rate > 9600 bauds, and a new termios baud
rate of 0 (hang up) is requested, uart_get_baud_rate() will return 0.
Most drivers do not check this return value and call uart_update_timeout()
with this zero baud rate, which will trigger a "Division by zero in kernel"
fault:

  stty -F /dev/ttySC0 0

  Division by zero in kernel.
  ...

Fix by returning the larger of 9600 or min for the B0 case. This now
ensures that a non-zero baud rate is returned, and greatly simplifies the
code.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
Tested with the sc16is7xx driver by setting the minimum baudrate to 19200.

If a "Fixes" tag is needed, this would probably be:
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
This would also imply, probably, to merge this patch with the previous ones
(touching serial_core.c) to make porting easier to stable trees...
---
 drivers/tty/serial/serial_core.c | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index f89c0dc295163..075a69164aa7c 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -462,11 +462,10 @@ EXPORT_SYMBOL(uart_update_timeout);
  *
  * Decode the termios structure into a numeric baud rate, taking account of the
  * magic 38400 baud rate (with spd_* flags), and mapping the %B0 rate to 9600
- * baud.
+ * baud or min argument, whichever is greater.
  *
  * If the new baud rate is invalid, try the @old termios setting. If it's still
  * invalid, clip to the nearest chip supported rate.
- * If that is also invalid 0 is returned.
  *
  * The @termios structure is updated to reflect the baud rate we're actually
  * going to be using. Don't do this for the case where B0 is requested ("hang
@@ -481,7 +480,6 @@ uart_get_baud_rate(struct uart_port *port, struct ktermios *termios,
 	unsigned int try;
 	unsigned int baud;
 	unsigned int altbaud;
-	int hung_up = 0;
 	upf_t flags = port->flags & UPF_SPD_MASK;
 
 	switch (flags) {
@@ -515,10 +513,8 @@ uart_get_baud_rate(struct uart_port *port, struct ktermios *termios,
 		/*
 		 * Special case: B0 rate.
 		 */
-		if (baud == 0) {
-			hung_up = 1;
-			baud = 9600;
-		}
+		if (baud == 0)
+			return max(min, 9600);
 
 		if (baud >= min && baud <= max)
 			return baud;
@@ -530,9 +526,7 @@ uart_get_baud_rate(struct uart_port *port, struct ktermios *termios,
 		termios->c_cflag &= ~CBAUD;
 		if (old) {
 			baud = tty_termios_baud_rate(old);
-			if (!hung_up)
-				tty_termios_encode_baud_rate(termios,
-								baud, baud);
+			tty_termios_encode_baud_rate(termios, baud, baud);
 			old = NULL;
 			continue;
 		}
@@ -541,15 +535,16 @@ uart_get_baud_rate(struct uart_port *port, struct ktermios *termios,
 		 * As a last resort, if the range cannot be met then clip to
 		 * the nearest chip supported rate.
 		 */
-		if (!hung_up) {
-			if (baud <= min)
-				baud = min + 1;
-			else
-				baud = max - 1;
+		if (baud <= min)
+			baud = min + 1;
+		else
+			baud = max - 1;
 
-			tty_termios_encode_baud_rate(termios, baud, baud);
-		}
+		tty_termios_encode_baud_rate(termios, baud, baud);
 	}
+
+	/* Should never happen */
+	WARN_ON(1);
 	return 0;
 }
 EXPORT_SYMBOL(uart_get_baud_rate);
-- 
2.47.3

