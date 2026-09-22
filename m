Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F843264D2;
	Tue, 22 Sep 2026 01:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790040076; cv=none; b=ZewubITSyd51dgcfctDc/EQf4lMGnUv+NY+BkgKSsU5oclhICw2NF9ZpXZnvuARVHQjzvPXdgcEaB3xsVSuXYCTF09P0gH1E5tWx+YWPCKK3kyCJ0uqUj0e4vXqCdqC24YE+kVlme7+XxQhad0k3gKTvHlA3p98l8m0goAgvmgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790040076; c=relaxed/simple;
	bh=AGoA4/iwqNxIvbkM9m87fuPgQXFSWC2djc1JB6O1P2w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=I0fS2xaToxMaF5kfKjsi7OZFoAxjn+wrezlX0jdAt87m6gHERxvmssybDIbO3Q1kr8BJ6OqAXeFjHvvfdnSLB1hpGm5BtxC74BagQqddxCC/sApoH/UxRzXFXZePy9Fl1Yzuf/gcRPwnhiaIFAmeNKCBBfLmMrMBSpV90kCf2G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HG6C+lS6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HG6C+lS6"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3D9D4C2BCB3;
	Tue, 22 Sep 2026 01:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790040076;
	bh=AGoA4/iwqNxIvbkM9m87fuPgQXFSWC2djc1JB6O1P2w=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=HG6C+lS6tONxVEtjmomvH142ZZZH44Zv+Nu8LHiVRHhVtzkTkQRHqo3TRLH3oe3FC
	 EBCUzhXbXelUOfj1n93SLFGcpuZtTDUHkCZvknkLmeNoP0hgz2+eypSgPpWOogKDnc
	 QTmR9MWzjFuvE9vJb9JikkQjOKBv+zruvqqAwp4sF6Tc7lukamIIIK1Vg9WRHfT6UZ
	 U2z0plvkAMsMO64PnaNSAOQGn0C4L54DIjTax9o5TuIq2/J2O8aPMUDTU8ykAqeDDr
	 /2ZPvOQo/Ded5e26ZzqEDHFGXiYKNklV49fm/+ZpLOhEp5xteqXL1WFHiv/Ry5e7Ym
	 KNTdOM1jsFOLA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29EA6C982F0;
	Tue, 22 Sep 2026 01:21:16 +0000 (UTC)
From: Jaidev Shastri via B4 Relay <devnull+jaidevshastri.vt.edu@kernel.org>
Date: Mon, 21 Sep 2026 21:21:13 -0400
Subject: [PATCH] serial: xilinx_uartps: publish console_port with release
 semantics
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-mb-uartps-v1-1-9fc2f3d4b1a5@vt.edu>
X-B4-Tracking: v=1; b=H4sIAAjYsWoC/yXM0Q6CMAyF4VchvbaGDaLiqxgvulJlJk7SAjEhv
 LsbXn4nJ/8KJhrF4FqtoLJEi5+U4Q4V8EDpKRj7bPC1P9Wdd/gOOJNOoyGLC47Jd3RpIP9HlUf
 87q3b/W+bw0t4KoHyCGSCQSnxUKady/nYoHIL2/YDZzaMOY0AAAA=
X-Change-ID: 20260921-mb-uartps-ce1b1ca29a83
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Michal Simek <michal.simek@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Jaidev Shastri <jaidevshastri@vt.edu>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790040075; l=2025;
 i=jaidevshastri@vt.edu; s=20260921; h=from:subject:message-id;
 bh=+qMMTlUnAlo5wMcrO/0fIIBY+h1Jroi7pkVqcuiqtuM=;
 b=Jh8+BFE5Ah6Lj6zvIelxnqC4MWlNXWoUGsODf6eaUwkm2e5X7Q9/8eLbZR4lYiM+l6uTGR6ms
 cUuaLI+lyEqAVStd+mqyXzmD5TpCCIAFT2Ay4mSDu9KTEZvMDEG4puJ
X-Developer-Key: i=jaidevshastri@vt.edu; a=ed25519;
 pk=J7+xYJRlTPds+pv5hbqFFRqGCpDeJDzmZT1ggRwj7/0=
X-Endpoint-Received: by B4 Relay for jaidevshastri@vt.edu/20260921 with
 auth_id=1044
X-Original-From: Jaidev Shastri <jaidevshastri@vt.edu>
Reply-To: jaidevshastri@vt.edu

From: Jaidev Shastri <jaidevshastri@vt.edu>

cdns_uart_probe() assigns the first probed port to console_port with a
plain store once the port is set up. cdns_uart_console_write() and
cdns_uart_console_setup() read it with plain loads.

Store it with smp_store_release() and read it with smp_load_acquire().

Found with MBCheck, a static herd7-based memory consistency checker.

Signed-off-by: Jaidev Shastri <jaidevshastri@vt.edu>
---
 drivers/tty/serial/xilinx_uartps.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index a072b75db..59e0d388d 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1371,7 +1371,8 @@ static struct uart_port *console_port;
 static void cdns_uart_console_write(struct console *co, const char *s,
 				unsigned int count)
 {
-	struct uart_port *port = console_port;
+	/* Pairs with the smp_store_release() in cdns_uart_probe(). */
+	struct uart_port *port = smp_load_acquire(&console_port);
 	unsigned long flags;
 	unsigned int imr, ctrl;
 	int locked = 1;
@@ -1414,7 +1415,8 @@ static void cdns_uart_console_write(struct console *co, const char *s,
  */
 static int cdns_uart_console_setup(struct console *co, char *options)
 {
-	struct uart_port *port = console_port;
+	/* Pairs with the smp_store_release() in cdns_uart_probe(). */
+	struct uart_port *port = smp_load_acquire(&console_port);
 
 	int baud = 9600;
 	int bits = 8;
@@ -1812,7 +1814,8 @@ static int cdns_uart_probe(struct platform_device *pdev)
 	 */
 	if (!console_port) {
 		cdns_uart_console.index = id;
-		console_port = port;
+		/* Pairs with the smp_load_acquire() in the console callbacks. */
+		smp_store_release(&console_port, port);
 	}
 #endif
 	if (cdns_uart_data->port->rs485.flags & SER_RS485_ENABLED)

---
base-commit: 93f51579e7df248780214094418f205253383cc5
change-id: 20260921-mb-uartps-ce1b1ca29a83

Best regards,
--  
Jaidev Shastri <jaidevshastri@vt.edu>


