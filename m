From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 9/9] serial: 8250_dw: Use devm_request_and_ioremap()
Date: Wed, 10 Apr 2013 16:58:32 +0300
Message-ID: <1365602312-25436-10-git-send-email-heikki.krogerus@linux.intel.com>
References: <1365602312-25436-1-git-send-email-heikki.krogerus@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1365602312-25436-1-git-send-email-heikki.krogerus@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Use resource managed ioremap.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/tty/serial/8250/8250_dw.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index b7c7d6a..bf2a6e2 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -250,7 +250,7 @@ static int dw8250_probe(struct platform_device *pdev)
 	uart.port.flags = UPF_SHARE_IRQ | UPF_BOOT_AUTOCONF | UPF_FIXED_PORT;
 	uart.port.dev = &pdev->dev;
 
-	uart.port.membase = ioremap(regs->start, resource_size(regs));
+	uart.port.membase = devm_request_and_ioremap(&pdev->dev, regs);
 	if (!uart.port.membase)
 		return -ENOMEM;
 
-- 
1.7.10.4
