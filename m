From: Mars Cheng <mars.cheng-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v5 07/11] soc: mediatek: add MT6765 subdomain support
Date: Tue, 17 Jul 2018 16:52:28 +0800
Message-ID: <1531817552-17221-8-git-send-email-mars.cheng@mediatek.com>
References: <1531817552-17221-1-git-send-email-mars.cheng@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1531817552-17221-1-git-send-email-mars.cheng-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Ryder Lee <ryder.lee-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Stephen Boyd <sboyd-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sean Wang <sean.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, CC Hwang <cc.hwang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, wsd_upstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Loda Chou <loda.chou-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mars Cheng <mars.cheng-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Owen Chen <owen.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-serial@vger.kernel.org

add extend data, parent_n for domain-subdomain corresponse.

Signed-off-by: Mars Cheng <mars.cheng-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Signed-off-by: Owen Chen <owen.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
---
 drivers/soc/mediatek/mtk-scpsys-ext.c |  132 ++++++++++++++++++++++++++++++++-
 1 file changed, 131 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/mediatek/mtk-scpsys-ext.c b/drivers/soc/mediatek/mtk-scpsys-ext.c
index 965e64d..e649a06 100644
--- a/drivers/soc/mediatek/mtk-scpsys-ext.c
+++ b/drivers/soc/mediatek/mtk-scpsys-ext.c
@@ -13,7 +13,7 @@
 #include <linux/regmap.h>
 #include <linux/soc/mediatek/infracfg.h>
 #include <linux/soc/mediatek/scpsys-ext.h>
-
+#include <dt-bindings/power/mt6765-power.h>
 
 #define MAX_CLKS		10
 #define INFRA			"infracfg"
@@ -65,6 +65,21 @@ struct bus_mask_ops {
 			   u32 sta_ofs, u32 mask);
 };
 
+static struct scpsys_ext_attr *__get_attr_node(const char *scpd_n)
+{
+	struct scpsys_ext_attr *attr;
+
+	if (!scpd_n)
+		return ERR_PTR(-EINVAL);
+
+	list_for_each_entry(attr, &ext_attr_map_list, attr_list) {
+		if (attr->scpd_n && !strcmp(scpd_n, attr->scpd_n))
+			return attr;
+	}
+
+	return ERR_PTR(-EINVAL);
+}
+
 static struct scpsys_ext_attr *__get_attr_parent(const char *parent_n)
 {
 	struct scpsys_ext_attr *attr;
@@ -353,8 +368,123 @@ int scpsys_ext_attr_init(const struct scpsys_ext_data *data)
 	return 0;
 }
 
