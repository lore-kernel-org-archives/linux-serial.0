Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E341516D33D;
	Thu, 11 Jul 2024 16:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720714895; cv=none; b=qyMhW5lWmWy0XbCKz/tfTE42ErCwGDa1WtNXbteL0Ds4eCI/YTuEkDwhmLObXwOdHO9lqrx+t83mxY0fEob4H9xQzfmkg/Dvrs+dZFFonOfqKgLxDHgT9fHSDCa5FT4votZoYXAoW17t4epb1NOtdYHzIiBmgRq+LunqKAuX7JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720714895; c=relaxed/simple;
	bh=kNHny3bD8VDch0F9MiEblutk39fnAED3gZpYZyJpiTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IITdByseVfRRbEfISyxWDbkuy1bBr4V7CUBu7h26vTlT1nF3GPFNp5PJTdVCCDQXmrR5C2t6U4LZMycAdAAEfCDA0VMlJaS8vlO6/tvkXZncSNJAJczwPdquvE6HY6tlMJHWOc+h7o7PkzJoPb37Zb53w9T3ozQuhlK+j1llVVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eJkAuBu8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eJkAuBu8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D85BC32786;
	Thu, 11 Jul 2024 16:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720714894;
	bh=kNHny3bD8VDch0F9MiEblutk39fnAED3gZpYZyJpiTQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eJkAuBu8BGQfrTxOU94WRLVYywOsc+YTkwVy0X4fXTLbps+ERsMHMiFJtMkqzCoA5
	 mSLl2KbsD3qP+3uYNsIRRM6jsNYHLV4QmNtO3rJNr1TX5y9fYMuZcrEvQFdPBoYGZk
	 hEwR5W9yl3JlnvuZkZSPzYOXuRlNlBebVkjziMB1BmNMF+8LwZFIWhAlll6q3mOP+n
	 mNemBNeRsf3Hdqctqr5FYggu2emJRsLgn/JtVTjg48ZFcYQPYon7lV0LYjCtlGBSfJ
	 A/C1ckURiwPigDbA3zWD5+e35Xn9rJ7hfz5a2PjlL5r3ZugWH1PIm/1vZVYOE2SHqo
	 qy9cqGIgD7Rfg==
From: Jisheng Zhang <jszhang@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v2 1/2] serial: 8250: move mmp|pxa uart earlycon code
Date: Fri, 12 Jul 2024 00:07:19 +0800
Message-ID: <20240711160720.3488-2-jszhang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240711160720.3488-1-jszhang@kernel.org>
References: <20240711160720.3488-1-jszhang@kernel.org>
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

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/tty/serial/8250/8250_early.c | 10 ++++++++++
 drivers/tty/serial/8250/8250_pxa.c   | 16 ----------------
 2 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_early.c b/drivers/tty/serial/8250/8250_early.c
index e3f482fd3de4..2ab61d6673d2 100644
--- a/drivers/tty/serial/8250/8250_early.c
+++ b/drivers/tty/serial/8250/8250_early.c
@@ -171,6 +171,16 @@ OF_EARLYCON_DECLARE(ns16550a, "ns16550a", early_serial8250_setup);
 OF_EARLYCON_DECLARE(uart, "nvidia,tegra20-uart", early_serial8250_setup);
 OF_EARLYCON_DECLARE(uart, "snps,dw-apb-uart", early_serial8250_setup);
 
+static int __init early_serial8250_rs2_setup(struct earlycon_device *device,
+					     const char *options)
+{
+	device->port.regshift = 2;
+
+	return early_serial8250_setup(device, options);
+}
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

