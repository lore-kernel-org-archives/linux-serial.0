Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC9E33F394;
	Wed, 19 Nov 2025 09:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763544313; cv=none; b=T6JobHLfN58y4Zg4LWjCp68e8148q9kz/zrbPDaIjzXFHDCnOJp366yFZhaIJANIi7MLkg8DD6gDvUW0S5iT7l9FKKBO92wJMvXQU+M94ZP0eWhssFr/EfTI7UhtMe2KqetMG802ZjW5/aj9AJr0KDWtt4eDdkrx/RyEhhRz3Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763544313; c=relaxed/simple;
	bh=avsZf4Hby80T8aqUVyWfb3572Q3z7lYinMuQ3rE64bw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MCY5IPP0BBXU/gOJ0RYW9vA7jJAo81pi4bhhPGy6eaAtVjxEKv2dfq3peWd1eLGn2YOQYstsQ9+2S6HVaPgDlI92qw5m7ysUBKdhXoE4mu6lWu+a2eluyvt09LdYm0ngI184jsTCqWPAtrLzGHgrDIx5r11jH4RSzwjOwe+sRWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gIyMPBcs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gIyMPBcs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A572C4AF12;
	Wed, 19 Nov 2025 09:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763544312;
	bh=avsZf4Hby80T8aqUVyWfb3572Q3z7lYinMuQ3rE64bw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gIyMPBcsDbdOhe2ItdWcjNEsB8g1b/4ZrDS7w7K03QD+f0x+U9YN5acQ6yD+xxqUR
	 /2aeU2VWbq65fikwJ+jfy6BFzB86aSYR55R25N+Ulz8DrqLlWczddglthQYN7jSLjW
	 SaAjBZuiXCmimpeegDvA815LCSI+2n5IZk1Qcr7gOzW1Sjtz2o1TM4cNOKAKOgGeYx
	 oT/wLKUWNkp1ilObd1m6ub0X8JgiC18L4tnu8Uih1sj7BJZEOpo258/GM/8BONely6
	 +BTwlpjPM4MXk5p1wTkf+d/CoUdwnhCYs/LewmoJ3DxGjZ0DgPkBfB8fhESHooFtPP
	 tsRoO8Cai2Zrg==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 6/6] serial: 8250_platform: simplify IRQF_SHARED handling
Date: Wed, 19 Nov 2025 10:24:57 +0100
Message-ID: <20251119092457.826789-7-jirislaby@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251119092457.826789-1-jirislaby@kernel.org>
References: <20251119092457.826789-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IRQF_SHARED is the only flag handled in __serial8250_isa_init_ports()
and serial8250_probe_platform(). There is no need to precompute the
flags. Instead, initialize port->irqflags directly in the for loop.

Note the "if (bool)" is cheap and these are not hot paths anyway.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/serial/8250/8250_platform.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_platform.c b/drivers/tty/serial/8250/8250_platform.c
index 4c1166a46a1f..af16a36193bf 100644
--- a/drivers/tty/serial/8250/8250_platform.c
+++ b/drivers/tty/serial/8250/8250_platform.c
@@ -58,7 +58,7 @@ EXPORT_SYMBOL(serial8250_set_isa_configurator);
 
 static void __init __serial8250_isa_init_ports(void)
 {
-	int i, irqflag = 0;
+	int i;
 
 	if (nr_uarts > UART_NR)
 		nr_uarts = UART_NR;
@@ -75,9 +75,6 @@ static void __init __serial8250_isa_init_ports(void)
 	univ8250_port_ops = *univ8250_port_base_ops;
 	univ8250_rsa_support(&univ8250_port_ops);
 
-	if (share_irqs)
-		irqflag = IRQF_SHARED;
-
 	for (i = 0; i < ARRAY_SIZE(old_serial_port) && i < nr_uarts; i++) {
 		struct uart_8250_port *up = serial8250_get_port(i);
 		struct uart_port *port = &up->port;
@@ -92,7 +89,9 @@ static void __init __serial8250_isa_init_ports(void)
 		port->iotype   = old_serial_port[i].io_type;
 		port->regshift = old_serial_port[i].iomem_reg_shift;
 
-		port->irqflags |= irqflag;
+		if (share_irqs)
+			port->irqflags |= IRQF_SHARED;
+
 		if (serial8250_isa_config != NULL)
 			serial8250_isa_config(i, &up->port, &up->capabilities);
 	}
@@ -155,15 +154,12 @@ static int serial8250_probe_acpi(struct platform_device *pdev)
 
 static int serial8250_probe_platform(struct platform_device *dev, struct plat_serial8250_port *p)
 {
-	int ret, i, irqflag = 0;
+	int ret, i;
 
 	struct uart_8250_port *uart __free(kfree) = kzalloc(sizeof(*uart), GFP_KERNEL);
 	if (!uart)
 		return -ENOMEM;
 
-	if (share_irqs)
-		irqflag = IRQF_SHARED;
-
 	for (i = 0; p && p->flags != 0; p++, i++) {
 		uart->port.iobase	= p->iobase;
 		uart->port.membase	= p->membase;
@@ -191,7 +187,10 @@ static int serial8250_probe_platform(struct platform_device *dev, struct plat_se
 		uart->port.get_mctrl	= p->get_mctrl;
 		uart->port.pm		= p->pm;
 		uart->port.dev		= &dev->dev;
-		uart->port.irqflags	|= irqflag;
+
+		if (share_irqs)
+			uart->port.irqflags |= IRQF_SHARED;
+
 		ret = serial8250_register_8250_port(uart);
 		if (ret < 0) {
 			dev_err(&dev->dev, "unable to register port at index %d "
-- 
2.51.1

