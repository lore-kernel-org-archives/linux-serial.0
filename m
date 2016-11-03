From: Heikki Krogerus <heikki.krogerus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH] ACPI / platform: Add support for build-in properties
Date: Thu,  3 Nov 2016 16:21:26 +0200
Message-ID: <20161103142126.87413-1-heikki.krogerus@linux.intel.com>
References: <20161102154139.GD11523@kuha.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161102154139.GD11523-FZxXFokcWpatqXYlAKuG4QC/G2K4zDHf@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?UTF-8?q?J=C3=A9r=C3=B4me=20de=20Bretagne?= <jerome.debretagne-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Kefeng Wang <wangkefeng.wang-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Feng Kan <fkan-qTEPVZfXA3Y@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

We have a couple of drivers, acpi_apd.c and acpi_lpss.c,
that need to pass extra build-in properties to the devices
they create. Previously the drivers added those properties
to the struct device which is member of the struct
acpi_device, but that does not work. Those properties need
to be assigned to the struct device of the platform device
instead in order for them to become available to the
drivers.

To fix this, this patch changes acpi_create_platform_device
function to take struct property_entry pointer as parameter.

Fixes: 20a875e2e86e ("serial: 8250_dw: Add quirk for APM X-Gene SoC")
Signed-off-by: Heikki Krogerus <heikki.krogerus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/acpi/acpi_apd.c             | 10 ++--------
 drivers/acpi/acpi_lpss.c            | 10 ++--------
 drivers/acpi/acpi_platform.c        |  5 ++++-
 drivers/acpi/dptf/int340x_thermal.c |  4 ++--
 drivers/acpi/scan.c                 |  2 +-
 drivers/platform/x86/intel-hid.c    |  2 +-
 drivers/platform/x86/intel-vbtn.c   |  2 +-
 include/linux/acpi.h                |  3 ++-
 8 files changed, 15 insertions(+), 23 deletions(-)

Hi,

Found the problem, and this is my proposal for a fix.

Jérôme, please test it when you have time.


Thanks,

