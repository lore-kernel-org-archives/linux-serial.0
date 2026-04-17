Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF1A3B6C0E;
	Fri, 17 Apr 2026 10:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776421479; cv=none; b=nk8KJCtDBQuy3Dwg5wDiO0XuTSB+4sJJWGZYNay1IqW8jqKFuqZCNJcC0u3qFDOfRgqR3KQyZWLn68WO3fGiCalW06UoalxGT1vTy0bnxllew4MSvMJp831v5RMmVt6aUsA7oCLmH0RZVwQmJQL5HB/nBGXSmE3OJ9DLL2U6zyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776421479; c=relaxed/simple;
	bh=9yFLVKakLkkiOEqaGGZspsRBWbyRAs5bN2Z3/85Xq4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YDwH0//CL5FTGRGb4IfkTHrA5b4dszgjJrHLkvsGcMMHEm0lkvWDbFViFfYMyA1C0YO3vcRblVleg6b07PIG/jbo6SBvqtjpcmJxyUgX0vWOAXdMe31v+oBJoMnQloT052ZDmi+oo0KFD15J60H7tEIL7cWwKYgaGFV9b8dcQ0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KROVrwwJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kuyZDQ+0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KROVrwwJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kuyZDQ+0"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1776421466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7zGtVxAk0EWfLsuiGtoS8oZDRAse+qfp7+FW77t1bxg=;
	b=KROVrwwJ0SncT59ANLfYJh8L9CUEPqO898XYTbPi4HqdELVv5DukQqQs0+BvJpRd/AHYFh
	c7sSLOIhjXMs71+65+5out/mIdjNTgtufoZoW9TkUcFA0JeAIEJFs+t5Pje0DQfAydi31P
	1Pu8FC86ipQjL2GoxzEIOtNVgkEp1n6BmJmzKs+nUe2s57DwZu+cdtQGvwaGaFIaou3Sir
	ggj3nLn/mOzjihDjx/FvutHopz7uSdNf3ZTkiLFFd3Gao+c4Q6BAUsB0TbmJO0cPtOx09f
	EFUhL3bgkFxK/Bnyv9o6IJcv8FSVdYGXb950bgR+IGWTM7L+AbOsmmrA4wkXHw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1776421466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7zGtVxAk0EWfLsuiGtoS8oZDRAse+qfp7+FW77t1bxg=;
	b=kuyZDQ+0Pchv9kJ6E7SeLm9sVSlsib40KvYlACkiL/YukHxerfEz1O0khFdqQGqT+c1qDd
	BqGYl3w7f60zojBg==
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-serial@vger.kernel.org
Subject: [PATCH tty v3 5/6] serial: 8250: Check LSR timeout on console flow control
Date: Fri, 17 Apr 2026 12:30:18 +0206
Message-ID: <20260417102423.40984-6-john.ogness@linutronix.de>
In-Reply-To: <20260417102423.40984-1-john.ogness@linutronix.de>
References: <20260417102423.40984-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

wait_for_xmitr() calls wait_for_lsr() to wait for the transmission
registers to be empty. wait_for_lsr() can timeout after a reasonable
amount of time.

When console flow control is active, wait_for_xmitr() additionally
polls CTS, waiting for the peer to signal that it is ready to receive
more data.

If hardware flow control is enabled (auto CTS) and the peer deasserts
CTS, wait_for_lsr() will timeout. If additionally console flow
control is active and while polling CTS the peer asserts CTS, the
console will assume it can immediately transmit, even though the
transmission registers may not be empty. This can lead to data loss.

Avoid this problem by performing an extra wait_for_lsr() upon CTS
assertion if wait_for_lsr() previously timed out.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 drivers/tty/serial/8250/8250_port.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index c91b0fa7111a7..b3247c55eebd5 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1984,16 +1984,20 @@ static bool wait_for_lsr(struct uart_8250_port *up, int bits)
 static void wait_for_xmitr(struct uart_8250_port *up, int bits)
 {
 	unsigned int tmout;
+	bool tx_ready;
 
-	wait_for_lsr(up, bits);
+	tx_ready = wait_for_lsr(up, bits);
 
 	/* Wait up to 1s for flow control if necessary */
 	if (uart_get_cons_flow(&up->port)) {
 		for (tmout = 1000000; tmout; tmout--) {
 			unsigned int msr = serial_in(up, UART_MSR);
 			up->msr_saved_flags |= msr & MSR_SAVE_FLAGS;
-			if (msr & UART_MSR_CTS)
+			if (msr & UART_MSR_CTS) {
+				if (!tx_ready)
+					wait_for_lsr(up, bits);
 				break;
+			}
 			udelay(1);
 			touch_nmi_watchdog();
 		}
-- 
2.47.3

