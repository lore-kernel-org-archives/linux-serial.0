Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D982ECE9E;
	Mon,  8 Sep 2025 09:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757324753; cv=none; b=VU+28laT6B5Oof/BeAAuI6QtmjmxVw5BiUmiVMcTdqCAv7q0RHNWJqrVmZP/1hxv6wSkIuB11GInU/1RERP4q5uyksLv6Yz4uB1wRWWKj15hrQMWcrQYEqjIpoxw+Mr76282w/3fO6Z2epbBrOL9vV33Q2DuJ8ChNn0VMEnd5V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757324753; c=relaxed/simple;
	bh=WG7WUKtE4zJYheWQPYmuVySI5x2lgsKDFdlo5YMsXy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NENsDwOPvPfVv0E8/krEUJJRWxNi66zSHCyFLbCnbMW0zZRUrjoGBWiPVMOV7H7Q29pMJU72ITX6/cogFe1sx5n18QYljdUYV6rjjH3jCKhvVTrhoA55TzuXYKRLMaNmwU3V8/WoOn/26Y3I/UMM+S4Yq36mFVnvgpdvEhsR7+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67DECC4CEF8;
	Mon,  8 Sep 2025 09:45:51 +0000 (UTC)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Philip Blundell <philb@gnu.org>,
	Kars de Jong <jongk@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 1/2] tty: serial: 8250: Move HP300/400 serial Kconfig options
Date: Mon,  8 Sep 2025 11:45:41 +0200
Message-ID: <56244caed4261057d317cd3101be27660b4fc117.1757323858.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1757323858.git.geert@linux-m68k.org>
References: <cover.1757323858.git.geert@linux-m68k.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The HPDCA and HPAPCI Kconfig symbols for HP300 and HP400 serial ports
are clearly suboptions of the HP300 serial driver.  Hence move them from
arch/m68k/Kconfig.devices to drivers/tty/serial/8250/Kconfig.
Add "SERIAL_8250_"-prefixes to the symbols, and "8250 "-prefixes
to their descriptions, to match the style of the new location.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/m68k/Kconfig.devices            | 14 -------------
 drivers/tty/serial/8250/8250_hp300.c | 30 ++++++++++++++--------------
 drivers/tty/serial/8250/Kconfig      | 14 +++++++++++++
 3 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/arch/m68k/Kconfig.devices b/arch/m68k/Kconfig.devices
index e6e3efac184074c2..999ee6aaa8d29c2f 100644
--- a/arch/m68k/Kconfig.devices
+++ b/arch/m68k/Kconfig.devices
@@ -104,20 +104,6 @@ config AMIGA_BUILTIN_SERIAL
 
 	  To compile this driver as a module, choose M here.
 
-config HPDCA
-	tristate "HP DCA serial support"
-	depends on DIO && SERIAL_8250
-	help
-	  If you want to use the internal "DCA" serial ports on an HP300
-	  machine, say Y here.
-
-config HPAPCI
-	tristate "HP APCI serial support"
-	depends on HP300 && SERIAL_8250
-	help
-	  If you want to use the internal "APCI" serial ports on an HP400
-	  machine, say Y here.
-
 config SERIAL_CONSOLE
 	bool "Support for serial port console"
 	depends on AMIGA_BUILTIN_SERIAL=y
diff --git a/drivers/tty/serial/8250/8250_hp300.c b/drivers/tty/serial/8250/8250_hp300.c
index 3012ea03d22ca1d5..583a86d87b559ec4 100644
--- a/drivers/tty/serial/8250/8250_hp300.c
+++ b/drivers/tty/serial/8250/8250_hp300.c
@@ -20,11 +20,11 @@
 
 #include "8250.h"
 
-#if !defined(CONFIG_HPDCA) && !defined(CONFIG_HPAPCI) && !defined(CONFIG_COMPILE_TEST)
-#warning CONFIG_SERIAL_8250 defined but neither CONFIG_HPDCA nor CONFIG_HPAPCI defined, are you sure?
+#if !defined(CONFIG_SERIAL_8250_HPDCA) && !defined(CONFIG_SERIAL_8250_HPAPCI) && !defined(CONFIG_COMPILE_TEST)
+#warning CONFIG_SERIAL_8250 defined but neither CONFIG_SERIAL_8250_HPDCA nor CONFIG_SERIAL_8250_HPAPCI defined, are you sure?
 #endif
 
