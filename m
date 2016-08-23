From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCHv2 1/3] ACPI / APD: Provide build-in properties of the UART
Date: Tue, 23 Aug 2016 11:33:26 +0300
Message-ID: <1471941208-27963-2-git-send-email-heikki.krogerus@linux.intel.com>
References: <1471941208-27963-1-git-send-email-heikki.krogerus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1471941208-27963-1-git-send-email-heikki.krogerus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org, Ken Xue <Ken.Xue@amd.com>
List-Id: linux-serial@vger.kernel.org

The UART driver, dw8250.c, needs some details regarding the
Designware UART. For ACPI enumerated devices the values are
hard-coded, but since the driver also reads the values from
device properties, providing them with build-in properties.
This allows us to later remove the hard-coded values from
the driver.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Ken Xue <Ken.Xue@amd.com>
---
 drivers/acpi/acpi_apd.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/acpi/acpi_apd.c b/drivers/acpi/acpi_apd.c
index c80c8f8..1f30fff 100644
--- a/drivers/acpi/acpi_apd.c
+++ b/drivers/acpi/acpi_apd.c
@@ -42,6 +42,7 @@ struct apd_private_data;
 struct apd_device_desc {
 	unsigned int flags;
 	unsigned int fixed_clk_rate;
+	struct property_entry *properties;
 	int (*setup)(struct apd_private_data *pdata);
 };
 
@@ -76,9 +77,17 @@ static struct apd_device_desc cz_i2c_desc = {
 	.fixed_clk_rate = 133000000,
 };
 
+static struct property_entry uart_properties[] = {
+	PROPERTY_ENTRY_U32("reg-io-width", 4),
+	PROPERTY_ENTRY_U32("reg-shift", 2),
+	PROPERTY_ENTRY_BOOL("snps,uart-16550-compatible"),
+	{ },
+};
+
 static struct apd_device_desc cz_uart_desc = {
 	.setup = acpi_apd_setup,
 	.fixed_clk_rate = 48000000,
+	.properties = uart_properties,
 };
 #endif
 
@@ -130,6 +139,12 @@ static int acpi_apd_create_device(struct acpi_device *adev,
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
 	if (!IS_ERR_OR_NULL(pdev))
-- 
2.8.1

