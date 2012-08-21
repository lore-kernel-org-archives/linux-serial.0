From: Tony Prisk <linux-ci5G2KO2hbZ+pU9mqzGVBQ@public.gmane.org>
Subject: [PATCHv3 4/9] usb: vt8500: Add devicetree support for vt8500-ehci and
 -uhci.
Date: Wed, 22 Aug 2012 08:47:33 +1200
Message-ID: <1345582058-2291-5-git-send-email-linux@prisktech.co.nz>
References: <1345582058-2291-1-git-send-email-linux@prisktech.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1345582058-2291-1-git-send-email-linux-ci5G2KO2hbZ+pU9mqzGVBQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: vt8500-wm8505-linux-kernel-/JYPxA39Uh6Zox4op4iWzw@public.gmane.org
Cc: Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, Florian Tobias Schandinat <FlorianSchandinat-Mmb7MZpHnFY@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Mike Turquette <mturquette-l0cyMroinI0@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Add devicetree support for vt8500-ehci.
Convert vt8500-uhci to a generic non-pci platform-uhci with
device tree support.

Signed-off-by: Tony Prisk <linux-ci5G2KO2hbZ+pU9mqzGVBQ@public.gmane.org>
---
 drivers/usb/host/Kconfig         |    4 +-
 drivers/usb/host/ehci-vt8500.c   |   25 ++++--
 drivers/usb/host/uhci-hcd.c      |    5 ++
 drivers/usb/host/uhci-platform.c |  169 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 195 insertions(+), 8 deletions(-)
 create mode 100644 drivers/usb/host/uhci-platform.c

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index dcfaaa9..d7a6b10 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -450,7 +450,7 @@ config USB_OHCI_LITTLE_ENDIAN
 
 config USB_UHCI_HCD
 	tristate "UHCI HCD (most Intel and VIA) support"
