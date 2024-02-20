Received: from mx2.securetransport.de (mx2.securetransport.de [188.68.39.254])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A0863117
	for <linux-serial@vger.kernel.org>; Tue, 20 Feb 2024 10:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.39.254
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708423637; cv=none; b=fJsF6n4Wk/NqN1qGUXGwNkpKSclRwJw2D9XfktTrs425TQDHcOlRXiK9Vx3xPoaL+YVk1w+jqSGp1mQFHohkxu+MeDwaXVQY1ewu8+AYWjk7E+CHRsxbErEuGOdWJ6EJdC/GIklzfpKV9CoN1aaiUYo2z1UQaqMwrF5VNbrSkt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708423637; c=relaxed/simple;
	bh=M0XpZ6HeNRNkfmIx1EpJxFW7bfcbGOXlwT4M/XUtYAc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kFTVjhjsfZEWWaV0X0+5EKdFD7NjJA/3oT0COK1rR+L1cNzj1WUiNP2mpDRsKH9A39QP3g+ptw5xk42V0m5Pa4CSRCsFrdznqOqNgyAjGHiRSxFc6jtfSRheLw/R3fScS19XAnpy2oeOjxIGFSz094TGhaSA3vC5p5HNN16xWmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com; spf=pass smtp.mailfrom=dh-electronics.com; dkim=pass (2048-bit key) header.d=dh-electronics.com header.i=@dh-electronics.com header.b=SxaLS9cp; arc=none smtp.client-ip=188.68.39.254
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dh-electronics.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dh-electronics.com header.i=@dh-electronics.com header.b="SxaLS9cp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
	s=dhelectronicscom; t=1708422961;
	bh=VkKll6ojm8/6jsuBX35DZl8SrdiDN3/71mYSJ8DLSzY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=SxaLS9cplPu3dzm8qnbvvj0G4043gcBc/p7uhxB735T2odgEEFJkhFkRyHK8ekP4r
	 ZKocJtn6GkHIIMa4zrpdOaCfLElZsWnKKubqlakgyiguzRTAdtC/pJFggNkQb8mQcQ
	 bXXcjTJ3iDUp3Qyt/OYGcXh1r3du/z+J9uJMGqDFfai8+1jrPAfHIsZXMZJH2fRdFh
	 E5eZz4dGxN8T5zZ9fNEPnGBkD0MeegzpNG4rXvKF8Z8WRyP3jLKn++7gbaMSjhvN9h
	 ocWFc/URAQVxHk5aN2FemrOKG0tJ3FbaQnLU7qAxjMG0dJMNhdY72ttjij3eTbrVjL
	 tou6RK6kbj7MQ==
From: Christoph Niedermaier <cniedermaier@dh-electronics.com>
To: <linux-serial@vger.kernel.org>
CC: Christoph Niedermaier <cniedermaier@dh-electronics.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
	<jirislaby@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Marek Vasut
	<marex@denx.de>, Fabio Estevam <festevam@denx.de>, Sascha Hauer
	<s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	NXP Linux Team <linux-imx@nxp.com>, Sergey Organov <sorganov@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Rob
 Herring <robh@kernel.org>, =?UTF-8?q?Ilpo=20J=C3=A4rvinen?=
	<ilpo.jarvinen@linux.intel.com>, Tom Rix <trix@redhat.com>, Thomas Gleixner
	<tglx@linutronix.de>, Lukas Wunner <lukas@wunner.de>
Subject: [RFC][PATCH] serial: imx: Fix RS485 behaviour on disabled RX_DURING_TX
Date: Tue, 20 Feb 2024 10:55:40 +0100
Message-ID: <20240220095540.3352-1-cniedermaier@dh-electronics.com>
X-klartext: yes
In-Reply-To: <20240220061243.4169045-1-rickaran@axis.com>
References: <20240220061243.4169045-1-rickaran@axis.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

I have made a patch that does not enable the loopback when
the RX_DURING_TX flag is disabled. Would you be so kind to
test my patch to see if it also solves your problem.

Regards
Christoph


