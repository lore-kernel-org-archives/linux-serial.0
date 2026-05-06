Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A1B44D020;
	Wed,  6 May 2026 12:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778069773; cv=none; b=egZPYSRua3hAAil5KxWpfXB0kAS2JAVEgI/SU6TO9ULjgp23UcXcjtoLtz+2QJ3wbJgBpVFsAhwXi5SLjDNtpwCbPdR06dvrB72VhM4hVrdnckTKNKGZ+Wr1TebdxXvRa5LkeO2kOwNQxIqxEz/CRJ7MvQ6RYMxahjHX3Y/ttMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778069773; c=relaxed/simple;
	bh=SB34X/ZdUpzR6E7fbHBweup02Nl2fDDJs+9DMnt2sOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hDUfup323FU950qNdNNC76PCjMsmQsoMMhI5hCXfutkDQx+GT/HDeVXxp+n25c7hCkdjLU/QHkn/dfen7jL6EJlH09x16duKq+KJ0wPh+gL4uRhchX/jKBNyufguzBJi7zk4Iugco3q5A6B7LXaZ/dzDMSpEoIzLj0I4VEF4o+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vmx4N+4Z; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YhRd+XBI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vmx4N+4Z";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YhRd+XBI"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1778069769;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AHAqtTbvwO8xcfrhhVzAqkOIkaPCLZmg1OdSKQBShJY=;
	b=vmx4N+4ZD8ZtCecZ3/fS+PVChHQ6FkU6NZPXuVpZ48fZPB2e9wILqgifq4f0NkzTqd8jCg
	JgdEAy8fJi3t7WMpHixD5hlPs61ECqztD/AzNFA34Y0aELAgDCDHCRZSDCw8140MLwYown
	GzbMmSEM4X6ZxSoyiiAjxYTu4rvfuJHjCu8Ayz33LJo+P83jnBDPytEcZZi6R3i+Wnl4jC
	0w42e5G63kODdlgCo5XSTlHt0MawCQzvviIm2cXqBscXLgsKMCCC31oXFXYhNvO+Fl0BX9
	bifSeaIEyX/heZLeHwAPgido1wUNifzb+6r/mLVmzjJ554Qdd0gbBCM/j7uT/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1778069769;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AHAqtTbvwO8xcfrhhVzAqkOIkaPCLZmg1OdSKQBShJY=;
	b=YhRd+XBI4sxmJsa98D1SN3IWbItEqGq735CxSRCZq3OOk8Sm8IlCBuXXOwLfn6x88e/n8u
	2NeQM70luCZHJuDg==
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-serial@vger.kernel.org
Subject: [PATCH tty v4 5/6] serial: 8250: Check LSR timeout on console flow control
Date: Wed,  6 May 2026 14:22:00 +0206
Message-ID: <20260506121606.5805-6-john.ogness@linutronix.de>
In-Reply-To: <20260506121606.5805-1-john.ogness@linutronix.de>
References: <20260506121606.5805-1-john.ogness@linutronix.de>
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
index dbed5e5767541..719789013f6df 100644
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

