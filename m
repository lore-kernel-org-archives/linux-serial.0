From: kbuild test robot <fengguang.wu@intel.com>
Subject: [RFC PATCH] soc: mediatek: bus_ctrl_set_release() can be static
Date: Wed, 18 Jul 2018 02:19:29 +0800
Message-ID: <20180717181929.GA13851@lkp-hsx02>
References: <1531817552-17221-7-git-send-email-mars.cheng@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1531817552-17221-7-git-send-email-mars.cheng@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: kbuild-all@01.org, Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh+dt@kernel.org>, Marc Zyngier <marc.zyngier@arm.com>, Ryder Lee <ryder.lee@mediatek.com>, Stephen Boyd <sboyd@kernel.org>, Sean Wang <sean.wang@mediatek.com>, CC Hwang <cc.hwang@mediatek.com>, Loda Chou <loda.chou@mediatek.com>, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, wsd_upstream@mediatek.com, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, Owen Chen <owen.chen@mediatek.com>, Mars Cheng <mars.cheng@mediatek.com>
List-Id: linux-serial@vger.kernel.org


Fixes: 4666e05d0237 ("soc: mediatek: add new flow for mtcmos power.")
Signed-off-by: kbuild test robot <fengguang.wu@intel.com>
---
 mtk-scpsys-ext.c |   28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-scpsys-ext.c b/drivers/soc/mediatek/mtk-scpsys-ext.c
index 965e64d..e4ceb38 100644
--- a/drivers/soc/mediatek/mtk-scpsys-ext.c
+++ b/drivers/soc/mediatek/mtk-scpsys-ext.c
@@ -80,7 +80,7 @@ static struct scpsys_ext_attr *__get_attr_parent(const char *parent_n)
 	return ERR_PTR(-EINVAL);
 }
 
-int bus_ctrl_set_release(struct scpsys_ext_attr *attr, bool set)
+static int bus_ctrl_set_release(struct scpsys_ext_attr *attr, bool set)
 {
 	int i;
 	int ret = 0;
@@ -111,17 +111,17 @@ int bus_ctrl_set_release(struct scpsys_ext_attr *attr, bool set)
 	return ret;
 }
 
-int bus_ctrl_set(struct scpsys_ext_attr *attr)
+static int bus_ctrl_set(struct scpsys_ext_attr *attr)
 {
 	return bus_ctrl_set_release(attr, CMD_ENABLE);
 }
 
-int bus_ctrl_release(struct scpsys_ext_attr *attr)
+static int bus_ctrl_release(struct scpsys_ext_attr *attr)
 {
 	return bus_ctrl_set_release(attr, CMD_DISABLE);
 }
 
-int bus_clk_enable_disable(struct scpsys_ext_attr *attr, bool enable)
+static int bus_clk_enable_disable(struct scpsys_ext_attr *attr, bool enable)
 {
 	int i = 0;
 	int ret = 0;
@@ -158,7 +158,7 @@ int bus_clk_enable_disable(struct scpsys_ext_attr *attr, bool enable)
 	return ret;
 }
 
-int bus_clk_enable(struct scpsys_ext_attr *attr)
+static int bus_clk_enable(struct scpsys_ext_attr *attr)
 {
 	struct scpsys_ext_attr *attr_p;
 	int ret = 0;
@@ -189,17 +189,17 @@ int bus_clk_disable(struct scpsys_ext_attr *attr)
 	return ret;
 }
 
-const struct bus_mask_ops bus_mask_set_clr_ctrl = {
+static const struct bus_mask_ops bus_mask_set_clr_ctrl = {
 	.set = &mtk_generic_set_cmd,
 	.release = &mtk_generic_clr_cmd,
 };
 
-const struct bus_ext_ops ext_bus_ctrl = {
+static const struct bus_ext_ops ext_bus_ctrl = {
 	.enable = &bus_ctrl_set,
 	.disable = &bus_ctrl_release,
 };
 
-const struct bus_ext_ops ext_cg_ctrl = {
+static const struct bus_ext_ops ext_cg_ctrl = {
 	.enable = &bus_clk_enable,
 	.disable = &bus_clk_disable,
 };
@@ -207,9 +207,9 @@ const struct bus_ext_ops ext_cg_ctrl = {
 /*
  * scpsys bus driver init
  */
-struct regmap *syscon_regmap_lookup_by_phandle_idx(struct device_node *np,
-						   const char *property,
-						   int index)
+static struct regmap *syscon_regmap_lookup_by_phandle_idx(struct device_node *np,
+							  const char *property,
+							  int index)
 {
 	struct device_node *syscon_np;
 	struct regmap *regmap;
@@ -228,7 +228,7 @@ struct regmap *syscon_regmap_lookup_by_phandle_idx(struct device_node *np,
 	return regmap;
 }
 
-int scpsys_ext_regmap_init(struct platform_device *pdev)
+static int scpsys_ext_regmap_init(struct platform_device *pdev)
 {
 	infracfg = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
 						   INFRA);
@@ -321,7 +321,7 @@ static int add_cg_to_list(struct platform_device *pdev)
 	return 0;
 }
 
-int scpsys_ext_clk_init(struct platform_device *pdev)
+static int scpsys_ext_clk_init(struct platform_device *pdev)
 {
 	int ret = 0;
 
@@ -333,7 +333,7 @@ int scpsys_ext_clk_init(struct platform_device *pdev)
 	return ret;
 }
 
-int scpsys_ext_attr_init(const struct scpsys_ext_data *data)
+static int scpsys_ext_attr_init(const struct scpsys_ext_data *data)
 {
 	int i, count = 0;
 
