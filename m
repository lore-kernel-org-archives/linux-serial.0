From: Mans Rullgard <mans-2StjZFpD7GcAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 03/15] dmaengine: dw: rename masters to reflect actual topology
Date: Sun, 24 Jan 2016 19:21:50 +0000
Message-ID: <1453663322-14474-4-git-send-email-mans@mansr.com>
References: <1453663322-14474-1-git-send-email-mans@mansr.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1453663322-14474-1-git-send-email-mans-2StjZFpD7GcAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Viresh Kumar <vireshk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Haavard Skinnemoen <hskinnemoen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Hans-Christian Egtvedt <egtvedt-BrfabpQBY5qlHtIdYg32fQ@public.gmane.org>, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>, Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

The source and destination masters are reflecting buses or their layers to
where the different devices can be connected. The patch changes the master
names to reflect which one is related to which independently on the transfer
direction.

The outcome of the change is that the memory data width is now always limited
by a data width of the master which is dedicated to communicate to memory.

The patch will not break anything since all current users have the same data
width for all masters. Though it would be nice to revisit avr32 plaforms to
check what is the actual hardware topology is used there. It seems that it has
one bus and two masters on it as stated by Table 8-2, that's why everything
works independently on the master in use. The purpose of the sequential patch
is to fix the driver for configuration of more that one bus.

The change is done in the assumption that src_master and dst_master are
reflecting a connection to the memory and peripheral correspondently on all
platforms except 460ex.

Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Mans Rullgard <mans-2StjZFpD7GcAvxtiuMwx3w@public.gmane.org>
---
 Documentation/devicetree/bindings/dma/snps-dma.txt |  4 ++--
 arch/avr32/mach-at32ap/at32ap700x.c                | 16 ++++++++--------
 drivers/ata/sata_dwc_460ex.c                       |  4 ++--
 drivers/dma/dw/core.c                              | 15 +++++++--------
 drivers/dma/dw/platform.c                          | 12 ++++++------
 drivers/dma/dw/regs.h                              |  4 ++--
 drivers/spi/spi-pxa2xx-pci.c                       |  8 ++++----
 drivers/tty/serial/8250/8250_pci.c                 |  8 ++++----
 include/linux/platform_data/dma-dw.h               |  8 ++++----
 9 files changed, 39 insertions(+), 40 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/snps-dma.txt b/Documentation/devicetree/bindings/dma/snps-dma.txt
index c261598164a7..c99c1ffac199 100644
--- a/Documentation/devicetree/bindings/dma/snps-dma.txt
+++ b/Documentation/devicetree/bindings/dma/snps-dma.txt
@@ -47,8 +47,8 @@ The four cells in order are:
 
 1. A phandle pointing to the DMA controller
 2. The DMA request line number
-3. Source master for transfers on allocated channel
-4. Destination master for transfers on allocated channel
+3. Memory master for transfers on allocated channel
+4. Peripheral master for transfers on allocated channel
 
 Example:
 	
diff --git a/arch/avr32/mach-at32ap/at32ap700x.c b/arch/avr32/mach-at32ap/at32ap700x.c
index bf445aa48282..00d6dcc1d9b6 100644
--- a/arch/avr32/mach-at32ap/at32ap700x.c
+++ b/arch/avr32/mach-at32ap/at32ap700x.c
@@ -1365,8 +1365,8 @@ at32_add_device_mci(unsigned int id, struct mci_platform_data *data)
 	slave->dma_dev = &dw_dmac0_device.dev;
 	slave->src_id = 0;
 	slave->dst_id = 1;
-	slave->src_master = 1;
-	slave->dst_master = 0;
+	slave->m_master = 1;
+	slave->p_master = 0;
 
 	data->dma_slave = slave;
 	data->dma_filter = at32_mci_dma_filter;
