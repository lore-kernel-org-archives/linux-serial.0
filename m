Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10E6274676;
	Wed, 11 Jun 2025 10:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749636255; cv=none; b=SmKxIoriejl5QCubPDtiBtkp8Uur0JIwC/0hRYFBJ47r1ssD7rrJD0TMdxepqhzK8nDtYtM7airh1OD9oPe8wWq6wQSNdZeeMcmX48gL0VoegMrZCKGVVnDrKF4vpzm3rzLcZzqYCS6mvDfjegHBBL2AN/Prg4AznKE1DN4ltFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749636255; c=relaxed/simple;
	bh=/pmfUrZUdBfKWuAWDNedV43TaddT3zUC0Xn4iWMbi6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AcYa/j/cQNLqBW3eEoaZrdN2OlnYir+Jb1nuILHy6Se6B5miF9HpfDd/i4bnHgxkig8E3wDtquV6W00ITibPXzCAERSRlTuc13KJSbQypkCEXtEIfJyHSo7bLsV+WKcyVRY/RBcWgmWDdmvt5s1ERtKCFdu3UYFv29P4egWqs+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bY2CsjGy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bY2CsjGy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32E05C4CEEE;
	Wed, 11 Jun 2025 10:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749636255;
	bh=/pmfUrZUdBfKWuAWDNedV43TaddT3zUC0Xn4iWMbi6c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bY2CsjGyKXjOmsqONsJFd2Vlwrfu5mSsTfjM+dacdICNsmkIYDD+/OzESSj1/CkLK
	 A7YhuswTiRwTnhz9qflVzw2JwU+TPlgrC5tr2wgrUBJs6LAFa7NbLpT7M/y5ZwK/lu
	 P/rbJf1QqzygDvNtOSDHwDfvwoG36zmQHecb3zT88xzt7crVaHtNMNvtEmHVMmFGey
	 c6NAL59LERm4FYH3mnX3IdqE1m1eTSzvsHSfn9/BP3NxMSfFKoVYiQiy6AN7/hx/kW
	 0tcRzTeYRdSgG3och6vfBi1PFGuvbGSU2h5r/jgVJx/FlCAA41mcuxQrMv8qKMwSyq
	 T2FVuSB/KMLWg==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 29/33] serial: 8250: drop DEBUG_AUTOCONF() macro
Date: Wed, 11 Jun 2025 12:03:15 +0200
Message-ID: <20250611100319.186924-30-jirislaby@kernel.org>
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

DEBUG_AUTOCONF() is always disabled (by "#if 0"), so one would need to
recompile the kernel to use it. And even if they did, they would find
out it is broken anyway:
  error: variable 'scratch' is used uninitialized whenever 'if' condition is false

Drop it.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/serial/8250/8250_port.c | 39 ++---------------------------
 1 file changed, 2 insertions(+), 37 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 6363915a1787..e93bfdac3d0e 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -38,15 +38,6 @@
 
 #include "8250.h"
 
-/*
- * Debugging.
- */
-#if 0
-#define DEBUG_AUTOCONF(fmt...)	printk(fmt)
-#else
-#define DEBUG_AUTOCONF(fmt...)	do { } while (0)
-#endif
-
 /*
  * Here we define the default xmit fifo size used for each type of UART.
  */
@@ -825,8 +816,6 @@ static void autoconfig_has_efr(struct uart_8250_port *up)
 	id3 = serial_icr_read(up, UART_ID3);
 	rev = serial_icr_read(up, UART_REV);
 
