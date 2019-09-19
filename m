From: Maximilian Luz <luzmaximilian@gmail.com>
Subject: [PATCH] serdev: Add ACPI devices by ResourceSource field
Date: Thu, 19 Sep 2019 21:56:24 +0200
Message-ID: <20190919195624.1140941-1-luzmaximilian@gmail.com>
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

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
This patch is similar to the the implementations in drivers/spi/spi.c
(see commit 4c3c59544f33e97cf8557f27e05a9904ead16363) and
drivers/i2c/i2c-core-acpi.c. However, I think that there may be an
issues with these two implementations: Both walk over the whole ACPI
namespace, but only match the first SPI or I2C resource (respectively),
so I think there may be problems when multiple SPI or I2C resources are
defined under the same ACPI device node (as in second or third SPI/I2C
resource definitions being ignored). Please note, however, that I am by
no means qualified with regards to this, and this might be totally fine.
Nevertheless I'd appreciate if anyone with more knowledge on the subject
could have a look at it. This patch would avoid this problem (for UART)
by simply walking all resource definitions via acpi_walk_resources.

There is a further issue in the serdev ACPI implementation that this
patch does not address: ACPI UART resource definitions contain things
like the initial baud-rate, parity, flow-control, etc. As far as I know,
these things can currently only be set once the device is opened.
Furthermore, some option values, such as ParityTypeMark, are not (yet)
supported. I'd be willing to try and implement setting the currently
supported values based on ACPI for a future patch, if anyone can provide
me with some pointers on how to do that.

I have personally tested this patch on a Microsoft Surface Book 2, which
like all newer MS Surface devices has a UART EC, and it has been in use
(in some form or another) for a couple of months on other Surface
devices via a patched kernel [1, 2, 3]. I can, however, not speak for
any non-Microsoft devices or potential Apple ACPI quirks.

[1]: https://github.com/jakeday/linux-surface/
[2]: https://github.com/qzed/linux-surface/
[3]: https://github.com/qzed/linux-surfacegen5-acpi/

 drivers/tty/serdev/core.c | 64 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 56 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index a0ac16ee6575..1c8360deea77 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -582,18 +582,64 @@ static acpi_status acpi_serdev_register_device(struct serdev_controller *ctrl,
 	return AE_OK;
 }
 
-static acpi_status acpi_serdev_add_device(acpi_handle handle, u32 level,
-				       void *data, void **return_value)
+struct acpi_serdev_resource_context {
+	struct serdev_controller *controller;
+	struct acpi_device *device;
+};
+
+static acpi_status
+acpi_serdev_add_device_from_resource(struct acpi_resource *resource, void *data)
 {
-	struct serdev_controller *ctrl = data;
-	struct acpi_device *adev;
+	struct acpi_serdev_resource_context *ctx
+		= (struct acpi_serdev_resource_context *)data;
+	struct acpi_resource_source *ctrl_name;
+	acpi_handle ctrl_handle;
+
+	if (resource->type != ACPI_RESOURCE_TYPE_SERIAL_BUS)
+		return AE_OK;
 
-	if (acpi_bus_get_device(handle, &adev))
+	if (resource->data.common_serial_bus.type
+	    != ACPI_RESOURCE_SERIAL_TYPE_UART)
 		return AE_OK;
 
-	return acpi_serdev_register_device(ctrl, adev);
+	ctrl_name = &resource->data.common_serial_bus.resource_source;
+	if (ctrl_name->string_length == 0 || !ctrl_name->string_ptr)
+		return AE_OK;
+
+	if (acpi_get_handle(ctx->device->handle, ctrl_name->string_ptr,
+			    &ctrl_handle))
+		return AE_OK;
+
+	if (ctrl_handle == ACPI_HANDLE(ctx->controller->dev.parent))
+		return acpi_serdev_register_device(ctx->controller,
+						   ctx->device);
+
+	return AE_OK;
 }
 
+static acpi_status
+acpi_serdev_add_devices_from_resources(acpi_handle handle, u32 level,
+				       void *data, void **return_value)
+{
+	struct acpi_serdev_resource_context ctx;
+	acpi_status status;
+
+	ctx.controller = (struct serdev_controller *)data;
+	status = acpi_bus_get_device(handle, &ctx.device);
+	if (status)
+		return AE_OK;		// ignore device if not present
+
+	status = acpi_walk_resources(handle, METHOD_NAME__CRS,
+				     acpi_serdev_add_device_from_resource,
+				     &ctx);
+	if (status == AE_NOT_FOUND)
+		return AE_OK;		// ignore if _CRS is not found
+	else
+		return status;
+}
+
+#define SERDEV_ACPI_ENUMERATE_MAX_DEPTH		32
+
 static int acpi_serdev_register_devices(struct serdev_controller *ctrl)
 {
 	acpi_status status;
@@ -603,8 +649,10 @@ static int acpi_serdev_register_devices(struct serdev_controller *ctrl)
 	if (!handle)
 		return -ENODEV;
 
-	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, handle, 1,
-				     acpi_serdev_add_device, NULL, ctrl, NULL);
+	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
+				     SERDEV_ACPI_ENUMERATE_MAX_DEPTH,
+				     acpi_serdev_add_devices_from_resources,
+				     NULL, ctrl, NULL);
 	if (ACPI_FAILURE(status))
 		dev_dbg(&ctrl->dev, "failed to enumerate serdev slaves\n");
 
-- 
2.23.0
