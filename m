From: Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH/RFC 5/8] serial: pxa: Make the driver buildable for BCM7xxx set-top platforms
Date: Wed, 12 Nov 2014 00:46:30 -0800
Message-ID: <1415781993-7755-6-git-send-email-cernekee@gmail.com>
References: <1415781993-7755-1-git-send-email-cernekee@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:33574 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752076AbaKLIrN (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 12 Nov 2014 03:47:13 -0500
In-Reply-To: <1415781993-7755-1-git-send-email-cernekee@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.cz, robh@kernel.org
Cc: tushar.behera@linaro.org, daniel@zonque.org, haojian.zhuang@gmail.com, robert.jarzmik@free.fr, grant.likely@linaro.org, f.fainelli@gmail.com, mbizon@freebox.fr, jogo@openwrt.org, linux-mips@linux-mips.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org

Remove the platform dependency in Kconfig and add an appropriate
compatible string.  Note that BCM7401 has one 16550A-compatible UART
in the UPG uart_clk domain, and two proprietary UARTs in the 27 MHz
clock domain.  This driver handles the former one.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 drivers/tty/serial/Kconfig | 2 +-
 drivers/tty/serial/pxa.c   | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index fdd851e..2015057 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -436,7 +436,7 @@ config SERIAL_MPSC_CONSOLE
 
 config SERIAL_PXA
 	bool "PXA serial port support"
-	depends on ARCH_PXA || ARCH_MMP
+	depends on ARM || MIPS
 	select SERIAL_CORE
 	help
 	  If you have a machine based on an Intel XScale PXA2xx CPU you
diff --git a/drivers/tty/serial/pxa.c b/drivers/tty/serial/pxa.c
index 78ed7ee..f6cc773 100644
--- a/drivers/tty/serial/pxa.c
+++ b/drivers/tty/serial/pxa.c
@@ -830,6 +830,7 @@ static const struct dev_pm_ops serial_pxa_pm_ops = {
 static struct of_device_id serial_pxa_dt_ids[] = {
 	{ .compatible = "mrvl,pxa-uart", },
 	{ .compatible = "mrvl,mmp-uart", },
+	{ .compatible = "brcm,bcm7401-upg-uart", },
 	{}
 };
 MODULE_DEVICE_TABLE(of, serial_pxa_dt_ids);
-- 
2.1.1