diff --git a/drivers/acpi/acpi_apd.c b/drivers/acpi/acpi_apd.c
index 5ec7f3a..26696b6 100644
--- a/drivers/acpi/acpi_apd.c
+++ b/drivers/acpi/acpi_apd.c
@@ -127,7 +127,7 @@ static int acpi_apd_create_device(struct acpi_device *adev,
 	int ret;
 
 	if (!dev_desc) {
-		pdev = acpi_create_platform_device(adev);
+		pdev = acpi_create_platform_device(adev, NULL);
 		return IS_ERR_OR_NULL(pdev) ? PTR_ERR(pdev) : 1;
 	}
 
@@ -144,14 +144,8 @@ static int acpi_apd_create_device(struct acpi_device *adev,
 			goto err_out;
 	}
 
-	if (dev_desc->properties) {
-		ret = device_add_properties(&adev->dev, dev_desc->properties);
-		if (ret)
-			goto err_out;
-	}
-
 	adev->driver_data = pdata;
-	pdev = acpi_create_platform_device(adev);
+	pdev = acpi_create_platform_device(adev, dev_desc->properties);
 	if (!IS_ERR_OR_NULL(pdev))
 		return 1;
 
diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index 5520102..373657f 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -395,7 +395,7 @@ static int acpi_lpss_create_device(struct acpi_device *adev,
 
 	dev_desc = (const struct lpss_device_desc *)id->driver_data;
 	if (!dev_desc) {
-		pdev = acpi_create_platform_device(adev);
+		pdev = acpi_create_platform_device(adev, NULL);
 		return IS_ERR_OR_NULL(pdev) ? PTR_ERR(pdev) : 1;
 	}
 	pdata = kzalloc(sizeof(*pdata), GFP_KERNEL);
@@ -451,14 +451,8 @@ static int acpi_lpss_create_device(struct acpi_device *adev,
 		goto err_out;
 	}
 
-	if (dev_desc->properties) {
-		ret = device_add_properties(&adev->dev, dev_desc->properties);
-		if (ret)
-			goto err_out;
-	}
-
 	adev->driver_data = pdata;
-	pdev = acpi_create_platform_device(adev);
+	pdev = acpi_create_platform_device(adev, dev_desc->properties);
 	if (!IS_ERR_OR_NULL(pdev)) {
 		return 1;
 	}
diff --git a/drivers/acpi/acpi_platform.c b/drivers/acpi/acpi_platform.c
index b200ae1..b4c1a6a 100644
--- a/drivers/acpi/acpi_platform.c
+++ b/drivers/acpi/acpi_platform.c
@@ -50,6 +50,7 @@ static void acpi_platform_fill_resource(struct acpi_device *adev,
 /**
  * acpi_create_platform_device - Create platform device for ACPI device node
  * @adev: ACPI device node to create a platform device for.
+ * @properties: Optional collection of build-in properties.
  *
  * Check if the given @adev can be represented as a platform device and, if
  * that's the case, create and register a platform device, populate its common
@@ -57,7 +58,8 @@ static void acpi_platform_fill_resource(struct acpi_device *adev,
  *
  * Name of the platform device will be the same as @adev's.
  */
-struct platform_device *acpi_create_platform_device(struct acpi_device *adev)
+struct platform_device *acpi_create_platform_device(struct acpi_device *adev,
+					struct property_entry *properties)
 {
 	struct platform_device *pdev = NULL;
 	struct platform_device_info pdevinfo;
@@ -106,6 +108,7 @@ struct platform_device *acpi_create_platform_device(struct acpi_device *adev)
 	pdevinfo.res = resources;
 	pdevinfo.num_res = count;
 	pdevinfo.fwnode = acpi_fwnode_handle(adev);
+	pdevinfo.properties = properties;
 
 	if (acpi_dma_supported(adev))
 		pdevinfo.dma_mask = DMA_BIT_MASK(32);
diff --git a/drivers/acpi/dptf/int340x_thermal.c b/drivers/acpi/dptf/int340x_thermal.c
index 33505c6..8636409 100644
--- a/drivers/acpi/dptf/int340x_thermal.c
+++ b/drivers/acpi/dptf/int340x_thermal.c
@@ -34,11 +34,11 @@ static int int340x_thermal_handler_attach(struct acpi_device *adev,
 					const struct acpi_device_id *id)
 {
 	if (IS_ENABLED(CONFIG_INT340X_THERMAL))
-		acpi_create_platform_device(adev);
+		acpi_create_platform_device(adev, NULL);
 	/* Intel SoC DTS thermal driver needs INT3401 to set IRQ descriptor */
 	else if (IS_ENABLED(CONFIG_INTEL_SOC_DTS_THERMAL) &&
 		 id->driver_data == INT3401_DEVICE)
-		acpi_create_platform_device(adev);
+		acpi_create_platform_device(adev, NULL);
 	return 1;
 }
 
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 035ac64..3d1856f 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1734,7 +1734,7 @@ static void acpi_default_enumeration(struct acpi_device *device)
 			       &is_spi_i2c_slave);
 	acpi_dev_free_resource_list(&resource_list);
 	if (!is_spi_i2c_slave) {
-		acpi_create_platform_device(device);
+		acpi_create_platform_device(device, NULL);
 		acpi_device_set_enumerated(device);
 	} else {
 		blocking_notifier_call_chain(&acpi_reconfig_chain,
diff --git a/drivers/platform/x86/intel-hid.c b/drivers/platform/x86/intel-hid.c
index ed58742..12dbb50 100644
--- a/drivers/platform/x86/intel-hid.c
+++ b/drivers/platform/x86/intel-hid.c
@@ -264,7 +264,7 @@ check_acpi_dev(acpi_handle handle, u32 lvl, void *context, void **rv)
 		return AE_OK;
 
 	if (acpi_match_device_ids(dev, ids) == 0)
-		if (acpi_create_platform_device(dev))
+		if (acpi_create_platform_device(dev, NULL))
 			dev_info(&dev->dev,
 				 "intel-hid: created platform device\n");
 
diff --git a/drivers/platform/x86/intel-vbtn.c b/drivers/platform/x86/intel-vbtn.c
index 146d02f..7808076 100644
--- a/drivers/platform/x86/intel-vbtn.c
+++ b/drivers/platform/x86/intel-vbtn.c
@@ -164,7 +164,7 @@ check_acpi_dev(acpi_handle handle, u32 lvl, void *context, void **rv)
 		return AE_OK;
 
 	if (acpi_match_device_ids(dev, ids) == 0)
-		if (acpi_create_platform_device(dev))
+		if (acpi_create_platform_device(dev, NULL))
 			dev_info(&dev->dev,
 				 "intel-vbtn: created platform device\n");
 
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 689a8b9..61a3d90 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -555,7 +555,8 @@ int acpi_device_uevent_modalias(struct device *, struct kobj_uevent_env *);
 int acpi_device_modalias(struct device *, char *, int);
 void acpi_walk_dep_device_list(acpi_handle handle);
 
-struct platform_device *acpi_create_platform_device(struct acpi_device *);
+struct platform_device *acpi_create_platform_device(struct acpi_device *,
+						    struct property_entry *);
 #define ACPI_PTR(_ptr)	(_ptr)
 
 static inline void acpi_device_set_enumerated(struct acpi_device *adev)
-- 
2.9.3
