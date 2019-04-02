From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 1/2] tty: add SPDX identifiers to Kconfig and Makefiles
Date: Tue,  2 Apr 2019 16:07:07 +0200
Message-ID: <20190402140708.519-1-gregkh@linuxfoundation.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Jiri Kosina <jikos@kernel.org>, David Sterba <dsterba@suse.com>, Rob Herring <robh@kernel.org>
List-Id: linux-serial@vger.kernel.org

There were a few Kconfig and Makefiles under drivers/tty/ that were
missing a SPDX identifier.  Fix that up so that automated tools can
properly classify all kernel source files.

Cc: Jiri Slaby <jslaby@suse.com>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: David Sterba <dsterba@suse.com>
Cc: Rob Herring <robh@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/Kconfig                  | 1 +
 drivers/tty/hvc/Kconfig              | 1 +
 drivers/tty/ipwireless/Makefile      | 1 +
 drivers/tty/serdev/Kconfig           | 1 +
 drivers/tty/serdev/Makefile          | 1 +
 drivers/tty/serial/8250/Kconfig      | 1 +
 drivers/tty/serial/Kconfig           | 1 +
 drivers/tty/serial/cpm_uart/Makefile | 1 +
 drivers/tty/serial/jsm/Makefile      | 1 +
 9 files changed, 9 insertions(+)

diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
index e0a04bfc873e..8034473c54ca 100644
--- a/drivers/tty/Kconfig
+++ b/drivers/tty/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 config TTY
 	bool "Enable TTY" if EXPERT
 	default y
diff --git a/drivers/tty/hvc/Kconfig b/drivers/tty/hvc/Kconfig
index 4293c172e120..1a910ec9f643 100644
--- a/drivers/tty/hvc/Kconfig
+++ b/drivers/tty/hvc/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 if TTY
 
 config HVC_DRIVER
diff --git a/drivers/tty/ipwireless/Makefile b/drivers/tty/ipwireless/Makefile
index fe2e1730986b..a665d021e24d 100644
--- a/drivers/tty/ipwireless/Makefile
+++ b/drivers/tty/ipwireless/Makefile
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # Makefile for the IPWireless driver
 #
diff --git a/drivers/tty/serdev/Kconfig b/drivers/tty/serdev/Kconfig
index 1dbc8352e027..46ae732bfc68 100644
--- a/drivers/tty/serdev/Kconfig
+++ b/drivers/tty/serdev/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # Serial bus device driver configuration
 #
diff --git a/drivers/tty/serdev/Makefile b/drivers/tty/serdev/Makefile
index 0cbdb9444d9d..078417e5b068 100644
--- a/drivers/tty/serdev/Makefile
+++ b/drivers/tty/serdev/Makefile
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 serdev-objs := core.o
 
 obj-$(CONFIG_SERIAL_DEV_BUS) += serdev.o
diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index 15c2c5463835..296115f6a4d8 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # The 8250/16550 serial drivers.  You shouldn't be in this list unless
 # you somehow have an implicit or explicit dependency on SERIAL_8250.
diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 72966bc0ac76..a5032e58c737 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # Serial device configuration
 #
diff --git a/drivers/tty/serial/cpm_uart/Makefile b/drivers/tty/serial/cpm_uart/Makefile
index 896a5d57881c..3f3a6ed02ed4 100644
--- a/drivers/tty/serial/cpm_uart/Makefile
+++ b/drivers/tty/serial/cpm_uart/Makefile
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # Makefile for the Motorola 8xx FEC ethernet controller
 #
diff --git a/drivers/tty/serial/jsm/Makefile b/drivers/tty/serial/jsm/Makefile
index 705d1ff6fdeb..4f2dbada7741 100644
--- a/drivers/tty/serial/jsm/Makefile
+++ b/drivers/tty/serial/jsm/Makefile
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # Makefile for Jasmine adapter
 #
-- 
2.21.0
