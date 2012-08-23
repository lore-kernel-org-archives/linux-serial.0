From: Tony Prisk <linux-ci5G2KO2hbZ+pU9mqzGVBQ@public.gmane.org>
Subject: [PATCHv4 5/9] video: vt8500: Add devicetree support for vt8500-fb and
 wm8505-fb
Date: Thu, 23 Aug 2012 19:35:41 +1200
Message-ID: <1345707346-9035-6-git-send-email-linux@prisktech.co.nz>
References: <1345707346-9035-1-git-send-email-linux@prisktech.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1345707346-9035-1-git-send-email-linux-ci5G2KO2hbZ+pU9mqzGVBQ@public.gmane.org>
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
To: vt8500-wm8505-linux-kernel-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Cc: Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, Florian Tobias Schandinat <FlorianSchandinat-Mmb7MZpHnFY@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Mike Turquette <mturquette-l0cyMroinI0@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Update vt8500-fb, wm8505-fb and wmt-ge-rops to support device
tree bindings.
Small change in wm8505-fb.c to support WM8650 framebuffer color
format.

Signed-off-by: Tony Prisk <linux-ci5G2KO2hbZ+pU9mqzGVBQ@public.gmane.org>
---
 drivers/video/Kconfig       |    6 +--
 drivers/video/vt8500lcdfb.c |   79 ++++++++++++++++++++++++++++++-----
 drivers/video/wm8505fb.c    |   97 ++++++++++++++++++++++++++++++++++++-------
 drivers/video/wmt_ge_rops.c |    9 +++-
 4 files changed, 161 insertions(+), 30 deletions(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 0217f74..b66d951 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -1788,7 +1788,7 @@ config FB_AU1200
 
 config FB_VT8500
 	bool "VT8500 LCD Driver"
-	depends on (FB = y) && ARM && ARCH_VT8500 && VTWM_VERSION_VT8500
+	depends on (FB = y) && ARM && ARCH_VT8500
 	select FB_WMT_GE_ROPS
 	select FB_SYS_IMAGEBLIT
 	help
@@ -1797,11 +1797,11 @@ config FB_VT8500
 
 config FB_WM8505
 	bool "WM8505 frame buffer support"
-	depends on (FB = y) && ARM && ARCH_VT8500 && VTWM_VERSION_WM8505
+	depends on (FB = y) && ARM && ARCH_VT8500
 	select FB_WMT_GE_ROPS
 	select FB_SYS_IMAGEBLIT
 	help
-	  This is the framebuffer driver for WonderMedia WM8505
+	  This is the framebuffer driver for WonderMedia WM8505/WM8650
 	  integrated LCD controller.
 
 source "drivers/video/geode/Kconfig"
diff --git a/drivers/video/vt8500lcdfb.c b/drivers/video/vt8500lcdfb.c
index 2a5fe6e..758e359 100644
--- a/drivers/video/vt8500lcdfb.c
+++ b/drivers/video/vt8500lcdfb.c
@@ -35,6 +35,13 @@
 #include "vt8500lcdfb.h"
 #include "wmt_ge_rops.h"
 
+#ifdef CONFIG_OF
+#include <linux/of.h>
+#include <linux/of_fdt.h>
+#include <linux/memblock.h>
+#endif
+
+
 #define to_vt8500lcd_info(__info) container_of(__info, \
 						struct vt8500lcd_info, fb)
 
