Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDAF3D88F6;
	Fri, 10 Apr 2026 14:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775832596; cv=none; b=pbBX5Jn5gawz4ZZ1c+gu/7mndXSttm9mjC8Sw4aGBdvLutTxce0fJDIlVafJsz2LfI7e081F56X/hZX94LXE7G4ZQ9HlqdMpAUtrtbXw8Wvp6CV2DZS3/d3SMCiUXO7IdO2izxNoEPht+MmRFrkBmqbhYByp7pd5Whjx2g8xues=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775832596; c=relaxed/simple;
	bh=DRN1x/oQ5Z1uKX0YUU9OtcaRzDixkESbp8P5tXM4OnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uorkv3e7jpuhsKM3R/QcaAt4FSnupEeO5DMy+1garwJrZQxslpQ56uvtdh15MfoX8hO5RrxrAo311DWDRsTQULLrnHhhJ2aUb9pa0QEuCaod3CpYKhN8xUlM25oyJGpYTq7p7Jl1u3JPoZ/ybja58Tg4ERtu59X5zRTXxsVWaPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zQ7pXlfo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+nizOHQp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zQ7pXlfo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+nizOHQp"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1775832590;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PQ4MqevHZebQMgVooazoGst1GA9UP6Mqkqsx5rKMs1A=;
	b=zQ7pXlfonAM0wK5TNzfD7uZ6MayebNMt1mF6wZpQ8TmTqPcYPLHHxQcb8Fq3NIcOnPqCyX
	E9kts5Ph4r2PLBKnYXrdcyxXZWNVymuT107xs0yONPfLmjNH+uB0j71BW5BRDczKUs3k7Z
	7DEht32tCf+GGAO5lmJ6Xq4aklyTCVAD0XilUeuZXJa2lO874gBLdddN8d4VtZVo36D+0M
	LUz5MWlJqapnI4NiPm3tyYgEN+JGrLN7lV1u6DbIhXnOzl0ezEuC0h0JRn8ifWHsCpqQ7U
	C/d8a+qaKGyxoc0O/jWVtgiqXDLhNmXC0S+/303cR3Ubjrs0bnznRlnLwRgp2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1775832590;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PQ4MqevHZebQMgVooazoGst1GA9UP6Mqkqsx5rKMs1A=;
	b=+nizOHQpkc7gpgRWjaRkEx7esXpYks2wsXPQnFzy47Eowfp8t8i7wy2a22IaIp7rsfb403
	SKKQe2Lj5dLJa/BA==
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-serial@vger.kernel.org
Subject: [PATCH tty v2 1/2] serial: 8250: Check LSR timeout on console flow control
Date: Fri, 10 Apr 2026 16:54:33 +0206
Message-ID: <20260410144949.16581-2-john.ogness@linutronix.de>
In-Reply-To: <20260410144949.16581-1-john.ogness@linutronix.de>
References: <20260410144949.16581-1-john.ogness@linutronix.de>
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

When console flow control is active (UPF_CONS_FLOW), wait_for_xmitr()
additionally polls CTS, waiting for the peer to signal that it is
ready to receive more data.

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
index af78cc02f38e7..a739350e634f9 100644
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
 	if (up->port.flags & UPF_CONS_FLOW) {
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

