Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416EC449EA6
	for <linux-serial@vger.kernel.org>; Sat,  3 Oct 2026 15:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791042635; cv=none; b=P3817QlYLkfCDcQAo6MeB6DuFPi9Ob7eJXcCrxVUNvOvTCEKR2NbKa/92XsNQ1Z8JkSr0LVOLM1yZIF19pfRLH9AW0du3KDYJWY73DHCkaDFTc6kW/5aVzCvPNghO+257QLWZ3v6D16ZCtDUlEgeYh9wO9uIq4sDd66X7yFpdE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791042635; c=relaxed/simple;
	bh=VCFZL8C7CskzounbxL3E1vIVFsfQTCnNmtrH/w2/R7g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rwi60VswuCsdGq4bg4bTcS8hQSEObYI1QiwmiKqKp3uR+OtNXz/iSwj0EELW6I9Vrk27kG7CGNPx+ouhYS69TuVJv82Kp/RRqc7Z23UrzOQxIxZGbBYhKL8IG0n6VW8jkeUzcOK+oUQgxbIuQgpDNh2LvYdxyzHevXFauedehvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O3KmMy1k; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O3KmMy1k"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-49d0da752ffso4981635e9.3
        for <linux-serial@vger.kernel.org>; Sat, 03 Oct 2026 08:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791042630; x=1791647430; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tLpRB5yATHQpX0YPaKzhPzon6/tpk2LiYbV0aGm14kM=;
        b=O3KmMy1ktsfB2cPq0pFa/ayTgXXWwwknZSDwbw3Yerq8gtTtcnn0wxmop0hWKn7Ay9
         UfXATnMgHBpTsxZXUsNKkfDHXEka3FyziVTOzLS3FTZu8XgJigKaD2saDBR5yLh70x7m
         1GeyYAEwwJcHtfp3Gq9WuyOh7hpHU3R9d9iCznD7oLqd0daA/ElCR7p0FssH3xIZmu8K
         HdVI7BmM/HrOyTzOFr7Tb2/TKfohVjRCimfoBeFaJ/comgFwkXZvLeJz8A/xdrQT89p8
         avfPhptFpHAtySsl21OVBIIPvCpY6lqofGG7xXoDgfA9zO7k/pqc4/IF0LwfLFfA9NiO
         kgZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791042630; x=1791647430;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tLpRB5yATHQpX0YPaKzhPzon6/tpk2LiYbV0aGm14kM=;
        b=kAEJ1zMMJV0EIDbCPiE8HcAtyhTXFWUTHzOp833JRl0vQACf8kF6lgkvu7YkM4b71k
         uzv8FrdEFTvSngmvmhTWKKJPS+WizZH1O7EyCAGUSC69R+0kj2P1niNlgu/vzp72Q1UJ
         sBLLi35swiIiXWY7/LKZXRaQvC5iBRAJ0vLq1F9utfa3iZH9me6wiUAYUj2Kh/XjshKY
         T2OJ4X4m2EwP01QOiSHWp3VVvipPftjUpDw46T9npp/+7II+j8f/N1XDKkU13engJBeq
         pQTWa7/s/bMYobwmZ3Yxi1vgyOgfLHcCSZXRAsl19WEmHypcvHfAKM37vA7/lRGFKRVG
         Pl8A==
X-Forwarded-Encrypted: i=1; AKwUvBxR1gCWPIiKBp9d7qkN0KD+puEYxlllLu4jpqPp1/70gwVMzCBvGJwrbbHEd4ATsIEXLlXUiUCQD71fR2Q=@vger.kernel.org
X-Gm-Message-State: AFuF++kiIvaw5kbm04zTIFSGS4VHK2zyfidsz8pAR32w4xe8+zEtzL07
	EMC07A7kX/1ib3rDV6bydvemKHhKji0DYD8tyNnWekp9Lw5LtOEZ1pma
