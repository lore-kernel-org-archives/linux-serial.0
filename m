From: Dan O'Donovan <dan@emutex.com>
Subject: [PATCH] disable RTS override on LPSS UART with Auto Flow Control
Date: Wed, 15 Mar 2017 14:13:48 +0000
Message-ID: <1489587228-10764-1-git-send-email-dan@emutex.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-acpi@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Dan O'Donovan <dan@emutex.com>
List-Id: linux-serial@vger.kernel.org

Currently, Auto Flow Control is not working correctly on the Atom
X5-Z8350 "Cherry Trail" SoC, because an "RTS override" feature is
enabled in a vendor-specific register in the LPSS UART. The symptom
is that RTS is not de-asserted as it should be when RTS/CTS flow
control is enabled and the RX FIFO fills up.

This appears to be introduced by commit 1f47a77c4e49 ("ACPI / LPSS:
not using UART RTS override with Auto Flow Control").

To _disable_ the RTS override, bit 3 needs to be _set_ in the
"GENERAL" register at offset 808h.  The power-on default is 0. The
aforementioned commit appears to have assumed the inverse of this.

Signed-off-by: Dan O'Donovan <dan@emutex.com>
---
 drivers/acpi/acpi_lpss.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index 8ea836c..4b3f2d5 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -45,7 +45,7 @@ ACPI_MODULE_NAME("acpi_lpss");
 #define LPSS_RESETS_RESET_APB		BIT(1)
 #define LPSS_GENERAL			0x08
 #define LPSS_GENERAL_LTR_MODE_SW	BIT(2)
-#define LPSS_GENERAL_UART_RTS_OVRD	BIT(3)
+#define LPSS_GENERAL_UART_RTS_NO_OVRD	BIT(3)
 #define LPSS_SW_LTR			0x10
 #define LPSS_AUTO_LTR			0x14
 #define LPSS_LTR_SNOOP_REQ		BIT(15)
@@ -123,10 +123,10 @@ static void lpss_uart_setup(struct lpss_private_data *pdata)
 	writel(val | LPSS_TX_INT_MASK, pdata->mmio_base + offset);
 
 	val = readl(pdata->mmio_base + LPSS_UART_CPR);
-	if (!(val & LPSS_UART_CPR_AFCE)) {
+	if (val & LPSS_UART_CPR_AFCE) {
 		offset = pdata->dev_desc->prv_offset + LPSS_GENERAL;
 		val = readl(pdata->mmio_base + offset);
-		val |= LPSS_GENERAL_UART_RTS_OVRD;
+		val |= LPSS_GENERAL_UART_RTS_NO_OVRD;
 		writel(val, pdata->mmio_base + offset);
 	}
 }
-- 
2.7.4
