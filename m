From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
        <frederic.danis.oss@gmail.com>
Subject: [PATCH 2/2] ACPI / scan: Fix enumeration for special UART devices
Date: Wed,  4 Oct 2017 10:51:30 +0200
Message-ID: <1507107090-15992-3-git-send-email-frederic.danis.oss@gmail.com>
References: <1507107090-15992-1-git-send-email-frederic.danis.oss@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1507107090-15992-1-git-send-email-frederic.danis.oss@gmail.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-acpi-owner@vger.kernel.org
To: robh@kernel.org, marcel@holtmann.org, sre@kernel.org, loic.poulain@gmail.com, johan@kernel.org, lukas@wunner.de, hdegoede@redhat.com
Cc: linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org, frederic.danis.oss@gmail.com
List-Id: linux-serial@vger.kernel.org

UART devices is expected to be enumerated by SerDev subsystem.

During ACPI scan, serial devices behind SPI, I2C or UART buses are not
enumerated, allowing them to be enumerated by their respective parents.

Rename *spi_i2c_slave* to *serial_bus_slave* as this will be used for serial
devices on serial buses (SPI, I2C or UART).

On Macs an empty ResourceTemplate is returned for uart slaves.
Instead the device properties "baud", "parity", "dataBits", "stopBits" are
provided. Add a check for "baud" in acpi_is_serial_bus_slave().

Signed-off-by: Frédéric Danis <frederic.danis.oss@gmail.com>
---
 drivers/acpi/scan.c     | 37 +++++++++++++++++--------------------
 include/acpi/acpi_bus.h |  2 +-
 2 files changed, 18 insertions(+), 21 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 602f8ff..860b698 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1505,41 +1505,38 @@ static void acpi_init_coherency(struct acpi_device *adev)
 	adev->flags.coherent_dma = cca;
 }
 
-static int acpi_check_spi_i2c_slave(struct acpi_resource *ares, void *data)
+static int acpi_check_serial_bus_slave(struct acpi_resource *ares, void *data)
 {
-	bool *is_spi_i2c_slave_p = data;
+	bool *is_serial_bus_slave_p = data;
 
 	if (ares->type != ACPI_RESOURCE_TYPE_SERIAL_BUS)
 		return 1;
 
-	/*
-	 * devices that are connected to UART still need to be enumerated to
-	 * platform bus
-	 */
-	if (ares->data.common_serial_bus.type != ACPI_RESOURCE_SERIAL_TYPE_UART)
-		*is_spi_i2c_slave_p = true;
+	*is_serial_bus_slave_p = true;
 
 	 /* no need to do more checking */
 	return -1;
 }
 
-static bool acpi_is_spi_i2c_slave(struct acpi_device *device)
+static bool acpi_is_serial_bus_slave(struct acpi_device *device)
 {
 	struct list_head resource_list;
-	bool is_spi_i2c_slave = false;
+	bool is_serial_bus_slave = false;
 
 	/* Macs use device properties in lieu of _CRS resources */
 	if (x86_apple_machine &&
 	    (fwnode_property_present(&device->fwnode, "spiSclkPeriod") ||
-	     fwnode_property_present(&device->fwnode, "i2cAddress")))
+	     fwnode_property_present(&device->fwnode, "i2cAddress") ||
+	     fwnode_property_present(&device->fwnode, "baud")))
 		return true;
 
 	INIT_LIST_HEAD(&resource_list);
-	acpi_dev_get_resources(device, &resource_list, acpi_check_spi_i2c_slave,
-			       &is_spi_i2c_slave);
+	acpi_dev_get_resources(device, &resource_list,
+			       acpi_check_serial_bus_slave,
+			       &is_serial_bus_slave);
 	acpi_dev_free_resource_list(&resource_list);
 
-	return is_spi_i2c_slave;
+	return is_serial_bus_slave;
 }
 
 void acpi_init_device_object(struct acpi_device *device, acpi_handle handle,
@@ -1557,7 +1554,7 @@ void acpi_init_device_object(struct acpi_device *device, acpi_handle handle,
 	acpi_bus_get_flags(device);
 	device->flags.match_driver = false;
 	device->flags.initialized = true;
-	device->flags.spi_i2c_slave = acpi_is_spi_i2c_slave(device);
+	device->flags.serial_bus_slave = acpi_is_serial_bus_slave(device);
 	acpi_device_clear_enumerated(device);
 	device_initialize(&device->dev);
 	dev_set_uevent_suppress(&device->dev, true);
@@ -1841,10 +1838,10 @@ static acpi_status acpi_bus_check_add(acpi_handle handle, u32 lvl_not_used,
 static void acpi_default_enumeration(struct acpi_device *device)
 {
 	/*
-	 * Do not enumerate SPI/I2C slaves as they will be enumerated by their
-	 * respective parents.
+	 * Do not enumerate SPI/I2C/UART slaves as they will be enumerated by
+	 * their respective parents.
 	 */
-	if (!device->flags.spi_i2c_slave) {
+	if (!device->flags.serial_bus_slave) {
 		acpi_create_platform_device(device, NULL);
 		acpi_device_set_enumerated(device);
 	} else {
@@ -1941,7 +1938,7 @@ static void acpi_bus_attach(struct acpi_device *device)
 		return;
 
 	device->flags.match_driver = true;
-	if (ret > 0 && !device->flags.spi_i2c_slave) {
+	if (ret > 0 && !device->flags.serial_bus_slave) {
 		acpi_device_set_enumerated(device);
 		goto ok;
 	}
@@ -1950,7 +1947,7 @@ static void acpi_bus_attach(struct acpi_device *device)
 	if (ret < 0)
 		return;
 
-	if (!device->pnp.type.platform_id && !device->flags.spi_i2c_slave)
+	if (!device->pnp.type.platform_id && !device->flags.serial_bus_slave)
 		acpi_device_set_enumerated(device);
 	else
 		acpi_default_enumeration(device);
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index fa15052..f849be2 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -211,7 +211,7 @@ struct acpi_device_flags {
 	u32 of_compatible_ok:1;
 	u32 coherent_dma:1;
 	u32 cca_seen:1;
-	u32 spi_i2c_slave:1;
+	u32 serial_bus_slave:1;
 	u32 reserved:19;
 };
 
-- 
2.7.4