-	depends on USB && (PCI || SPARC_LEON)
+	depends on USB && (PCI || SPARC_LEON || ARCH_VT8500)
 	---help---
 	  The Universal Host Controller Interface is a standard by Intel for
 	  accessing the USB hardware in the PC (which is also called the USB
@@ -468,7 +468,7 @@ config USB_UHCI_HCD
 config USB_UHCI_SUPPORT_NON_PCI_HC
 	bool
 	depends on USB_UHCI_HCD
-	default y if SPARC_LEON
+	default y if (SPARC_LEON  || ARCH_VT8500)
 
 config USB_UHCI_BIG_ENDIAN_MMIO
 	bool
diff --git a/drivers/usb/host/ehci-vt8500.c b/drivers/usb/host/ehci-vt8500.c
index c1eda73..0e1637b 100644
--- a/drivers/usb/host/ehci-vt8500.c
+++ b/drivers/usb/host/ehci-vt8500.c
@@ -16,6 +16,7 @@
  *
  */
 
+#include <linux/of.h>
 #include <linux/platform_device.h>
 
 static int ehci_update_device(struct usb_hcd *hcd, struct usb_device *udev)
@@ -84,20 +85,23 @@ static const struct hc_driver vt8500_ehci_hc_driver = {
 	.clear_tt_buffer_complete	= ehci_clear_tt_buffer_complete,
 };
 
+static u64 wmt_ehci_dma_mask = DMA_BIT_MASK(32);
+
 static int vt8500_ehci_drv_probe(struct platform_device *pdev)
 {
 	struct usb_hcd *hcd;
 	struct ehci_hcd *ehci;
 	struct resource *res;
+	int irq;
 	int ret;
 
 	if (usb_disabled())
 		return -ENODEV;
 
-	if (pdev->resource[1].flags != IORESOURCE_IRQ) {
-		pr_debug("resource[1] is not IORESOURCE_IRQ");
-		return -ENOMEM;
-	}
+	/* devicetree created devices don't specify a dma mask */
+	if (!pdev->dev.dma_mask)
+		pdev->dev.dma_mask = &wmt_ehci_dma_mask;
+
 	hcd = usb_create_hcd(&vt8500_ehci_hc_driver, &pdev->dev, "VT8500");
 	if (!hcd)
 		return -ENOMEM;
@@ -134,8 +138,9 @@ static int vt8500_ehci_drv_probe(struct platform_device *pdev)
 
 	ehci_reset(ehci);
 
-	ret = usb_add_hcd(hcd, pdev->resource[1].start,
-			  IRQF_SHARED);
+	irq = platform_get_irq(pdev, 0);
+
+	ret = usb_add_hcd(hcd, irq, IRQF_SHARED);
 	if (ret == 0) {
 		platform_set_drvdata(pdev, hcd);
 		return ret;
@@ -162,6 +167,11 @@ static int vt8500_ehci_drv_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id vt8500_ehci_ids[] = {
+	{ .compatible = "via,vt8500-ehci", },
+	{}
+};
+
 static struct platform_driver vt8500_ehci_driver = {
 	.probe		= vt8500_ehci_drv_probe,
 	.remove		= vt8500_ehci_drv_remove,
@@ -169,7 +179,10 @@ static struct platform_driver vt8500_ehci_driver = {
 	.driver = {
 		.name	= "vt8500-ehci",
 		.owner	= THIS_MODULE,
+		.of_match_table = of_match_ptr(vt8500_ehci_ids),
 	}
 };
 
 MODULE_ALIAS("platform:vt8500-ehci");
+MODULE_LICENSE("GPL v2");
+MODULE_DEVICE_TABLE(of, vt8500_ehci_ids);
diff --git a/drivers/usb/host/uhci-hcd.c b/drivers/usb/host/uhci-hcd.c
index e4db350..5da5c99 100644
--- a/drivers/usb/host/uhci-hcd.c
+++ b/drivers/usb/host/uhci-hcd.c
@@ -846,6 +846,11 @@ static const char hcd_name[] = "uhci_hcd";
 #define PLATFORM_DRIVER		uhci_grlib_driver
 #endif
 
+#ifdef CONFIG_ARCH_VT8500
+#include "uhci-platform.c"
+#define PLATFORM_DRIVER		uhci_platform_driver
+#endif
+
 #if !defined(PCI_DRIVER) && !defined(PLATFORM_DRIVER)
 #error "missing bus glue for uhci-hcd"
 #endif
diff --git a/drivers/usb/host/uhci-platform.c b/drivers/usb/host/uhci-platform.c
new file mode 100644
index 0000000..35ca094
--- /dev/null
+++ b/drivers/usb/host/uhci-platform.c
@@ -0,0 +1,169 @@
+/*
+ * Generic UHCI HCD (Host Controller Driver) for Platform Devices
+ *
+ * Copyright (c) 2011 Tony Prisk <linux-ci5G2KO2hbZ+pU9mqzGVBQ@public.gmane.org>
+ *
+ * This file is based on uhci-grlib.c
+ * (C) Copyright 2004-2007 Alan Stern, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org
+ */
+
+#include <linux/of.h>
+#include <linux/platform_device.h>
+
+static int uhci_platform_init(struct usb_hcd *hcd)
+{
+	struct uhci_hcd *uhci = hcd_to_uhci(hcd);
+
+	uhci->rh_numports = uhci_count_ports(hcd);
+
+	/* Set up pointers to to generic functions */
+	uhci->reset_hc = uhci_generic_reset_hc;
+	uhci->check_and_reset_hc = uhci_generic_check_and_reset_hc;
+
+	/* No special actions need to be taken for the functions below */
+	uhci->configure_hc = NULL;
+	uhci->resume_detect_interrupts_are_broken = NULL;
+	uhci->global_suspend_mode_is_broken = NULL;
+
+	/* Reset if the controller isn't already safely quiescent. */
+	check_and_reset_hc(uhci);
+	return 0;
+}
+
+static const struct hc_driver uhci_platform_hc_driver = {
+	.description =          hcd_name,
+	.product_desc =         "Generic UHCI Host Controller",
+	.hcd_priv_size =        sizeof(struct uhci_hcd),
+
+	/* Generic hardware linkage */
+	.irq =                  uhci_irq,
+	.flags =                HCD_MEMORY | HCD_USB11,
+
+	/* Basic lifecycle operations */
+	.reset =                uhci_platform_init,
+	.start =                uhci_start,
+#ifdef CONFIG_PM
+	.pci_suspend =          NULL,
+	.pci_resume =           NULL,
+	.bus_suspend =          uhci_rh_suspend,
+	.bus_resume =           uhci_rh_resume,
+#endif
+	.stop =                 uhci_stop,
+
+	.urb_enqueue =          uhci_urb_enqueue,
+	.urb_dequeue =          uhci_urb_dequeue,
+
+	.endpoint_disable =     uhci_hcd_endpoint_disable,
+	.get_frame_number =     uhci_hcd_get_frame_number,
+
+	.hub_status_data =      uhci_hub_status_data,
+	.hub_control =          uhci_hub_control,
+};
+
+static u64 platform_uhci_dma_mask = DMA_BIT_MASK(32);
+
+static int __devinit uhci_hcd_platform_probe(struct platform_device *pdev)
+{
+	struct usb_hcd *hcd;
+	struct uhci_hcd *uhci;
+	struct resource *res;
+	int ret;
+
+	if (usb_disabled())
+		return -ENODEV;
+
+	/* Right now device-tree probed devices don't get dma_mask set.
+	 * Since shared usb code relies on it, set it here for now.
+	 * Once we have dma capability bindings this can go away.
+	 */
+	if (!pdev->dev.dma_mask)
+		pdev->dev.dma_mask = &platform_uhci_dma_mask;
+
+	hcd = usb_create_hcd(&uhci_platform_hc_driver, &pdev->dev,
+				pdev->name);
+	if (!hcd)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	hcd->rsrc_start = res->start;
+	hcd->rsrc_len = resource_size(res);
+
+	if (!request_mem_region(hcd->rsrc_start, hcd->rsrc_len, hcd_name)) {
+		pr_err("%s: request_mem_region failed\n", __func__);
+		ret = -EBUSY;
+		goto err_rmr;
+	}
+
+	hcd->regs = ioremap(hcd->rsrc_start, hcd->rsrc_len);
+	if (!hcd->regs) {
+		pr_err("%s: ioremap failed\n", __func__);
+		ret = -ENOMEM;
+		goto err_irq;
+	}
+	uhci = hcd_to_uhci(hcd);
+
+	uhci->regs = hcd->regs;
+
+	ret = usb_add_hcd(hcd, pdev->resource[1].start, IRQF_DISABLED |
+								IRQF_SHARED);
+	if (ret)
+		goto err_uhci;
+
+	return 0;
+
+err_uhci:
+	iounmap(hcd->regs);
+err_irq:
+	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
+err_rmr:
+	usb_put_hcd(hcd);
+
+	return ret;
+}
+
+static int uhci_hcd_platform_remove(struct platform_device *pdev)
+{
+	struct usb_hcd *hcd = platform_get_drvdata(pdev);
+
+	usb_remove_hcd(hcd);
+	iounmap(hcd->regs);
+	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
+	usb_put_hcd(hcd);
+	platform_set_drvdata(pdev, NULL);
+
+	return 0;
+}
+
+/* Make sure the controller is quiescent and that we're not using it
+ * any more.  This is mainly for the benefit of programs which, like kexec,
+ * expect the hardware to be idle: not doing DMA or generating IRQs.
+ *
+ * This routine may be called in a damaged or failing kernel.  Hence we
+ * do not acquire the spinlock before shutting down the controller.
+ */
+static void uhci_hcd_platform_shutdown(struct platform_device *op)
+{
+	struct usb_hcd *hcd = dev_get_drvdata(&op->dev);
+
+	uhci_hc_died(hcd_to_uhci(hcd));
+}
+
+static const struct of_device_id platform_uhci_ids[] = {
+	{ .compatible = "platform-uhci", },
+	{}
+};
+
+static struct platform_driver uhci_platform_driver = {
+	.probe          = uhci_hcd_platform_probe,
+	.remove         = uhci_hcd_platform_remove,
+	.shutdown       = uhci_hcd_platform_shutdown,
+	.driver = {
+		.name = "platform-uhci",
+		.owner = THIS_MODULE,
+		.of_match_table = of_match_ptr(platform_uhci_ids),
+	},
+};
+
+MODULE_ALIAS("platform:platform-uhci");
+MODULE_LICENSE("GPL v2");
+MODULE_DEVICE_TABLE(of, platform_uhci_ids);
-- 
1.7.9.5