Commit 79d0224f6bf2 ("tty: serial: imx: Handle RS485 DE signal active high")
activated the loopback mode for RS485 controlled by UART CTS_B when the
function imx_uart_stop_rx() is called. But through that changes the RS485
flag RX_DURING_TX isn’t able to turn off the receiver anymore. If the flag
RX_DURING_TX is disabled everything that was sent will be received due to
the active loopback. To turn off the receiver in this case the function
imx_uart_stop_rx() is extended by a wrapper function
imx_uart_stop_rx_with_loopback_rs485_ctrl() for the use of RS485 with
disabled flag RX_DURING_TX, where the receiver is turn off. For all other
cases there aren’t a functional change.

When the receiver is turned off the UART CTS_B signal is always high. To
ensure that the RS485 bus won’t blocked by a disabled receiver caused by a
high UART CTS_B signal the function imx_uart_shutdown() is extended. So in
RS485 loopback mode the receiver is always on after shutdown the device.

Fixes: 79d0224f6bf2 ("tty: serial: imx: Handle RS485 DE signal active high")
Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
---
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Marek Vasut <marex@denx.de>
Cc: Fabio Estevam <festevam@denx.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: Sergey Organov <sorganov@gmail.com>
Cc: "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>
Cc: Rob Herring <robh@kernel.org>
Cc: "Ilpo Järvinen" <ilpo.jarvinen@linux.intel.com>
Cc: Tom Rix <trix@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Lukas Wunner <lukas@wunner.de>
To: linux-serial@vger.kernel.org
---
 drivers/tty/serial/imx.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 4aa72d5aeafb..222e2c929bd7 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -463,7 +463,8 @@ static void imx_uart_stop_tx(struct uart_port *port)
 }
 
 /* called with port.lock taken and irqs off */
-static void imx_uart_stop_rx(struct uart_port *port)
+static void imx_uart_stop_rx_with_loopback_rs485_ctrl(struct uart_port *port,
+						  bool loopback_rs485_enable)
 {
 	struct imx_port *sport = (struct imx_port *)port;
 	u32 ucr1, ucr2, ucr4, uts;
@@ -483,7 +484,7 @@ static void imx_uart_stop_rx(struct uart_port *port)
 	imx_uart_writel(sport, ucr4, UCR4);
 
 	/* See SER_RS485_ENABLED/UTS_LOOP comment in imx_uart_probe() */
-	if (port->rs485.flags & SER_RS485_ENABLED &&
+	if (port->rs485.flags & SER_RS485_ENABLED && loopback_rs485_enable &&
 	    port->rs485.flags & SER_RS485_RTS_ON_SEND &&
 	    sport->have_rtscts && !sport->have_rtsgpio) {
 		uts = imx_uart_readl(sport, imx_uart_uts_reg(sport));
@@ -498,6 +499,12 @@ static void imx_uart_stop_rx(struct uart_port *port)
 }
 
 /* called with port.lock taken and irqs off */
+static void imx_uart_stop_rx(struct uart_port *port)
+{
+	imx_uart_stop_rx_with_loopback_rs485_ctrl(port, 1);
+}
+
+/* called with port.lock taken and irqs off */
 static void imx_uart_enable_ms(struct uart_port *port)
 {
 	struct imx_port *sport = (struct imx_port *)port;
@@ -684,7 +691,7 @@ static void imx_uart_start_tx(struct uart_port *port)
 
 			if (!(port->rs485.flags & SER_RS485_RX_DURING_TX) &&
 			    !port->rs485_rx_during_tx_gpio)
-				imx_uart_stop_rx(port);
+				imx_uart_stop_rx_with_loopback_rs485_ctrl(port, 0);
 
 			sport->tx_state = WAIT_AFTER_RTS;
 
@@ -1596,6 +1603,9 @@ static void imx_uart_shutdown(struct uart_port *port)
 		uts = imx_uart_readl(sport, imx_uart_uts_reg(sport));
 		uts |= UTS_LOOP;
 		imx_uart_writel(sport, uts, imx_uart_uts_reg(sport));
+		ucr2 = imx_uart_readl(sport, UCR2);
+		ucr2 |= UCR2_RXEN;
+		imx_uart_writel(sport, ucr2, UCR2);
 		ucr1 |= UCR1_UARTEN;
 	} else {
 		ucr1 &= ~UCR1_UARTEN;
-- 
2.11.0

