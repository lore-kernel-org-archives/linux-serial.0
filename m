From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 9/9] serial: 8250_dw: Convert to devm_ioremap()
Date: Thu, 11 Apr 2013 15:43:21 +0300
Message-ID: <1365684201-11793-1-git-send-email-heikki.krogerus@linux.intel.com>
References: <20130411122053.GA2982@xps8300>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130411122053.GA2982@xps8300>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Use resource managed ioremap.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/tty/serial/8250/8250_dw.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index b7c7d6a..39b7ae4 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -250,7 +250,8 @@ static int dw8250_probe(struct platform_device *pdev)
 	uart.port.flags = UPF_SHARE_IRQ | UPF_BOOT_AUTOCONF | UPF_FIXED_PORT;
 	uart.port.dev = &pdev->dev;
 
-	uart.port.membase = ioremap(regs->start, resource_size(regs));
+	uart.port.membase = devm_ioremap(&pdev->dev, regs->start,
+					 resource_size(regs));
 	if (!uart.port.membase)
 		return -ENOMEM;
 
-- 
1.7.10.4
