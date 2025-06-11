Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE99826A1DD;
	Wed, 11 Jun 2025 10:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749636226; cv=none; b=ZholNl16PK3wzmZjjpZPl93ygEhU9vMiHexK6gfvaSSub5pkx5A4HbE7ZcI5vyDCrov1OCA1L6dwm69Fsf/QhrKL/UACZQtaz3ZUO5pG2dn3+N/3wFcejDcEH4Bwzk8Hawd0Exx1PATrcscgpF1Mm8GBpF1Z7GTsuXs+qLFF8uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749636226; c=relaxed/simple;
	bh=zADBZh3/I+6iFXqflCXcndvocrGLcKPL2i3MplPDgAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xe7t1rA2/HrIfeyDtiacbW1vU9OomAzWQO7IiXaB0yTvi5l3SlSVmo2C9PhzEST3icCCE6xoZibrrhoV9MmfO70lGiRlV3aXAl4idM15LuBQRw5z+8gp8WQAwg85P3LeYy5W/P3NyTl7fMDmSvAw5E3kusDHVMI3sBv2acGlEgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hr7dYY7X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hr7dYY7X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37EB0C4CEF1;
	Wed, 11 Jun 2025 10:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749636226;
	bh=zADBZh3/I+6iFXqflCXcndvocrGLcKPL2i3MplPDgAs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hr7dYY7XREUs/MaaLoarDIL48Blok43CyLjPM6/8jdwGrV29QOCSt+n4h8em2tmbI
	 dSz6h8XpWGA5H9bZS/XdpdjeDJbHktO8jFi8UY20txhpZo8T39Sx5/AWaaF7+1kx1t
	 pP8vtg8hi+d+p1GQ/qgUmm5J2B21H6dHbB0O7MNu+f1TYWHeKkKEBsMDD96tpiCo7O
	 d+B60IXh+moyYQ0mCHBCu+keyreTput1FZzObn/29vdSGNYoNkF5Ucm3WUYXnWYXci
	 uoA3WM0jblfKIg239E28LrvWQIwu3iJKFDtm0T8q4mxTd4fycsAQ/TfQ5nCLDO3efI
	 WhmGVS3Kdjxqw==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 10/33] serial: 8250: invert conditions in RSA functions
Date: Wed, 11 Jun 2025 12:02:56 +0200
Message-ID: <20250611100319.186924-11-jirislaby@kernel.org>
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

The code can short-return in case something does not hold. So invert the
conditions and return in those cases immediately. This makes the code
flow more natural and less nested.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/serial/8250/8250_port.c | 59 +++++++++++++++++------------
 1 file changed, 34 insertions(+), 25 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 233316a88df2..e7652d62ab2f 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -743,15 +743,16 @@ static int __enable_rsa(struct uart_8250_port *up)
  */
 static void enable_rsa(struct uart_8250_port *up)
 {
-	if (up->port.type == PORT_RSA) {
-		if (up->port.uartclk != SERIAL_RSA_BAUD_BASE * 16) {
-			uart_port_lock_irq(&up->port);
-			__enable_rsa(up);
-			uart_port_unlock_irq(&up->port);
-		}
-		if (up->port.uartclk == SERIAL_RSA_BAUD_BASE * 16)
-			serial_out(up, UART_RSA_FRR, 0);
+	if (up->port.type != PORT_RSA)
+		return;
+
+	if (up->port.uartclk != SERIAL_RSA_BAUD_BASE * 16) {
+		uart_port_lock_irq(&up->port);
+		__enable_rsa(up);
+		uart_port_unlock_irq(&up->port);
 	}
+	if (up->port.uartclk == SERIAL_RSA_BAUD_BASE * 16)
+		serial_out(up, UART_RSA_FRR, 0);
 }
 
 /*
@@ -764,37 +765,45 @@ static void disable_rsa(struct uart_8250_port *up)
 	unsigned char mode;
 	int result;
 
-	if (up->port.type == PORT_RSA &&
-	    up->port.uartclk == SERIAL_RSA_BAUD_BASE * 16) {
-		uart_port_lock_irq(&up->port);
+	if (up->port.type != PORT_RSA)
+		return;
 
-		mode = serial_in(up, UART_RSA_MSR);
-		result = !(mode & UART_RSA_MSR_FIFO);
+	if (up->port.uartclk != SERIAL_RSA_BAUD_BASE * 16)
+		return;
 
-		if (!result) {
-			serial_out(up, UART_RSA_MSR, mode & ~UART_RSA_MSR_FIFO);
-			mode = serial_in(up, UART_RSA_MSR);
-			result = !(mode & UART_RSA_MSR_FIFO);
-		}
+	uart_port_lock_irq(&up->port);
+	mode = serial_in(up, UART_RSA_MSR);
+	result = !(mode & UART_RSA_MSR_FIFO);
 
-		if (result)
-			up->port.uartclk = SERIAL_RSA_BAUD_BASE_LO * 16;
-		uart_port_unlock_irq(&up->port);
+	if (!result) {
+		serial_out(up, UART_RSA_MSR, mode & ~UART_RSA_MSR_FIFO);
+		mode = serial_in(up, UART_RSA_MSR);
+		result = !(mode & UART_RSA_MSR_FIFO);
 	}
+
+	if (result)
+		up->port.uartclk = SERIAL_RSA_BAUD_BASE_LO * 16;
+	uart_port_unlock_irq(&up->port);
 }
 
 static void rsa_autoconfig(struct uart_8250_port *up)
 {
 	/* Only probe for RSA ports if we got the region. */
-	if (up->port.type == PORT_16550A && up->probe & UART_PROBE_RSA &&
-	    __enable_rsa(up))
+	if (up->port.type != PORT_16550A)
+		return;
+	if (!(up->probe & UART_PROBE_RSA))
+		return;
+
+	if (__enable_rsa(up))
 		up->port.type = PORT_RSA;
 }
 
 static void rsa_reset(struct uart_8250_port *up)
 {
-	if (up->port.type == PORT_RSA)
-		serial_out(up, UART_RSA_FRR, 0);
+	if (up->port.type != PORT_RSA)
+		return;
+
+	serial_out(up, UART_RSA_FRR, 0);
 }
 #else
 static inline void enable_rsa(struct uart_8250_port *up) {}
-- 
2.49.0

