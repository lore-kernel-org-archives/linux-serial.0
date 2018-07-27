From: Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH] serial: 8250_dw: Add ACPI support for uart on Broadcom SoC
Date: Fri, 27 Jul 2018 09:31:06 +0530
Message-ID: <1532664066-30056-1-git-send-email-srinath.mannam@broadcom.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, vikram.prakash@broadcom.com, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, Srinath Mannam <srinath.mannam@broadcom.com>
List-Id: linux-serial@vger.kernel.org

Add ACPI identifier HID for UART DW 8250 on Broadcom SoCs
to match the HID passed through ACPI tables to enable
UART controller.

Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
Reviewed-by: Vladimir Olovyannikov <vladimir.olovyannikov@broadcom.com>
Tested-by: Vladimir Olovyannikov <vladimir.olovyannikov@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
---
 drivers/tty/serial/8250/8250_dw.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index aff04f1..7ea94ec 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -708,6 +708,7 @@ static const struct acpi_device_id dw8250_acpi_match[] = {
 	{ "AMD0020", 0 },
 	{ "AMDI0020", 0 },
 	{ "HISI0031", 0 },
+	{ "BRCM2032", 0 },
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, dw8250_acpi_match);
-- 
2.7.4
