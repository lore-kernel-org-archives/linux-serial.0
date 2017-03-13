From: "zhichang.yuan" <yuanzhichang-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
Subject: [PATCH V7 5/7] ACPI: Delay the enumeration on the devices whose  dependency has not met
Date: Mon, 13 Mar 2017 10:42:41 +0800
Message-ID: <1489372963-9000-6-git-send-email-yuanzhichang@hisilicon.com>
References: <1489372963-9000-1-git-send-email-yuanzhichang@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1489372963-9000-1-git-send-email-yuanzhichang-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, minyard-HInyCGIudOg@public.gmane.org, liviu.dudau-5wv7dgnIgG8@public.gmane.org, zourongrong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, gabriele.paoloni-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, zhichang.yuan02-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, kantyzc-9Onoh4P/yGk@public.gmane.org, xuwei5-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, "zhichang.yuan" <yuanzhichang-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

In commit 40e7fcb1929(ACPI: Add _DEP support to fix battery issue on Asus
T100TA), the '_DEP' was supported to solve the dependency of Asus battery. But
this patch is specific to Asus battery device.
In the real world, there are other devices which need the dependency to play the
role on the enumeration order. For example, all the Hip06 LPC
periperals(IPMI-BT, uart, etc) must be scanned after the LPC host driver
finished the probing. So, it makes sense to add a checking whether the ACPI
device meet all the dependencies during its enumeration slot, if not, the
enumeration will be delayed till all dependency master finish their work.

This patch adds the dependency checking in ACPI enumeration, also the
corresponding handling to retrigger the Hip06 LPC peripherals' scanning.

Signed-off-by: zhichang.yuan <yuanzhichang-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
---
 drivers/acpi/battery.c |  3 ---
 drivers/acpi/scan.c    |  3 +++
 drivers/bus/hisi_lpc.c | 12 +++++++++++-
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 4ef1e46..e8d1af1 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -1210,9 +1210,6 @@ static int acpi_battery_add(struct acpi_device *device)
 	if (!device)
 		return -EINVAL;
 
-	if (device->dep_unmet)
-		return -EPROBE_DEFER;
-
 	battery = kzalloc(sizeof(struct acpi_battery), GFP_KERNEL);
 	if (!battery)
 		return -ENOMEM;
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 1926918..97721b1 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1843,6 +1843,9 @@ static void acpi_bus_attach(struct acpi_device *device)
 	if (device->handler)
 		goto ok;
 
+	if (device->dep_unmet)
+		return;
+
 	if (!device->flags.initialized) {
 		device->flags.power_manageable =
 			device->power.states[ACPI_STATE_D0].flags.valid;
diff --git a/drivers/bus/hisi_lpc.c b/drivers/bus/hisi_lpc.c
index 03cf19a..345ea12 100644
--- a/drivers/bus/hisi_lpc.c
+++ b/drivers/bus/hisi_lpc.c
@@ -516,8 +516,18 @@ static int hisilpc_probe(struct platform_device *pdev)
 
 	/*
 	 * It is time to start the children scannings....
+	 * For ACPI children, the corresponding devices will be created after
+	 * retriggering the ACPI scanning by removing the dependency blocking.
 	 */
-	if (!has_acpi_companion(dev)) {
+	if (has_acpi_companion(dev)) {
+		struct acpi_device *adev;
+
+		adev = to_acpi_device_node(dev->fwnode);
+		if (!adev)
+			ret = -ENODEV;
+		else
+			acpi_walk_dep_device_list(adev->handle);
+	} else {
 		ret = of_platform_populate(dev->of_node, NULL, NULL, dev);
 		if (ret)
 			dev_err(dev, "OF: enumerate LPC bus fail(%d)\n", ret);
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
