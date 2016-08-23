From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCHv2 2/3] ACPI / LPSS: Provide build-in properties of the UART
Date: Tue, 23 Aug 2016 11:33:27 +0300
Message-ID: <1471941208-27963-3-git-send-email-heikki.krogerus@linux.intel.com>
References: <1471941208-27963-1-git-send-email-heikki.krogerus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1471941208-27963-1-git-send-email-heikki.krogerus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The UART driver, dw8250.c, needs some details regarding the
Designware UART. For ACPI enumerated devices the values are
hard-coded, but since the driver also reads the values from
device properties, providing them with build-in properties.
This allows us to later remove the hard-coded values from
the driver.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/acpi/acpi_lpss.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index 357a0b8..5520102 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -75,6 +75,7 @@ struct lpss_device_desc {
 	const char *clk_con_id;
 	unsigned int prv_offset;
 	size_t prv_size_override;
+	struct property_entry *properties;
 	void (*setup)(struct lpss_private_data *pdata);
 };
 
@@ -163,11 +164,19 @@ static const struct lpss_device_desc lpt_i2c_dev_desc = {
 	.prv_offset = 0x800,
 };
 
+static struct property_entry uart_properties[] = {
+	PROPERTY_ENTRY_U32("reg-io-width", 4),
+	PROPERTY_ENTRY_U32("reg-shift", 2),
+	PROPERTY_ENTRY_BOOL("snps,uart-16550-compatible"),
+	{ },
+};
+
 static const struct lpss_device_desc lpt_uart_dev_desc = {
 	.flags = LPSS_CLK | LPSS_CLK_GATE | LPSS_CLK_DIVIDER | LPSS_LTR,
 	.clk_con_id = "baudclk",
 	.prv_offset = 0x800,
 	.setup = lpss_uart_setup,
+	.properties = uart_properties,
 };
 
 static const struct lpss_device_desc lpt_sdio_dev_desc = {
@@ -189,6 +198,7 @@ static const struct lpss_device_desc byt_uart_dev_desc = {
 	.clk_con_id = "baudclk",
 	.prv_offset = 0x800,
 	.setup = lpss_uart_setup,
+	.properties = uart_properties,
 };
 
 static const struct lpss_device_desc bsw_uart_dev_desc = {
@@ -197,6 +207,7 @@ static const struct lpss_device_desc bsw_uart_dev_desc = {
 	.clk_con_id = "baudclk",
 	.prv_offset = 0x800,
 	.setup = lpss_uart_setup,
+	.properties = uart_properties,
 };
 
 static const struct lpss_device_desc byt_spi_dev_desc = {
@@ -440,6 +451,12 @@ static int acpi_lpss_create_device(struct acpi_device *adev,
 		goto err_out;
 	}
 
+	if (dev_desc->properties) {
+		ret = device_add_properties(&adev->dev, dev_desc->properties);
+		if (ret)
+			goto err_out;
+	}
+
 	adev->driver_data = pdata;
 	pdev = acpi_create_platform_device(adev);
 	if (!IS_ERR_OR_NULL(pdev)) {
-- 
2.8.1