X-Gm-Gg: AYBFou3aVGAcpFqKRUlu/kn2Xae1063/Fkfi1pwjEE25sANO9RJXyQRFvGspnn1qYr0
	/v/0iIAMzhVGl4gpLnk95+/kxenP/297y4CAh2r+TQ5iS6bGvH1IV+rzOr2W/y3mG9DMm7pEYpV
	y1BWDkOKjNUANKos7eFgj34HzvqDmY0UXCAP6xyElXs7X8oD9xWBHXFD6DsTIK64YLzXJ0GAokM
	sIzAZGnzVJEfOcUi41kczlw55jDTRzDcAHO9nWOpiaiTduCC/+IeFmCq+GxrVYunrp4E1pLJg4q
	n05hr8IEiRIj4DP5X2S60PuarzfN2hdS1Wx5m6cd5dNcCA7QWCJjqFNBhV1FN76z/zN7TUpNbWw
	u3Mtr4+S56tencI+N8W32aIkjbAkDxlsJabZNQnNijhYqfvD1apLtmxx26TgHtDx2pR/q3R8PDt
	4VYXxYnXrWiQ9AAUys8HjFRGDb3PJEsf+RACCqOiNab2SpPYFnVCUytMRSDzl7A+K556UWyvkit
	cU8Q85x+hZKy6jvR1/v4WCqMavsjC9+Qdg2kSZizpgkQKhxozEcs2ufWX0fwCghcWZ1rdYlSsO7
	uim/
X-Received: by 2002:a05:600c:3110:b0:4a0:b6:4619 with SMTP id 5b1f17b1804b1-4a168069b91mr46835855e9.0.1791042630024;
        Sat, 03 Oct 2026 08:50:30 -0700 (PDT)
