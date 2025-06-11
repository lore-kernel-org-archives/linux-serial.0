Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4728E26B0B6;
	Wed, 11 Jun 2025 10:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749636228; cv=none; b=tr2AkjVq97SplxdxufI136CaNXbNHNDcYYSoEyaMw3h7C+TswoIofQ3NMJG9Jy/eamD8anLRjep4Sa2cozfeDAI6IlOXVnPMG9TrEZ0tCpZW3S+OQ1W0wGGB4Ik1yVJ70LfkuUlreoEEn27BEiksSxpO99/0+3jnfl4PjPmSfms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749636228; c=relaxed/simple;
	bh=aqVbkfTUA8V0nJKIHfTwYOHOebwoKHiR0JhSOS93pEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eEsEVRqjo1JU/ohoRdTkG5YGaGU0ooe984SxSoa9VCwKFYwRNuhZrrnoaKE/1H1OE+hFqPzoyuqmuzgPzlSn1iev/5YUvRFuaIoHqCb2YOtKGy8xKNRTHtDkQO4xD13SzGumOU/9q36YpHBPBE10f0iYSrybfgrSH9Mzy76ASeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RnsbPBGB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RnsbPBGB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8C19C4CEF2;
	Wed, 11 Jun 2025 10:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749636227;
	bh=aqVbkfTUA8V0nJKIHfTwYOHOebwoKHiR0JhSOS93pEk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RnsbPBGBj7fVaW1UbWAmfdSlz5Pr134lZUnuDQyOIebvYMpelbuPfwD7RViLD/rlp
	 3SHhEF/8Lf++vh2FNDBl9fTypxkw2eeA3otWdodQfdpXsTm02CI9RT2S0/jzwa7iUe
	 r5g5XRMbY7i4ANAOhN9nUXCoucihI9s/PVMyoZt+vy0l/AksaHBmTHWWWB+xfYROd3
	 lm0Cd1kG88PGnvakZE4HNaZ7orZg0DyonQb14C3uHJUynd9wqAfVmLs35rqrec6WiB
	 vSQZkNnpwb87t6ToPR9UqXq1mNsc4+QCvotDBfWWRaXLdHdAv4SFtsvZNfYM2BixvJ
	 GodV9n0sie+ww==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 11/33] serial: 8250: put RSA functions to their namespace
Date: Wed, 11 Jun 2025 12:02:57 +0200
Message-ID: <20250611100319.186924-12-jirislaby@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250611100319.186924-1-jirislaby@kernel.org>
References: <20250611100319.186924-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prefix the functions with rsa_, not suffix.

This is a preparation for moving them out to 8250_rsa.c in the next
patch.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/serial/8250/8250_port.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index e7652d62ab2f..d8a90818f431 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -718,7 +718,7 @@ static void serial8250_clear_IER(struct uart_8250_port *up)
  * Attempts to turn on the RSA FIFO.  Returns zero on failure.
  * We set the port uart clock rate if we succeed.
  */
-static int __enable_rsa(struct uart_8250_port *up)
+static int __rsa_enable(struct uart_8250_port *up)
 {
 	unsigned char mode;
 	int result;
@@ -741,14 +741,14 @@ static int __enable_rsa(struct uart_8250_port *up)
 /*
  * If this is an RSA port, see if we can kick it up to the higher speed clock.
  */
-static void enable_rsa(struct uart_8250_port *up)
+static void rsa_enable(struct uart_8250_port *up)
 {
 	if (up->port.type != PORT_RSA)
 		return;
 
 	if (up->port.uartclk != SERIAL_RSA_BAUD_BASE * 16) {
 		uart_port_lock_irq(&up->port);
-		__enable_rsa(up);
+		__rsa_enable(up);
 		uart_port_unlock_irq(&up->port);
 	}
 	if (up->port.uartclk == SERIAL_RSA_BAUD_BASE * 16)
@@ -760,7 +760,7 @@ static void enable_rsa(struct uart_8250_port *up)
  * unknown why interrupts were disabled in here. However, the caller is expected to preserve this
  * behaviour by grabbing the spinlock before calling this function.
  */
-static void disable_rsa(struct uart_8250_port *up)
+static void rsa_disable(struct uart_8250_port *up)
 {
 	unsigned char mode;
 	int result;
@@ -794,7 +794,7 @@ static void rsa_autoconfig(struct uart_8250_port *up)
 	if (!(up->probe & UART_PROBE_RSA))
 		return;
 
-	if (__enable_rsa(up))
+	if (__rsa_enable(up))
 		up->port.type = PORT_RSA;
 }
 
@@ -806,8 +806,8 @@ static void rsa_reset(struct uart_8250_port *up)
 	serial_out(up, UART_RSA_FRR, 0);
 }
 #else
-static inline void enable_rsa(struct uart_8250_port *up) {}
-static inline void disable_rsa(struct uart_8250_port *up) {}
+static inline void rsa_enable(struct uart_8250_port *up) {}
+static inline void rsa_disable(struct uart_8250_port *up) {}
 static inline void rsa_autoconfig(struct uart_8250_port *up) {}
 static inline void rsa_reset(struct uart_8250_port *up) {}
 #endif /* CONFIG_SERIAL_8250_RSA */
@@ -2268,7 +2268,7 @@ int serial8250_do_startup(struct uart_port *port)
 				UART_DA830_PWREMU_MGMT_FREE);
 	}
 
-	enable_rsa(up);
+	rsa_enable(up);
 
 	/*
 	 * Clear the FIFO buffers and disable them.
@@ -2535,7 +2535,7 @@ void serial8250_do_shutdown(struct uart_port *port)
 			serial_port_in(port, UART_LCR) & ~UART_LCR_SBC);
 	serial8250_clear_fifos(up);
 
-	disable_rsa(up);
+	rsa_disable(up);
 
 	/*
 	 * Read data port to reset things, and then unlink from
-- 
2.49.0