-#ifdef CONFIG_HPAPCI
+#ifdef CONFIG_SERIAL_8250_HPAPCI
 struct hp300_port {
 	struct hp300_port *next;	/* next port */
 	int line;			/* line (tty) number */
@@ -33,7 +33,7 @@ struct hp300_port {
 static struct hp300_port *hp300_ports;
 #endif
 
-#ifdef CONFIG_HPDCA
+#ifdef CONFIG_SERIAL_8250_HPDCA
 
 static int hpdca_init_one(struct dio_dev *d,
 					const struct dio_device_id *ent);
@@ -110,7 +110,7 @@ int __init hp300_setup_serial_console(void)
 
 	/* Check for APCI console */
 	if (scode == 256) {
-#ifdef CONFIG_HPAPCI
+#ifdef CONFIG_SERIAL_8250_HPAPCI
 		pr_info("Serial console is HP APCI 1\n");
 
 		port.uartclk = HPAPCI_BAUD_BASE * 16;
@@ -119,11 +119,11 @@ int __init hp300_setup_serial_console(void)
 		port.regshift = 2;
 		add_preferred_console("ttyS", port.line, "9600n8");
 #else
-		pr_warn("Serial console is APCI but support is disabled (CONFIG_HPAPCI)!\n");
+		pr_warn("Serial console is APCI but support is disabled (CONFIG_SERIAL_8250_HPAPCI)!\n");
 		return 0;
 #endif
 	} else {
-#ifdef CONFIG_HPDCA
+#ifdef CONFIG_SERIAL_8250_HPDCA
 		unsigned long pa = dio_scodetophysaddr(scode);
 		if (!pa)
 			return 0;
@@ -142,7 +142,7 @@ int __init hp300_setup_serial_console(void)
 		if (DIO_ID(pa + DIO_VIRADDRBASE) & 0x80)
 			add_preferred_console("ttyS", port.line, "9600n8");
 #else
-		pr_warn("Serial console is DCA but support is disabled (CONFIG_HPDCA)!\n");
+		pr_warn("Serial console is DCA but support is disabled (CONFIG_SERIAL_8250_HPDCA)!\n");
 		return 0;
 #endif
 	}
@@ -153,7 +153,7 @@ int __init hp300_setup_serial_console(void)
 }
 #endif /* CONFIG_SERIAL_8250_CONSOLE */
 
-#ifdef CONFIG_HPDCA
+#ifdef CONFIG_SERIAL_8250_HPDCA
 static int hpdca_init_one(struct dio_dev *d,
 				const struct dio_device_id *ent)
 {
@@ -203,7 +203,7 @@ static int hpdca_init_one(struct dio_dev *d,
 static int __init hp300_8250_init(void)
 {
 	static int called;
-#ifdef CONFIG_HPAPCI
+#ifdef CONFIG_SERIAL_8250_HPAPCI
 	int line;
 	unsigned long base;
 	struct uart_8250_port uart;
@@ -217,10 +217,10 @@ static int __init hp300_8250_init(void)
 	if (!MACH_IS_HP300)
 		return -ENODEV;
 
-#ifdef CONFIG_HPDCA
+#ifdef CONFIG_SERIAL_8250_HPDCA
 	dio_register_driver(&hpdca_driver);
 #endif
-#ifdef CONFIG_HPAPCI
+#ifdef CONFIG_SERIAL_8250_HPAPCI
 	if (hp300_model < HP_400) {
 		if (!num_ports)
 			return -ENODEV;
@@ -284,7 +284,7 @@ static int __init hp300_8250_init(void)
 	return 0;
 }
 
-#ifdef CONFIG_HPDCA
+#ifdef CONFIG_SERIAL_8250_HPDCA
 static void hpdca_remove_one(struct dio_dev *d)
 {
 	int line;
@@ -300,7 +300,7 @@ static void hpdca_remove_one(struct dio_dev *d)
 
 static void __exit hp300_8250_exit(void)
 {
-#ifdef CONFIG_HPAPCI
+#ifdef CONFIG_SERIAL_8250_HPAPCI
 	struct hp300_port *port, *to_free;
 
 	for (port = hp300_ports; port; ) {
@@ -312,7 +312,7 @@ static void __exit hp300_8250_exit(void)
 
 	hp300_ports = NULL;
 #endif
-#ifdef CONFIG_HPDCA
+#ifdef CONFIG_SERIAL_8250_HPDCA
 	dio_unregister_driver(&hpdca_driver);
 #endif
 }
diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index f64ef0819cd4e507..2696c236917afddd 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -162,6 +162,20 @@ config SERIAL_8250_HP300
 	depends on SERIAL_8250 && HP300
 	default SERIAL_8250
 
+config SERIAL_8250_HPDCA
+	tristate "8250 HP DCA serial support"
+	depends on SERIAL_8250 && DIO
+	help
+	  If you want to use the internal "DCA" serial ports on an HP300
+	  machine, say Y here.
+
+config SERIAL_8250_HPAPCI
+	tristate "8250 HP APCI serial support"
+	depends on SERIAL_8250 && HP300
+	help
+	  If you want to use the internal "APCI" serial ports on an HP400
+	  machine, say Y here.
+
 config SERIAL_8250_CS
 	tristate "8250/16550 PCMCIA device support"
 	depends on PCMCIA && SERIAL_8250 && HAS_IOPORT
-- 
2.43.0