Received: from lap.lan (xdsl-31-165-251-31.adslplus.ch. [31.165.251.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b380fa61csm13483899f8f.17.2026.10.03.08.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 08:50:29 -0700 (PDT)
From: =?UTF-8?q?Jo=C3=A3o=20Loureiro?= <joaofl@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Sherry Sun <sherry.sun@nxp.com>,
	Frank Li <frank.li@nxp.com>,
	Alexander Dahl <ada@thorsis.com>,
	linux-serial@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Jo=C3=A3o=20Loureiro?= <joaofl@gmail.com>
Subject: [PATCH v2] serial: fsl_lpuart: add support for GPIO-controlled modem lines
Date: Sat,  3 Oct 2026 17:50:22 +0200
Message-ID: <20261003155022.466971-1-joaofl@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

LPUART has no register bit to drive RTS to a chosen level: UARTMODIR only
offers receiver-driven auto-RTS (RXRTSE) and RTS-during-transmit (TXRTSE).
Consequently lpuart_set_mctrl() and lpuart32_set_mctrl() ignore TIOCM_RTS,
and their get_mctrl() counterparts report a hardcoded
TIOCM_CAR | TIOCM_DSR | TIOCM_CTS.

That makes it impossible to talk to a peripheral which is driven by a
software controlled RTS strobe and answers on CTS.  TIOCMBIS/TIOCMBIC
silently do nothing, and because CTS always reads back as asserted, a
userspace handshake that waits for CTS to follow RTS can never complete:
de-asserting RTS and waiting for CTS to drop times out every time.  Boards
that route the two pins to plain GPIOs cannot work around it either, since
the driver never looks at rts-gpios/cts-gpios.

Wire the driver up to the serial_mctrl_gpio helpers, as imx.c and
atmel_serial.c already do.  set_mctrl() forwards the state to
mctrl_gpio_set(), and get_mctrl() runs the flags through mctrl_gpio_get()
so that a described cts-gpios overrides the assumed-asserted default.
Boards without such a description keep the previous behaviour.  Modem
status interrupts are enabled from startup() and disabled from shutdown(),
with a .enable_ms callback for the serial core.

The same limitation was reported for an i.MX 8XLite board that needs RS-485
with a GPIO RTS [1].  This change was developed and tested on an i.MX95
board whose barcode scanner is driven over LPUART with a manual RTS strobe;
with it, RTS toggles as requested and CTS is reported from the real pin.

[1] https://lore.kernel.org/all/20260210-rearview-hungrily-536a95fc3385@thorsis.com/

Signed-off-by: João Loureiro <joaofl@gmail.com>
---

Notes:
    Changes in v2:
    - Resend: v1 (Message-ID <20260819144458.253967-1-joaofl@gmail.com>)
      never reached the mailing lists, so it could not go through CI.
    - Rebased onto tty-next; no functional changes.

 drivers/tty/serial/Kconfig      |  1 +
 drivers/tty/serial/fsl_lpuart.c | 35 +++++++++++++++++++++++++++++++--
 2 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index bf680d22199b..cbf6b44d8a3e 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1316,6 +1316,7 @@ config SERIAL_FSL_LPUART
 	tristate "Freescale lpuart serial port support"
 	depends on HAS_DMA
 	select SERIAL_CORE
+	select SERIAL_MCTRL_GPIO if GPIOLIB
 	help
 	  Support for the on-chip lpuart on some Freescale SOCs.
 
diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index c8575c965203..909253aab212 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -27,6 +27,8 @@
 #include <linux/slab.h>
 #include <linux/tty_flip.h>
 
+#include "serial_mctrl_gpio.h"
+
 /* All registers are 8-bit width */
 #define UARTBDH			0x00
 #define UARTBDL			0x01
@@ -291,6 +293,7 @@ struct lpuart_port {
 	bool			is_cs7; /* Set to true when character size is 7 */
 					/* and the parity is enabled		*/
 	bool			dma_idle_int;
+	struct mctrl_gpios	*gpios;
 };
 
 struct lpuart_soc_data {
@@ -1528,6 +1531,7 @@ static int lpuart32_config_rs485(struct uart_port *port, struct ktermios *termio
 
 static unsigned int lpuart_get_mctrl(struct uart_port *port)
 {
+	struct lpuart_port *sport = container_of(port, struct lpuart_port, port);
 	unsigned int mctrl = 0;
 	u8 cr1;
 
@@ -1535,11 +1539,12 @@ static unsigned int lpuart_get_mctrl(struct uart_port *port)
 	if (cr1 & UARTCR1_LOOPS)
 		mctrl |= TIOCM_LOOP;
 
-	return mctrl;
+	return mctrl_gpio_get(sport->gpios, &mctrl);
 }
 
 static unsigned int lpuart32_get_mctrl(struct uart_port *port)
 {
+	struct lpuart_port *sport = container_of(port, struct lpuart_port, port);
 	unsigned int mctrl = TIOCM_CAR | TIOCM_DSR | TIOCM_CTS;
 	u32 ctrl;
 
@@ -1547,11 +1552,13 @@ static unsigned int lpuart32_get_mctrl(struct uart_port *port)
 	if (ctrl & UARTCTRL_LOOPS)
 		mctrl |= TIOCM_LOOP;
 
-	return mctrl;
+	/* A cts-gpio, when present, overrides the assumed-asserted CTS above. */
+	return mctrl_gpio_get(sport->gpios, &mctrl);
 }
 
 static void lpuart_set_mctrl(struct uart_port *port, unsigned int mctrl)
 {
+	struct lpuart_port *sport = container_of(port, struct lpuart_port, port);
 	u8 cr1;
 
 	cr1 = readb(port->membase + UARTCR1);
@@ -1562,10 +1569,13 @@ static void lpuart_set_mctrl(struct uart_port *port, unsigned int mctrl)
 		cr1 |= UARTCR1_LOOPS;
 
 	writeb(cr1, port->membase + UARTCR1);
+
+	mctrl_gpio_set(sport->gpios, mctrl);
 }
 
 static void lpuart32_set_mctrl(struct uart_port *port, unsigned int mctrl)
 {
+	struct lpuart_port *sport = container_of(port, struct lpuart_port, port);
 	u32 ctrl;
 
 	ctrl = lpuart32_read(port, UARTCTRL);
@@ -1576,6 +1586,15 @@ static void lpuart32_set_mctrl(struct uart_port *port, unsigned int mctrl)
 		ctrl |= UARTCTRL_LOOPS;
 
 	lpuart32_write(port, ctrl, UARTCTRL);
+
+	mctrl_gpio_set(sport->gpios, mctrl);
+}
+
+static void lpuart_enable_ms(struct uart_port *port)
+{
+	struct lpuart_port *sport = container_of(port, struct lpuart_port, port);
+
+	mctrl_gpio_enable_ms(sport->gpios);
 }
 
 static void lpuart_break_ctl(struct uart_port *port, int break_state)
@@ -1844,6 +1863,8 @@ static int lpuart_startup(struct uart_port *port)
 	lpuart_request_dma(sport);
 	lpuart_hw_setup(sport);
 
+	mctrl_gpio_enable_ms(sport->gpios);
+
 	return 0;
 }
 
@@ -1915,6 +1936,8 @@ static int lpuart32_startup(struct uart_port *port)
 	lpuart_request_dma(sport);
 	lpuart32_hw_setup(sport);
 
+	mctrl_gpio_enable_ms(sport->gpios);
+
 	return 0;
 }
 
@@ -1956,6 +1979,7 @@ static void lpuart_shutdown(struct uart_port *port)
 
 	uart_port_unlock_irqrestore(port, flags);
 
+	mctrl_gpio_disable_ms_sync(sport->gpios);
 	lpuart_dma_shutdown(sport);
 }
 
@@ -1990,6 +2014,7 @@ static void lpuart32_shutdown(struct uart_port *port)
 
 	uart_port_unlock_irqrestore(port, flags);
 
+	mctrl_gpio_disable_ms_sync(sport->gpios);
 	lpuart_dma_shutdown(sport);
 }
 
