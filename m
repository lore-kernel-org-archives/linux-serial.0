From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
        <frederic.danis.oss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [RFC 3/3] Bluetooth: hci_bcm: Add ACPI serdev support for BCM2E39
Date: Thu,  7 Sep 2017 14:10:14 +0200
Message-ID: <1504786214-1866-4-git-send-email-frederic.danis.oss@gmail.com>
References: <1504786214-1866-1-git-send-email-frederic.danis.oss@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1504786214-1866-1-git-send-email-frederic.danis.oss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, loic.poulain-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, frederic.danis.oss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-serial@vger.kernel.org

Signed-off-by: Frédéric Danis <frederic.danis.oss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/bluetooth/hci_bcm.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 2e358cc..b1cf07e 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -922,7 +922,6 @@ static const struct hci_uart_proto bcm_proto = {
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id bcm_acpi_match[] = {
 	{ "BCM2E1A", (kernel_ulong_t)&acpi_bcm_int_last_gpios },
-	{ "BCM2E39", (kernel_ulong_t)&acpi_bcm_int_last_gpios },
 	{ "BCM2E3A", (kernel_ulong_t)&acpi_bcm_int_last_gpios },
 	{ "BCM2E3D", (kernel_ulong_t)&acpi_bcm_int_last_gpios },
 	{ "BCM2E3F", (kernel_ulong_t)&acpi_bcm_int_last_gpios },
@@ -942,6 +941,14 @@ static const struct acpi_device_id bcm_acpi_match[] = {
 MODULE_DEVICE_TABLE(acpi, bcm_acpi_match);
 #endif
 
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id bcm_serdev_acpi_match[] = {
+	{ "BCM2E39", (kernel_ulong_t)&acpi_bcm_int_last_gpios },
+	{ },
+};
+MODULE_DEVICE_TABLE(acpi, bcm_serdev_acpi_match);
+#endif
+
 /* Platform suspend and resume callbacks */
 static const struct dev_pm_ops bcm_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(bcm_suspend, bcm_resume)
@@ -999,6 +1006,7 @@ static struct serdev_device_driver bcm_serdev_driver = {
 	.driver = {
 		.name = "hci_uart_bcm",
 		.of_match_table = of_match_ptr(bcm_bluetooth_of_match),
+		.acpi_match_table = ACPI_PTR(bcm_serdev_acpi_match),
 	},
 };
 
-- 
2.7.4
