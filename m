From: Maximilian Luz <luzmaximilian@gmail.com>
Subject: [PATCH v2] serdev: Add ACPI devices by ResourceSource field
Date: Tue, 24 Sep 2019 18:22:26 +0200
Message-ID: <20190924162226.1493407-1-luzmaximilian@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Johan Hovold <johan@kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Hans de Goede <hdegoede@redhat.com>, linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Maximilian Luz <luzmaximilian@gmail.com>
List-Id: linux-serial@vger.kernel.org

When registering a serdev controller, ACPI needs to be checked for
devices attached to it. Currently, all immediate children of the ACPI
node of the controller are assumed to be UART client devices for this
controller. Furthermore, these devices are not searched elsewhere.

This is incorrect: Similar to SPI and I2C devices, the UART client
device definition (via UARTSerialBusV2) can reside anywhere in the ACPI
namespace as resource definition inside the _CRS method and points to
the controller via its ResourceSource field. This field may either
contain a fully qualified or relative path, indicating the controller
device. To address this, we need to walk over the whole ACPI namespace,
looking at each resource definition, and match the client device to the
controller via this field.

This patch is based on the existing acpi serial bus implementations in
drivers/i2c/i2c-core-acpi.c and drivers/spi/spi.c, specifically commit
4c3c59544f33e97cf8557f27e05a9904ead16363 ("spi/acpi: enumerate all SPI
slaves in the namespace").

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
Changes compared to v1:
- Patch now reflects the behavior of the existing ACPI serial bus
  implementations (drivers/i2c/i2c-core-acpi.c and drivers/spi/spi.c),
  with a maximum of one serdev client device per ACPI device node
  allocated.

- Ignores and continues on errors from AML code execution and resource
  parsing.

Notes:
  The resource lookup is kept generic (similarly to the implementations
  it is based on), meaning that it should be fairly simple to extend
  acpi_serdev_parse_resource and acpi_serdev_check_resources to get and
  return more information about the serdev client device (e.g. initial
  baud rate) once this is required.

  If multiple device definitions inside a single _CRS block ever become
  a concern, the lookup function can be instructed as to which
  UARTSerialBusV2 resource should be considered by spefifying its index
  in acpi_serdev_lookup.index. This is again based on the I2C
  implementation. Currently the last resource definition is chosen (i.e.
  index = -1) to reflect the behavior of the other ACPI serial bus
  implementations.
---
 drivers/tty/serdev/core.c | 111 +++++++++++++++++++++++++++++++++-----
 1 file changed, 99 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index a0ac16ee6575..226adeec2aed 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -552,16 +552,97 @@ static int of_serdev_register_devices(struct serdev_controller *ctrl)
 }
 
 #ifdef CONFIG_ACPI
+
+#define SERDEV_ACPI_MAX_SCAN_DEPTH 32
+
+struct acpi_serdev_lookup {
+	acpi_handle device_handle;
+	acpi_handle controller_handle;
+	int n;
+	int index;
+};
+
+static int acpi_serdev_parse_resource(struct acpi_resource *ares, void *data)
+{
+	struct acpi_serdev_lookup *lookup = data;
+	struct acpi_resource_uart_serialbus *sb;
+	acpi_status status;
+
+	if (ares->type != ACPI_RESOURCE_TYPE_SERIAL_BUS)
+		return 1;
+
+	if (ares->data.common_serial_bus.type != ACPI_RESOURCE_SERIAL_TYPE_UART)
+		return 1;
+
+	if (lookup->index != -1 && lookup->n++ != lookup->index)
+		return 1;
+
+	sb = &ares->data.uart_serial_bus;
+
+	status = acpi_get_handle(lookup->device_handle,
+				 sb->resource_source.string_ptr,
+				 &lookup->controller_handle);
+	if (ACPI_FAILURE(status))
+		return 1;
+
+	/*
+	 * NOTE: Ideally, we would also want to retreive other properties here,
+	 * once setting them before opening the device is supported by serdev.
+	 */
+
+	return 1;
+}
+
+static int acpi_serdev_do_lookup(struct acpi_device *adev,
+                                 struct acpi_serdev_lookup *lookup)
+{
+	struct list_head resource_list;
+	int ret;
+
+	lookup->device_handle = acpi_device_handle(adev);
+	lookup->controller_handle = NULL;
+	lookup->n = 0;
+
+	INIT_LIST_HEAD(&resource_list);
+	ret = acpi_dev_get_resources(adev, &resource_list,
+				     acpi_serdev_parse_resource, lookup);
+	acpi_dev_free_resource_list(&resource_list);
+
+	if (ret < 0)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int acpi_serdev_check_resources(struct serdev_controller *ctrl,
+				       struct acpi_device *adev)
+{
+	struct acpi_serdev_lookup lookup;
+	int ret;
+
+	if (acpi_bus_get_status(adev) || !adev->status.present)
+		return -EINVAL;
+
+	/* Look for UARTSerialBusV2 resource */
+	lookup.index = -1;	// we only care for the last device
+
+	ret = acpi_serdev_do_lookup(adev, &lookup);
+	if (ret)
+		return ret;
+
+	/* Make sure controller and ResourceSource handle match */
+	if (ACPI_HANDLE(ctrl->dev.parent) != lookup.controller_handle)
+		return -ENODEV;
+
+	return 0;
+}
+
 static acpi_status acpi_serdev_register_device(struct serdev_controller *ctrl,
-					    struct acpi_device *adev)
+					       struct acpi_device *adev)
 {
-	struct serdev_device *serdev = NULL;
+	struct serdev_device *serdev;
 	int err;
 
-	if (acpi_bus_get_status(adev) || !adev->status.present ||
-	    acpi_device_enumerated(adev))
-		return AE_OK;
-
 	serdev = serdev_device_alloc(ctrl);
 	if (!serdev) {
 		dev_err(&ctrl->dev, "failed to allocate serdev device for %s\n",
@@ -583,7 +664,7 @@ static acpi_status acpi_serdev_register_device(struct serdev_controller *ctrl,
 }
 
 static acpi_status acpi_serdev_add_device(acpi_handle handle, u32 level,
-				       void *data, void **return_value)
+					  void *data, void **return_value)
 {
 	struct serdev_controller *ctrl = data;
 	struct acpi_device *adev;
@@ -591,22 +672,28 @@ static acpi_status acpi_serdev_add_device(acpi_handle handle, u32 level,
 	if (acpi_bus_get_device(handle, &adev))
 		return AE_OK;
 
+	if (acpi_device_enumerated(adev))
+		return AE_OK;
+
+	if (acpi_serdev_check_resources(ctrl, adev))
+		return AE_OK;
+
 	return acpi_serdev_register_device(ctrl, adev);
 }
 
+
 static int acpi_serdev_register_devices(struct serdev_controller *ctrl)
 {
 	acpi_status status;
-	acpi_handle handle;
 
-	handle = ACPI_HANDLE(ctrl->dev.parent);
-	if (!handle)
+	if (!has_acpi_companion(ctrl->dev.parent))
 		return -ENODEV;
 
-	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, handle, 1,
+	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
+				     SERDEV_ACPI_MAX_SCAN_DEPTH,
 				     acpi_serdev_add_device, NULL, ctrl, NULL);
 	if (ACPI_FAILURE(status))
-		dev_dbg(&ctrl->dev, "failed to enumerate serdev slaves\n");
+		dev_warn(&ctrl->dev, "failed to enumerate serdev slaves\n");
 
 	if (!ctrl->serdev)
 		return -ENODEV;
-- 
2.23.0