@@ -2441,6 +2466,7 @@ static const struct uart_ops lpuart_pops = {
 	.tx_empty	= lpuart_tx_empty,
 	.set_mctrl	= lpuart_set_mctrl,
 	.get_mctrl	= lpuart_get_mctrl,
+	.enable_ms	= lpuart_enable_ms,
 	.stop_tx	= lpuart_stop_tx,
 	.start_tx	= lpuart_start_tx,
 	.stop_rx	= lpuart_stop_rx,
@@ -2466,6 +2492,7 @@ static const struct uart_ops lpuart32_pops = {
 	.tx_empty	= lpuart32_tx_empty,
 	.set_mctrl	= lpuart32_set_mctrl,
 	.get_mctrl	= lpuart32_get_mctrl,
+	.enable_ms	= lpuart_enable_ms,
 	.stop_tx	= lpuart32_stop_tx,
 	.start_tx	= lpuart32_start_tx,
 	.stop_rx	= lpuart32_stop_rx,
@@ -2912,6 +2939,10 @@ static int lpuart_probe(struct platform_device *pdev)
 		sport->port.rs485_config = lpuart_config_rs485;
 	sport->port.rs485_supported = lpuart_rs485_supported;
 
+	sport->gpios = mctrl_gpio_init(&sport->port, 0);
+	if (IS_ERR(sport->gpios))
+		return PTR_ERR(sport->gpios);
+
 	sport->ipg_clk = devm_clk_get(&pdev->dev, "ipg");
 	if (IS_ERR(sport->ipg_clk)) {
 		ret = PTR_ERR(sport->ipg_clk);

base-commit: c44a4925cdac02af781ebfae96df68a7bf3580b0
-- 
2.55.0

