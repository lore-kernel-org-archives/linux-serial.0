Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6171BDA95;
	Fri, 13 Sep 2024 08:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726216803; cv=none; b=nveyDAXMMcuCOOfe3gF6f5OaN8n8iOnFaJExmw7u3Ts12yQHRVTm9Yu67x08m5JjN2evoJqxOzv08PW0wQKbYXUOyvTQNH8kVEzjJNdXM5ps1bh/DtYbFQg1bi+fQOwRbZUMTxH0wnsL3XMicl/8aFFSvNSmTi3QK+TJ8xvW/KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726216803; c=relaxed/simple;
	bh=a8ByUJ/uOEUjYWDnE/dtInA626JBUnf9q+ifF8JKvZE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uKnTsxnXiawSG9wcPxaQV4ZaXczsGjgIjHZDBKt7/NhlqqTe6bLmS7+/Pvg6DC7dsQ1ZgBLRfvA6E4NO6C5GgGC2mthG2tTH5CFBG5DWqOVxtlNhlmH0f65Jh7y4YYenblwoD27woSoQuDKJrUK/specvTs9NitX1hCsWATCCUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=FhBEH4dV; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="FhBEH4dV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=Cn4kUwYeuytQMsE365PcfJ/lfyo4K65OPmJ3B2UpHak=; b=FhBEH4dVFNOQBRMRZHZb4eqiIj
	LCLbWGFcapAevOvXliPBCb+AU2jQj7+2K9WHXJ5DAA01l7YWuvH8i8SnQl3YgX2JVePStIdRvKixO
	fZ2BwjSg42mEx3qsG1p3XLBf+vH+wGrssYzPpWlAhZ5Fz5J2bJjCSytYTYkBUauCgW9on87ukkkne
	eiMHRAULPYfvGHLkSdzY+aLlthac8OjrfEPSfBRVowstAWfdC+beauPbYv2C09+uB3dVWZRloHl3H
	niLiQIIlaJFwfZAnCWPDrIcOAmQ8CcbijjzU45OwF5zNCceifYnpNgECBlqn6eL40G8AJuq/6jQrD
	2u5z5TSA==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1sp1qM-000Dwt-ED; Fri, 13 Sep 2024 10:39:54 +0200
Received: from [80.62.117.18] (helo=localhost)
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <esben@geanix.com>)
	id 1sp1qL-0003OG-14;
	Fri, 13 Sep 2024 10:39:53 +0200
From: Esben Haabendal <esben@geanix.com>
Date: Fri, 13 Sep 2024 10:39:50 +0200
Subject: [PATCH 2/2] serial: imx: Add more comments on port lock status
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240913-serial-imx-lockfix-v1-2-4d102746c89d@geanix.com>
References: <20240913-serial-imx-lockfix-v1-0-4d102746c89d@geanix.com>
In-Reply-To: <20240913-serial-imx-lockfix-v1-0-4d102746c89d@geanix.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 John Ogness <john.ogness@linuxtronix.de>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Esben Haabendal <esben@geanix.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726216791; l=2785;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=a8ByUJ/uOEUjYWDnE/dtInA626JBUnf9q+ifF8JKvZE=;
 b=AMZZDzPDMOyiJ4EEnRXHPd4iG2IDMAY8tt+eJX/ZtFaPyLYNpgZWBCltOds8cFxRIf07u6wm5
 QSYxm2nthw7BKVpn2JUzUKnjm2szURFzUudeE3uSAnPiQMB16eDMI4f
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=
X-Authenticated-Sender: esben@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27396/Thu Sep 12 10:46:40 2024)

Comments regarding status of port.lock on internal functions is useful when
reviewing correct handling of registers that must be protected by this
lock.

Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 drivers/tty/serial/imx.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index efa3eb3a2c57..bea4510743ef 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -370,6 +370,7 @@ static void imx_uart_soft_reset(struct imx_port *sport)
 	sport->idle_counter = 0;
 }
 
+/* called with port.lock taken and irqs off */
 static void imx_uart_disable_loopback_rs485(struct imx_port *sport)
 {
 	unsigned int uts;
@@ -470,6 +471,7 @@ static void imx_uart_stop_tx(struct uart_port *port)
 	}
 }
 
+/* called with port.lock taken and irqs off */
 static void imx_uart_stop_rx_with_loopback_ctrl(struct uart_port *port, bool loopback)
 {
 	struct imx_port *sport = to_imx_port(port);
@@ -803,6 +805,8 @@ static irqreturn_t imx_uart_txint(int irq, void *dev_id)
  * issuing soft reset to the UART (just stop/start of RX does not help). Note
  * that what we do here is sending isolated start bit about 2.4 times shorter
  * than it is to be on UART configured baud rate.
+ *
+ * Called with port.lock taken and irqs off.
  */
 static void imx_uart_check_flood(struct imx_port *sport, u32 usr2)
 {
@@ -838,6 +842,7 @@ static void imx_uart_check_flood(struct imx_port *sport, u32 usr2)
 	}
 }
 
+/* called with port.lock taken and irqs off */
 static irqreturn_t __imx_uart_rxint(int irq, void *dev_id)
 {
 	struct imx_port *sport = dev_id;
@@ -916,6 +921,7 @@ static void imx_uart_clear_rx_errors(struct imx_port *sport);
 /*
  * We have a modem side uart, so the meanings of RTS and CTS are inverted.
  */
+/* called with port.lock taken and irqs off */
 static unsigned int imx_uart_get_hwmctrl(struct imx_port *sport)
 {
 	unsigned int tmp = TIOCM_DSR;
@@ -938,6 +944,8 @@ static unsigned int imx_uart_get_hwmctrl(struct imx_port *sport)
 
 /*
  * Handle any change of modem status signal since we were last called.
+ *
+ * Called with port.lock taken and irqs off.
  */
 static void imx_uart_mctrl_check(struct imx_port *sport)
 {
@@ -1277,6 +1285,7 @@ static int imx_uart_start_rx_dma(struct imx_port *sport)
 	return 0;
 }
 
+/* called with port.lock taken and irqs off */
 static void imx_uart_clear_rx_errors(struct imx_port *sport)
 {
 	struct tty_port *port = &sport->port.state->port;
@@ -1407,6 +1416,7 @@ static int imx_uart_dma_init(struct imx_port *sport)
 	return ret;
 }
 
+/* called with port.lock taken and irqs off */
 static void imx_uart_enable_dma(struct imx_port *sport)
 {
 	u32 ucr1;

-- 
2.46.0

