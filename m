From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v9 02/11] dmaengine: dw: provide probe(), remove() stubs for users
Date: Mon, 20 Jun 2016 12:17:53 +0300
Message-ID: <1466414282-96691-3-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1466414282-96691-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1466414282-96691-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bryan O'Donoghue <pure.logic@nexus-software.ie>, Peter Hurley <peter@hurleysoftware.com>, linux-serial@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, ismo.puustinen@intel.com, Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

Some users consider DMA optional, thus when driver is not compiled we shouldn't
prevent compilation of the users. Add stubs for dw_dma_probe() and
dw_dma_remove().

Acked-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/dma/dw.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/dma/dw.h b/include/linux/dma/dw.h
index f2e538a..ccfd0c3 100644
--- a/include/linux/dma/dw.h
+++ b/include/linux/dma/dw.h
@@ -40,8 +40,13 @@ struct dw_dma_chip {
 };
 
 /* Export to the platform drivers */
+#if IS_ENABLED(CONFIG_DW_DMAC_CORE)
 int dw_dma_probe(struct dw_dma_chip *chip);
 int dw_dma_remove(struct dw_dma_chip *chip);
+#else
+static inline int dw_dma_probe(struct dw_dma_chip *chip) { return -ENODEV; }
+static inline int dw_dma_remove(struct dw_dma_chip *chip) { return 0; }
+#endif /* CONFIG_DW_DMAC_CORE */
 
 /* DMA API extensions */
 struct dw_desc;
-- 
2.8.1
