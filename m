From: Anup Patel <anup@brainfault.org>
Subject: [PATCH 1/3] tty/serial: Add RISC-V SBI earlycon support
Date: Tue,  4 Dec 2018 19:25:05 +0530
Message-ID: <20181204135507.3706-2-anup@brainfault.org>
References: <20181204135507.3706-1-anup@brainfault.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181204135507.3706-1-anup@brainfault.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Palmer Dabbelt <palmer@sifive.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: Atish Patra <atish.patra@wdc.com>, Christoph Hellwig <hch@infradead.org>, Rob Herring <robh@kernel.org>, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Anup Patel <anup@brainfault.org>
List-Id: linux-serial@vger.kernel.org

In RISC-V, the M-mode runtime firmware provide SBI calls for
debug prints. This patch adds earlycon support using RISC-V
SBI console calls. To enable it, just pass "earlycon=sbi" in
kernel parameters.

Signed-off-by: Anup Patel <anup@brainfault.org>
---
 drivers/tty/serial/Kconfig              | 12 +++++++++++
 drivers/tty/serial/Makefile             |  1 +
 drivers/tty/serial/earlycon-riscv-sbi.c | 28 +++++++++++++++++++++++++
 3 files changed, 41 insertions(+)
 create mode 100644 drivers/tty/serial/earlycon-riscv-sbi.c

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 32886c304641..287bb41ac814 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -85,6 +85,18 @@ config SERIAL_EARLYCON_ARM_SEMIHOST
 	  with "earlycon=smh" on the kernel command line. The console is
 	  enabled when early_param is processed.
 
+config SERIAL_EARLYCON_RISCV_SBI
+	bool "Early console using RISC-V SBI"
+	depends on RISCV
+	select SERIAL_CORE
+	select SERIAL_CORE_CONSOLE
+	select SERIAL_EARLYCON
+	help
+	  Support for early debug console using RISC-V SBI. This enables
+	  the console before standard serial driver is probed. This is enabled
+	  with "earlycon=sbi" on the kernel command line. The console is
+	  enabled when early_param is processed.
+
 config SERIAL_SB1250_DUART
 	tristate "BCM1xxx on-chip DUART serial support"
 	depends on SIBYTE_SB1xxx_SOC=y
diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
index daac675612df..3ce26ce08616 100644
--- a/drivers/tty/serial/Makefile
+++ b/drivers/tty/serial/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_SERIAL_CORE) += serial_core.o
 
 obj-$(CONFIG_SERIAL_EARLYCON) += earlycon.o
 obj-$(CONFIG_SERIAL_EARLYCON_ARM_SEMIHOST) += earlycon-arm-semihost.o
+obj-$(CONFIG_SERIAL_EARLYCON_RISCV_SBI) += earlycon-riscv-sbi.o
 
 # These Sparc drivers have to appear before others such as 8250
 # which share ttySx minor node space.  Otherwise console device
diff --git a/drivers/tty/serial/earlycon-riscv-sbi.c b/drivers/tty/serial/earlycon-riscv-sbi.c
new file mode 100644
index 000000000000..e1a551aae336
--- /dev/null
+++ b/drivers/tty/serial/earlycon-riscv-sbi.c
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * RISC-V SBI based earlycon
+ *
+ * Copyright (C) 2018 Anup Patel <anup@brainfault.org>
+ */
+#include <linux/kernel.h>
+#include <linux/console.h>
+#include <linux/init.h>
+#include <linux/serial_core.h>
+#include <asm/sbi.h>
+
+static void sbi_console_write(struct console *con,
+			      const char *s, unsigned int n)
+{
+	int i;
+
+	for (i = 0; i < n; ++i)
+		sbi_console_putchar(s[i]);
+}
+
+static int __init early_sbi_setup(struct earlycon_device *device,
+				  const char *opt)
+{
+	device->con->write = sbi_console_write;
+	return 0;
+}
+EARLYCON_DECLARE(sbi, early_sbi_setup);
-- 
2.17.1
