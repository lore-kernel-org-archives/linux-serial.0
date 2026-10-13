Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F7E4F3EA5
	for <linux-serial@vger.kernel.org>; Tue, 13 Oct 2026 12:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791893415; cv=none; b=nTbpX05W5WNJeWuNEoT84T3DUlPyVP3N5vy7FMjBAxyn0saoN/xUporOy53WPvEcuJXgyCph9duYjb1gTKBMflVPjwdroPk8A8/x/Et2yW/c9Dcg7tvYnd8epVTHkNBSPZjBHRHol6xB3PsQYShbIQOK6E35UoqxXsEu/hG06Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791893415; c=relaxed/simple;
	bh=9Bh6OjDA45LHpSQNyCzoL7KX+oAtr2gjhHZ1P6+rnVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n6UW36XlHXSy8Dz19oUEdQCWOC+Oew8Pmtlp1L9yXVnMGZMB6QVLwqM4JnzS+jXXYmSVW4jC/3vhAoSxhZsO7h88K3pnk5QtEqFKxAZZbrk/vVty90YQjXXZJ8ci0FOlLHrdSYgoONU6U2He8G7Glh1iXKvtP0n0f9rApN+1rpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2941A1F0089A;
	Tue, 13 Oct 2026 12:10:11 +0000 (UTC)
From: Greg Ungerer <gerg@linux-m68k.org>
To: linux-m68k@lists.linux-m68k.org,
	linux-serial@vger.kernel.org
Cc: Greg Ungerer <gerg@linux-m68k.org>
Subject: [PATCH 3/5] serial: mcf: dynamically allocate memory
Date: Tue, 13 Oct 2026 22:07:01 +1000
Message-ID: <20261013120831.1046590-4-gerg@linux-m68k.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261013120831.1046590-1-gerg@linux-m68k.org>
References: <20261013120831.1046590-1-gerg@linux-m68k.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Modify the ColdFire serial driver to dynamically allocate the local uart
port structures as required at init time. Currently it uses a fixed
size array - a little wasteful of memory on most parts with only a
couple of UARTs.

Signed-off-by: Greg Ungerer <gerg@linux-m68k.org>
---
 drivers/tty/serial/mcf.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/mcf.c b/drivers/tty/serial/mcf.c
index 3651910dff99..7cbe43cbe3a0 100644
--- a/drivers/tty/serial/mcf.c
+++ b/drivers/tty/serial/mcf.c
@@ -55,6 +55,14 @@ struct mcf_uart {
 	unsigned char		imr;		/* Local IMR mirror */
 };
 
+/*
+ * Define maximum number of UARTs this driver will support.
+ * This is set to maximum number on any known ColdFire SoC.
+ */
+#define MCF_MAXPORTS            10
+
+static struct mcf_uart *mcf_ports[MCF_MAXPORTS];
+
 /****************************************************************************/
 
 static unsigned int mcf_tx_empty(struct uart_port *port)
@@ -462,19 +470,19 @@ static const struct uart_ops mcf_uart_ops = {
 	.verify_port	= mcf_verify_port,
 };
 
-static struct mcf_uart mcf_ports[10];
-
-#define	MCF_MAXPORTS	ARRAY_SIZE(mcf_ports)
-
 /****************************************************************************/
 #if defined(CONFIG_SERIAL_MCF_CONSOLE)
 /****************************************************************************/
 
 static void mcf_console_putc(struct console *co, const char c)
 {
-	struct uart_port *port = &(mcf_ports + co->index)->port;
+	struct uart_port *port;
 	int i;
 
+	if ((co->index < 0) || (co->index >= MCF_MAXPORTS))
+		co->index = 0;
+	port = &mcf_ports[co->index]->port;
+
 	for (i = 0; (i < 0x10000); i++) {
 		if (readb(port->membase + MCFUART_USR) & MCFUART_USR_TXREADY)
 			break;
@@ -509,9 +517,9 @@ static int __init mcf_console_setup(struct console *co, char *options)
 
 	if ((co->index < 0) || (co->index >= MCF_MAXPORTS))
 		co->index = 0;
-	port = &mcf_ports[co->index].port;
-	if (port->membase == 0)
+	if (mcf_ports[co->index] == NULL)
 		return -ENODEV;
+	port = &mcf_ports[co->index]->port;
 
 	if (options)
 		uart_parse_options(options, &baud, &parity, &bits, &flow);
@@ -572,10 +580,16 @@ static int mcf_probe(struct platform_device *pdev)
 {
 	struct uart_port *port;
 	struct resource *res;
+	struct mcf_uart *mp;
 
 	if (pdev->id >= MCF_MAXPORTS)
 		return -ENODEV;
-	port = &mcf_ports[pdev->id].port;
+
+	mp = devm_kzalloc(&pdev->dev, sizeof(*mp), GFP_KERNEL);
+	if (mp == NULL)
+		return -ENOMEM;
+	mcf_ports[pdev->id] = mp;
+	port = &mp->port;
 
 	port->membase = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(port->membase))
@@ -605,13 +619,11 @@ static int mcf_probe(struct platform_device *pdev)
 
 static void mcf_remove(struct platform_device *pdev)
 {
-	struct uart_port *port;
 	int i;
 
 	for (i = 0; (i < MCF_MAXPORTS); i++) {
-		port = &mcf_ports[i].port;
-		if (port)
-			uart_remove_one_port(&mcf_driver, port);
+		if (mcf_ports[i])
+			uart_remove_one_port(&mcf_driver, &mcf_ports[i]->port);
 	}
 }
 
-- 
2.55.0

