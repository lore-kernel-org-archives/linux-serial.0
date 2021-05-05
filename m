Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C76EC433ED
	for <linux-serial@archiver.kernel.org>; Wed,  5 May 2021 09:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 761CE613F9
	for <linux-serial@archiver.kernel.org>; Wed,  5 May 2021 09:20:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232525AbhEEJVJ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 5 May 2021 05:21:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:41350 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232297AbhEEJUk (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 5 May 2021 05:20:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 59B2FB158;
        Wed,  5 May 2021 09:19:43 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>, Arnd Bergmann <arnd@arndb.de>,
        David Lin <dtwlin@gmail.com>, Johan Hovold <johan@kernel.org>,
        Alex Elder <elder@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Oliver Neukum <oneukum@suse.com>
Subject: [PATCH 35/35] tty: make use of tty_get_byte_size
Date:   Wed,  5 May 2021 11:19:28 +0200
Message-Id: <20210505091928.22010-36-jslaby@suse.cz>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210505091928.22010-1-jslaby@suse.cz>
References: <20210505091928.22010-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

In the previous patch, we introduced tty_get_byte_size for computing
byte size. Here, we make use of it in various tty drivers.

The stats look nice: 16 insertions, 203 deletions.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: David Lin <dtwlin@gmail.com>
Cc: Johan Hovold <johan@kernel.org>
Cc: Alex Elder <elder@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Oliver Neukum <oneukum@suse.com>
---
 drivers/char/pcmcia/synclink_cs.c           |  8 +-----
 drivers/staging/greybus/uart.c              | 16 +----------
 drivers/tty/serial/cpm_uart/cpm_uart_core.c | 19 +-----------
 drivers/tty/serial/mxs-auart.c              | 18 +-----------
 drivers/tty/serial/qcom_geni_serial.c       | 16 +----------
 drivers/tty/serial/sh-sci.c                 | 20 +------------
 drivers/tty/serial/stm32-usart.c            | 32 +--------------------
 drivers/tty/synclink_gt.c                   |  9 +-----
 drivers/usb/class/cdc-acm.c                 | 17 ++---------
 drivers/usb/serial/belkin_sa.c              | 21 ++------------
 drivers/usb/serial/cypress_m8.c             | 19 ++----------
 drivers/usb/serial/pl2303.c                 | 15 +---------
 drivers/usb/serial/whiteheat.c              |  9 +-----
 13 files changed, 16 insertions(+), 203 deletions(-)

diff --git a/drivers/char/pcmcia/synclink_cs.c b/drivers/char/pcmcia/synclink_cs.c
index 9f7420bc5026..502d04da54ba 100644
--- a/drivers/char/pcmcia/synclink_cs.c
+++ b/drivers/char/pcmcia/synclink_cs.c
@@ -1419,13 +1419,7 @@ static void mgslpc_change_params(MGSLPC_INFO *info, struct tty_struct *tty)
 
 	/* byte size and parity */
 
-	switch (cflag & CSIZE) {
-	case CS5: info->params.data_bits = 5; break;
-	case CS6: info->params.data_bits = 6; break;
-	case CS7: info->params.data_bits = 7; break;
-	case CS8: info->params.data_bits = 8; break;
-	default:  info->params.data_bits = 7; break;
-	}
+	info->params.data_bits = tty_get_byte_size(cflag, false);
 
 	if (cflag & CSTOPB)
 		info->params.stop_bits = 2;
diff --git a/drivers/staging/greybus/uart.c b/drivers/staging/greybus/uart.c
index ccfaa0f21b9c..3db2f414f519 100644
--- a/drivers/staging/greybus/uart.c
+++ b/drivers/staging/greybus/uart.c
@@ -494,21 +494,7 @@ static void gb_tty_set_termios(struct tty_struct *tty,
 				(termios->c_cflag & PARODD ? 1 : 2) +
 				(termios->c_cflag & CMSPAR ? 2 : 0) : 0;
 
-	switch (termios->c_cflag & CSIZE) {
-	case CS5:
-		newline.data_bits = 5;
-		break;
-	case CS6:
-		newline.data_bits = 6;
-		break;
-	case CS7:
-		newline.data_bits = 7;
-		break;
-	case CS8:
-	default:
-		newline.data_bits = 8;
-		break;
-	}
+	newline.data_bits = tty_get_byte_size(termios->c_cflag, false);
 
 	/* FIXME: needs to clear unsupported bits in the termios */
 	gb_tty->clocal = ((termios->c_cflag & CLOCAL) != 0);
diff --git a/drivers/tty/serial/cpm_uart/cpm_uart_core.c b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
index 58aaa533203b..1ac4746c27ac 100644
--- a/drivers/tty/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
@@ -524,24 +524,7 @@ static void cpm_uart_set_termios(struct uart_port *port,
 	scval = 0;
 
 	/* byte size */
-	switch (termios->c_cflag & CSIZE) {
-	case CS5:
-		bits = 5;
-		break;
-	case CS6:
-		bits = 6;
-		break;
-	case CS7:
-		bits = 7;
-		break;
-	case CS8:
-		bits = 8;
-		break;
-		/* Never happens, but GCC is too dumb to figure it out */
-	default:
-		bits = 8;
-		break;
-	}
+	bits = tty_get_byte_size(termios->c_cflag, false);
 	sbits = bits - 5;
 
 	if (termios->c_cflag & CSTOPB) {
diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index f414d6acad69..a5cbd7324268 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -971,23 +971,7 @@ static void mxs_auart_settermios(struct uart_port *u,
 	ctrl2 = mxs_read(s, REG_CTRL2);
 
 	/* byte size */
-	switch (cflag & CSIZE) {
-	case CS5:
-		bm = 0;
-		break;
-	case CS6:
-		bm = 1;
-		break;
-	case CS7:
-		bm = 2;
-		break;
-	case CS8:
-		bm = 3;
-		break;
-	default:
-		return;
-	}
-
+	bm = tty_get_byte_size(cflag, false) - 5;
 	ctrl |= AUART_LINECTRL_WLEN(bm);
 
 	/* parity */
diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 23d729ed3bf6..9488eefff67c 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -1050,21 +1050,7 @@ static void qcom_geni_serial_set_termios(struct uart_port *uport,
 	}
 
 	/* bits per char */
-	switch (termios->c_cflag & CSIZE) {
-	case CS5:
-		bits_per_char = 5;
-		break;
-	case CS6:
-		bits_per_char = 6;
-		break;
-	case CS7:
-		bits_per_char = 7;
-		break;
-	case CS8:
-	default:
-		bits_per_char = 8;
-		break;
-	}
+	bits_per_char = tty_get_byte_size(termios->c_cflag, false);
 
 	/* stop bits */
 	if (termios->c_cflag & CSTOPB)
diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index bef8ca742ed9..b3a692f76a55 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2494,25 +2494,7 @@ static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
 	uart_update_timeout(port, termios->c_cflag, baud);
 
 	/* byte size and parity */
-	switch (termios->c_cflag & CSIZE) {
-	case CS5:
-		bits = 7;
-		break;
-	case CS6:
-		bits = 8;
-		break;
-	case CS7:
-		bits = 9;
-		break;
-	default:
-		bits = 10;
-		break;
-	}
-
-	if (termios->c_cflag & CSTOPB)
-		bits++;
-	if (termios->c_cflag & PARENB)
-		bits++;
+	bits = tty_get_byte_size(termios->c_cflag, true);
 
 	if (best_clk >= 0) {
 		if (port->type == PORT_SCIFA || port->type == PORT_SCIFB)
diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index c2ae7b392b86..3a36a1a2f55a 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -718,36 +718,6 @@ static void stm32_usart_shutdown(struct uart_port *port)
 	free_irq(port->irq, port);
 }
 
-static unsigned int stm32_usart_get_databits(struct ktermios *termios)
-{
-	unsigned int bits;
-
-	tcflag_t cflag = termios->c_cflag;
-
-	switch (cflag & CSIZE) {
-	/*
-	 * CSIZE settings are not necessarily supported in hardware.
-	 * CSIZE unsupported configurations are handled here to set word length
-	 * to 8 bits word as default configuration and to print debug message.
-	 */
-	case CS5:
-		bits = 5;
-		break;
-	case CS6:
-		bits = 6;
-		break;
-	case CS7:
-		bits = 7;
-		break;
-	/* default including CS8 */
-	default:
-		bits = 8;
-		break;
-	}
-
-	return bits;
-}
-
 static void stm32_usart_set_termios(struct uart_port *port,
 				    struct ktermios *termios,
 				    struct ktermios *old)
@@ -805,7 +775,7 @@ static void stm32_usart_set_termios(struct uart_port *port,
 	if (cflag & CSTOPB)
 		cr2 |= USART_CR2_STOP_2B;
 
-	bits = stm32_usart_get_databits(termios);
+	bits = tty_get_byte_size(cflag, false);
 	stm32_port->rdr_mask = (BIT(bits) - 1);
 
 	if (cflag & PARENB) {
diff --git a/drivers/tty/synclink_gt.c b/drivers/tty/synclink_gt.c
index cf87dc66087b..af9fcb0e11db 100644
--- a/drivers/tty/synclink_gt.c
+++ b/drivers/tty/synclink_gt.c
@@ -2465,14 +2465,7 @@ static void change_params(struct slgt_info *info)
 
 	/* byte size and parity */
 
-	switch (cflag & CSIZE) {
-	case CS5: info->params.data_bits = 5; break;
-	case CS6: info->params.data_bits = 6; break;
-	case CS7: info->params.data_bits = 7; break;
-	case CS8: info->params.data_bits = 8; break;
-	default:  info->params.data_bits = 7; break;
-	}
-
+	info->params.data_bits = tty_get_byte_size(cflag, false);
 	info->params.stop_bits = (cflag & CSTOPB) ? 2 : 1;
 
 	if (cflag & PARENB)
diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
index 81199efe0312..e44b6bbd008b 100644
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -1056,21 +1056,8 @@ static void acm_tty_set_termios(struct tty_struct *tty,
 	newline.bParityType = termios->c_cflag & PARENB ?
 				(termios->c_cflag & PARODD ? 1 : 2) +
 				(termios->c_cflag & CMSPAR ? 2 : 0) : 0;
-	switch (termios->c_cflag & CSIZE) {
-	case CS5:
-		newline.bDataBits = 5;
-		break;
-	case CS6:
-		newline.bDataBits = 6;
-		break;
-	case CS7:
-		newline.bDataBits = 7;
-		break;
-	case CS8:
-	default:
-		newline.bDataBits = 8;
-		break;
-	}
+	newline.bDataBits = tty_get_byte_size(termios->c_cflag, false);
+
 	/* FIXME: Needs to clear unsupported bits in the termios */
 	acm->clocal = ((termios->c_cflag & CLOCAL) != 0);
 
diff --git a/drivers/usb/serial/belkin_sa.c b/drivers/usb/serial/belkin_sa.c
index ed9193f3bb1a..a5bfe8e6c0c9 100644
--- a/drivers/usb/serial/belkin_sa.c
+++ b/drivers/usb/serial/belkin_sa.c
@@ -356,25 +356,8 @@ static void belkin_sa_set_termios(struct tty_struct *tty,
 
 	/* set the number of data bits */
 	if ((cflag & CSIZE) != (old_cflag & CSIZE)) {
-		switch (cflag & CSIZE) {
-		case CS5:
-			urb_value = BELKIN_SA_DATA_BITS(5);
-			break;
-		case CS6:
-			urb_value = BELKIN_SA_DATA_BITS(6);
-			break;
-		case CS7:
-			urb_value = BELKIN_SA_DATA_BITS(7);
-			break;
-		case CS8:
-			urb_value = BELKIN_SA_DATA_BITS(8);
-			break;
-		default:
-			dev_dbg(&port->dev,
-				"CSIZE was not CS5-CS8, using default of 8\n");
-			urb_value = BELKIN_SA_DATA_BITS(8);
-			break;
-		}
+		urb_value = BELKIN_SA_DATA_BITS(tty_get_byte_size(cflag,
+					false));
 		if (BSA_USB_CMD(BELKIN_SA_SET_DATA_BITS_REQUEST, urb_value) < 0)
 			dev_err(&port->dev, "Set data bits error\n");
 	}
diff --git a/drivers/usb/serial/cypress_m8.c b/drivers/usb/serial/cypress_m8.c
index 1dca04e1519d..b135ed1ee512 100644
--- a/drivers/usb/serial/cypress_m8.c
+++ b/drivers/usb/serial/cypress_m8.c
@@ -887,23 +887,8 @@ static void cypress_set_termios(struct tty_struct *tty,
 	} else
 		parity_enable = parity_type = 0;
 
-	switch (cflag & CSIZE) {
-	case CS5:
-		data_bits = 0;
-		break;
-	case CS6:
-		data_bits = 1;
-		break;
-	case CS7:
-		data_bits = 2;
-		break;
-	case CS8:
-		data_bits = 3;
-		break;
-	default:
-		dev_err(dev, "%s - CSIZE was set, but not CS5-CS8\n", __func__);
-		data_bits = 3;
-	}
+	data_bits = tty_get_byte_size(cflag, false) - 5;
+
 	spin_lock_irqsave(&priv->lock, flags);
 	oldlines = priv->line_control;
 	if ((cflag & CBAUD) == B0) {
diff --git a/drivers/usb/serial/pl2303.c b/drivers/usb/serial/pl2303.c
index fd773d252691..76e4d90a9d43 100644
--- a/drivers/usb/serial/pl2303.c
+++ b/drivers/usb/serial/pl2303.c
@@ -788,20 +788,7 @@ static void pl2303_set_termios(struct tty_struct *tty,
 
 	pl2303_get_line_request(port, buf);
 
-	switch (C_CSIZE(tty)) {
-	case CS5:
-		buf[6] = 5;
-		break;
-	case CS6:
-		buf[6] = 6;
-		break;
-	case CS7:
-		buf[6] = 7;
-		break;
-	default:
-	case CS8:
-		buf[6] = 8;
-	}
+	buf[6] = tty_get_byte_size(C_CSIZE(tty), false);
 	dev_dbg(&port->dev, "data bits = %d\n", buf[6]);
 
 	/* For reference buf[0]:buf[3] baud rate value */
diff --git a/drivers/usb/serial/whiteheat.c b/drivers/usb/serial/whiteheat.c
index 5116ed9db3eb..7d4f2c1de4f6 100644
--- a/drivers/usb/serial/whiteheat.c
+++ b/drivers/usb/serial/whiteheat.c
@@ -625,14 +625,7 @@ static void firm_setup_port(struct tty_struct *tty)
 
 	port_settings.port = port->port_number + 1;
 
-	/* get the byte size */
-	switch (cflag & CSIZE) {
-	case CS5:	port_settings.bits = 5;   break;
-	case CS6:	port_settings.bits = 6;   break;
-	case CS7:	port_settings.bits = 7;   break;
-	default:
-	case CS8:	port_settings.bits = 8;   break;
-	}
+	port_settings.bits = tty_get_byte_size(cflag, false);
 	dev_dbg(dev, "%s - data bits = %d\n", __func__, port_settings.bits);
 
 	/* determine the parity */
-- 
2.31.1

