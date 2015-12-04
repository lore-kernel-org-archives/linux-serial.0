From: Wang Hongcheng <annie.wang@amd.com>
Subject: [PATCH 9/9] iommu/amd: Add ACPI HID named devices IOMMU driver support
Date: Fri, 4 Dec 2015 11:24:26 +0800
Message-ID: <1449199466-6081-10-git-send-email-annie.wang@amd.com>
References: <1449199466-6081-1-git-send-email-annie.wang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1449199466-6081-1-git-send-email-annie.wang@amd.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, dmaengine@vger.kernel.org, iommu@lists.linux-foundation.org, Borislav Petkov <bp@alien8.de>, Huang Rui <ray.huang@amd.com>, Wan Zongshun <vincent.wan@amd.com>, Ken Xue <ken.xue@amd.com>, Tony Li <tony.li@amd.com>, Wan Zongshun <Vincent.Wan@amd.com>
List-Id: linux-serial@vger.kernel.org

From: Wan Zongshun <Vincent.Wan@amd.com>

AMD UART is a ACPI HID named device, it also is none-pci device,
currently, iommu driver only supports pci device, so UART DMA did
not work at current AMD IOMMU driver.

AMD reused 8250 serial driver and ARM PL330 DMA engine driver,
since AMD uart and dma ips are compatible with 8250 and pl330.

When those non-pci functions do DMA, they still generate some
sort of fake PCI like BDF(bus:dev:fun) id with the request to
work properly with IOMMU.

According to above descriptions, this patch was designed:

1. Add ivrs_acpihid kernel boot parameter interface, map HID:UID
to BDF id, those ids were hardcoded by AMD.
2. We never create new group for none-pci device, just adhere them
to existing group that has same bus and device id.
3. Add amd iommu callbacks for amba type bus, since pl330 driver
transferred amba_device->dev into dma_map_single.

Signed-off-by: Wan Zongshun <Vincent.Wan@amd.com>
---
 drivers/iommu/amd_iommu.c       | 165 +++++++++++++++++++++++++++++++++++-----
 drivers/iommu/amd_iommu_init.c  | 123 +++++++++++++++++++++++++++++-
 drivers/iommu/amd_iommu_types.h |  11 +++
 3 files changed, 279 insertions(+), 20 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 8b2be1e..13581c0 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -35,6 +35,7 @@
 #include <linux/msi.h>
 #include <linux/dma-contiguous.h>
 #include <linux/irqdomain.h>
+#include <linux/acpi.h>
 #include <asm/irq_remapping.h>
 #include <asm/io_apic.h>
 #include <asm/apic.h>
@@ -71,6 +72,7 @@ static DEFINE_SPINLOCK(dev_data_list_lock);
 
 LIST_HEAD(ioapic_map);
 LIST_HEAD(hpet_map);
+LIST_HEAD(acpihid_map);
 
 /*
  * Domain for untranslated devices - only allocated
@@ -174,13 +176,71 @@ static struct iommu_dev_data *find_dev_data(u16 devid)
 	return dev_data;
 }
 
-static inline u16 get_device_id(struct device *dev)
+static inline int match_hid_uid(struct device *dev,
+					struct acpihid_map *entry)
+{
+	const u8 *hid, *uid;
+
+	hid = acpi_device_hid(ACPI_COMPANION(dev));
+	uid = acpi_device_uid(ACPI_COMPANION(dev));
+
+	if (!strcmp(hid, entry->hid) && !strcmp(uid, entry->uid))
+		return 0;
+
+	return -ENODEV;
+}
+
+static inline u16 get_pci_device_id(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 
 	return PCI_DEVID(pdev->bus->number, pdev->devfn);
 }
 
+static inline int get_acpihid_device_id(struct device *dev)
+{
+	struct acpihid_map *entry;
+
+	list_for_each_entry(entry, &acpihid_map, list) {
+		if (!match_hid_uid(dev, entry))
+			return entry->devid;
+	}
+	return -EINVAL;
+}
+
+static inline u16 get_device_id(struct device *dev)
+{
+	if (dev_is_pci(dev))
+		return get_pci_device_id(dev);
+	else
+		return get_acpihid_device_id(dev);
+}
+
+static void find_acpihid_group_by_rootid(struct device *dev,
+					struct iommu_group *group)
+{
+	struct acpihid_map *entry;
+
+	list_for_each_entry(entry, &acpihid_map, list) {
+		if (entry->group)
+			continue;
+		if (entry->root_devid == get_device_id(dev))
+			entry->group = group;
+	}
+}
+
+static struct iommu_group *find_acpihid_group_by_devid(struct device *dev)
+{
+	struct acpihid_map *entry;
+
+	list_for_each_entry(entry, &acpihid_map, list) {
+		if (!match_hid_uid(dev, entry))
+			return entry->group;
+	}
+
+	return NULL;
+}
+
 static struct iommu_dev_data *get_dev_data(struct device *dev)
 {
 	return dev->archdata.iommu;
@@ -260,7 +320,7 @@ static bool check_device(struct device *dev)
 		return false;
 
 	/* No PCI device */
