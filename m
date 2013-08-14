From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 18/29] tty: ar933x_uart: simplify use of devm_ioremap_resource
Date: Wed, 14 Aug 2013 11:11:22 +0200
Message-ID: <1376471493-22215-19-git-send-email-Julia.Lawall@lip6.fr>
References: <1376471493-22215-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1376471493-22215-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: kernel-janitors@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

From: Julia Lawall <Julia.Lawall@lip6.fr>

Remove unneeded error handling on the result of a call to
platform_get_resource when the value is passed to devm_ioremap_resource.

Move the call to platform_get_resource adjacent to the call to
devm_ioremap_resource to make the connection between them more clear.

A simplified version of the semantic patch that makes this change is as
follows: (http://coccinelle.lip6.fr/)

// <smpl>
@@
expression pdev,res,n,e,e1;
expression ret != 0;
identifier l;
@@

- res = platform_get_resource(pdev, IORESOURCE_MEM, n);
  ... when != res
- if (res == NULL) { ... \(goto l;\|return ret;\) }
  ... when != res
+ res = platform_get_resource(pdev, IORESOURCE_MEM, n);
  e = devm_ioremap_resource(e1, res);
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/tty/serial/ar933x_uart.c |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/tty/serial/ar933x_uart.c b/drivers/tty/serial/ar933x_uart.c
index 3f5517f..a712a3f 100644
--- a/drivers/tty/serial/ar933x_uart.c
+++ b/drivers/tty/serial/ar933x_uart.c
@@ -640,12 +640,6 @@ static int ar933x_uart_probe(struct platform_device *pdev)
 	if (id > CONFIG_SERIAL_AR933X_NR_UARTS)
 		return -EINVAL;
 
-	mem_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!mem_res) {
-		dev_err(&pdev->dev, "no MEM resource\n");
-		return -EINVAL;
-	}
-
 	irq_res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
 	if (!irq_res) {
 		dev_err(&pdev->dev, "no IRQ resource\n");
@@ -659,6 +653,7 @@ static int ar933x_uart_probe(struct platform_device *pdev)
 
 	port = &up->port;
 
+	mem_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	port->membase = devm_ioremap_resource(&pdev->dev, mem_res);
 	if (IS_ERR(port->membase))
 		return PTR_ERR(port->membase);