+/*
+ * MT6765 extend power domain support
+ */
+
+#define INFRA_TOPAXI_PROTECTEN_SET_MT6765	0x02A0
+#define INFRA_TOPAXI_PROTECTEN_STA1_MT6765	0x0228
+#define INFRA_TOPAXI_PROTECTEN_CLR_MT6765	0x02A4
+
+#define INFRA_TOPAXI_PROTECTEN_1_SET_MT6765	0x02A8
+#define INFRA_TOPAXI_PROTECTEN_STA1_1_MT6765	0x0258
+#define INFRA_TOPAXI_PROTECTEN_1_CLR_MT6765	0x02AC
+
+#define SMI_COMMON_SMI_CLAMP_MT6765		0x03C0
+#define SMI_COMMON_SMI_CLAMP_SET_MT6765	0x03C4
+#define SMI_COMMON_SMI_CLAMP_CLR_MT6765	0x03C8
+
+static struct ext_reg_ctrl infra_bus_regs_0_mt6765 = {
+	.type = IFR_TYPE,
+	.set_ofs = INFRA_TOPAXI_PROTECTEN_SET_MT6765,
+	.clr_ofs = INFRA_TOPAXI_PROTECTEN_CLR_MT6765,
+	.sta_ofs = INFRA_TOPAXI_PROTECTEN_STA1_MT6765,
+};
+
+#define BUS_IFR0_MT6765(_mask) {				\
+		.regs = &infra_bus_regs_0_mt6765,		\
+		.mask = _mask,				\
+		.ops = &bus_mask_set_clr_ctrl,		\
+	}
+
+static struct ext_reg_ctrl infra_bus_regs_1_mt6765 = {
+	.type = IFR_TYPE,
+	.set_ofs = INFRA_TOPAXI_PROTECTEN_1_SET_MT6765,
+	.clr_ofs = INFRA_TOPAXI_PROTECTEN_1_CLR_MT6765,
+	.sta_ofs = INFRA_TOPAXI_PROTECTEN_STA1_1_MT6765,
+};
+
+#define BUS_IFR1_MT6765(_mask) {				\
+		.regs = &infra_bus_regs_1_mt6765,		\
+		.mask = _mask,				\
+		.ops = &bus_mask_set_clr_ctrl,		\
+	}
+
+static struct ext_reg_ctrl smi_bus_regs_0_mt6765 = {
+	.type = SMI_TYPE,
+	.set_ofs = SMI_COMMON_SMI_CLAMP_SET_MT6765,
+	.clr_ofs = SMI_COMMON_SMI_CLAMP_CLR_MT6765,
+	.sta_ofs = SMI_COMMON_SMI_CLAMP_MT6765,
+};
+
+#define BUS_SMI0_MT6765(_mask) {				\
+		.regs = &smi_bus_regs_0_mt6765,		\
+		.mask = _mask,				\
+		.ops = &bus_mask_set_clr_ctrl,		\
+	}
+
+static struct scpsys_ext_attr scp_ext_attr_mt6765[] = {
+	[MT6765_POWER_DOMAIN_ISP] = {
+		.scpd_n = "isp",
+		.mask =  {
+			BUS_IFR1_MT6765(BIT(20)),
+			BUS_SMI0_MT6765(BIT(2)),
+		},
+		.parent_n = "mm",
+		.bus_ops = &ext_bus_ctrl,
+		.cg_ops = &ext_cg_ctrl,
+	},
+	[MT6765_POWER_DOMAIN_MM] = {
+		.scpd_n = "mm",
+		.mask = {
+			BUS_IFR1_MT6765(BIT(16) | BIT(17)),
+			BUS_IFR0_MT6765(BIT(10) | BIT(11)),
+			BUS_IFR0_MT6765(BIT(1) | BIT(2)),
+		},
+		.bus_ops = &ext_bus_ctrl,
+		.cg_ops = &ext_cg_ctrl,
+	},
+	[MT6765_POWER_DOMAIN_CONN] = {
+		.scpd_n = "conn",
+		.mask = {
+			BUS_IFR0_MT6765(BIT(13)),
+			BUS_IFR1_MT6765(BIT(18)),
+			BUS_IFR0_MT6765(BIT(14) | BIT(16)),
+		},
+		.bus_ops = &ext_bus_ctrl,
+	},
+	[MT6765_POWER_DOMAIN_MFG] = {
+		.scpd_n = "mfg",
+		.mask = {
+			BUS_IFR0_MT6765(BIT(25)),
+			BUS_IFR0_MT6765(BIT(21) | BIT(22)),
+		},
+		.bus_ops = &ext_bus_ctrl,
+	},
+	[MT6765_POWER_DOMAIN_CAM] = {
+		.scpd_n = "cam",
+		.mask = {
+			BUS_IFR1_MT6765(BIT(19) | BIT(21)),
+			BUS_IFR0_MT6765(BIT(20)),
+			BUS_SMI0_MT6765(BIT(3)),
+		},
+		.parent_n = "mm",
+		.bus_ops = &ext_bus_ctrl,
+		.cg_ops = &ext_cg_ctrl,
+	},
+};
+
+static const struct scpsys_ext_data scp_ext_data_mt6765 = {
+	.attr = scp_ext_attr_mt6765,
+	.num_attr = ARRAY_SIZE(scp_ext_attr_mt6765),
+	.get_attr = __get_attr_node,
+};
+
 static const struct of_device_id of_scpsys_ext_match_tbl[] = {
 	{
+		.compatible = "mediatek,mt6765-scpsys",
+		.data = &scp_ext_data_mt6765,
+	}, {
 		/* sentinel */
 	}
 };
-- 
1.7.9.5
