From: Chris Ruehl <chris.ruehl@gtsys.com.hk>
Subject: [PATCH] serial: imx: enable IMX21_UCR3_RXDMUXSEL for non-dte-mode
Date: Fri, 20 Apr 2018 09:07:59 +0800
Message-ID: <1524186479-25315-1-git-send-email-chris.ruehl@gtsys.com.hk>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Chris Ruehl <chris.ruehl@gtsys.com.hk>
List-Id: linux-serial@vger.kernel.org

Fix a problem introduced with
commit e61c38d85b73 ("serial: imx: setup DCEDTE early and ensure DCD and RI irqs to be off")
result in non dte-mode imx-uart fail receive data.
By add back IMX21_UCR3_RXDMUXSEL the serial port works as expected.

Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
---
 drivers/tty/serial/imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 91f3a1a..3d09933 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1391,7 +1391,7 @@ static int imx_uart_startup(struct uart_port *port)
 
 		ucr3 = imx_uart_readl(sport, UCR3);
 
-		ucr3 |= UCR3_DTRDEN | UCR3_RI | UCR3_DCD;
+		ucr3 |= IMX21_UCR3_RXDMUXSEL | UCR3_DTRDEN | UCR3_RI | UCR3_DCD;
 
 		if (sport->dte_mode)
 			/* disable broken interrupts */
-- 
2.1.4