@@ -2061,16 +2061,16 @@ at32_add_device_ac97c(unsigned int id, struct ac97c_platform_data *data,
 	if (flags & AC97C_CAPTURE) {
 		rx_dws->dma_dev = &dw_dmac0_device.dev;
 		rx_dws->src_id = 3;
-		rx_dws->src_master = 0;
-		rx_dws->dst_master = 1;
+		rx_dws->m_master = 0;
+		rx_dws->p_master = 1;
 	}
 
 	/* Check if DMA slave interface for playback should be configured. */
 	if (flags & AC97C_PLAYBACK) {
 		tx_dws->dma_dev = &dw_dmac0_device.dev;
 		tx_dws->dst_id = 4;
-		tx_dws->src_master = 0;
-		tx_dws->dst_master = 1;
+		tx_dws->m_master = 0;
+		tx_dws->p_master = 1;
 	}
 
 	if (platform_device_add_data(pdev, data,
@@ -2141,8 +2141,8 @@ at32_add_device_abdac(unsigned int id, struct atmel_abdac_pdata *data)
 
 	dws->dma_dev = &dw_dmac0_device.dev;
 	dws->dst_id = 2;
-	dws->src_master = 0;
-	dws->dst_master = 1;
+	dws->m_master = 0;
+	dws->p_master = 1;
 
 	if (platform_device_add_data(pdev, data,
 				sizeof(struct atmel_abdac_pdata)))
diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index 902034991517..80bdcabc293f 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -201,8 +201,8 @@ static struct sata_dwc_host_priv host_pvt;
 static struct dw_dma_slave sata_dwc_dma_dws = {
 	.src_id = 0,
 	.dst_id = 0,
-	.src_master = 0,
-	.dst_master = 1,
+	.m_master = 1,
+	.p_master = 0,
 };
 
 /*
diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
index 03ec88f1c161..8d1b87ff2ac6 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -50,8 +50,8 @@
 		 | DWC_CTLL_SRC_MSIZE(_smsize)			\
 		 | DWC_CTLL_LLP_D_EN				\
 		 | DWC_CTLL_LLP_S_EN				\
-		 | DWC_CTLL_DMS(_dwc->dst_master)		\
-		 | DWC_CTLL_SMS(_dwc->src_master));		\
+		 | DWC_CTLL_DMS(_dwc->p_master)			\
+		 | DWC_CTLL_SMS(_dwc->m_master));		\
 	})
 
 /*
@@ -722,8 +722,7 @@ dwc_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
 
 	dwc->direction = DMA_MEM_TO_MEM;
 
-	data_width = min_t(unsigned int, dw->data_width[dwc->src_master],
-			   dw->data_width[dwc->dst_master]);
+	data_width = dw->data_width[dwc->m_master];
 
 	src_width = dst_width = min_t(unsigned int, data_width,
 				      dwc_fast_ffs(src | dest | len));
@@ -815,7 +814,7 @@ dwc_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 		ctllo |= sconfig->device_fc ? DWC_CTLL_FC(DW_DMA_FC_P_M2P) :
 			DWC_CTLL_FC(DW_DMA_FC_D_M2P);
 
-		data_width = dw->data_width[dwc->src_master];
+		data_width = dw->data_width[dwc->m_master];
 
 		for_each_sg(sgl, sg, sg_len, i) {
 			struct dw_desc	*desc;
@@ -871,7 +870,7 @@ slave_sg_todev_fill_desc:
 		ctllo |= sconfig->device_fc ? DWC_CTLL_FC(DW_DMA_FC_P_P2M) :
 			DWC_CTLL_FC(DW_DMA_FC_D_P2M);
 
-		data_width = dw->data_width[dwc->dst_master];
+		data_width = dw->data_width[dwc->m_master];
 
 		for_each_sg(sgl, sg, sg_len, i) {
 			struct dw_desc	*desc;
@@ -949,8 +948,8 @@ bool dw_dma_filter(struct dma_chan *chan, void *param)
 	dwc->src_id = dws->src_id;
 	dwc->dst_id = dws->dst_id;
 
-	dwc->src_master = dws->src_master;
-	dwc->dst_master = dws->dst_master;
+	dwc->m_master = dws->m_master;
+	dwc->p_master = dws->p_master;
 
 	return true;
 }
diff --git a/drivers/dma/dw/platform.c b/drivers/dma/dw/platform.c
index 26edbe3a27ac..d3e1abcebd7f 100644
--- a/drivers/dma/dw/platform.c
+++ b/drivers/dma/dw/platform.c
@@ -42,13 +42,13 @@ static struct dma_chan *dw_dma_of_xlate(struct of_phandle_args *dma_spec,
 
 	slave.src_id = dma_spec->args[0];
 	slave.dst_id = dma_spec->args[0];
-	slave.src_master = dma_spec->args[1];
-	slave.dst_master = dma_spec->args[2];
+	slave.m_master = dma_spec->args[1];
+	slave.p_master = dma_spec->args[2];
 
 	if (WARN_ON(slave.src_id >= DW_DMA_MAX_NR_REQUESTS ||
 		    slave.dst_id >= DW_DMA_MAX_NR_REQUESTS ||
-		    slave.src_master >= dw->nr_masters ||
-		    slave.dst_master >= dw->nr_masters))
+		    slave.m_master >= dw->nr_masters ||
+		    slave.p_master >= dw->nr_masters))
 		return NULL;
 
 	dma_cap_zero(cap);
@@ -66,8 +66,8 @@ static bool dw_dma_acpi_filter(struct dma_chan *chan, void *param)
 		.dma_dev = dma_spec->dev,
 		.src_id = dma_spec->slave_id,
 		.dst_id = dma_spec->slave_id,
-		.src_master = 1,
-		.dst_master = 0,
+		.m_master = 1,
+		.p_master = 0,
 	};
 
 	return dw_dma_filter(chan, &slave);
diff --git a/drivers/dma/dw/regs.h b/drivers/dma/dw/regs.h
index afd340958266..0391f8ff6919 100644
--- a/drivers/dma/dw/regs.h
+++ b/drivers/dma/dw/regs.h
@@ -249,8 +249,8 @@ struct dw_dma_chan {
 	/* custom slave configuration */
 	u8			src_id;
 	u8			dst_id;
-	u8			src_master;
-	u8			dst_master;
+	u8			m_master;
+	u8			p_master;
 
 	/* configuration passed via .device_config */
 	struct dma_slave_config dma_sconfig;
diff --git a/drivers/spi/spi-pxa2xx-pci.c b/drivers/spi/spi-pxa2xx-pci.c
index d19d7f28aecb..01ccc7448313 100644
--- a/drivers/spi/spi-pxa2xx-pci.c
+++ b/drivers/spi/spi-pxa2xx-pci.c
@@ -132,16 +132,16 @@ static int pxa2xx_spi_pci_probe(struct pci_dev *dev,
 		struct dw_dma_slave *slave = c->tx_param;
 
 		slave->dma_dev = &dma_dev->dev;
-		slave->src_master = 1;
-		slave->dst_master = 0;
+		slave->m_master = 1;
+		slave->p_master = 0;
 	}
 
 	if (c->rx_param) {
 		struct dw_dma_slave *slave = c->rx_param;
 
 		slave->dma_dev = &dma_dev->dev;
-		slave->src_master = 1;
-		slave->dst_master = 0;
+		slave->m_master = 1;
+		slave->p_master = 0;
 	}
 
 	spi_pdata.dma_filter = lpss_dma_filter;
diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 4097f3f65b3b..aa1b5cc7e158 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -1473,13 +1473,13 @@ byt_serial_setup(struct serial_private *priv,
 		return -EINVAL;
 	}
 
-	rx_param->src_master = 1;
-	rx_param->dst_master = 0;
+	rx_param->m_master = 1;
+	rx_param->p_master = 0;
 
 	dma->rxconf.src_maxburst = 16;
 
-	tx_param->src_master = 1;
-	tx_param->dst_master = 0;
+	tx_param->m_master = 1;
+	tx_param->p_master = 0;
 
 	dma->txconf.dst_maxburst = 16;
 
diff --git a/include/linux/platform_data/dma-dw.h b/include/linux/platform_data/dma-dw.h
index 03b6095d3b18..b881b978e486 100644
--- a/include/linux/platform_data/dma-dw.h
+++ b/include/linux/platform_data/dma-dw.h
@@ -21,15 +21,15 @@
  * @dma_dev:	required DMA master device
  * @src_id:	src request line
  * @dst_id:	dst request line
- * @src_master: src master for transfers on allocated channel.
- * @dst_master: dest master for transfers on allocated channel.
+ * @m_master:	memory master for transfers on allocated channel
+ * @p_master:	peripheral master for transfers on allocated channel
  */
 struct dw_dma_slave {
 	struct device		*dma_dev;
 	u8			src_id;
 	u8			dst_id;
-	u8			src_master;
-	u8			dst_master;
+	u8			m_master;
+	u8			p_master;
 };
 
 /**
-- 
2.7.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
