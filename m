From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 1/3] serial: imx: Fix warning when !CONFIG_SERIAL_IMX_CONSOLE
Date: Mon,  3 Jun 2013 23:51:46 -0300
Message-ID: <1370314308-11637-1-git-send-email-festevam@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ye0-f170.google.com ([209.85.213.170]:49600 "EHLO
	mail-ye0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755384Ab3FDCwE (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 3 Jun 2013 22:52:04 -0400
Received: by mail-ye0-f170.google.com with SMTP id q3so439238yen.1
        for <linux-serial@vger.kernel.org>; Mon, 03 Jun 2013 19:52:03 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: shawn.guo@linaro.org, b35083@freescale.com, kernel@pengutronix.de, linux-serial@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

From: Fabio Estevam <fabio.estevam@freescale.com>

When CONFIG_SERIAL_IMX_CONSOLE is not selected the following build warnings
appear:

drivers/tty/serial/imx.c:274:13: warning: 'imx_port_ucrs_save' defined but not used [-Wunused-function]
drivers/tty/serial/imx.c:283:13: warning: 'imx_port_ucrs_restore' defined but not used [-Wunused-function]

imx_port_ucrs_save() and imx_port_ucrs_restore() are only used when 
CONFIG_CONSOLE_POLL or CONFIG_SERIAL_IMX_CONSOLE are selected, so protect these
functions declaration with a proper ifdef.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/tty/serial/imx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 72bc1db..90eba78 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -271,6 +271,7 @@ static inline int is_imx21_uart(struct imx_port *sport)
 /*
  * Save and restore functions for UCR1, UCR2 and UCR3 registers
  */
+#if defined(CONFIG_CONSOLE_POLL) || defined(CONFIG_SERIAL_IMX_CONSOLE)
 static void imx_port_ucrs_save(struct uart_port *port,
 			       struct imx_port_ucrs *ucr)
 {
@@ -288,6 +289,7 @@ static void imx_port_ucrs_restore(struct uart_port *port,
 	writel(ucr->ucr2, port->membase + UCR2);
 	writel(ucr->ucr3, port->membase + UCR3);
 }
+#endif
 
 /*
  * Handle any change of modem status signal since we were last called.
-- 
1.8.1.2

