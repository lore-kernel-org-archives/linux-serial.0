From: Jisheng Zhang <jszhang@marvell.com>
Subject: [PATCH] serial: 8250_dw: #ifdef out dw8250_acpi_match if ACPI isn't set
Date: Fri, 23 Dec 2016 20:33:55 +0800
Message-ID: <20161223123355.1370-1-jszhang@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Jisheng Zhang <jszhang@marvell.com>
List-Id: linux-serial@vger.kernel.org

dw8250_acpi_match is used only when ACPI is enabled. Fix the following
gcc warning when W=1 is set:

drivers/tty/serial/8250/8250_dw.c:640:36: warning: 'dw8250_acpi_match'
defined but not used [-Wunused-const-variable=]

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/tty/serial/8250/8250_dw.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index c89fafc972b6..bd43cbfd0783 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -637,6 +637,7 @@ static const struct of_device_id dw8250_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, dw8250_of_match);
 
+#ifdef CONFIG_ACPI
 static const struct acpi_device_id dw8250_acpi_match[] = {
 	{ "INT33C4", 0 },
 	{ "INT33C5", 0 },
@@ -651,6 +652,7 @@ static const struct acpi_device_id dw8250_acpi_match[] = {
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, dw8250_acpi_match);
+#endif
 
 static struct platform_driver dw8250_platform_driver = {
 	.driver = {
-- 
2.11.0
