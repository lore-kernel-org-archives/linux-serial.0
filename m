Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F36931282F;
	Mon, 11 May 2026 15:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778513231; cv=none; b=KlPkZVzltLo7ngB0jdcNU1H2RaXiGohaEuyohBtXFV2k4KY0OIrGIHAqi8lCeQhPx8D94VUuHksEPvzBz4ajyP0ze8E7cKA5sRFbD14hRAOje7ott95OlHbblzbihliTJqmqv2LIqqGoazbZsiHeMzdaDGoz4q2TFPX+0mITBIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778513231; c=relaxed/simple;
	bh=MUlSn0UiWR09shuTnt0BYBc6SZJng0VDgqjX/7w6C50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=usPkm6eYE42NPDHQWEDCQXn++YY9r4nwZj4Czw7SBBrU0KKMDS33EcdTIKsd/4iPAIVhW+jNrQG70owv1ZcrKDQmwSEEOUtKDvbKCDoPuVCLOadUIt0P2bHimxRNHL7udMFiCoyfqYGmP9wxH/9AeLz6SleSE9Psrx3zXgLqSFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c1fv/7nr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/rQIaL2R; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c1fv/7nr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/rQIaL2R"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1778513228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gOn3r2tGi+YkPttbA658zBvIXmEx/XTTS4KknxXdib4=;
	b=c1fv/7nrDrNNygXanDkRiOi5UnEOd1WRn0OeDIAdyGXdbU3oOjdar+Qdd/Li5Dr1Jgr8Pi
	SPI9udHST02OWoWxb59DG8R6mh+UujDpYLiUMSOIkiHpiecTcClFm9FOuW37mEpSqKuLxE
	MS05Ztzgq8axEsI7Ow1YbUiXLN4f8aj5uucwmyKbW+bVX5MWV4i+/FV/OHJRBuCxSCo4hO
	8HoF0sz2jFk9jt8KhAGjmBYbk2jp/cXh1/96+o9llpRmzzKljOsqRrBx+vTfbTZvPcxsJC
	HPDfOZCOmuqgAUiqkrXjbFjsntDKXftUKKJ7F/eSH5zz7pqE1lx5Ein/sGLfYA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1778513228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gOn3r2tGi+YkPttbA658zBvIXmEx/XTTS4KknxXdib4=;
	b=/rQIaL2R9pdE3o4hRz+z4sI900ESuQbw24+2TGulCgIaT+49rvBYPXf/kxpx+FMXcMnPE0
	XGQ48U1uOhW3TRAg==
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-serial@vger.kernel.org
Subject: [PATCH tty v5 2/3] serial: 8250: Check LSR timeout on console flow control
Date: Mon, 11 May 2026 17:33:01 +0206
Message-ID: <20260511152706.151498-3-john.ogness@linutronix.de>
In-Reply-To: <20260511152706.151498-1-john.ogness@linutronix.de>
References: <20260511152706.151498-1-john.ogness@linutronix.de>
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
index e4e6a53ebea39..fe2e0f1e66c21 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1986,16 +1986,20 @@ static bool wait_for_lsr(struct uart_8250_port *up, int bits)
 static void wait_for_xmitr(struct uart_8250_port *up, int bits)
 {
 	unsigned int tmout;
+	bool tx_ready;
 
-	wait_for_lsr(up, bits);
+	tx_ready = wait_for_lsr(up, bits);
 
 	/* Wait up to 1s for flow control if necessary */
 	if (uart_cons_flow_enabled(&up->port)) {
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

