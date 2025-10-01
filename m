Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F5527703C;
	Wed,  1 Oct 2025 11:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759319297; cv=none; b=EBPcszDu5lGDu8q/W1TC3rilK1bYzg6WE+2UGdafiMV4gq2nemzEXcwQmdFvRqD73h/ujcLlFb9xuvSKCYxouPyxZsGi1HjWp0k4uDQUR9gjNWZ6x9AETcDpFp/fC7ySEfnnup3pa25qPPYXMV5OpgaZjfumIeHoqE8CeHqo+t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759319297; c=relaxed/simple;
	bh=8voT62oZgp4naNokBhr1QSxLG19Gn93M1T5OgAhUMtM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=MeWuniLh2i2tw2m9g0ffigq8mLees0na+lnxInbwuyRPKtJQeWp/e7NQw5o7UZ2UpwRhaH8zmRvGml85QUDk4+UkmTnj9RhZgfTeOPF2GTxDmGEGE4ncMVZXawLL+upQGQMC41sQU6E/qJay70HE82VK51ofpzYiv+8yJnAHBA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Received: from sven-desktop.home.narfation.org (p200300C5973A2bE00000000000000C00.dip0.t-ipconnect.de [IPv6:2003:c5:973a:2be0::c00])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id C57DAFA12C;
	Wed,  1 Oct 2025 13:48:06 +0200 (CEST)
From: Sven Eckelmann <se@simonwunderlich.de>
Date: Wed, 01 Oct 2025 13:47:26 +0200
Subject: [PATCH] serial: ar933x: Add polling support
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251001-ar933x-kgdb-support-v1-1-5fffd9e36a01@simonwunderlich.de>
X-B4-Tracking: v=1; b=H4sIAM0U3WgC/x3MMQqAMAxA0atIZgNtNYNeRRyqRg2CllRFKN7d4
 viG/xNEVuEIbZFA+ZYox55hywLG1e8Lo0zZ4Iwja4xFr01VPbgt04DxCuHQEx3NVJMdnKcGchm
 UZ3n+a9e/7wcXSglIZQAAAA==
X-Change-ID: 20251001-ar933x-kgdb-support-25f5451b2a59
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Sven Eckelmann <se@simonwunderlich.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3029; i=se@simonwunderlich.de;
 h=from:subject:message-id; bh=8voT62oZgp4naNokBhr1QSxLG19Gn93M1T5OgAhUMtM=;
 b=kA0DAAoWTQ93K9MU9csByyZiAGjdFNCiddfJQBd24bxkVsSADioXXJTzfGqXOAT2bk114CGq2
 Ih1BAAWCgAdFiEEvNRvz7MH7R/zlvHFTQ93K9MU9csFAmjdFNAACgkQTQ93K9MU9cuNxAEA09u2
 OamUKVXw/v1zDdAsze+u+xUnew8rWqbNmNrm+dUBAN6A7vjWbns3h9ZFCcFPGYvxj0DC/stTnYs
 qYm1PVIgK
X-Developer-Key: i=se@simonwunderlich.de; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF

KGDB requires at least the polling hooks .poll_get_char and .poll_put_char
to transmit/receive character via the serial driver.

Signed-off-by: Sven Eckelmann <se@simonwunderlich.de>
---
 drivers/tty/serial/ar933x_uart.c | 62 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/drivers/tty/serial/ar933x_uart.c b/drivers/tty/serial/ar933x_uart.c
index 8bb33556b31208a1707ca7a48db0aa2ca81452bd..5b491db9d2fc01e051f629f224024ac4dc4d35ff 100644
--- a/drivers/tty/serial/ar933x_uart.c
+++ b/drivers/tty/serial/ar933x_uart.c
@@ -560,6 +560,64 @@ static int ar933x_uart_verify_port(struct uart_port *port,
 	return 0;
 }
 
+#ifdef CONFIG_CONSOLE_POLL
+static int ar933x_poll_get_char(struct uart_port *port)
+{
+	struct ar933x_uart_port *up =
+		container_of(port, struct ar933x_uart_port, port);
+	unsigned int rdata;
+	unsigned char ch;
+	u32 imr;
+
+	/* Disable all interrupts */
+	imr = ar933x_uart_read(up, AR933X_UART_INT_EN_REG);
+	ar933x_uart_write(up, AR933X_UART_INT_EN_REG, 0);
+
+	rdata = ar933x_uart_read(up, AR933X_UART_DATA_REG);
+	if ((rdata & AR933X_UART_DATA_RX_CSR) == 0) {
+		/* Enable interrupts */
+		ar933x_uart_write(up, AR933X_UART_INT_EN_REG, imr);
+		return NO_POLL_CHAR;
+	}
+
+	/* remove the character from the FIFO */
+	ar933x_uart_write(up, AR933X_UART_DATA_REG,
+			  AR933X_UART_DATA_RX_CSR);
+
+	ch = rdata & AR933X_UART_DATA_TX_RX_MASK;
+
+	/* Enable interrupts */
+	ar933x_uart_write(up, AR933X_UART_INT_EN_REG, imr);
+
+	return ch;
+}
+
+static void ar933x_poll_put_char(struct uart_port *port, unsigned char c)
+{
+	struct ar933x_uart_port *up =
+		container_of(port, struct ar933x_uart_port, port);
+	u32 imr;
+
+	/* Disable all interrupts */
+	imr = ar933x_uart_read(up, AR933X_UART_INT_EN_REG);
+	ar933x_uart_write(up, AR933X_UART_INT_EN_REG, 0);
+
+	/* Wait until FIFO is empty */
+	while (!(ar933x_uart_read(up, AR933X_UART_DATA_REG) & AR933X_UART_DATA_TX_CSR))
+		cpu_relax();
+
+	/* Write a character */
+	ar933x_uart_putc(up, c);
+
+	/* Wait until FIFO is empty */
+	while (!(ar933x_uart_read(up, AR933X_UART_DATA_REG) & AR933X_UART_DATA_TX_CSR))
+		cpu_relax();
+
+	/* Enable interrupts */
+	ar933x_uart_write(up, AR933X_UART_INT_EN_REG, imr);
+}
+#endif
+
 static const struct uart_ops ar933x_uart_ops = {
 	.tx_empty	= ar933x_uart_tx_empty,
 	.set_mctrl	= ar933x_uart_set_mctrl,
@@ -576,6 +634,10 @@ static const struct uart_ops ar933x_uart_ops = {
 	.request_port	= ar933x_uart_request_port,
 	.config_port	= ar933x_uart_config_port,
 	.verify_port	= ar933x_uart_verify_port,
+#ifdef CONFIG_CONSOLE_POLL
+	.poll_get_char	= ar933x_poll_get_char,
+	.poll_put_char	= ar933x_poll_put_char,
+#endif
 };
 
 static int ar933x_config_rs485(struct uart_port *port, struct ktermios *termios,

---
base-commit: f83ec76bf285bea5727f478a68b894f5543ca76e
change-id: 20251001-ar933x-kgdb-support-25f5451b2a59

Best regards,
-- 
Sven Eckelmann <se@simonwunderlich.de>