-	if (!dev_is_pci(dev))
+	if (!dev_is_pci(dev) && (get_acpihid_device_id(dev) < 0))
 		return false;
 
 	devid = get_device_id(dev);
@@ -285,6 +345,8 @@ static void init_iommu_group(struct device *dev)
 	if (IS_ERR(group))
 		return;
 
+	find_acpihid_group_by_rootid(dev, group);
+
 	domain = iommu_group_default_domain(group);
 	if (!domain)
 		goto out;
@@ -2071,29 +2133,33 @@ static bool pci_pri_tlp_required(struct pci_dev *pdev)
 static int attach_device(struct device *dev,
 			 struct protection_domain *domain)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
 	struct iommu_dev_data *dev_data;
 	unsigned long flags;
 	int ret;
 
 	dev_data = get_dev_data(dev);
 
-	if (domain->flags & PD_IOMMUV2_MASK) {
-		if (!dev_data->passthrough)
-			return -EINVAL;
+	if (dev_is_pci(dev)) {
+
+		struct pci_dev *pdev = to_pci_dev(dev);
 
-		if (dev_data->iommu_v2) {
-			if (pdev_iommuv2_enable(pdev) != 0)
+		if (domain->flags & PD_IOMMUV2_MASK) {
+			if (!dev_data->passthrough)
 				return -EINVAL;
 
+			if (dev_data->iommu_v2) {
+				if (pdev_iommuv2_enable(pdev) != 0)
+					return -EINVAL;
+
+				dev_data->ats.enabled = true;
+				dev_data->ats.qdep    = pci_ats_queue_depth(pdev);
+				dev_data->pri_tlp     = pci_pri_tlp_required(pdev);
+			}
+		} else if (amd_iommu_iotlb_sup &&
+			   pci_enable_ats(pdev, PAGE_SHIFT) == 0) {
 			dev_data->ats.enabled = true;
 			dev_data->ats.qdep    = pci_ats_queue_depth(pdev);
-			dev_data->pri_tlp     = pci_pri_tlp_required(pdev);
 		}
-	} else if (amd_iommu_iotlb_sup &&
-		   pci_enable_ats(pdev, PAGE_SHIFT) == 0) {
-		dev_data->ats.enabled = true;
-		dev_data->ats.qdep    = pci_ats_queue_depth(pdev);
 	}
 
 	write_lock_irqsave(&amd_iommu_devtable_lock, flags);
@@ -2152,14 +2218,58 @@ static void detach_device(struct device *dev)
 	__detach_device(dev_data);
 	write_unlock_irqrestore(&amd_iommu_devtable_lock, flags);
 
-	if (domain->flags & PD_IOMMUV2_MASK && dev_data->iommu_v2)
-		pdev_iommuv2_disable(to_pci_dev(dev));
-	else if (dev_data->ats.enabled)
-		pci_disable_ats(to_pci_dev(dev));
+	if (dev_is_pci(dev)) {
+
+		if (domain->flags & PD_IOMMUV2_MASK && dev_data->iommu_v2)
+			pdev_iommuv2_disable(to_pci_dev(dev));
+		else if (dev_data->ats.enabled)
+			pci_disable_ats(to_pci_dev(dev));
+	}
 
 	dev_data->ats.enabled = false;
 }
 
+static int init_acpihid_device_group(struct device *dev)
+{
+	struct dma_ops_domain *dma_domain;
+	struct iommu_dev_data *dev_data;
+	struct iommu_domain *domain;
+	struct iommu_group *group;
+	int ret;
+
+	if (dev->archdata.iommu)
+		return 0;
+
+	dev_data = find_dev_data(get_device_id(dev));
+	if (!dev_data)
+		return -ENOMEM;
+
+	dev->archdata.iommu = dev_data;
+
+	group = find_acpihid_group_by_devid(dev);
+	if (!group)
+		return -ENXIO;
+
+	ret = iommu_group_add_device(group, dev);
+	if (ret)
+		return ret;
+
+	domain = iommu_group_default_domain(group);
+	if (!domain)
+		return -ENXIO;
+
+	dma_domain = to_pdomain(domain)->priv;
+
+	init_unity_mappings_for_device(dev, dma_domain);
+
+	if (domain->type == IOMMU_DOMAIN_IDENTITY)
+		dev_data->passthrough = true;
+	else
+		dev->archdata.dma_ops = &amd_iommu_dma_ops;
+
+	return 0;
+}
+
 static int amd_iommu_add_device(struct device *dev)
 {
 	struct iommu_dev_data *dev_data;
@@ -2174,6 +2284,15 @@ static int amd_iommu_add_device(struct device *dev)
 	devid = get_device_id(dev);
 	iommu = amd_iommu_rlookup_table[devid];
 
+	if (!dev_is_pci(dev)) {
+		ret = init_acpihid_device_group(dev);
+		if (ret) {
+			iommu_ignore_device(dev);
+			dev->archdata.dma_ops = &nommu_dma_ops;
+			goto out;
+		}
+	}
+
 	ret = iommu_init_device(dev);
 	if (ret) {
 		if (ret != -ENOTSUPP)
@@ -2758,7 +2877,17 @@ static struct dma_map_ops amd_iommu_dma_ops = {
 
 int __init amd_iommu_init_api(void)
 {
-	return bus_set_iommu(&pci_bus_type, &amd_iommu_ops);
+	int err;
+
+	err = bus_set_iommu(&pci_bus_type, &amd_iommu_ops);
+	if (err)
+		return err;
+#ifdef CONFIG_ARM_AMBA
+	err = bus_set_iommu(&amba_bustype, &amd_iommu_ops);
+	if (err)
+		return err;
+#endif
+	return 0;
 }
 
 int __init amd_iommu_init_dma_ops(void)
diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 013bdff..058cf5b 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -58,6 +58,7 @@
 #define IVHD_DEV_EXT_SELECT             0x46
 #define IVHD_DEV_EXT_SELECT_RANGE       0x47
 #define IVHD_DEV_SPECIAL		0x48
+#define IVHD_DEV_ACPI_HID		0xf0
 
 #define IVHD_SPECIAL_IOAPIC		1
 #define IVHD_SPECIAL_HPET		2
@@ -111,6 +112,11 @@ struct ivhd_entry {
 	u16 devid;
 	u8 flags;
 	u32 ext;
+	u32 hidh;
+	u64 cid;
+	u8 uidf;
+	u8 uidl;
+	u8 uid;
 } __attribute__((packed));
 
 /*
@@ -218,8 +224,12 @@ enum iommu_init_state {
 #define EARLY_MAP_SIZE		4
 static struct devid_map __initdata early_ioapic_map[EARLY_MAP_SIZE];
 static struct devid_map __initdata early_hpet_map[EARLY_MAP_SIZE];
+static struct acpihid_map __initdata early_acpihid_map[EARLY_MAP_SIZE];
+
 static int __initdata early_ioapic_map_size;
 static int __initdata early_hpet_map_size;
+static int __initdata early_acpihid_map_size;
+
 static bool __initdata cmdline_maps;
 
 static enum iommu_init_state init_state = IOMMU_START_STATE;
@@ -720,6 +730,45 @@ static int __init add_special_device(u8 type, u8 id, u16 *devid, bool cmd_line)
 	return 0;
 }
 
+static int __init add_acpi_hid_device(u8 *hid,
+			u8 *uid, u16 *devid, bool cmd_line)
+{
+	struct acpihid_map *entry;
+	struct list_head *list;
+
+	list = &acpihid_map;
+
+	list_for_each_entry(entry, list, list) {
+		if (!(!strcmp(entry->hid, hid) && !strcmp(entry->uid, uid)
+							&& entry->cmd_line))
+			continue;
+
+		pr_info("AMD-Vi: Command-line override present for hid:%s uid:%s - ignoring\n", hid, uid);
+
+		*devid = entry->devid;
+
+		return 0;
+	}
+
+	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
+	if (!entry)
+		return -ENOMEM;
+
+	memcpy(entry->uid, uid, 2);
+	memcpy(entry->hid, hid, 9);
+
+	entry->devid	= *devid;
+	entry->cmd_line	= cmd_line;
+	entry->root_devid = (entry->devid & (~0x7));
+
+	pr_info("AMD-Vi:Command-line, add hid:%s,uid: %s, root_devid:%d\n",
+				entry->hid, entry->uid, entry->root_devid);
+
+	list_add_tail(&entry->list, list);
+
+	return 0;
+}
+
 static int __init add_early_maps(void)
 {
 	int i, ret;
@@ -742,6 +791,15 @@ static int __init add_early_maps(void)
 			return ret;
 	}
 
+	for (i = 0; i < early_acpihid_map_size; ++i) {
+		ret = add_acpi_hid_device(early_acpihid_map[i].hid,
+					 early_acpihid_map[i].uid,
+					 &early_acpihid_map[i].devid,
+					 early_acpihid_map[i].cmd_line);
+		if (ret)
+			return ret;
+	}
+
 	return 0;
 }
 
@@ -783,7 +841,6 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 	struct ivhd_entry *e;
 	int ret;
 
-
 	ret = add_early_maps();
 	if (ret)
 		return ret;
@@ -799,7 +856,6 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 	p += sizeof(struct ivhd_header);
 	end += h->length;
 
-
 	while (p < end) {
 		e = (struct ivhd_entry *)p;
 		switch (e->type) {
@@ -954,6 +1010,40 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 
 			break;
 		}
+		case IVHD_DEV_ACPI_HID: {
+			u16 devid;
+			u8 hid[9];
+			u8 uid[2];
+			int ret;
+
+			devid  = e->devid;
+			flags = e->flags;
+
+			memcpy(hid, (u8 *)(&e->ext), 8);
+			hid[8] = '\0';
+
+			memcpy(uid, (u8 *)(&e->uid), 1);
+			uid[1] = '\0';
+
+			DUMP_printk("  DEV_ACPI_HID(%s[%s])\t\tdevid: %02x:%02x.%x\n",
+				    hid, uid,
+				    PCI_BUS_NUM(devid),
+				    PCI_SLOT(devid),
+				    PCI_FUNC(devid));
+
+			ret = add_acpi_hid_device(hid, uid, &devid, false);
+			if (ret)
+				return ret;
+
+			/*
+			 * add_special_device might update the devid in case a
+			 * command-line override is present. So call
+			 * set_dev_entry_from_acpi after add_special_device.
+			 */
+			set_dev_entry_from_acpi(iommu, devid, e->flags, 0);
+
+			break;
+		}
 		default:
 			break;
 		}
@@ -2226,10 +2316,39 @@ static int __init parse_ivrs_hpet(char *str)
 	return 1;
 }
 
+static int __init parse_ivrs_acpihid(char *str)
+{
+	u32 bus, dev, fn;
+	char *hid, *uid, *p;
+	char acpiid[11] = {0};
+	int ret, i;
+
+	ret = sscanf(str, "[%x:%x.%x]=%s", &bus, &dev, &fn, acpiid);
+	if (ret != 4) {
+		pr_err("AMD-Vi: Invalid command line: ivrs_acpihid(%s)\n", str);
+		return 1;
+	}
+
+	p = acpiid;
+	hid = strsep(&p, ":");
+	uid = p;
+
+	i = early_acpihid_map_size++;
+	memcpy(early_acpihid_map[i].hid, hid, strlen(hid));
+	memcpy(early_acpihid_map[i].uid, uid, strlen(uid));
+
+	early_acpihid_map[i].devid =
+		((bus & 0xff) << 8) | ((dev & 0x1f) << 3) | (fn & 0x7);
+	early_acpihid_map[i].cmd_line	= true;
+
+	return 1;
+}
+
 __setup("amd_iommu_dump",	parse_amd_iommu_dump);
 __setup("amd_iommu=",		parse_amd_iommu_options);
 __setup("ivrs_ioapic",		parse_ivrs_ioapic);
 __setup("ivrs_hpet",		parse_ivrs_hpet);
+__setup("ivrs_acpihid",		parse_ivrs_acpihid);
 
 IOMMU_INIT_FINISH(amd_iommu_detect,
 		  gart_iommu_hole_init,
diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
index b08cf57..6770218 100644
--- a/drivers/iommu/amd_iommu_types.h
+++ b/drivers/iommu/amd_iommu_types.h
@@ -567,6 +567,16 @@ struct amd_iommu {
 #endif
 };
 
+struct acpihid_map {
+	struct list_head list;
+	u8 uid[2];
+	u8 hid[9];
+	u16 devid;
+	u16 root_devid;
+	bool cmd_line;
+	struct iommu_group *group;
+};
+
 struct devid_map {
 	struct list_head list;
 	u8 id;
@@ -577,6 +587,7 @@ struct devid_map {
 /* Map HPET and IOAPIC ids to the devid used by the IOMMU */
 extern struct list_head ioapic_map;
 extern struct list_head hpet_map;
+extern struct list_head acpihid_map;
 
 /*
  * List with all IOMMUs in the system. This list is not locked because it is
-- 
1.9.1

