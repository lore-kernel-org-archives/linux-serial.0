From: Graeme Gregory <graeme.gregory@linaro.org>
Subject: [PATCH 1/3] ACPI: amba bus probing support
Date: Wed, 30 Sep 2015 11:38:48 +0100
Message-ID: <1443609530-21524-2-git-send-email-graeme.gregory@linaro.org>
References: <1443609530-21524-1-git-send-email-graeme.gregory@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1443609530-21524-1-git-send-email-graeme.gregory@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, shannon.zhao@linaro.org, Graeme Gregory <graeme.gregory@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Russell King <linux@arm.linux.org.uk>
List-Id: linux-serial@vger.kernel.org

On ARM64 some devices use the AMBA device and not the platform bus for
probing so add support for this. Uses a dummy clock for apb_pclk as ACPI
does not have a suitable clock representation and to keep the core
AMBA bus code unchanged between probing methods.

Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
---
 drivers/acpi/Makefile    |   1 +
 drivers/acpi/acpi_amba.c | 157 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/acpi.h     |   1 +
 3 files changed, 159 insertions(+)
 create mode 100644 drivers/acpi/acpi_amba.c

diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index b5e7cd8..b94aa9f 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -43,6 +43,7 @@ acpi-y				+= pci_root.o pci_link.o pci_irq.o
 acpi-y				+= acpi_lpss.o acpi_apd.o
 acpi-y				+= acpi_platform.o
 acpi-y				+= acpi_pnp.o
+acpi-y				+= acpi_amba.o
 acpi-y				+= int340x_thermal.o
 acpi-y				+= power.o
 acpi-y				+= event.o
diff --git a/drivers/acpi/acpi_amba.c b/drivers/acpi/acpi_amba.c
new file mode 100644
index 0000000..2f45b71
--- /dev/null
+++ b/drivers/acpi/acpi_amba.c
@@ -0,0 +1,157 @@
+
+/*
+ * ACPI support for platform bus type.
+ *
+ * Copyright (C) 2015, Linaro Ltd
+ * Authors: Graeme Gregory <graeme.gregory@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/acpi.h>
+#include <linux/amba/bus.h>
+#include <linux/clkdev.h>
+#include <linux/clk-provider.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/ioport.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+
+#ifdef CONFIG_ARM_AMBA
+static const struct acpi_device_id amba_id_list[] = {
+	{"ARMH0011", 0}, /* PL011 SBSA Uart */
+	{"ARMH0061", 0}, /* PL061 GPIO Device */
+	{"", 0},
+};
+
+struct clk *amba_dummy_clk;
+
+void amba_register_dummy_clk(void)
+{
+	struct clk *clk;
+
+	/* If clock already registered */
+	if (amba_dummy_clk)
+		return;
+
+	clk = clk_register_fixed_rate(NULL, "apb_pclk", NULL, CLK_IS_ROOT, 0);
+	clk_register_clkdev(clk, "apb_pclk", NULL);
+
+	amba_dummy_clk = clk;
+}
+
+/**
+ * acpi_create_amba_device - Create platform device for ACPI device node
+ * @adev: ACPI device node to create a AMBA device for.
+ *
+ * Create and register an AMBA device, populate its common
+ * resources and return a pointer to it.  Otherwise, return %NULL.
+ *
+ * Name of the AMBA device will be the same as @adev's.
+ */
+struct amba_device *acpi_create_amba_device(struct acpi_device *adev)
+{
+	struct amba_device *dev = NULL;
+	struct acpi_device *acpi_parent;
+	struct resource_entry *rentry;
+	struct list_head resource_list;
+	struct resource *resources = NULL;
+	bool address_found = false;
+	int ret, count, irq_no = 0;
+
+	/* If the ACPI node already has a physical device attached, skip it. */
+	if (adev->physical_node_count)
+		return NULL;
+
+	/* AMBA devices use amba_device not platform device */
+	if (acpi_match_device_ids(adev, amba_id_list))
+		return NULL;
+
+	amba_register_dummy_clk();
+
+	dev = amba_device_alloc(NULL, 0, 0);
+	if (!dev) {
+		pr_err("%s(): amba_device_alloc() failed for %s\n",
+		       __func__, dev_name(&adev->dev));
+		return NULL;
+	}
+
+	INIT_LIST_HEAD(&resource_list);
+	count = acpi_dev_get_resources(adev, &resource_list, NULL, NULL);
+	if (count < 0) {
+		return NULL;
+	} else if (count > 0) {
+		resources = kmalloc_array(count, sizeof(struct resource),
+				    GFP_KERNEL);
+		if (!resources) {
+			acpi_dev_free_resource_list(&resource_list);
+			return ERR_PTR(-ENOMEM);
+		}
+		count = 0;
+		list_for_each_entry(rentry, &resource_list, node) {
+			switch (resource_type(rentry->res)) {
+			case IORESOURCE_MEM:
+				if (!address_found) {
+					dev->res = *rentry->res;
+					address_found = true;
+				}
+				break;
+			case IORESOURCE_IRQ:
+				if (irq_no < AMBA_NR_IRQS)
+					dev->irq[irq_no++] = rentry->res->start;
+				break;
+			default:
+				dev_warn(&adev->dev, "Invalid resource\n");
+			}
+		}
+		acpi_dev_free_resource_list(&resource_list);
+	}
+
+	/*
+	 * If the ACPI node has a parent and that parent has a physical device
+	 * attached to it, that physical device should be the parent of the
+	 * platform device we are about to create.
+	 */
+	dev->dev.parent = NULL;
+	acpi_parent = adev->parent;
+	if (acpi_parent) {
+		struct acpi_device_physical_node *entry;
+		struct list_head *list;
+
+		mutex_lock(&acpi_parent->physical_node_lock);
+		list = &acpi_parent->physical_node_list;
+		if (!list_empty(list)) {
+			entry = list_first_entry(list,
+					struct acpi_device_physical_node,
+					node);
+			dev->dev.parent = entry->dev;
+		}
+		mutex_unlock(&acpi_parent->physical_node_lock);
+	}
+
+	dev_set_name(&dev->dev, "%s", dev_name(&adev->dev));
+	ACPI_COMPANION_SET(&dev->dev, adev);
+
+	ret = amba_device_add(dev, &iomem_resource);
+	if (ret) {
+		pr_err("%s(): amba_device_add() failed (%d) for %s\n",
+		       __func__, ret, dev_name(&adev->dev));
+		goto err_free;
+	}
+
+	return dev;
+
+err_free:
+	amba_device_put(dev);
+	return NULL;
+}
+#else
+struct amba_device *acpi_create_amba_device(struct acpi_device *adev)
+{
+	return NULL;
+}
+#endif /* CONFIG_ARM_AMBA */
+EXPORT_SYMBOL_GPL(acpi_create_amba_device);
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 84e7055..dc42ec0 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -457,6 +457,7 @@ int acpi_device_modalias(struct device *, char *, int);
 void acpi_walk_dep_device_list(acpi_handle handle);
 
 struct platform_device *acpi_create_platform_device(struct acpi_device *);
+struct amba_device *acpi_create_amba_device(struct acpi_device *);
 #define ACPI_PTR(_ptr)	(_ptr)
 
 #else	/* !CONFIG_ACPI */
-- 
2.4.3
