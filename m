From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] serial: imx: Fix warning when building 'allmodconfig'
Date: Wed, 12 Nov 2014 15:55:07 -0200
Message-ID: <1415814907-9913-1-git-send-email-festevam@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-qa0-f41.google.com ([209.85.216.41]:50012 "EHLO
	mail-qa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752957AbaKLRzZ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 12 Nov 2014 12:55:25 -0500
Received: by mail-qa0-f41.google.com with SMTP id s7so9066775qap.28
        for <linux-serial@vger.kernel.org>; Wed, 12 Nov 2014 09:55:24 -0800 (PST)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

From: Fabio Estevam <fabio.estevam@freescale.com>

When CONFIG_SERIAL_IMX_CONSOLE=n and CONFIG_CONSOLE_POLL=y we get the following
build warning:

drivers/tty/serial/imx.c:306:13: warning: 'imx_port_ucrs_save' defined but not used [-Wunused-function]
drivers/tty/serial/imx.c:315:13: warning: 'imx_port_ucrs_restore' defined but not used [-Wunused-function]

imx_port_ucrs_save/restore are only used under CONFIG_SERIAL_IMX_CONSOLE, so 
their definitions should be also be protected only by CONFIG_SERIAL_IMX_CONSOLE.

This was detected when building 'allmodconfig'.

Reported-by: Olof's autobuilder <build@lixom.net>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/tty/serial/imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index bdafdd9..4c5e909 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -302,7 +302,7 @@ static inline int is_imx6q_uart(struct imx_port *sport)
 /*
  * Save and restore functions for UCR1, UCR2 and UCR3 registers
  */
-#if defined(CONFIG_CONSOLE_POLL) || defined(CONFIG_SERIAL_IMX_CONSOLE)
+#if defined(CONFIG_SERIAL_IMX_CONSOLE)
 static void imx_port_ucrs_save(struct uart_port *port,
 			       struct imx_port_ucrs *ucr)
 {
-- 
1.9.1

