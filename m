Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5CB17722;
	Sat,  6 Jul 2024 10:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720261986; cv=none; b=cIEx7diyxYFWku8yMZwRtS3Dx/8qYfLBeinEZtffczNp4SKBUobx7JJG5oBnlXuRA908TsrNVEBNUvrf0UrO/thIgFr6ChaRccYfkOsdheIQ2nlIO2UvsZ54q5R2Pw+Ry7rz8fcgT4MI4thyV4Dr86xM2fOdRLtWg3Lxx06D2/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720261986; c=relaxed/simple;
	bh=KHWR0ANV7dBwgxd07y4BVHXxMvo2nDwvqCjPmc0nIok=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oy6XP4/MiXA/n4YmTkyyieuSY7QHS/M3aLCnlFMEYrSWIfpQ+HA9lLIaf6g4U3ZeLrbLRA9/xHExVB8GsOv2O0omyVJ99fQedKG1Vt9wiXT49srWyV/HTML0JpdV4QaBbkDHLETPAPOO19VRb5lzRFqpE/xOIuiS0rVXNFwMh/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ktys9FIj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ktys9FIj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76F85C2BD10;
	Sat,  6 Jul 2024 10:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720261985;
	bh=KHWR0ANV7dBwgxd07y4BVHXxMvo2nDwvqCjPmc0nIok=;
	h=From:To:Cc:Subject:Date:From;
	b=Ktys9FIj674M4QOSW/gHzV2j7FwCyknm8wUw/DtGW5jDwID9nC3kKUBLUUbOCcXKv
	 5HAkJAvKTtbrSuW6wKJyWsUz+UDB1re0xAAluflP2ur5Y/zdbU6zPbgYRwh9jfspqu
	 I8PtYqaZQxzaH+EKsyw4b+0rV074OcsxwEshTklcehbiqzQ9fnESyT3V5l//qnRYvQ
	 Dmh0Zu4KQht0G0+m0vqixxmLnqkNLqVckSw1JWN0z1X4YWgl5I6Z4bsZ5cXXr56g3U
	 jgw8Nu1yJtYGvZtVsrwdLjNFCLai6lxJZJ3yBOg6TMSbH/6Rx1PaoGC0m23qSSQSA6
	 NQr80OZ8RUIlg==
From: Jisheng Zhang <jszhang@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH] serial: 8250: move mmp|pxa uart earlycon code and add xscale earlycon
Date: Sat,  6 Jul 2024 18:18:56 +0800
Message-ID: <20240706101856.3077-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are two other drivers that bind to "mrvl,mmp-uart": the 8250_of
and the 8250_pxa. The previous one is generic and the latter is binded
to ARCH_PXA || ARCH_MMP. Now we may have pxa programming compatible
HW to support, making use of the generic 8250_of seems a good idea.
However, there's no earlycon support if we go with this solution. So
move the mmp|pxa-uart earlycon code to core 8250_early.c.

At the same, add xscale earlycon support too, only build test since
I have no xscale machine any more.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/tty/serial/8250/8250_early.c | 11 +++++++++++
 drivers/tty/serial/8250/8250_pxa.c   | 16 ----------------
 2 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_early.c b/drivers/tty/serial/8250/8250_early.c
index e3f482fd3de4..6176083d0341 100644
--- a/drivers/tty/serial/8250/8250_early.c
+++ b/drivers/tty/serial/8250/8250_early.c
@@ -171,6 +171,17 @@ OF_EARLYCON_DECLARE(ns16550a, "ns16550a", early_serial8250_setup);
 OF_EARLYCON_DECLARE(uart, "nvidia,tegra20-uart", early_serial8250_setup);
 OF_EARLYCON_DECLARE(uart, "snps,dw-apb-uart", early_serial8250_setup);
 
+static int __init early_serial8250_rs2_setup(struct earlycon_device *device,
+					     const char *options)
+{
+	device->port.regshift = 2;
+
+	return early_serial8250_setup(device, options);
+}
+OF_EARLYCON_DECLARE(uart, "intel,xscale-uart", early_serial8250_rs2_setup);
+OF_EARLYCON_DECLARE(uart, "mrvl,mmp-uart", early_serial8250_rs2_setup);
+OF_EARLYCON_DECLARE(uart, "mrvl,pxa-uart", early_serial8250_rs2_setup);
+
 #ifdef CONFIG_SERIAL_8250_OMAP
 
 static int __init early_omap8250_setup(struct earlycon_device *device,
diff --git a/drivers/tty/serial/8250/8250_pxa.c b/drivers/tty/serial/8250/8250_pxa.c
index ba96fa913e7f..b5d937f6f3f9 100644
--- a/drivers/tty/serial/8250/8250_pxa.c
+++ b/drivers/tty/serial/8250/8250_pxa.c
@@ -165,22 +165,6 @@ static struct platform_driver serial_pxa_driver = {
 
 module_platform_driver(serial_pxa_driver);
 
-#ifdef CONFIG_SERIAL_8250_CONSOLE
-static int __init early_serial_pxa_setup(struct earlycon_device *device,
-				  const char *options)
-{
-	struct uart_port *port = &device->port;
-
-	if (!(device->port.membase || device->port.iobase))
-		return -ENODEV;
-
-	port->regshift = 2;
-	return early_serial8250_setup(device, NULL);
-}
-OF_EARLYCON_DECLARE(early_pxa, "mrvl,pxa-uart", early_serial_pxa_setup);
-OF_EARLYCON_DECLARE(mmp, "mrvl,mmp-uart", early_serial_pxa_setup);
-#endif
-
 MODULE_AUTHOR("Sergei Ianovich");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:pxa2xx-uart");
-- 
2.43.0

