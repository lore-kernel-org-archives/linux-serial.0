From: Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH V2 8/9] tty: serial: of-serial: Allow OF earlycon to default to "on"
Date: Mon, 20 Oct 2014 13:54:07 -0700
Message-ID: <1413838448-29464-9-git-send-email-cernekee@gmail.com>
References: <1413838448-29464-1-git-send-email-cernekee@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:47468 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753385AbaJTUzI (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 20 Oct 2014 16:55:08 -0400
In-Reply-To: <1413838448-29464-1-git-send-email-cernekee@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.cz, robh@kernel.org, grant.likely@linaro.org
Cc: geert@linux-m68k.org, f.fainelli@gmail.com, mbizon@freebox.fr, jogo@openwrt.org, linux-mips@linux-mips.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org

On many development systems it is very common to see failures during the
early stages of the boot process, e.g. SMP boot or PCIe initialization.
This is one likely reason why some existing earlyprintk implementations,
such as arch/mips/kernel/early_printk.c, are enabled unconditionally
at compile time.

Now that earlycon's operating parameters can be passed into the kernel
via DT, it is helpful to be able to configure the kernel to turn it on
automatically.  Introduce a new CONFIG_SERIAL_EARLYCON_FORCE option for
this purpose.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 drivers/of/fdt.c           |  5 +++++
 drivers/tty/serial/Kconfig | 11 +++++++++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 20193cc..3e2ea1e 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -1013,6 +1013,11 @@ bool __init early_init_dt_verify(void *params)
 
 void __init early_init_dt_scan_nodes(void)
 {
+#ifdef CONFIG_SERIAL_EARLYCON_FORCE
+	if (early_init_dt_scan_chosen_serial() < 0)
+		pr_warn("Unable to set up earlycon from stdout-path\n");
+#endif
+
 	/* Retrieve various information from the /chosen node */
 	of_scan_flat_dt(early_init_dt_scan_chosen, boot_command_line);
 
diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index fdd851e..bc4ebcc 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -14,6 +14,17 @@ config SERIAL_EARLYCON
 	  the console before standard serial driver is probed. The console is
 	  enabled when early_param is processed.
 
+config SERIAL_EARLYCON_FORCE
+	bool "Always enable early console"
+	depends on SERIAL_EARLYCON
+	help
+	  Traditionally, enabling the early console has required passing in
+	  the "earlycon" parameter on the kernel command line.  On systems
+	  under development it may be desirable to enable earlycon
+	  unconditionally rather than to force the user to manually add it
+	  to the boot argument string, as boot failures often occur before
+	  the standard serial driver is probed.
+
 source "drivers/tty/serial/8250/Kconfig"
 
 comment "Non-8250 serial port support"
-- 
2.1.1

