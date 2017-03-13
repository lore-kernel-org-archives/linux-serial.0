From: "zhichang.yuan" <yuanzhichang-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
Subject: [PATCH V7 7/7] LPC: Add the ACPI LPC support
Date: Mon, 13 Mar 2017 10:42:43 +0800
Message-ID: <1489372963-9000-8-git-send-email-yuanzhichang@hisilicon.com>
References: <1489372963-9000-1-git-send-email-yuanzhichang@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1489372963-9000-1-git-send-email-yuanzhichang-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, minyard-HInyCGIudOg@public.gmane.org, liviu.dudau-5wv7dgnIgG8@public.gmane.org, zourongrong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, gabriele.paoloni-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, zhichang.yuan02-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, kantyzc-9Onoh4P/yGk@public.gmane.org, xuwei5-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, "zhichang.yuan" <yuanzhichang-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

The patch update the _CRS of LPC children based on the relevant LIBIO
interfaces. Then the ACPI platform device enumeration for LPC can apply the
right I/O resource to request the system I/O space from ioport_resource and
ensure the LPC peripherals work well.

Signed-off-by: zhichang.yuan <yuanzhichang-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
Signed-off-by: John Garry <john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
---
 drivers/bus/hisi_lpc.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/bus/hisi_lpc.c b/drivers/bus/hisi_lpc.c
index 345ea12..3796b1f 100644
--- a/drivers/bus/hisi_lpc.c
+++ b/drivers/bus/hisi_lpc.c
@@ -464,6 +464,27 @@ static int hisilpc_host_io_register(struct device *dev,
 
 	lpcdev->io_host = range;
 
+	/*
+	 * For ACPI children, translate the bus-local I/O range to logical
+	 * I/O range and set it as the current resource before the children
+	 * are enumerated.
+	 */
+	if (has_acpi_companion(dev)) {
+		struct acpi_device *root, *child;
+
+		root = to_acpi_device_node(dev->fwnode);
+		/* For hisilpc, only care about the sons of host. */
+		list_for_each_entry(child, &root->children, node) {
+			int ret;
+
+			ret = acpi_set_libio_resource(child, root);
+			if (ret) {
+				dev_err(&child->dev, "set resource failed..\n");
+				return ret;
+			}
+		}
+	}
+
 	return 0;
 }
 
@@ -558,10 +579,18 @@ static int hisilpc_probe(struct platform_device *pdev)
 	{},
 };
 
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id hisilpc_acpi_match[] = {
+	{"HISI0191", },
+	{},
+};
+#endif
+
 static struct platform_driver hisilpc_driver = {
 	.driver = {
 		.name           = "hisi_lpc",
 		.of_match_table = hisilpc_of_match,
+		.acpi_match_table = ACPI_PTR(hisilpc_acpi_match),
 	},
 	.probe = hisilpc_probe,
 };
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
