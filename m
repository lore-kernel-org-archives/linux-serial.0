From: Aleksey Makarov <aleksey.makarov@linaro.org>
Subject: [PATCH 8/8] serial: pl011: add ACPI DBG2 serial port
Date: Mon, 22 Feb 2016 16:46:56 +0300
Message-ID: <1456148818-26257-9-git-send-email-aleksey.makarov@linaro.org>
References: <1456148818-26257-1-git-send-email-aleksey.makarov@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1456148818-26257-1-git-send-email-aleksey.makarov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Aleksey Makarov <aleksey.makarov@linaro.org>, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Leif Lindholm <leif.lindholm@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, Al Stone <ahs3@redhat.com>, Christopher Covington <cov@codeaurora.org>, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

Add a handler for ACPI DBG2 serial port of type ACPI_DBG2_ARM_PL011
that sets up an earlycon on it.

Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>
---
 drivers/tty/serial/amba-pl011.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index c0da0cc..5633741 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -59,6 +59,7 @@
 #include <linux/sizes.h>
 #include <linux/io.h>
 #include <linux/acpi.h>
+#include <linux/acpi_dbg2.h>
 
 #include "amba-pl011.h"
 
@@ -2329,6 +2330,8 @@ static int __init pl011_early_console_setup(struct earlycon_device *device,
 }
 EARLYCON_DECLARE(pl011, pl011_early_console_setup);
 OF_EARLYCON_DECLARE(pl011, "arm,pl011", pl011_early_console_setup);
+ACPI_DBG2_EARLYCON_DECLARE(pl011, ACPI_DBG2_ARM_PL011,
+			   pl011_early_console_setup);
 
 #else
 #define AMBA_CONSOLE	NULL
-- 
2.7.1
