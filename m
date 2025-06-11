Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169E826E71E;
	Wed, 11 Jun 2025 10:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749636237; cv=none; b=DnG7GKJbUbGVWN52NMulseX14RqSTGeStMfFC4WfUKj1ZBCYo4DbcKRFwpEJARd0xvQKiKWfntGzAyK8t6c2Phgf3QO1kCYgDzlejdHQ5QFxWYYTkPhmqsi2l1fDp0YIqtE98C3x2yzcOy/RfNio3gfKVs/Qvz4UiTF9RntPcJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749636237; c=relaxed/simple;
	bh=JdzKrio3EtFrI1IOdFlxX4OF4VPG1PDPzdE0atRSivE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XRkwPTbRKgrwMNpsMANvpv31QZb1pCv8DeNMyHuNKwo1NhX1yopKn6mHnidGtyvqtGZOImV5x+YgbsBntmWlvRr/6b+fv87B3wVznYL8rolEfBM/RnWNaFZqwDdHte5IC7JcQ8XDSOjExBaG1KZkg59lwzpw/3QJVO3T6Zdjid0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V07hw66b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V07hw66b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB4DBC4CEF2;
	Wed, 11 Jun 2025 10:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749636237;
	bh=JdzKrio3EtFrI1IOdFlxX4OF4VPG1PDPzdE0atRSivE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V07hw66bgqRQnFUhXu4wLWW7KUrpu/dThYLLlg6JnDeQnUwMaKGowFFpaYU1wdVje
	 N+SLbNh7EsPdd20SaGZFRld2jUFfWVgoqLdopkj4A+EeO6xrrCdoOB0Rq4DcH2SGWV
	 Rp7f/KWhOmTMwS7E6cVoKyZH5exXd9Z4gs9ZtpDAgsIkpJIAmMDyUUUMLVUUspBrvG
	 p3QSFZncys7WUCNQ4Th2HQmW4d5dR1R9ccw0wfWgpEuLTg97ZAwjoPr2TU0WsOeW3h
	 2DwoKMkhZWswotkZbMnwpRQKIrajhv5pKgmgx5syMpd1VLSpQK6OHPQZaa909zWOSl
	 XJY6HHtjaWesw==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 17/33] serial: 8250: extract serial8250_clear_interrupts()
Date: Wed, 11 Jun 2025 12:03:03 +0200
Message-ID: <20250611100319.186924-18-jirislaby@kernel.org>
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

On three places in 8250_port.c, the interrupts are cleared by reading 4
registers. Extract this to a separate function:
serial8250_clear_interrupts(). And call it from all the places.

Note autoconfig_irq() now uses serial_port_in() instead of serial_in().
But they are the same, in fact (modulo parameter).

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/serial/8250/8250_port.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 6851c197b31d..a73f4db22feb 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -705,6 +705,15 @@ static void serial8250_set_sleep(struct uart_8250_port *p, int sleep)
 	serial8250_rpm_put(p);
 }
 
+/* Clear the interrupt registers. */
+static void serial8250_clear_interrupts(struct uart_port *port)
+{
+	serial_port_in(port, UART_LSR);
+	serial_port_in(port, UART_RX);
+	serial_port_in(port, UART_IIR);
+	serial_port_in(port, UART_MSR);
+}
+
 static void serial8250_clear_IER(struct uart_8250_port *up)
 {
 	if (up->capabilities & UART_CAP_UUE)
@@ -1275,10 +1284,7 @@ static void autoconfig_irq(struct uart_8250_port *up)
 	uart_port_lock_irq(port);
 	serial_out(up, UART_IER, UART_IER_ALL_INTR);
 	uart_port_unlock_irq(port);
-	serial_in(up, UART_LSR);
-	serial_in(up, UART_RX);
-	serial_in(up, UART_IIR);
-	serial_in(up, UART_MSR);
+	serial8250_clear_interrupts(port);
 	serial_out(up, UART_TX, 0xFF);
 	udelay(20);
 	irq = probe_irq_off(irqs);
@@ -2322,13 +2328,7 @@ int serial8250_do_startup(struct uart_port *port)
 	 */
 	serial8250_clear_fifos(up);
 
-	/*
-	 * Clear the interrupt registers.
-	 */
-	serial_port_in(port, UART_LSR);
-	serial_port_in(port, UART_RX);
-	serial_port_in(port, UART_IIR);
-	serial_port_in(port, UART_MSR);
+	serial8250_clear_interrupts(port);
 
 	/*
 	 * At this point, there's no way the LSR could still be 0xff;
@@ -2363,10 +2363,7 @@ int serial8250_do_startup(struct uart_port *port)
 	 * saved flags to avoid getting false values from polling
 	 * routines or the previous session.
 	 */
-	serial_port_in(port, UART_LSR);
-	serial_port_in(port, UART_RX);
-	serial_port_in(port, UART_IIR);
-	serial_port_in(port, UART_MSR);
+	serial8250_clear_interrupts(port);
 	up->lsr_saved_flags = 0;
 	up->msr_saved_flags = 0;
 
-- 
2.49.0

