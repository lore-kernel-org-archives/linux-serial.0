Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355242638A2;
	Wed, 11 Jun 2025 10:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749636225; cv=none; b=PFGv6nmcrE6HXdr4EsO/yX/N9TqBoE3oG0AexSobY//lVXYtdP0GoM4+8c6GAi63sPfjOEnrylj9OGUovKG7mQ3fGROBopTVoDqO+KVySi8p3++8mUtn1SDfopff9kvPIJbWAYhN30xEAXJvGYj+s8SssNzzoQ5aUGfo3+kj41s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749636225; c=relaxed/simple;
	bh=0bsacJEh4/kwfEk4/swnlI17ttTGNYzZGHJ2+pD578k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uZ7MfNxzqg4yNRVv0YcE4CJpCSXE2RQTW633zZ0oDQf4Nj6l6AK6mB/+4NOXXc9HbswzBT0OBUSeEd2dkBuXV4KaezzMNFEBl8qtmGXk5U5Se330SBlYFuE1kSIxDj72DrA8dWbx0i+hWeDjame5LN+8luxNz+PjKXpn5sTpeOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PPCLUFhd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PPCLUFhd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB84BC4CEF5;
	Wed, 11 Jun 2025 10:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749636224;
	bh=0bsacJEh4/kwfEk4/swnlI17ttTGNYzZGHJ2+pD578k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PPCLUFhdE/Ddd87gvpZi9E+fuqdXWd/5NvItu5GZA0En0YsJXj3biGJRHzJ0PUteV
	 /zDo/lsvTTWws3djFcPt9m9370l292Fd2qbT2ICHxw+pl/hr9DkU9CdK5eLvZv6JOV
	 wHTfP4QExkAJ33QBV6bskN9q7kGwB4D7mFzExmJqChKCNtmcvBpI9+bXxHiz9cL/O2
	 4sIRavH1l6P9ZStfAx7xz0WiIOHSZZFls20Uu76ZDpendrMWzBm0QkG/QhQLmEiDGA
	 7iEYpo5cr0kfclfdwINdCnEdlIT8nHr8U+kTW0ZaRqHsGzbI/7IyKadvO8DXvN9CWM
	 W6F1YrX6ybxhg==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 09/33] serial: 8250: remove CONFIG_SERIAL_8250_RSA inline macros from code
Date: Wed, 11 Jun 2025 12:02:55 +0200
Message-ID: <20250611100319.186924-10-jirislaby@kernel.org>
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

All these:
  #ifdef CONFIG_SERIAL_8250_RSA
  ...
  #endif

in the 8250 generic code distract the reader. Introduce empty inlines to
handle the !CONFIG_SERIAL_8250_RSA case and handle the '#if's around the
RSA functions definitions.

This means rsa_autoconfig() and rsa_reset() functions were introduced to
contain the particular code.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/serial/8250/8250_port.c | 54 ++++++++++++++---------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index f5407832e8a7..233316a88df2 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -738,6 +738,9 @@ static int __enable_rsa(struct uart_8250_port *up)
 	return result;
 }
 
+/*
+ * If this is an RSA port, see if we can kick it up to the higher speed clock.
+ */
 static void enable_rsa(struct uart_8250_port *up)
 {
 	if (up->port.type == PORT_RSA) {
@@ -752,10 +755,9 @@ static void enable_rsa(struct uart_8250_port *up)
 }
 
 /*
- * Attempts to turn off the RSA FIFO.  Returns zero on failure.
- * It is unknown why interrupts were disabled in here.  However,
- * the caller is expected to preserve this behaviour by grabbing
- * the spinlock before calling this function.
+ * Attempts to turn off the RSA FIFO and resets the RSA board back to 115kbps compat mode. It is
+ * unknown why interrupts were disabled in here. However, the caller is expected to preserve this
+ * behaviour by grabbing the spinlock before calling this function.
  */
 static void disable_rsa(struct uart_8250_port *up)
 {
@@ -780,6 +782,25 @@ static void disable_rsa(struct uart_8250_port *up)
 		uart_port_unlock_irq(&up->port);
 	}
 }
+
+static void rsa_autoconfig(struct uart_8250_port *up)
+{
+	/* Only probe for RSA ports if we got the region. */
+	if (up->port.type == PORT_16550A && up->probe & UART_PROBE_RSA &&
+	    __enable_rsa(up))
+		up->port.type = PORT_RSA;
+}
+
+static void rsa_reset(struct uart_8250_port *up)
+{
+	if (up->port.type == PORT_RSA)
+		serial_out(up, UART_RSA_FRR, 0);
+}
+#else
+static inline void enable_rsa(struct uart_8250_port *up) {}
+static inline void disable_rsa(struct uart_8250_port *up) {}
+static inline void rsa_autoconfig(struct uart_8250_port *up) {}
+static inline void rsa_reset(struct uart_8250_port *up) {}
 #endif /* CONFIG_SERIAL_8250_RSA */
 
 /*
@@ -1267,14 +1288,7 @@ static void autoconfig(struct uart_8250_port *up)
 		break;
 	}
 
-#ifdef CONFIG_SERIAL_8250_RSA
-	/*
-	 * Only probe for RSA ports if we got the region.
-	 */
-	if (port->type == PORT_16550A && up->probe & UART_PROBE_RSA &&
-	    __enable_rsa(up))
-		port->type = PORT_RSA;
-#endif
+	rsa_autoconfig(up);
 
 	serial_out(up, UART_LCR, save_lcr);
 
@@ -1289,10 +1303,7 @@ static void autoconfig(struct uart_8250_port *up)
 	/*
 	 * Reset the UART.
 	 */
-#ifdef CONFIG_SERIAL_8250_RSA
-	if (port->type == PORT_RSA)
-		serial_out(up, UART_RSA_FRR, 0);
-#endif
+	rsa_reset(up);
 	serial8250_out_MCR(up, save_mcr);
 	serial8250_clear_fifos(up);
 	serial_in(up, UART_RX);
@@ -2248,13 +2259,7 @@ int serial8250_do_startup(struct uart_port *port)
 				UART_DA830_PWREMU_MGMT_FREE);
 	}
 
-#ifdef CONFIG_SERIAL_8250_RSA
-	/*
-	 * If this is an RSA port, see if we can kick it up to the
-	 * higher speed clock.
-	 */
 	enable_rsa(up);
-#endif
 
 	/*
 	 * Clear the FIFO buffers and disable them.
@@ -2521,12 +2526,7 @@ void serial8250_do_shutdown(struct uart_port *port)
 			serial_port_in(port, UART_LCR) & ~UART_LCR_SBC);
 	serial8250_clear_fifos(up);
 
-#ifdef CONFIG_SERIAL_8250_RSA
-	/*
-	 * Reset the RSA board back to 115kbps compat mode.
-	 */
 	disable_rsa(up);
-#endif
 
 	/*
 	 * Read data port to reset things, and then unlink from
-- 
2.49.0