-	DEBUG_AUTOCONF("950id=%02x:%02x:%02x:%02x ", id1, id2, id3, rev);
-
 	if (id1 == 0x16 && id2 == 0xC9 &&
 	    (id3 == 0x50 || id3 == 0x52 || id3 == 0x54)) {
 		up->port.type = PORT_16C950;
@@ -850,7 +839,6 @@ static void autoconfig_has_efr(struct uart_8250_port *up)
 	 *  0x14 - XR16C854.
 	 */
 	id1 = autoconfig_read_divisor_id(up);
-	DEBUG_AUTOCONF("850id=%04x ", id1);
 
 	id2 = id1 >> 8;
 	if (id2 == 0x10 || id2 == 0x12 || id2 == 0x14) {
@@ -937,7 +925,6 @@ static void autoconfig_16550a(struct uart_8250_port *up)
 	if (serial_in(up, UART_EFR) == 0) {
 		serial_out(up, UART_EFR, 0xA8);
 		if (serial_in(up, UART_EFR) != 0) {
-			DEBUG_AUTOCONF("EFRv1 ");
 			up->port.type = PORT_16650;
 			up->capabilities |= UART_CAP_EFR | UART_CAP_SLEEP;
 		} else {
@@ -950,8 +937,6 @@ static void autoconfig_16550a(struct uart_8250_port *up)
 
 			if (status1 == UART_IIR_FIFO_ENABLED_16750)
 				up->port.type = PORT_16550A_FSL64;
-			else
-				DEBUG_AUTOCONF("Motorola 8xxx DUART ");
 		}
 		serial_out(up, UART_EFR, 0);
 		return;
@@ -963,7 +948,6 @@ static void autoconfig_16550a(struct uart_8250_port *up)
 	 */
 	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
 	if (serial_in(up, UART_EFR) == 0 && !broken_efr(up)) {
-		DEBUG_AUTOCONF("EFRv2 ");
 		autoconfig_has_efr(up);
 		return;
 	}
@@ -1026,8 +1010,6 @@ static void autoconfig_16550a(struct uart_8250_port *up)
 
 	serial_out(up, UART_LCR, 0);
 
-	DEBUG_AUTOCONF("iir1=%d iir2=%d ", status1, status2);
-
 	if (status1 == UART_IIR_FIFO_ENABLED_16550A &&
 	    status2 == UART_IIR_FIFO_ENABLED_16750) {
 		up->port.type = PORT_16750;
@@ -1056,17 +1038,10 @@ static void autoconfig_16550a(struct uart_8250_port *up)
 			 * It's an Xscale.
 			 * We'll leave the UART_IER_UUE bit set to 1 (enabled).
 			 */
-			DEBUG_AUTOCONF("Xscale ");
 			up->port.type = PORT_XSCALE;
 			up->capabilities |= UART_CAP_UUE | UART_CAP_RTOIE;
 			return;
 		}
-	} else {
-		/*
-		 * If we got here we couldn't force the IER_UUE bit to 0.
-		 * Log it and continue.
-		 */
-		DEBUG_AUTOCONF("Couldn't force IER_UUE to 0 ");
 	}
 	serial_out(up, UART_IER, iersave);
 
@@ -1098,9 +1073,6 @@ static void autoconfig(struct uart_8250_port *up)
 	if (!port->iobase && !port->mapbase && !port->membase)
 		return;
 
-	DEBUG_AUTOCONF("%s: autoconf (0x%04lx, 0x%p): ",
-		       port->name, port->iobase, port->membase);
-
 	/*
 	 * We really do need global IRQs disabled here - we're going to
 	 * be frobbing the chips IRQ enable register to see if it exists.
@@ -1147,9 +1119,7 @@ static void autoconfig(struct uart_8250_port *up)
 			 * We failed; there's nothing here
 			 */
 			uart_port_unlock_irqrestore(port, flags);
-			DEBUG_AUTOCONF("IER test failed (%02x, %02x) ",
-				       scratch2, scratch3);
-			goto out;
+			return;
 		}
 	}
 
@@ -1171,9 +1141,7 @@ static void autoconfig(struct uart_8250_port *up)
 		serial8250_out_MCR(up, save_mcr);
 		if (status1 != (UART_MSR_DCD | UART_MSR_CTS)) {
 			uart_port_unlock_irqrestore(port, flags);
-			DEBUG_AUTOCONF("LOOP test failed (%02x) ",
-				       status1);
-			goto out;
+			return;
 		}
 	}
 
@@ -1241,9 +1209,6 @@ static void autoconfig(struct uart_8250_port *up)
 		dev_warn(port->dev, "detected caps %08x should be %08x\n",
 			 old_capabilities, up->capabilities);
 	}
-out:
-	DEBUG_AUTOCONF("iir=%d ", scratch);
-	DEBUG_AUTOCONF("type=%s\n", uart_config[port->type].name);
 }
 
 static void autoconfig_irq(struct uart_8250_port *up)
-- 
2.49.0