@@ -270,15 +277,21 @@ static int __devinit vt8500lcd_probe(struct platform_device *pdev)
 {
 	struct vt8500lcd_info *fbi;
 	struct resource *res;
-	struct vt8500fb_platform_data *pdata = pdev->dev.platform_data;
 	void *addr;
 	int irq, ret;
 
+	struct fb_videomode	of_mode;
+	struct device_node	*np;
+	u32			bpp;
+	dma_addr_t fb_mem_phys;
+	unsigned long fb_mem_len;
+	void *fb_mem_virt;
+
 	ret = -ENOMEM;
 	fbi = NULL;
 
-	fbi = kzalloc(sizeof(struct vt8500lcd_info) + sizeof(u32) * 16,
-							GFP_KERNEL);
+	fbi = devm_kzalloc(&pdev->dev, sizeof(struct vt8500lcd_info)
+			+ sizeof(u32) * 16, GFP_KERNEL);
 	if (!fbi) {
 		dev_err(&pdev->dev, "Failed to initialize framebuffer device\n");
 		ret = -ENOMEM;
@@ -333,9 +346,45 @@ static int __devinit vt8500lcd_probe(struct platform_device *pdev)
 		goto failed_free_res;
 	}
 
-	fbi->fb.fix.smem_start	= pdata->video_mem_phys;
-	fbi->fb.fix.smem_len	= pdata->video_mem_len;
-	fbi->fb.screen_base	= pdata->video_mem_virt;
+	np = of_parse_phandle(pdev->dev.of_node, "via,display", 0);
+	if (!np) {
+		pr_err("%s: No display description in Device Tree\n", __func__);
+		ret = -EINVAL;
+		goto failed_free_res;
+	}
+
+	/*
+	 * This code is copied from Sascha Hauer's of_videomode helper
+	 * and can be replaced with a call to the helper once mainlined
+	 */
+	ret = 0;
+	ret |= of_property_read_u32(np, "xres", &of_mode.xres);
+	ret |= of_property_read_u32(np, "yres", &of_mode.yres);
+	ret |= of_property_read_u32(np, "left-margin", &of_mode.left_margin);
+	ret |= of_property_read_u32(np, "right-margin", &of_mode.right_margin);
+	ret |= of_property_read_u32(np, "hsync-len", &of_mode.hsync_len);
+	ret |= of_property_read_u32(np, "upper-margin", &of_mode.upper_margin);
+	ret |= of_property_read_u32(np, "lower-margin", &of_mode.lower_margin);
+	ret |= of_property_read_u32(np, "vsync-len", &of_mode.vsync_len);
+	ret |= of_property_read_u32(np, "bpp", &bpp);
+	if (ret) {
+		pr_err("%s: Unable to read display properties\n", __func__);
+		goto failed_free_res;
+	}
+	of_mode.vmode = FB_VMODE_NONINTERLACED;
+
+	/* try allocating the framebuffer */
+	fb_mem_len = of_mode.xres * of_mode.yres * 2 * (bpp / 8);
+	fb_mem_virt = dma_alloc_coherent(&pdev->dev, fb_mem_len, &fb_mem_phys,
+				GFP_KERNEL);
+	if (!fb_mem_virt) {
+		pr_err("%s: Failed to allocate framebuffer\n", __func__);
+		return -ENOMEM;
+	};
+
+	fbi->fb.fix.smem_start	= fb_mem_phys;
+	fbi->fb.fix.smem_len	= fb_mem_len;
+	fbi->fb.screen_base	= fb_mem_virt;
 
 	fbi->palette_size	= PAGE_ALIGN(512);
 	fbi->palette_cpu	= dma_alloc_coherent(&pdev->dev,
@@ -370,10 +419,11 @@ static int __devinit vt8500lcd_probe(struct platform_device *pdev)
 		goto failed_free_irq;
 	}
 
-	fb_videomode_to_var(&fbi->fb.var, &pdata->mode);
-	fbi->fb.var.bits_per_pixel	= pdata->bpp;
-	fbi->fb.var.xres_virtual	= pdata->xres_virtual;
-	fbi->fb.var.yres_virtual	= pdata->yres_virtual;
+	fb_videomode_to_var(&fbi->fb.var, &of_mode);
+
+	fbi->fb.var.xres_virtual	= of_mode.xres;
+	fbi->fb.var.yres_virtual	= of_mode.yres * 2;
+	fbi->fb.var.bits_per_pixel	= bpp;
 
 	ret = vt8500lcd_set_par(&fbi->fb);
 	if (ret) {
@@ -448,12 +498,18 @@ static int __devexit vt8500lcd_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id via_dt_ids[] = {
+	{ .compatible = "via,vt8500-fb", },
+	{}
+};
+
 static struct platform_driver vt8500lcd_driver = {
 	.probe		= vt8500lcd_probe,
 	.remove		= __devexit_p(vt8500lcd_remove),
 	.driver		= {
 		.owner	= THIS_MODULE,
 		.name	= "vt8500-lcd",
+		.of_match_table = of_match_ptr(via_dt_ids),
 	},
 };
 
@@ -461,4 +517,5 @@ module_platform_driver(vt8500lcd_driver);
 
 MODULE_AUTHOR("Alexey Charkov <alchark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>");
 MODULE_DESCRIPTION("LCD controller driver for VIA VT8500");
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
+MODULE_DEVICE_TABLE(of, via_dt_ids);
diff --git a/drivers/video/wm8505fb.c b/drivers/video/wm8505fb.c
index c8703bd..d4448b0 100644
--- a/drivers/video/wm8505fb.c
+++ b/drivers/video/wm8505fb.c
@@ -28,6 +28,9 @@
 #include <linux/dma-mapping.h>
 #include <linux/platform_device.h>
 #include <linux/wait.h>
+#include <linux/of.h>
+#include <linux/of_fdt.h>
+#include <linux/memblock.h>
 
 #include <mach/vt8500fb.h>
 
@@ -59,8 +62,12 @@ static int wm8505fb_init_hw(struct fb_info *info)
 	writel(fbi->fb.fix.smem_start, fbi->regbase + WMT_GOVR_FBADDR);
 	writel(fbi->fb.fix.smem_start, fbi->regbase + WMT_GOVR_FBADDR1);
 
-	/* Set in-memory picture format to RGB 32bpp */
-	writel(0x1c,		       fbi->regbase + WMT_GOVR_COLORSPACE);
+	/*
+	 * Set in-memory picture format to RGB
+	 * 0x31C sets the correct color mode (RGB565) for WM8650
+	 * Bit 8+9 (0x300) are ignored on WM8505 as reserved
+	 */
+	writel(0x31c,		       fbi->regbase + WMT_GOVR_COLORSPACE);
 	writel(1,		       fbi->regbase + WMT_GOVR_COLORSPACE1);
 
 	/* Virtual buffer size */
@@ -127,6 +134,18 @@ static int wm8505fb_set_par(struct fb_info *info)
 		info->var.blue.msb_right = 0;
 		info->fix.visual = FB_VISUAL_TRUECOLOR;
 		info->fix.line_length = info->var.xres_virtual << 2;
+	} else if (info->var.bits_per_pixel == 16) {
+		info->var.red.offset = 11;
+		info->var.red.length = 5;
+		info->var.red.msb_right = 0;
+		info->var.green.offset = 5;
+		info->var.green.length = 6;
+		info->var.green.msb_right = 0;
+		info->var.blue.offset = 0;
+		info->var.blue.length = 5;
+		info->var.blue.msb_right = 0;
+		info->fix.visual = FB_VISUAL_TRUECOLOR;
+		info->fix.line_length = info->var.xres_virtual << 1;
 	}
 
 	wm8505fb_set_timing(info);
@@ -246,16 +265,20 @@ static int __devinit wm8505fb_probe(struct platform_device *pdev)
 	struct wm8505fb_info	*fbi;
 	struct resource		*res;
 	void			*addr;
-	struct vt8500fb_platform_data *pdata;
 	int ret;
 
-	pdata = pdev->dev.platform_data;
+	struct fb_videomode	of_mode;
+	struct device_node	*np;
+	u32			bpp;
+	dma_addr_t fb_mem_phys;
+	unsigned long fb_mem_len;
+	void *fb_mem_virt;
 
 	ret = -ENOMEM;
 	fbi = NULL;
 
-	fbi = kzalloc(sizeof(struct wm8505fb_info) + sizeof(u32) * 16,
-							GFP_KERNEL);
+	fbi = devm_kzalloc(&pdev->dev, sizeof(struct wm8505fb_info) +
+			sizeof(u32) * 16, GFP_KERNEL);
 	if (!fbi) {
 		dev_err(&pdev->dev, "Failed to initialize framebuffer device\n");
 		ret = -ENOMEM;
@@ -305,21 +328,58 @@ static int __devinit wm8505fb_probe(struct platform_device *pdev)
 		goto failed_free_res;
 	}
 
-	fb_videomode_to_var(&fbi->fb.var, &pdata->mode);
+	np = of_parse_phandle(pdev->dev.of_node, "via,display", 0);
+	if (!np) {
+		pr_err("%s: No display description in Device Tree\n", __func__);
+		ret = -EINVAL;
+		goto failed_free_res;
+	}
+
+	/*
+	 * This code is copied from Sascha Hauer's of_videomode helper
+	 * and can be replaced with a call to the helper once mainlined
+	 */
+	ret = 0;
+	ret |= of_property_read_u32(np, "xres", &of_mode.xres);
+	ret |= of_property_read_u32(np, "yres", &of_mode.yres);
+	ret |= of_property_read_u32(np, "left-margin", &of_mode.left_margin);
+	ret |= of_property_read_u32(np, "right-margin", &of_mode.right_margin);
+	ret |= of_property_read_u32(np, "hsync-len", &of_mode.hsync_len);
+	ret |= of_property_read_u32(np, "upper-margin", &of_mode.upper_margin);
+	ret |= of_property_read_u32(np, "lower-margin", &of_mode.lower_margin);
+	ret |= of_property_read_u32(np, "vsync-len", &of_mode.vsync_len);
+	ret |= of_property_read_u32(np, "bpp", &bpp);
+	if (ret) {
+		pr_err("%s: Unable to read display properties\n", __func__);
+		goto failed_free_res;
+	}
+
+	of_mode.vmode = FB_VMODE_NONINTERLACED;
+	fb_videomode_to_var(&fbi->fb.var, &of_mode);
 
 	fbi->fb.var.nonstd		= 0;
 	fbi->fb.var.activate		= FB_ACTIVATE_NOW;
 
 	fbi->fb.var.height		= -1;
 	fbi->fb.var.width		= -1;
-	fbi->fb.var.xres_virtual	= pdata->xres_virtual;
-	fbi->fb.var.yres_virtual	= pdata->yres_virtual;
-	fbi->fb.var.bits_per_pixel	= pdata->bpp;
 
-	fbi->fb.fix.smem_start	= pdata->video_mem_phys;
-	fbi->fb.fix.smem_len	= pdata->video_mem_len;
-	fbi->fb.screen_base	= pdata->video_mem_virt;
-	fbi->fb.screen_size	= pdata->video_mem_len;
+	/* try allocating the framebuffer */
+	fb_mem_len = of_mode.xres * of_mode.yres * 2 * (bpp / 8);
+	fb_mem_virt = dma_alloc_coherent(&pdev->dev, fb_mem_len, &fb_mem_phys,
+				GFP_KERNEL);
+	if (!fb_mem_virt) {
+		pr_err("%s: Failed to allocate framebuffer\n", __func__);
+		return -ENOMEM;
+	};
+
+	fbi->fb.var.xres_virtual	= of_mode.xres;
+	fbi->fb.var.yres_virtual	= of_mode.yres * 2;
+	fbi->fb.var.bits_per_pixel	= bpp;
+
+	fbi->fb.fix.smem_start		= fb_mem_phys;
+	fbi->fb.fix.smem_len		= fb_mem_len;
+	fbi->fb.screen_base		= fb_mem_virt;
+	fbi->fb.screen_size		= fb_mem_len;
 
 	if (fb_alloc_cmap(&fbi->fb.cmap, 256, 0) < 0) {
 		dev_err(&pdev->dev, "Failed to allocate color map\n");
@@ -395,12 +455,18 @@ static int __devexit wm8505fb_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id wmt_dt_ids[] = {
+	{ .compatible = "wm,wm8505-fb", },
+	{}
+};
+
 static struct platform_driver wm8505fb_driver = {
 	.probe		= wm8505fb_probe,
 	.remove		= __devexit_p(wm8505fb_remove),
 	.driver		= {
 		.owner	= THIS_MODULE,
 		.name	= DRIVER_NAME,
+		.of_match_table = of_match_ptr(wmt_dt_ids),
 	},
 };
 
@@ -408,4 +474,5 @@ module_platform_driver(wm8505fb_driver);
 
 MODULE_AUTHOR("Ed Spiridonov <edo.rus-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>");
 MODULE_DESCRIPTION("Framebuffer driver for WMT WM8505");
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
+MODULE_DEVICE_TABLE(of, wmt_dt_ids);
diff --git a/drivers/video/wmt_ge_rops.c b/drivers/video/wmt_ge_rops.c
index 55be386..ba025b4 100644
--- a/drivers/video/wmt_ge_rops.c
+++ b/drivers/video/wmt_ge_rops.c
@@ -158,12 +158,18 @@ static int __devexit wmt_ge_rops_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id wmt_dt_ids[] = {
+	{ .compatible = "wm,prizm-ge-rops", },
+	{ /* sentinel */ }
+};
+
 static struct platform_driver wmt_ge_rops_driver = {
 	.probe		= wmt_ge_rops_probe,
 	.remove		= __devexit_p(wmt_ge_rops_remove),
 	.driver		= {
 		.owner	= THIS_MODULE,
 		.name	= "wmt_ge_rops",
+		.of_match_table = of_match_ptr(wmt_dt_ids),
 	},
 };
 
@@ -172,4 +178,5 @@ module_platform_driver(wmt_ge_rops_driver);
 MODULE_AUTHOR("Alexey Charkov <alchark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org");
 MODULE_DESCRIPTION("Accelerators for raster operations using "
 		   "WonderMedia Graphics Engine");
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
+MODULE_DEVICE_TABLE(of, wmt_dt_ids);
-- 
1.7.9.5
