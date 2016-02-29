From: Aleksey Makarov <aleksey.makarov@linaro.org>
Subject: [PATCH v3 7/7] serial: pl011: add ACPI DBG2 serial port
Date: Mon, 29 Feb 2016 15:42:04 +0300
Message-ID: <1456749726-30261-8-git-send-email-aleksey.makarov@linaro.org>
References: <1456749726-30261-1-git-send-email-aleksey.makarov@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1456749726-30261-1-git-send-email-aleksey.makarov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Aleksey Makarov <aleksey.makarov@linaro.org>, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Leif Lindholm <leif.lindholm@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, Al Stone <ahs3@redhat.com>, Christopher Covington <cov@codeaurora.org>, Matthias Brugger <mbrugger@suse.com>, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

Add a handler for ACPI DBG2 serial port of type ACPI_DBG2_ARM_PL011
that sets up an earlycon on it.

Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>
---
 drivers/tty/serial/amba-pl011.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 500232a..d38da86 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -59,6 +59,7 @@
 #include <linux/sizes.h>
 #include <linux/io.h>
 #include <linux/acpi.h>
+#include <linux/acpi_dbg2.h>
 
 #include "amba-pl011.h"
 
@@ -2327,6 +2328,8 @@ static int __init pl011_early_console_setup(struct earlycon_device *device,
 	return 0;
 }
 OF_EARLYCON_DECLARE(pl011, "arm,pl011", pl011_early_console_setup);
+ACPI_DBG2_EARLYCON_DECLARE(pl011, ACPI_DBG2_ARM_PL011,
+			   pl011_early_console_setup);
 
 #else
 #define AMBA_CONSOLE	NULL
-- 
2.7.1
