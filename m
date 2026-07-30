Received: from mx0b-00622301.pphosted.com (mx0b-00622301.pphosted.com [205.220.175.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F83D40B106;
	Thu, 30 Jul 2026 11:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.175.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785409599; cv=none; b=OtDWxlxlPPrR22NDRsfTI3wd3Vju+op8VoeeSrfjAdc1B6P8byD8Q3TssNy3WuYh7QagCqp+WbS7RJIRVsC73JfRezpJLbxm/avbqW+eSOanRk5RnPAbQyKvap9nuFQUBkXoB5toITgoeO8AmPHwj9NhKtm/IEzvZosr7dxz/j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785409599; c=relaxed/simple;
	bh=bUofClu1/zGtirj8pRqn6zQv+Ydp5qFnEVY6+nQ5iNg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZPq5idUTgo8eF8h5j3go0H+jFxxCUGXEKxA4xFlZgGQny/GXAfbPNpttzK1eL+8eIM9wru4dD+hUNA1fjIJSA1vv7u2SFEfHWo9HDrHJDTGnafWTgTntDYmRxdsqcNPDWcgEMB3wHqoaSqp+XuhJbhh+NXda4n6aYugx28Qsz04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ambarella.com; spf=pass smtp.mailfrom=ambarella.com; dkim=pass (2048-bit key) header.d=ambarella.com header.i=@ambarella.com header.b=OebNI5VR; arc=none smtp.client-ip=205.220.175.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ambarella.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ambarella.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ambarella.com header.i=@ambarella.com header.b="OebNI5VR"
Received: from pps.filterd (m0241925.ppops.net [127.0.0.1])
	by mx0a-00622301.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UA6Egm3332841;
	Thu, 30 Jul 2026 10:43:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ambarella.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	com20210415pp; bh=YvuFtUHRJ622fTQw6EE1ghwsynYcwiJGjeuiRoRxumM=; b=
	OebNI5VRxOmyVPW1SGzRmGi7YC05G6RwIZBMaQlwgVI1cjqB+qFaXoCj/TXAR8wK
	0+wheBf7/dDfrYyq+91zTyKcCz0AxXk9HAl/OWRVzhNmPFyy61HcuPgpwqMr78TV
	mcB+VAzg4ly8ZbOiiNFf+qKFgiDQEpUB7jfpwgwjyis5l80kor3aXk9TfUQMM9NO
	ilOlzdZByY94CbE4Lw0CHmIOVOiBxJeooCSmJ1Sj0tIDLIT9iM8F/c/VAtSCkCbw
	36hMDnw0WOq1EVRBsn1QKuUygamL8pboje/5t7C4p7K7/3QBB63qLNOGlfjz1xoW
	5eAjQUJkjXfMhyvQWah29w==
Received: from webmail.ambarella.com ([12.30.244.130])
	by mx0a-00622301.pphosted.com (PPS) with ESMTPS id 4fq8twhnbd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 10:43:50 +0000 (GMT)
Received: from ambtw-cas2.ambarella.net (10.2.4.227) by
 ambus-ex-se2.ambarella.net (10.1.4.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 30 Jul 2026 03:43:49 -0700
Received: from ambtw-cas3.ambarella.net (10.2.4.228) by
 ambtw-cas2.ambarella.net (10.2.4.227) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.58; Thu, 30 Jul 2026 18:43:47 +0800
Received: from shbuild7.ambarella.net (10.4.8.70) by ambtw-cas3.ambarella.net
 (10.2.4.228) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Thu, 30 Jul 2026 18:43:46 +0800
From: Long Zhao <longzhao@ambarella.com>
To: Arnd Bergmann <arnd@arndb.de>,
        Alexandre Belloni
	<alexandre.belloni@bootlin.com>,
        <linux-arm-kernel@lists.infradead.org>, <soc@lists.linux.dev>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
        "Michael
 Turquette" <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, <linux-clk@vger.kernel.org>,
        Linus Walleij <linusw@kernel.org>, <linux-gpio@vger.kernel.org>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, <linux-serial@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, <linux-kernel@vger.kernel.org>,
        Long Zhao
	<longzhao@ambarella.com>
Subject: [PATCH 07/10] pinctrl: ambarella: add Ambarella pin controller
Date: Thu, 30 Jul 2026 18:43:27 +0800
Message-ID: <20260730104330.81367-8-longzhao@ambarella.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260730104330.81367-1-longzhao@ambarella.com>
References: <20260730104330.81367-1-longzhao@ambarella.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Proofpoint-GUID: kcJt9lrt0ZUIqc_mUSlYukSblaeURZG3
X-Proofpoint-ORIG-GUID: kcJt9lrt0ZUIqc_mUSlYukSblaeURZG3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDA4MCBTYWx0ZWRfX2vLs/idSfRNH
 YVWNr6Ym5M+/52HMkuX3ZKCEcyEFhtFjDxjx4M5/Mkcz7rB+OJvkccFGB/005HIVeTG4EvW6z+N
 OJvxia5q2PESNe47dzZiNlbDgmkvhX0ruSFRdGhvcXfwmkzveb8RT+txdqYRZUjmXVGYww1Dr9R
 kfNSyXDmRQN/BNyshj4DqpOTaR/9GBFQhYxX+LVCHIRWmEyzfyUM+i8IKr1Ob9MXGc6KltwWOH9
 TRpmGX/j/zmdsXH3uQj6IHUIzavtSvnaGUJPsJSC7Roz7pc5wpUf9YwOJmtOhv7pAeGYZZ5O5+F
 R/w8BHrGktX5VDCvQzBILLDIAQR4JacU0ZbYeKVkdBK9jpwB+B6gk2qQ5dlp1CtdiQnLNLTuPFy
 HO4OAj0dzyQMxPJUruO14r1mh4SVSv7/yJw/2bRzVYyrATk1Nr7+iR+Uw6Q26oWuCoGrpmDhVtA
 pOdHRz85eKpvlAocfTA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDA4MCBTYWx0ZWRfX3cZ44uiO9cyk
 yp7BZ+3Z1OhxkFtFNKLm/YCxfzcns072pbtwBxjLvdb4y4mT99Buw0PAMOrQ1u7PEKqeM7rDOW2
 7vWqqGhYOFDXs0K2FLdHIM/cC8oo+mfFiPNYvcPxEZbomDly/vfM
X-Authority-Analysis: v=2.4 cv=PNE/P/qC c=1 sm=1 tr=0 ts=6a6b2ae7 cx=c_pps
 a=DgnZYc2JwZ3KnY28M5UqXQ==:117 a=DgnZYc2JwZ3KnY28M5UqXQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yXVIz-0bn9infC194UBj:22
 a=KblO7da7ppA7TBl3N-nE:22 a=ppJngBeKAAAA:8 a=cH2J6t5YKUCr9WsprtMA:9
 a=O8hF6Hzn-FEA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_03,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 adultscore=0 malwarescore=0 clxscore=1015
 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300080

Add the Ambarella pinmux/GPIO controller driver used by CV75.

Signed-off-by: Long Zhao <longzhao@ambarella.com>
---
 drivers/pinctrl/Kconfig             |   15 +
 drivers/pinctrl/Makefile            |    1 +
 drivers/pinctrl/pinctrl-ambarella.c | 1561 +++++++++++++++++++++++++++
 3 files changed, 1577 insertions(+)
 create mode 100644 drivers/pinctrl/pinctrl-ambarella.c

diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index c2cdd7b2c49b..572a4a898a99 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -37,6 +37,21 @@ config DEBUG_PINCTRL
        help
          Say Y here to add some extra checks and diagnostics to PINCTRL ca=
lls.

+config PINCTRL_AMB
+       bool "Ambarella pin controller support"
+       depends on ARCH_AMBARELLA || COMPILE_TEST
+       select GENERIC_PINCONF
+       select GPIOLIB
+       select GPIOLIB_IRQCHIP
+       select MFD_SYSCON
+       select PINCONF
+       select PINMUX
+       help
+         Say Y here to enable the pin controller found on Ambarella SoCs.
+         The driver provides pin multiplexing and pin configuration as wel=
l
+         as GPIO and GPIO interrupt support. It is required to configure
+         peripheral pins on systems using an Ambarella SoC.
+
 config PINCTRL_AMD
        bool "AMD GPIO pin control"
        depends on HAS_IOMEM
diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
index a35d71135abf..7cd9820d3088 100644
--- a/drivers/pinctrl/Makefile
+++ b/drivers/pinctrl/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_GENERIC_PINCONF) +=3D pinconf-generic.o
 obj-$(CONFIG_GENERIC_PINCTRL)  +=3D pinctrl-generic.o
 obj-$(CONFIG_OF)               +=3D devicetree.o

+obj-$(CONFIG_PINCTRL_AMB)      +=3D pinctrl-ambarella.o
 obj-$(CONFIG_PINCTRL_AMD)      +=3D pinctrl-amd.o
 obj-$(CONFIG_PINCTRL_AMDISP)   +=3D pinctrl-amdisp.o
 obj-$(CONFIG_PINCTRL_APPLE_GPIO) +=3D pinctrl-apple-gpio.o
diff --git a/drivers/pinctrl/pinctrl-ambarella.c b/drivers/pinctrl/pinctrl-=
ambarella.c
new file mode 100644
index 000000000000..641b50a0624d
--- /dev/null
+++ b/drivers/pinctrl/pinctrl-ambarella.c
@@ -0,0 +1,1561 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Pinctrl driver for Ambarella SoCs
+ *
+ * History:
+ *     2013/12/18 - [Cao Rongrong] created file
+ *
+ * Copyright (C) 2012-2026, Ambarella, Inc.
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/of_irq.h>
+#include <linux/pm.h>
+#include <linux/slab.h>
+#include <linux/regmap.h>
+#include <linux/mfd/syscon.h>
+#include <linux/irqdomain.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/gpio/driver.h>
+#include <linux/pinctrl/pinctrl.h>
+#include <linux/pinctrl/pinmux.h>
+#include <linux/pinctrl/pinconf.h>
+#include <linux/pinctrl/pinconf-generic.h>
+#include <linux/seq_file.h>
+#include "core.h"
+
+/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D*/
+
+#define GPIO_DATA_OFFSET               0x00
+#define GPIO_DIR_OFFSET                        0x04
+#define GPIO_IS_OFFSET                 0x08
+#define GPIO_IBE_OFFSET                        0x0c
+#define GPIO_IEV_OFFSET                        0x10
+#define GPIO_IE_OFFSET                 0x14
+#define GPIO_AFSEL_OFFSET              0x18
+#define GPIO_RIS_OFFSET                        0x1c
+#define GPIO_MIS_OFFSET                        0x20
+#define GPIO_IC_OFFSET                 0x24
+#define GPIO_MASK_OFFSET               0x28
+#define GPIO_ENABLE_OFFSET             0x2c
+
+#define IOMUX_OFFSET(bank, n)          (((bank) * 0xc) + ((n) * 4))
+#define IOMUX_CTRL_SET_OFFSET          0xf0
+
+/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D*/
+
+#define MAX_BANK_NUM                   8
+#define MAX_PIN_NUM                    (MAX_BANK_NUM * 32)
+
+#define PINID_TO_BANK(p)               ((p) >> 5)
+#define PINID_TO_OFFSET(p)             ((p) & 0x1f)
+
+#define MUXIDS_TO_PINID(m)             ((m) & 0xfff)
+#define MUXIDS_TO_ALT(m)               (((m) >> 12) & 0xf)
+
+struct ambpin_group {
+       const char              *name;
+       const char              *function;
+       unsigned int            *pins;
+       unsigned int            num_pins;
+       u8                      *alt;
+       unsigned long           *configs;
+       unsigned int            num_configs;
+};
+
+struct ambpin_function {
+       const char              *name;
+       const char              **groups;
+       unsigned int            num_groups;
+};
+
+struct amb_pinctrl_data {
+       unsigned int            ds0[MAX_BANK_NUM];
+       unsigned int            ds1[MAX_BANK_NUM];
+       unsigned int            ds2[MAX_BANK_NUM];
+       unsigned int            pull_en[MAX_BANK_NUM];
+       unsigned int            pull_dir[MAX_BANK_NUM];
+       bool                    have_ds2;
+       u32                     hsm_domain_id;
+       u32                     clk_au_dedicated_pin;
+};
+
+struct amb_pinctrl_pm_state {
+       u32 iomux[3];
+       u32 pull[2];
+       u32 ds[3];
+       u32 data;
+       u32 dir;
+       u32 is;
+       u32 ibe;
+       u32 iev;
+       u32 ie;
+       u32 afsel;
+       u32 mask;
+};
+
+struct amb_pinctrl_soc_data {
+       struct device                   *dev;
+       const struct amb_pinctrl_data   *data;
+       void __iomem                    *gpio_base[MAX_BANK_NUM];
+       void __iomem                    *iomux_base;
+       struct regmap                   *ds_regmap;
+       struct regmap                   *pull_regmap;
+       unsigned int                    ds0[MAX_BANK_NUM];
+       unsigned int                    ds1[MAX_BANK_NUM];
+       unsigned int                    ds2[MAX_BANK_NUM];
+       unsigned int                    pull_en[MAX_BANK_NUM];
+       unsigned int                    pull_dir[MAX_BANK_NUM];
+       unsigned int                    bank_num;
+       unsigned int                    have_ds2;
+       int                             irq[MAX_BANK_NUM];
+       unsigned int                    irq_wake_mask[MAX_BANK_NUM];
+       unsigned long                   used[BITS_TO_LONGS(MAX_PIN_NUM)];
+       raw_spinlock_t lock;
+
+       struct pinctrl_dev              *pctl;
+       struct gpio_chip                *gc;
+       struct irq_domain               *domain;
+
+       struct ambpin_function          *functions;
+       unsigned int                    nr_functions;
+       struct ambpin_group             *groups;
+       unsigned int                    nr_groups;
+
+       struct amb_pinctrl_pm_state     pm[MAX_BANK_NUM];
+
+       /* Domain ID used in HSM boot. */
+       u32                             hsm_domain_id;
+       /* Dedicated clk_au pin used on some chips. */
+       u32                             clk_au_dedicated_pin;
+};
+
+static __iomem void *
+amb_get_gpio_base(const struct amb_pinctrl_soc_data *soc,
+                 struct irq_data *data)
+{
+       return soc->gpio_base[PINID_TO_BANK(irqd_to_hwirq(data))];
+}
+
+/* check if the selector is a valid pin group selector */
+static int amb_get_group_count(struct pinctrl_dev *pctldev)
+{
+       struct amb_pinctrl_soc_data *soc =3D pinctrl_dev_get_drvdata(pctlde=
v);
+
+       return soc->nr_groups;
+}
+
+/* return the name of the group selected by the group selector */
+static const char *amb_get_group_name(struct pinctrl_dev *pctldev,
+                                     unsigned int selector)
+{
+       struct amb_pinctrl_soc_data *soc =3D pinctrl_dev_get_drvdata(pctlde=
v);
+
+       return soc->groups[selector].name;
+}
+
+/* return the pin numbers associated with the specified group */
+static int amb_get_group_pins(struct pinctrl_dev *pctldev,
+                             unsigned int selector, const unsigned int **p=
ins,
+                             unsigned int *num_pins)
+{
+       struct amb_pinctrl_soc_data *soc =3D pinctrl_dev_get_drvdata(pctlde=
v);
+
+       *pins =3D soc->groups[selector].pins;
+       *num_pins =3D soc->groups[selector].num_pins;
+
+       return 0;
+}
+
+#if IS_ENABLED(CONFIG_DEBUG_FS)
+static void amb_pin_dbg_show(struct pinctrl_dev *pctldev,
+                            struct seq_file *s, unsigned int pin)
+{
+       struct pin_desc *desc;
+
+       seq_printf(s, " %s", dev_name(pctldev->dev));
+
+       desc =3D pin_desc_get(pctldev, pin);
+       if (desc) {
+               seq_printf(s, " owner: %s%s%s%s",
+                          desc->mux_owner ? desc->mux_owner : "",
+                          desc->mux_owner && desc->gpio_owner ? " " : "",
+                          desc->gpio_owner ? desc->gpio_owner : "",
+                          !desc->mux_owner && !desc->gpio_owner ? "NULL" :=
 "");
+       } else {
+               seq_puts(s, " not registered");
+       }
+}
+#endif
+
+#if IS_ENABLED(CONFIG_OF)
+static int amb_dt_node_to_map(struct pinctrl_dev *pctldev,
+                             struct device_node *np,
+                             struct pinctrl_map **map,
+                             unsigned int *num_maps)
+{
+       struct amb_pinctrl_soc_data *soc =3D pinctrl_dev_get_drvdata(pctlde=
v);
+       struct ambpin_group *grp =3D NULL;
+       struct pinctrl_map *new_map;
+       u32 i, new_num;
+
+       /* find the group of this node by name */
+       for (i =3D 0; i < soc->nr_groups; i++) {
+               if (!strcmp(soc->groups[i].name, np->name)) {
+                       grp =3D &soc->groups[i];
+                       break;
+               }
+       }
+       if (!grp) {
+               dev_err(soc->dev, "unable to find group for node %s\n", np-=
>name);
+               return -EINVAL;
+       }
+
+       new_num =3D !!grp->num_pins + !!grp->num_configs;
+       new_map =3D kcalloc(new_num, sizeof(*new_map), GFP_KERNEL);
+       if (!new_map)
+               return -ENOMEM;
+
+       *map =3D new_map;
+       *num_maps =3D new_num;
+
+       /* create mux map */
+       if (grp->num_pins) {
+               new_map[0].type =3D PIN_MAP_TYPE_MUX_GROUP;
+               new_map[0].data.mux.group =3D grp->name;
+               new_map[0].data.mux.function =3D grp->function;
+               new_map++;
+       }
+
+       if (grp->num_configs) {
+               new_map[0].type =3D PIN_MAP_TYPE_CONFIGS_GROUP;
+               new_map[0].data.configs.group_or_pin =3D grp->name;
+               new_map[0].data.configs.configs =3D grp->configs;
+               new_map[0].data.configs.num_configs =3D grp->num_configs;
+       }
+
+       return 0;
+}
+
+static void amb_dt_free_map(struct pinctrl_dev *pctldev,
+                           struct pinctrl_map *map, unsigned int num_maps)
+{
+       kfree(map);
+}
+#endif
+
+/* list of pinctrl callbacks for the pinctrl core */
+static const struct pinctrl_ops amb_pctrl_ops =3D {
+       .get_groups_count       =3D amb_get_group_count,
+       .get_group_name         =3D amb_get_group_name,
+       .get_group_pins         =3D amb_get_group_pins,
+#if IS_ENABLED(CONFIG_DEBUG_FS)
+       .pin_dbg_show           =3D amb_pin_dbg_show,
+#endif
+#if IS_ENABLED(CONFIG_OF)
+       .dt_node_to_map         =3D amb_dt_node_to_map,
+       .dt_free_map            =3D amb_dt_free_map,
+#endif
+};
+
+/* check if the selector is a valid pin function selector */
+static int amb_pinmux_request(struct pinctrl_dev *pctldev, unsigned int pi=
n)
+{
+       struct amb_pinctrl_soc_data *soc =3D pinctrl_dev_get_drvdata(pctlde=
v);
+
+       if (test_and_set_bit(pin, soc->used))
+               return -EBUSY;
+
+       return 0;
+}
+
+/* check if the selector is a valid pin function selector */
+static int amb_pinmux_free(struct pinctrl_dev *pctldev, unsigned int pin)
+{
+       struct amb_pinctrl_soc_data *soc =3D pinctrl_dev_get_drvdata(pctlde=
v);
+
+       clear_bit(pin, soc->used);
+
+       return 0;
+}
+
+/* check if the selector is a valid pin function selector */
+static int amb_pinmux_get_fcount(struct pinctrl_dev *pctldev)
+{
+       struct amb_pinctrl_soc_data *soc =3D pinctrl_dev_get_drvdata(pctlde=
v);
+
+       return soc->nr_functions;
+}
+
+/* return the name of the pin function specified */
+static const char *amb_pinmux_get_fname(struct pinctrl_dev *pctldev,
+                                       unsigned int selector)
+{
+       struct amb_pinctrl_soc_data *soc =3D pinctrl_dev_get_drvdata(pctlde=
v);
+
+       return soc->functions[selector].name;
+}
+
+/* return the groups associated for the specified function selector */
+static int amb_pinmux_get_groups(struct pinctrl_dev *pctldev,
+                                unsigned int selector,
+                                const char * const **groups,
+                                unsigned int * const num_groups)
+{
+       struct amb_pinctrl_soc_data *soc =3D pinctrl_dev_get_drvdata(pctlde=
v);
+
+       *groups =3D soc->functions[selector].groups;
+       *num_groups =3D soc->functions[selector].num_groups;
+
+       return 0;
+}
+
+static void amb_pinmux_set_altfunc(struct amb_pinctrl_soc_data *soc,
+                                  u32 bank, u32 offset, u32 altfunc)
+{
+       u32 i, data;
+
+       /* On CV3 platform, only ARM cluster0 (safety domain) can access pi=
nctrl registers */
+       if (soc->hsm_domain_id !=3D 0)
+               return;
+
+       for (i =3D 0; i < 3; i++) {
+               data =3D readl_relaxed(soc->iomux_base + IOMUX_OFFSET(bank,=
 i));
+               data &=3D (~(0x1 << offset));
+               data |=3D (((altfunc >> i) & 0x1) << offset);
+               writel_relaxed(data, soc->iomux_base + IOMUX_OFFSET(bank, i=
));
+       }
+
+       writel_relaxed(0x1, soc->iomux_base + IOMUX_CTRL_SET_OFFSET);
+       writel_relaxed(0x0, soc->iomux_base + IOMUX_CTRL_SET_OFFSET);
+}
+
+/* enable a specified pinmux by writing to registers */
+static int amb_pinmux_set_mux(struct pinctrl_dev *pctldev,
+                             unsigned int selector, unsigned int group)
+{
+       struct amb_pinctrl_soc_data *soc =3D pinctrl_dev_get_drvdata(pctlde=
v);
+       const struct ambpin_group *grp;
+       u32 i, bank, offset;
+       unsigned long flags;
+
+       grp =3D &soc->groups[group];
+
+       raw_spin_lock_irqsave(&soc->lock, flags);
+       for (i =3D 0; i < grp->num_pins; i++) {
+               bank =3D PINID_TO_BANK(grp->pins[i]);
+               offset =3D PINID_TO_OFFSET(grp->pins[i]);
+               amb_pinmux_set_altfunc(soc, bank, offset,  grp->alt[i]);
+       }
+       raw_spin_unlock_irqrestore(&soc->lock, flags);
+
+       return 0;
+}
+
+static int amb_pinmux_gpio_request_enable(struct pinctrl_dev *pctldev,
+                                         struct pinctrl_gpio_range *range,
+                                         unsigned int pin)
+{
+       struct amb_pinctrl_soc_data *soc =3D pinctrl_dev_get_drvdata(pctlde=
v);
+       u32 bank, offset;
+       unsigned long flags;
+
+       if (!range || !range->gc) {
+               dev_err(soc->dev, "invalid range: %p\n", range);
+               return -EINVAL;
+       }
+
+       if (test_and_set_bit(pin, soc->used))
+               return -EBUSY;
+
+       bank =3D PINID_TO_BANK(pin);
+       offset =3D PINID_TO_OFFSET(pin);
+
+       raw_spin_lock_irqsave(&soc->lock, flags);
+       amb_pinmux_set_altfunc(soc, bank, offset, 0);
+       raw_spin_unlock_irqrestore(&soc->lock, flags);
+
+       return 0;
+}
+
+static void amb_pinmux_gpio_disable_free(struct pinctrl_dev *pctldev,
+                                        struct pinctrl_gpio_range *range,
+                                        unsigned int pin)
+{
+       struct amb_pinctrl_soc_data *soc =3D pinctrl_dev_get_drvdata(pctlde=
v);
+
+       dev_dbg(soc->dev, "disable pin %u as GPIO\n", pin);
+       /* Set the pin to some default state, GPIO is usually default */
+
+       clear_bit(pin, soc->used);
+}
+
+/* list of pinmux callbacks for the pinmux vertical in pinctrl core */
+static const struct pinmux_ops amb_pinmux_ops =3D {
+       .request                =3D amb_pinmux_request,
+       .free                   =3D amb_pinmux_free,
+       .get_functions_count    =3D amb_pinmux_get_fcount,
+       .get_function_name      =3D amb_pinmux_get_fname,
+       .get_function_groups    =3D amb_pinmux_get_groups,
+       .set_mux                =3D amb_pinmux_set_mux,
+       .gpio_request_enable    =3D amb_pinmux_gpio_request_enable,
+       .gpio_disable_free      =3D amb_pinmux_gpio_disable_free,
+};
+
+static int amb_drive_strength_to_reg(struct amb_pinctrl_soc_data *soc,
+                                    u32 strength)
+{
+       if (soc->have_ds2) {
+               switch (strength) {
+               case 3:
+                       return 0;
+               case 4:
+               case 5:
+                       return 1;
+               case 6:
+                       return 2;
+               case 7:
+               case 8:
+                       return 3;
+               case 9:
+                       return 4;
+               case 12:
+                       return 5;
+               default:
+                       return -EINVAL;
+               }
+       }
+
+       switch (strength) {
+       case 2:
+               return 0;
+       case 4:
+               return 1;
+       case 8:
+               return 2;
+       case 12:
+               return 3;
+       default:
+               return -EINVAL;
+       }
+}
+
+/* set the pin config settings for a specified pin */
+static int amb_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
+                          unsigned long *configs, unsigned int num_configs=
)
+{
+       struct amb_pinctrl_soc_data *soc =3D pinctrl_dev_get_drvdata(pctlde=
v);
+       u32 i, bank, offset;
+       unsigned long config, flags;
+       enum pin_config_param param;
+       u32 arg;
+       int ds;
+
+       bank =3D PINID_TO_BANK(pin);
+       offset =3D PINID_TO_OFFSET(pin);
+
+       raw_spin_lock_irqsave(&soc->lock, flags);
+       for (i =3D 0; i < num_configs; i++) {
+               config =3D configs[i];
+               param =3D pinconf_to_config_param(config);
+               arg =3D pinconf_to_config_argument(config);
+
+               switch (param) {
+               case PIN_CONFIG_BIAS_DISABLE:
+                       regmap_update_bits(soc->pull_regmap,
+                                          soc->pull_en[bank], BIT(offset),=
 0);
+                       break;
+               case PIN_CONFIG_BIAS_PULL_DOWN:
+               case PIN_CONFIG_BIAS_PULL_UP:
+                       regmap_update_bits(soc->pull_regmap, soc->pull_dir[=
bank],
+                                          BIT(offset),
+                                          (param =3D=3D PIN_CONFIG_BIAS_PU=
LL_UP) ?
+                                          BIT(offset) : 0);
+                       regmap_update_bits(soc->pull_regmap, soc->pull_en[b=
ank],
+                                          BIT(offset), BIT(offset));
+                       break;
+               case PIN_CONFIG_DRIVE_STRENGTH:
+                       ds =3D amb_drive_strength_to_reg(soc, arg);
+                       if (ds < 0) {
+                               raw_spin_unlock_irqrestore(&soc->lock, flag=
s);
+                               return ds;
+                       }
+                       if (soc->have_ds2) {
+                               regmap_update_bits(soc->ds_regmap,
+                                                  soc->ds0[bank], BIT(offs=
et),
+                                                  (ds & BIT(0)) ? BIT(offs=
et) : 0);
+                               regmap_update_bits(soc->ds_regmap,
+                                                  soc->ds1[bank], BIT(offs=
et),
+                                                  (ds & BIT(1)) ? BIT(offs=
et) : 0);
+                               regmap_update_bits(soc->ds_regmap,
+                                                  soc->ds2[bank], BIT(offs=
et),
+                                                  (ds & BIT(2)) ? BIT(offs=
et) : 0);
+                       } else {
+                               regmap_update_bits(soc->ds_regmap,
+                                                  soc->ds0[bank], BIT(offs=
et),
+                                                  (ds & BIT(1)) ? BIT(offs=
et) : 0);
+                               regmap_update_bits(soc->ds_regmap,
+                                                  soc->ds1[bank], BIT(offs=
et),
+                                                  (ds & BIT(0)) ? BIT(offs=
et) : 0);
+                       }
+                       break;
+               default:
+                       raw_spin_unlock_irqrestore(&soc->lock, flags);
+                       return -EOPNOTSUPP;
+               }
+       }
+       raw_spin_unlock_irqrestore(&soc->lock, flags);
+
+       return 0;
+}
+
+static int amb_pinconf_group_set(struct pinctrl_dev *pctldev,
+                                unsigned int selector,
+                                unsigned long *configs,
+                                unsigned int num_configs)
+{
+       struct amb_pinctrl_soc_data *soc =3D pinctrl_dev_get_drvdata(pctlde=
v);
+       const struct ambpin_group *grp =3D &soc->groups[selector];
+       int ret;
+       u32 i;
+
+       for (i =3D 0; i < grp->num_pins; i++) {
+               ret =3D amb_pinconf_set(pctldev, grp->pins[i], configs,
+                                     num_configs);
+               if (ret)
+                       return ret;
+       }
+
+       return 0;
+}
+
+/* get the pin config settings for a specified pin */
+static int amb_pinconf_get(struct pinctrl_dev *pctldev,
+                          unsigned int pin, unsigned long *config)
+{
+       dev_WARN_ONCE(pctldev->dev, true, "NOT Implemented.\n");
+       return -EOPNOTSUPP;
+}
+
+#if IS_ENABLED(CONFIG_DEBUG_FS)
+static void amb_pinconf_dbg_show(struct pinctrl_dev *pctldev,
+                                struct seq_file *s, unsigned int pin)
+{
+       struct amb_pinctrl_soc_data *soc =3D pinctrl_dev_get_drvdata(pctlde=
v);
+       u32 pull_en, pull_dir, ds0, ds1, ds2, drv_strength;
+       u32 bank, offset;
+
+       bank =3D PINID_TO_BANK(pin);
+       offset =3D PINID_TO_OFFSET(pin);
+
+       regmap_read(soc->pull_regmap, soc->pull_en[bank], &pull_en);
+       pull_en =3D (pull_en >> offset) & 0x1;
+       regmap_read(soc->pull_regmap, soc->pull_dir[bank], &pull_dir);
+       pull_dir =3D (pull_dir >> offset) & 0x1;
+       seq_printf(s, " pull: %s, ", pull_en ? pull_dir ? "up" : "down" : "=
disable");
+
+       regmap_read(soc->ds_regmap, soc->ds0[bank], &ds0);
+       ds0 =3D (ds0 >> offset) & 0x1;
+       regmap_read(soc->ds_regmap, soc->ds1[bank], &ds1);
+       ds1 =3D (ds1 >> offset) & 0x1;
+       if (soc->have_ds2) {
+               regmap_read(soc->ds_regmap, soc->ds2[bank], &ds2);
+               ds2 =3D (ds2 >> offset) & 0x1;
+               drv_strength =3D (ds2 << 2) | (ds1 << 1) | ds0;
+               seq_printf(s, "drive-strength: %s",
+                          drv_strength =3D=3D 5 ? "12mA(lvl5)" :
+                          drv_strength =3D=3D 4 ? "9mA(lvl4)" :
+                          drv_strength =3D=3D 3 ? "7.5mA(lvl3)" :
+                          drv_strength =3D=3D 2 ? "6mA(lvl2)" :
+                          drv_strength =3D=3D 1 ? "4.5mA(lvl1)" :
+                          drv_strength =3D=3D 0 ? "3mA(lvl0)" : "invalid")=
;
+       } else {
+               drv_strength =3D (ds0 << 1) | ds1;
+               seq_printf(s, "drive-strength: %s",
+                          drv_strength =3D=3D 3 ? "12mA" :
+                          drv_strength =3D=3D 2 ? "8mA" :
+                          drv_strength =3D=3D 1 ? "4mA" : "2mA");
+       }
+}
+#endif
+
+/* list of pinconfig callbacks for pinconfig vertical in the pinctrl code =
*/
+static const struct pinconf_ops amb_pinconf_ops =3D {
+       .is_generic             =3D true,
+       .pin_config_get         =3D amb_pinconf_get,
+       .pin_config_set         =3D amb_pinconf_set,
+       .pin_config_group_set   =3D amb_pinconf_group_set,
+#if IS_ENABLED(CONFIG_DEBUG_FS)
+       .pin_config_dbg_show    =3D amb_pinconf_dbg_show,
+#endif
+};
+
+static int amb_pinctrl_get_function_name(struct device_node *np,
+                                        const char **function)
+{
+       if (of_property_read_string(np, "function", function))
+               *function =3D np->name;
+
+       return 0;
+}
+
+static int amb_pinctrl_count_configs(struct device_node *np)
+{
+       unsigned int bias =3D 0, count =3D 0;
+
+       if (of_property_read_bool(np, "bias-disable"))
+               bias++;
+       if (of_property_read_bool(np, "bias-pull-down"))
+               bias++;
+       if (of_property_read_bool(np, "bias-pull-up"))
+               bias++;
+       if (bias > 1)
+               return -EINVAL;
+
+       count +=3D bias;
+       if (of_find_property(np, "drive-strength", NULL))
+               count++;
+
+       return count;
+}
+
+static int amb_pinctrl_parse_configs(struct amb_pinctrl_soc_data *soc,
+                                    struct device_node *np,
+                                    struct ambpin_group *grp)
+{
+       u32 drive;
+       int num_configs, i =3D 0;
+
+       num_configs =3D amb_pinctrl_count_configs(np);
+       if (num_configs < 0)
+               return dev_err_probe(soc->dev, num_configs,
+                                    "%pOF has conflicting bias properties\=
n", np);
+       if (!num_configs)
+               return 0;
+
+       grp->configs =3D devm_kcalloc(soc->dev, num_configs,
+                                   sizeof(*grp->configs), GFP_KERNEL);
+       if (!grp->configs)
+               return -ENOMEM;
+
+       if (of_property_read_bool(np, "bias-disable"))
+               grp->configs[i++] =3D
+                       pinconf_to_config_packed(PIN_CONFIG_BIAS_DISABLE, 0=
);
+       else if (of_property_read_bool(np, "bias-pull-down"))
+               grp->configs[i++] =3D
+                       pinconf_to_config_packed(PIN_CONFIG_BIAS_PULL_DOWN,=
 1);
+       else if (of_property_read_bool(np, "bias-pull-up"))
+               grp->configs[i++] =3D
+                       pinconf_to_config_packed(PIN_CONFIG_BIAS_PULL_UP, 1=
);
+
+       if (!of_property_read_u32(np, "drive-strength", &drive))
+               grp->configs[i++] =3D
+                       pinconf_to_config_packed(PIN_CONFIG_DRIVE_STRENGTH,
+                                                drive);
+
+       grp->num_configs =3D i;
+
+       return 0;
+}
+
+static int amb_pinctrl_parse_group(struct amb_pinctrl_soc_data *soc,
+                                  struct device_node *np, int idx,
+                                  const char **out_name)
+{
+       struct ambpin_group *grp =3D &soc->groups[idx];
+       struct device *dev =3D soc->dev;
+       struct property *prop;
+       int length;
+       int ret;
+       u32 i;
+
+       grp->name =3D np->name;
+       amb_pinctrl_get_function_name(np, &grp->function);
+
+       prop =3D of_find_property(np, "pinmux", &length);
+       if (prop) {
+               grp->num_pins =3D length / sizeof(u32);
+
+               grp->pins =3D devm_kcalloc(dev, grp->num_pins, sizeof(*grp-=
>pins), GFP_KERNEL);
+               if (!grp->pins)
+                       return -ENOMEM;
+
+               grp->alt =3D devm_kcalloc(dev, grp->num_pins, sizeof(*grp->=
alt), GFP_KERNEL);
+               if (!grp->alt)
+                       return -ENOMEM;
+
+               of_property_read_u32_array(np, "pinmux", grp->pins,
+                                          grp->num_pins);
+
+               for (i =3D 0; i < grp->num_pins; i++) {
+                       grp->alt[i] =3D MUXIDS_TO_ALT(grp->pins[i]);
+                       grp->pins[i] =3D MUXIDS_TO_PINID(grp->pins[i]);
+               }
+       }
+
+       if (!grp->num_pins)
+               return dev_err_probe(soc->dev, -EINVAL,
+                                    "%pOF: missing pinmux property\n", np)=
;
+
+       ret =3D amb_pinctrl_parse_configs(soc, np, grp);
+       if (ret)
+               return ret;
+
+       if (out_name)
+               *out_name =3D grp->name;
+
+       return 0;
+}
+
+static int amb_pinctrl_find_function(struct amb_pinctrl_soc_data *soc,
+                                    const char *function)
+{
+       int i;
+
+       for (i =3D 0; i < soc->nr_functions; i++) {
+               if (soc->functions[i].name &&
+                   !strcmp(soc->functions[i].name, function))
+                       return i;
+       }
+
+       return -ENOENT;
+}
+
+static int amb_pinctrl_parse_dt(struct amb_pinctrl_soc_data *soc)
+{
+       struct device_node *np =3D soc->dev->of_node;
+       struct device_node *child;
+       int idxf =3D 0, idxg =3D 0;
+       int i, ret;
+
+       /* Count total functions and groups */
+       for_each_child_of_node(np, child) {
+               if (of_find_property(child, "gpio-controller", NULL))
+                       continue;
+
+               soc->nr_groups++;
+       }
+
+       if (!soc->nr_groups) {
+               dev_err(soc->dev, "no group is defined\n");
+               return -ENOENT;
+       }
+
+       soc->functions =3D devm_kcalloc(soc->dev, soc->nr_groups,
+                                     sizeof(struct ambpin_function), GFP_K=
ERNEL);
+       if (!soc->functions)
+               return -ENOMEM;
+
+       soc->groups =3D devm_kcalloc(soc->dev, soc->nr_groups,
+                                  sizeof(struct ambpin_group), GFP_KERNEL)=
;
+       if (!soc->groups)
+               return -ENOMEM;
+
+       /* Parse groups and collect unique functions. */
+       idxg =3D 0;
+       for_each_child_of_node(np, child) {
+               if (of_find_property(child, "gpio-controller", NULL))
+                       continue;
+
+               ret =3D amb_pinctrl_parse_group(soc, child, idxg, NULL);
+               if (ret) {
+                       of_node_put(child);
+                       return ret;
+               }
+
+               i =3D amb_pinctrl_find_function(soc, soc->groups[idxg].func=
tion);
+               if (i < 0) {
+                       soc->functions[idxf].name =3D soc->groups[idxg].fun=
ction;
+                       i =3D idxf++;
+               }
+
+               soc->functions[i].num_groups++;
+               idxg++;
+       }
+
+       soc->nr_functions =3D idxf;
+
+       for (idxf =3D 0; idxf < soc->nr_functions; idxf++) {
+               soc->functions[idxf].groups =3D
+                       devm_kcalloc(soc->dev, soc->functions[idxf].num_gro=
ups,
+                                    sizeof(*soc->functions[idxf].groups),
+                                    GFP_KERNEL);
+               if (!soc->functions[idxf].groups)
+                       return -ENOMEM;
+
+               soc->functions[idxf].num_groups =3D 0;
+       }
+
+       for (idxg =3D 0; idxg < soc->nr_groups; idxg++) {
+               i =3D amb_pinctrl_find_function(soc, soc->groups[idxg].func=
tion);
+               if (i < 0)
+                       return -EINVAL;
+
+               soc->functions[i].groups[soc->functions[i].num_groups++] =
=3D
+                       soc->groups[idxg].name;
+       }
+
+       return 0;
+}
+
+/* register the pinctrl interface with the pinctrl subsystem */
+static int amb_pinctrl_register(struct amb_pinctrl_soc_data *soc)
+{
+       struct pinctrl_pin_desc *pindesc;
+       int pin, pin_num, rval;
+       struct pinctrl_desc *amb_pinctrl_desc;
+
+       /* Addition one for clk_au dedicated pin */
+       pin_num =3D soc->bank_num * 32 + 16;
+
+       /* dynamically populate the pin number and pin name for pindesc */
+       pindesc =3D devm_kcalloc(soc->dev, pin_num, sizeof(*pindesc), GFP_K=
ERNEL);
+       if (!pindesc)
+               return -ENOMEM;
+
+       for (pin =3D 0; pin < pin_num; pin++) {
+               pindesc[pin].number =3D pin;
+               pindesc[pin].name =3D devm_kasprintf(soc->dev, GFP_KERNEL, =
"io%d", pin);
+               if (!pindesc[pin].name)
+                       return -ENOMEM;
+       }
+
+       amb_pinctrl_desc =3D devm_kzalloc(soc->dev, sizeof(*amb_pinctrl_des=
c), GFP_KERNEL);
+       if (!amb_pinctrl_desc)
+               return -ENOMEM;
+
+       amb_pinctrl_desc->name =3D dev_name(soc->dev);
+       amb_pinctrl_desc->pins =3D pindesc;
+       amb_pinctrl_desc->npins =3D pin_num;
+       amb_pinctrl_desc->pctlops =3D &amb_pctrl_ops;
+       amb_pinctrl_desc->pmxops =3D &amb_pinmux_ops;
+       amb_pinctrl_desc->confops =3D &amb_pinconf_ops;
+
+       rval =3D amb_pinctrl_parse_dt(soc);
+       if (rval)
+               return rval;
+
+       soc->pctl =3D devm_pinctrl_register(soc->dev, amb_pinctrl_desc, soc=
);
+       if (IS_ERR(soc->pctl)) {
+               dev_err(soc->dev, "could not register pinctrl driver\n");
+               return PTR_ERR(soc->pctl);
+       }
+
+       return 0;
+}
+
+/* gpiolib gpio_set callback function */
+static int amb_gpio_set(struct gpio_chip *gc, unsigned int pin, int value)
+{
+       struct amb_pinctrl_soc_data *soc =3D gpiochip_get_data(gc);
+       u32 bank, offset, data;
+       unsigned long flags;
+
+       bank =3D PINID_TO_BANK(pin);
+       offset =3D PINID_TO_OFFSET(pin);
+
+       raw_spin_lock_irqsave(&soc->lock, flags);
+       writel_relaxed(0x1 << offset, soc->gpio_base[bank] + GPIO_MASK_OFFS=
ET);
+       data =3D (value =3D=3D 0) ? 0 : 0x1 << offset;
+       writel_relaxed(data, soc->gpio_base[bank] + GPIO_DATA_OFFSET);
+       raw_spin_unlock_irqrestore(&soc->lock, flags);
+
+       return 0;
+}
+
+/* gpiolib gpio_get callback function */
+static int amb_gpio_get(struct gpio_chip *gc, unsigned int pin)
+{
+       struct amb_pinctrl_soc_data *soc =3D gpiochip_get_data(gc);
+       u32 bank, offset, data;
+       unsigned long flags;
+
+       bank =3D PINID_TO_BANK(pin);
+       offset =3D PINID_TO_OFFSET(pin);
+
+       raw_spin_lock_irqsave(&soc->lock, flags);
+       writel_relaxed(0x1 << offset, soc->gpio_base[bank] + GPIO_MASK_OFFS=
ET);
+       data =3D readl_relaxed(soc->gpio_base[bank] + GPIO_DATA_OFFSET);
+       raw_spin_unlock_irqrestore(&soc->lock, flags);
+
+       return (data >> offset) & 0x1;
+}
+
+static int amb_gpio_get_direction(struct gpio_chip *gc, unsigned int pin)
+{
+       struct amb_pinctrl_soc_data *soc =3D gpiochip_get_data(gc);
+       u32 bank, offset, data;
+       unsigned long flags;
+
+       bank =3D PINID_TO_BANK(pin);
+       offset =3D PINID_TO_OFFSET(pin);
+
+       raw_spin_lock_irqsave(&soc->lock, flags);
+       data =3D readl_relaxed(soc->gpio_base[bank] + GPIO_DIR_OFFSET);
+       data =3D (data >> offset) & 0x1;
+       raw_spin_unlock_irqrestore(&soc->lock, flags);
+
+       return data ? GPIO_LINE_DIRECTION_OUT : GPIO_LINE_DIRECTION_IN;
+}
+
+static int amb_gpio_set_direction(struct gpio_chip *gc, unsigned int pin, =
bool input)
+{
+       struct amb_pinctrl_soc_data *soc =3D gpiochip_get_data(gc);
+       u32 bank, offset, data;
+       unsigned long flags;
+
+       bank =3D PINID_TO_BANK(pin);
+       offset =3D PINID_TO_OFFSET(pin);
+
+       raw_spin_lock_irqsave(&soc->lock, flags);
+       data =3D readl_relaxed(soc->gpio_base[bank] + GPIO_DIR_OFFSET);
+       if (input)
+               writel_relaxed(data & ~(0x1 << offset), soc->gpio_base[bank=
] + GPIO_DIR_OFFSET);
+       else
+               writel_relaxed(data | (0x1 << offset), soc->gpio_base[bank]=
 + GPIO_DIR_OFFSET);
+       raw_spin_unlock_irqrestore(&soc->lock, flags);
+
+       return 0;
+}
+
+/* gpiolib gpio_direction_input callback function */
+static int amb_gpio_direction_input(struct gpio_chip *gc, unsigned int pin=
)
+{
+       return amb_gpio_set_direction(gc, pin, true);
+}
+
+/* gpiolib gpio_direction_output callback function */
+static int amb_gpio_direction_output(struct gpio_chip *gc, unsigned int pi=
n, int value)
+{
+       amb_gpio_set_direction(gc, pin, false);
+       amb_gpio_set(gc, pin, value);
+       return 0;
+}
+
+/* gpiolib gpio_to_irq callback function */
+static int amb_gpio_to_irq(struct gpio_chip *gc, unsigned int pin)
+{
+       struct amb_pinctrl_soc_data *soc =3D gpiochip_get_data(gc);
+
+       return irq_create_mapping(soc->domain, pin);
+}
+
+#if IS_ENABLED(CONFIG_DEBUG_FS)
+static void amb_gpio_dbg_show(struct seq_file *s, struct gpio_chip *gc)
+{
+       struct amb_pinctrl_soc_data *soc =3D gpiochip_get_data(gc);
+       u32 afsel, data, dir, mask, iomux0, iomux1, iomux2, alt;
+       u32 i, bank, offset;
+
+       for (i =3D 0; i < gc->ngpio; i++) {
+               offset =3D PINID_TO_OFFSET(i);
+               if (!offset) {
+                       bank =3D PINID_TO_BANK(i);
+
+                       afsel =3D readl_relaxed(soc->gpio_base[bank] + GPIO=
_AFSEL_OFFSET);
+                       dir =3D readl_relaxed(soc->gpio_base[bank] + GPIO_D=
IR_OFFSET);
+                       mask =3D readl_relaxed(soc->gpio_base[bank] + GPIO_=
MASK_OFFSET);
+                       writel_relaxed(0xffffffff, soc->gpio_base[bank] + G=
PIO_MASK_OFFSET);
+                       data =3D readl_relaxed(soc->gpio_base[bank] + GPIO_=
DATA_OFFSET);
+                       writel_relaxed(mask, soc->gpio_base[bank] + GPIO_MA=
SK_OFFSET);
+
+                       seq_printf(s, "\nGPIO[%d]:\t[%d - %d]\n", bank, i, =
i + 32 - 1);
+                       seq_printf(s, "GPIO_AFSEL:\t0x%08X\n", afsel);
+                       seq_printf(s, "GPIO_DIR:\t0x%08X\n", dir);
+                       seq_printf(s, "GPIO_MASK:\t0x%08X\n", mask);
+                       seq_printf(s, "GPIO_DATA:\t0x%08X\n", data);
+
+                       iomux0 =3D readl_relaxed(soc->iomux_base + bank * 1=
2);
+                       iomux1 =3D readl_relaxed(soc->iomux_base + bank * 1=
2 + 4);
+                       iomux2 =3D readl_relaxed(soc->iomux_base + bank * 1=
2 + 8);
+                       seq_printf(s, "IOMUX_REG%d_0:\t0x%08X\n", bank, iom=
ux0);
+                       seq_printf(s, "IOMUX_REG%d_1:\t0x%08X\n", bank, iom=
ux1);
+                       seq_printf(s, "IOMUX_REG%d_2:\t0x%08X\n", bank, iom=
ux2);
+               }
+
+               seq_printf(s, " gpio-%-3d", gc->base + i);
+
+               alt =3D ((iomux2 >> offset) & 1) << 2;
+               alt |=3D ((iomux1 >> offset) & 1) << 1;
+               alt |=3D ((iomux0 >> offset) & 1) << 0;
+               if (alt) {
+                       seq_printf(s, " [HW  ] (alt%d)\n", alt);
+               } else {
+                       char *label __free(kfree) =3D gpiochip_dup_line_lab=
el(gc, i);
+                       if (IS_ERR(label)) {
+                               pr_debug("Failed to duplicate label\n");
+                               continue;
+                       }
+
+                       seq_printf(s, " [GPIO] (%-20.20s) %s %s\n",
+                                  label ? label : "",
+                                  (dir & (1 << offset)) ? "out" : "in ",
+                                  (data & (1 << offset)) ? "hi" : "lo");
+               }
+       }
+}
+#endif
+
+static void amb_gpio_irq_enable(struct irq_data *data)
+{
+       struct gpio_chip *gc =3D irq_data_get_irq_chip_data(data);
+       struct amb_pinctrl_soc_data *soc =3D gpiochip_get_data(gc);
+       void __iomem *gpio_base =3D amb_get_gpio_base(soc, data);
+       void __iomem *iomux_base =3D soc->iomux_base;
+       u32 i, val, bank, offset;
+       unsigned long flags;
+
+       bank =3D PINID_TO_BANK(irqd_to_hwirq(data));
+       offset =3D PINID_TO_OFFSET(irqd_to_hwirq(data));
+
+       raw_spin_lock_irqsave(&soc->lock, flags);
+
+       val =3D readl_relaxed(gpio_base + GPIO_DIR_OFFSET);
+       val &=3D ~(0x1 << offset);
+       writel_relaxed(val, gpio_base + GPIO_DIR_OFFSET);
+
+       for (i =3D 0; i < 3; i++) {
+               val =3D readl_relaxed(iomux_base + IOMUX_OFFSET(bank, i));
+               val &=3D ~(0x1 << offset);
+               writel_relaxed(val, iomux_base + IOMUX_OFFSET(bank, i));
+       }
+       writel_relaxed(0x1, iomux_base + IOMUX_CTRL_SET_OFFSET);
+       writel_relaxed(0x0, iomux_base + IOMUX_CTRL_SET_OFFSET);
+
+       writel_relaxed(0x1 << offset, gpio_base + GPIO_IC_OFFSET);
+
+       val =3D readl_relaxed(gpio_base + GPIO_IE_OFFSET);
+       val |=3D 0x1 << offset;
+       writel_relaxed(val, gpio_base + GPIO_IE_OFFSET);
+
+       raw_spin_unlock_irqrestore(&soc->lock, flags);
+}
+
+static void amb_gpio_irq_disable(struct irq_data *data)
+{
+       struct gpio_chip *gc =3D irq_data_get_irq_chip_data(data);
+       struct amb_pinctrl_soc_data *soc =3D gpiochip_get_data(gc);
+       void __iomem *gpio_base =3D amb_get_gpio_base(soc, data);
+       u32 offset, ie;
+       unsigned long flags;
+
+       offset =3D PINID_TO_OFFSET(irqd_to_hwirq(data));
+
+       raw_spin_lock_irqsave(&soc->lock, flags);
+       ie =3D readl_relaxed(gpio_base + GPIO_IE_OFFSET);
+       writel_relaxed(ie & ~(0x1 << offset), gpio_base + GPIO_IE_OFFSET);
+       writel_relaxed(0x1 << offset, gpio_base + GPIO_IC_OFFSET);
+       raw_spin_unlock_irqrestore(&soc->lock, flags);
+}
+
+static void amb_gpio_irq_ack(struct irq_data *data)
+{
+       struct gpio_chip *gc =3D irq_data_get_irq_chip_data(data);
+       struct amb_pinctrl_soc_data *soc =3D gpiochip_get_data(gc);
+       void __iomem *gpio_base =3D amb_get_gpio_base(soc, data);
+       u32 offset =3D PINID_TO_OFFSET(irqd_to_hwirq(data));
+       unsigned long flags;
+
+       raw_spin_lock_irqsave(&soc->lock, flags);
+       writel_relaxed(0x1 << offset, gpio_base + GPIO_IC_OFFSET);
+       raw_spin_unlock_irqrestore(&soc->lock, flags);
+}
+
+static void amb_gpio_irq_mask(struct irq_data *data)
+{
+       struct gpio_chip *gc =3D irq_data_get_irq_chip_data(data);
+       struct amb_pinctrl_soc_data *soc =3D gpiochip_get_data(gc);
+       void __iomem *gpio_base =3D amb_get_gpio_base(soc, data);
+       u32 offset, ie;
+       unsigned long flags;
+
+       offset =3D PINID_TO_OFFSET(irqd_to_hwirq(data));
+
+       raw_spin_lock_irqsave(&soc->lock, flags);
+       ie =3D readl_relaxed(gpio_base + GPIO_IE_OFFSET);
+       writel_relaxed(ie & ~(0x1 << offset), gpio_base + GPIO_IE_OFFSET);
+       raw_spin_unlock_irqrestore(&soc->lock, flags);
+}
+
+static void amb_gpio_irq_mask_ack(struct irq_data *data)
+{
+       struct gpio_chip *gc =3D irq_data_get_irq_chip_data(data);
+       struct amb_pinctrl_soc_data *soc =3D gpiochip_get_data(gc);
+       void __iomem *gpio_base =3D amb_get_gpio_base(soc, data);
+       u32 offset, ie;
+       unsigned long flags;
+
+       offset =3D PINID_TO_OFFSET(irqd_to_hwirq(data));
+
+       raw_spin_lock_irqsave(&soc->lock, flags);
+       ie =3D readl_relaxed(gpio_base + GPIO_IE_OFFSET);
+       writel_relaxed(ie & ~(0x1 << offset), gpio_base + GPIO_IE_OFFSET);
+       writel_relaxed(0x1 << offset, gpio_base + GPIO_IC_OFFSET);
+       raw_spin_unlock_irqrestore(&soc->lock, flags);
+}
+
+static void amb_gpio_irq_unmask(struct irq_data *data)
+{
+       struct gpio_chip *gc =3D irq_data_get_irq_chip_data(data);
+       struct amb_pinctrl_soc_data *soc =3D gpiochip_get_data(gc);
+       void __iomem *gpio_base =3D amb_get_gpio_base(soc, data);
+       u32 offset, ie;
+       unsigned long flags;
+
+       offset =3D PINID_TO_OFFSET(irqd_to_hwirq(data));
+
+       raw_spin_lock_irqsave(&soc->lock, flags);
+       ie =3D readl_relaxed(gpio_base + GPIO_IE_OFFSET);
+       writel_relaxed(ie | (0x1 << offset), gpio_base + GPIO_IE_OFFSET);
+       raw_spin_unlock_irqrestore(&soc->lock, flags);
+}
+
+static int amb_gpio_irq_set_type(struct irq_data *data, unsigned int type)
+{
+       struct gpio_chip *gc =3D irq_data_get_irq_chip_data(data);
+       struct amb_pinctrl_soc_data *soc =3D gpiochip_get_data(gc);
+       void __iomem *gpio_base =3D amb_get_gpio_base(soc, data);
+       u32 offset =3D PINID_TO_OFFSET(irqd_to_hwirq(data));
+       u32 mask, bit, sense, bothedges, event;
+       unsigned long flags;
+
+       mask =3D ~(0x1 << offset);
+       bit =3D (0x1 << offset);
+       sense =3D readl_relaxed(gpio_base + GPIO_IS_OFFSET);
+       bothedges =3D readl_relaxed(gpio_base + GPIO_IBE_OFFSET);
+       event =3D readl_relaxed(gpio_base + GPIO_IEV_OFFSET);
+
+       switch (type) {
+       case IRQ_TYPE_EDGE_RISING:
+               sense &=3D mask;
+               bothedges &=3D mask;
+               event |=3D bit;
+               irq_set_handler_locked(data, handle_edge_irq);
+               break;
+       case IRQ_TYPE_EDGE_FALLING:
+               sense &=3D mask;
+               bothedges &=3D mask;
+               event &=3D mask;
+               irq_set_handler_locked(data, handle_edge_irq);
+               break;
+       case IRQ_TYPE_EDGE_BOTH:
+               sense &=3D mask;
+               bothedges |=3D bit;
+               event &=3D mask;
+               irq_set_handler_locked(data, handle_edge_irq);
+               break;
+       case IRQ_TYPE_LEVEL_HIGH:
+               sense |=3D bit;
+               bothedges &=3D mask;
+               event |=3D bit;
+               irq_set_handler_locked(data, handle_level_irq);
+               break;
+       case IRQ_TYPE_LEVEL_LOW:
+               sense |=3D bit;
+               bothedges &=3D mask;
+               event &=3D mask;
+               irq_set_handler_locked(data, handle_level_irq);
+               break;
+       default:
+               pr_err("%s: irq[%d] type[%d] fail!\n",
+                      __func__, data->irq, type);
+               return -EINVAL;
+       }
+
+       raw_spin_lock_irqsave(&soc->lock, flags);
+       writel_relaxed(sense, gpio_base + GPIO_IS_OFFSET);
+       writel_relaxed(bothedges, gpio_base + GPIO_IBE_OFFSET);
+       writel_relaxed(event, gpio_base + GPIO_IEV_OFFSET);
+       /* clear obsolete irq */
+       writel_relaxed(0x1 << offset, gpio_base + GPIO_IC_OFFSET);
+       raw_spin_unlock_irqrestore(&soc->lock, flags);
+
+       return 0;
+}
+
+static int amb_gpio_irq_set_wake(struct irq_data *data, unsigned int on)
+{
+       if (IS_ENABLED(CONFIG_PM)) {
+               struct gpio_chip *gc =3D irq_data_get_irq_chip_data(data);
+               struct amb_pinctrl_soc_data *soc =3D gpiochip_get_data(gc);
+               u32 bank =3D PINID_TO_BANK(irqd_to_hwirq(data));
+               u32 offset =3D PINID_TO_OFFSET(irqd_to_hwirq(data));
+               unsigned long flags;
+
+               raw_spin_lock_irqsave(&soc->lock, flags);
+               if (on)
+                       soc->irq_wake_mask[bank] |=3D (1 << offset);
+               else
+                       soc->irq_wake_mask[bank] &=3D ~(1 << offset);
+               raw_spin_unlock_irqrestore(&soc->lock, flags);
+       }
+       return 0;
+}
+
+static struct irq_chip amb_gpio_irqchip =3D {
+       .name           =3D "GPIO",
+       .irq_enable     =3D amb_gpio_irq_enable,
+       .irq_disable    =3D amb_gpio_irq_disable,
+       .irq_ack        =3D amb_gpio_irq_ack,
+       .irq_mask       =3D amb_gpio_irq_mask,
+       .irq_mask_ack   =3D amb_gpio_irq_mask_ack,
+       .irq_unmask     =3D amb_gpio_irq_unmask,
+       .irq_set_type   =3D amb_gpio_irq_set_type,
+       .irq_set_wake   =3D amb_gpio_irq_set_wake,
+       .flags          =3D IRQCHIP_SET_TYPE_MASKED | IRQCHIP_MASK_ON_SUSPE=
ND,
+};
+
+static int amb_gpio_irqdomain_map(struct irq_domain *d, unsigned int irq,
+                                 irq_hw_number_t hwirq)
+{
+       struct amb_pinctrl_soc_data *soc =3D d->host_data;
+
+       irq_set_chip_data(irq, soc->gc);
+       irq_set_chip_and_handler(irq, &amb_gpio_irqchip, handle_level_irq);
+       irq_set_noprobe(irq);
+
+       return 0;
+}
+
+static const struct irq_domain_ops amb_gpio_irq_domain_ops =3D {
+       .map =3D amb_gpio_irqdomain_map,
+       .xlate =3D irq_domain_xlate_twocell,
+};
+
+static void amb_gpio_handle_irq(struct irq_desc *desc)
+{
+       struct amb_pinctrl_soc_data *soc;
+       struct irq_chip *irqchip;
+       u32 i, bit, gpio_mis, gpio_hwirq;
+
+       irqchip =3D irq_desc_get_chip(desc);
+       chained_irq_enter(irqchip, desc);
+
+       soc =3D irq_desc_get_handler_data(desc);
+
+       /* find the GPIO bank generating this irq */
+       for (i =3D 0; i < soc->bank_num; i++) {
+               if (soc->irq[i] =3D=3D irq_desc_get_irq(desc))
+                       break;
+       }
+
+       if (i =3D=3D soc->bank_num)
+               goto out;
+
+       gpio_mis =3D readl_relaxed(soc->gpio_base[i] + GPIO_MIS_OFFSET);
+       while (gpio_mis) {
+               bit =3D __ffs(gpio_mis);
+               gpio_hwirq =3D i * 32 + bit;
+               generic_handle_domain_irq(soc->domain, gpio_hwirq);
+               gpio_mis &=3D ~BIT(bit);
+       }
+
+out:
+       chained_irq_exit(irqchip, desc);
+}
+
+/* register the pinctrl interface with the pinctrl subsystem */
+static int amb_gpio_register(struct amb_pinctrl_soc_data *soc)
+{
+       struct device_node *np;
+       int i, rval =3D -ENODEV;
+
+       for_each_child_of_node(soc->dev->of_node, np) {
+               if (of_find_property(np, "gpio-controller", NULL)) {
+                       rval =3D 0;
+                       break;
+               }
+       }
+       if (rval < 0) {
+               dev_err(soc->dev, "no gpio-controller child node\n");
+               return rval;
+       }
+
+       soc->gc =3D devm_kzalloc(soc->dev, sizeof(struct gpio_chip), GFP_KE=
RNEL);
+       if (!soc->gc)
+               return -ENOMEM;
+       soc->gc->label =3D dev_name(soc->dev);
+       soc->gc->base =3D -1;
+       soc->gc->request =3D gpiochip_generic_request;
+       soc->gc->free =3D gpiochip_generic_free;
+       soc->gc->direction_input =3D amb_gpio_direction_input;
+       soc->gc->direction_output =3D amb_gpio_direction_output;
+       soc->gc->get_direction =3D amb_gpio_get_direction;
+       soc->gc->get =3D amb_gpio_get;
+       soc->gc->set =3D amb_gpio_set;
+       soc->gc->to_irq =3D amb_gpio_to_irq;
+#if IS_ENABLED(CONFIG_DEBUG_FS)
+       soc->gc->dbg_show  =3D amb_gpio_dbg_show;
+#endif
+       soc->gc->parent =3D soc->dev;
+       soc->gc->fwnode =3D of_fwnode_handle(np);
+       soc->gc->ngpio =3D soc->bank_num * 32;
+
+       rval =3D devm_gpiochip_add_data(soc->dev, soc->gc, soc);
+       if (rval) {
+               dev_err(soc->dev, "gpiochip_add_data failed %d\n", rval);
+               return rval;
+       }
+
+       for (i =3D 0; i < soc->bank_num; i++) {
+               writel_relaxed(0xffffffff, soc->gpio_base[i] + GPIO_ENABLE_=
OFFSET);
+               writel_relaxed(0x00000000, soc->gpio_base[i] + GPIO_AFSEL_O=
FFSET);
+               writel_relaxed(0x00000000, soc->gpio_base[i] + GPIO_MASK_OF=
FSET);
+       }
+
+       /* Initialize GPIO irq */
+       soc->domain =3D irq_domain_add_linear(np, soc->gc->ngpio,
+                                           &amb_gpio_irq_domain_ops, soc);
+       if (!soc->domain) {
+               dev_err(soc->dev, "Failed to create irqdomain\n");
+               return -ENODEV;
+       }
+
+       for (i =3D 0; i < soc->bank_num; i++) {
+               irq_set_irq_type(soc->irq[i], IRQ_TYPE_LEVEL_HIGH);
+               irq_set_chained_handler_and_data(soc->irq[i], amb_gpio_hand=
le_irq, soc);
+       }
+
+       return 0;
+}
+
+static int amb_pinctrl_probe(struct platform_device *pdev)
+{
+       struct amb_pinctrl_soc_data *soc;
+       struct device_node *np;
+       int i, rval;
+
+       soc =3D devm_kzalloc(&pdev->dev, sizeof(*soc), GFP_KERNEL);
+       if (!soc)
+               return -ENOMEM;
+
+       soc->dev =3D &pdev->dev;
+       soc->data =3D of_device_get_match_data(&pdev->dev);
+       if (!soc->data)
+               return dev_err_probe(&pdev->dev, -EINVAL, "missing soc data=
");
+
+       np =3D pdev->dev.of_node;
+       soc->bank_num =3D of_irq_count(np);
+       if (!soc->bank_num || soc->bank_num > MAX_BANK_NUM)
+               return dev_err_probe(&pdev->dev, -EINVAL, "Invalid gpio ban=
k(irq)");
+
+       for (i =3D 0; i < soc->bank_num; i++) {
+               soc->gpio_base[i] =3D devm_platform_ioremap_resource(pdev, =
i);
+               if (IS_ERR(soc->gpio_base[i]))
+                       return dev_err_probe(&pdev->dev, PTR_ERR(soc->gpio_=
base[i]),
+                                                                "couldn't =
get gpio[%d] reg", i);
+
+               soc->irq[i] =3D platform_get_irq(pdev, i);
+               if (soc->irq[i] < 0)
+                       return dev_err_probe(&pdev->dev, -ENODEV, "couldn't=
 get gpio[%d] irq", i);
+       }
+
+       soc->iomux_base =3D devm_platform_ioremap_resource(pdev, i);
+       if (IS_ERR(soc->iomux_base))
+               return dev_err_probe(&pdev->dev, PTR_ERR(soc->iomux_base),
+                                                        "couldn't get iomu=
x reg");
+
+       soc->ds_regmap =3D syscon_regmap_lookup_by_phandle(np, "ambarella,d=
rive-strength-syscon");
+       if (IS_ERR(soc->ds_regmap))
+               return dev_err_probe(&pdev->dev, PTR_ERR(soc->ds_regmap),
+                                    "couldn't get drive-strength regmap");
+
+       soc->pull_regmap =3D syscon_regmap_lookup_by_phandle(np, "ambarella=
,pull-syscon");
+       if (IS_ERR(soc->pull_regmap))
+               return dev_err_probe(&pdev->dev, PTR_ERR(soc->pull_regmap),
+                                    "couldn't get pull regmap");
+
+       for (i =3D 0; i < soc->bank_num; i++) {
+               soc->ds0[i] =3D soc->data->ds0[i];
+               soc->ds1[i] =3D soc->data->ds1[i];
+               soc->ds2[i] =3D soc->data->ds2[i];
+               soc->pull_en[i] =3D soc->data->pull_en[i];
+               soc->pull_dir[i] =3D soc->data->pull_dir[i];
+       }
+
+       soc->have_ds2 =3D soc->data->have_ds2;
+       soc->hsm_domain_id =3D soc->data->hsm_domain_id;
+       soc->clk_au_dedicated_pin =3D soc->data->clk_au_dedicated_pin;
+
+       raw_spin_lock_init(&soc->lock);
+
+       /* not allowed to use for non-existed pins */
+       for (i =3D soc->bank_num * 32; i < MAX_BANK_NUM * 32; i++)
+               set_bit(i, soc->used);
+
+       if (soc->clk_au_dedicated_pin)
+               clear_bit(soc->clk_au_dedicated_pin, soc->used);
+
+       rval =3D amb_pinctrl_register(soc);
+       if (rval)
+               return dev_err_probe(&pdev->dev, rval, "pinctrl register fa=
iled!");
+
+       rval =3D amb_gpio_register(soc);
+       if (rval)
+               return dev_err_probe(&pdev->dev, rval, "gpio register faile=
d!");
+
+       platform_set_drvdata(pdev, soc);
+       dev_info(&pdev->dev, "Ambarella pinctrl driver registered");
+
+       return 0;
+}
+
+static int amb_pinctrl_suspend_noirq(struct device *dev)
+{
+       struct amb_pinctrl_soc_data *soc =3D dev_get_drvdata(dev);
+       u32 i;
+
+       for (i =3D 0; i < soc->bank_num; i++) {
+               regmap_read(soc->pull_regmap, soc->pull_en[i], &soc->pm[i].=
pull[0]);
+               regmap_read(soc->pull_regmap, soc->pull_dir[i], &soc->pm[i]=
.pull[1]);
+
+               regmap_read(soc->ds_regmap, soc->ds0[i], &soc->pm[i].ds[0])=
;
+               regmap_read(soc->ds_regmap, soc->ds1[i], &soc->pm[i].ds[1])=
;
+               if (soc->have_ds2)
+                       regmap_read(soc->ds_regmap, soc->ds2[i], &soc->pm[i=
].ds[2]);
+
+               soc->pm[i].iomux[0] =3D readl_relaxed(soc->iomux_base + IOM=
UX_OFFSET(i, 0));
+               soc->pm[i].iomux[1] =3D readl_relaxed(soc->iomux_base + IOM=
UX_OFFSET(i, 1));
+               soc->pm[i].iomux[2] =3D readl_relaxed(soc->iomux_base + IOM=
UX_OFFSET(i, 2));
+
+               soc->pm[i].afsel =3D readl_relaxed(soc->gpio_base[i] + GPIO=
_AFSEL_OFFSET);
+               soc->pm[i].dir =3D readl_relaxed(soc->gpio_base[i] + GPIO_D=
IR_OFFSET);
+               soc->pm[i].is =3D readl_relaxed(soc->gpio_base[i] + GPIO_IS=
_OFFSET);
+               soc->pm[i].ibe =3D readl_relaxed(soc->gpio_base[i] + GPIO_I=
BE_OFFSET);
+               soc->pm[i].iev =3D readl_relaxed(soc->gpio_base[i] + GPIO_I=
EV_OFFSET);
+               soc->pm[i].ie =3D readl_relaxed(soc->gpio_base[i] + GPIO_IE=
_OFFSET);
+               soc->pm[i].mask =3D readl_relaxed(soc->gpio_base[i] + GPIO_=
MASK_OFFSET);
+               writel_relaxed(0xffffffff, soc->gpio_base[i] + GPIO_MASK_OF=
FSET);
+               soc->pm[i].data =3D readl_relaxed(soc->gpio_base[i] + GPIO_=
DATA_OFFSET);
+
+               if (soc->irq_wake_mask[i])
+                       writel_relaxed(soc->irq_wake_mask[i], soc->gpio_bas=
e[i] + GPIO_IE_OFFSET);
+       }
+
+       if (soc->clk_au_dedicated_pin) {
+               i =3D PINID_TO_BANK(soc->clk_au_dedicated_pin);
+               soc->pm[i].iomux[0] =3D readl_relaxed(soc->iomux_base + IOM=
UX_OFFSET(i, 0));
+               soc->pm[i].iomux[1] =3D readl_relaxed(soc->iomux_base + IOM=
UX_OFFSET(i, 1));
+               soc->pm[i].iomux[2] =3D readl_relaxed(soc->iomux_base + IOM=
UX_OFFSET(i, 2));
+       }
+
+       return 0;
+}
+
+static int amb_pinctrl_resume_noirq(struct device *dev)
+{
+       struct amb_pinctrl_soc_data *soc =3D dev_get_drvdata(dev);
+       u32 i;
+
+       for (i =3D 0; i < soc->bank_num; i++) {
+               regmap_write(soc->pull_regmap, soc->pull_en[i], soc->pm[i].=
pull[0]);
+               regmap_write(soc->pull_regmap, soc->pull_dir[i], soc->pm[i]=
.pull[1]);
+
+               regmap_write(soc->ds_regmap, soc->ds0[i], soc->pm[i].ds[0])=
;
+               regmap_write(soc->ds_regmap, soc->ds1[i], soc->pm[i].ds[1])=
;
+               if (soc->have_ds2)
+                       regmap_write(soc->ds_regmap, soc->ds2[i], soc->pm[i=
].ds[2]);
+
+               writel_relaxed(soc->pm[i].iomux[0], soc->iomux_base + IOMUX=
_OFFSET(i, 0));
+               writel_relaxed(soc->pm[i].iomux[1], soc->iomux_base + IOMUX=
_OFFSET(i, 1));
+               writel_relaxed(soc->pm[i].iomux[2], soc->iomux_base + IOMUX=
_OFFSET(i, 2));
+
+               writel_relaxed(soc->pm[i].afsel, soc->gpio_base[i] + GPIO_A=
FSEL_OFFSET);
+               writel_relaxed(soc->pm[i].dir, soc->gpio_base[i] + GPIO_DIR=
_OFFSET);
+               /* Expose DATA writes while restoring the saved GPIO state.=
 */
+               writel_relaxed(0xffffffff,
+                              soc->gpio_base[i] + GPIO_MASK_OFFSET);
+               writel_relaxed(soc->pm[i].data, soc->gpio_base[i] + GPIO_DA=
TA_OFFSET);
+               /* Ensure DATA restore reaches hardware before restoring ma=
sk. */
+               wmb();
+               writel_relaxed(soc->pm[i].mask, soc->gpio_base[i] + GPIO_MA=
SK_OFFSET);
+               writel_relaxed(soc->pm[i].is, soc->gpio_base[i] + GPIO_IS_O=
FFSET);
+               writel_relaxed(soc->pm[i].ibe, soc->gpio_base[i] + GPIO_IBE=
_OFFSET);
+               writel_relaxed(soc->pm[i].iev, soc->gpio_base[i] + GPIO_IEV=
_OFFSET);
+               writel_relaxed(soc->pm[i].ie, soc->gpio_base[i] + GPIO_IE_O=
FFSET);
+               writel_relaxed(0xffffffff, soc->gpio_base[i] + GPIO_ENABLE_=
OFFSET);
+       }
+
+       if (soc->clk_au_dedicated_pin) {
+               i =3D PINID_TO_BANK(soc->clk_au_dedicated_pin);
+               writel_relaxed(soc->pm[i].iomux[0], soc->iomux_base + IOMUX=
_OFFSET(i, 0));
+               writel_relaxed(soc->pm[i].iomux[1], soc->iomux_base + IOMUX=
_OFFSET(i, 1));
+               writel_relaxed(soc->pm[i].iomux[2], soc->iomux_base + IOMUX=
_OFFSET(i, 2));
+               /* Ensure dedicated-pin iomux writes reach hardware before =
commit. */
+               wmb();
+       }
+
+       writel_relaxed(0x1, soc->iomux_base + IOMUX_CTRL_SET_OFFSET);
+       writel_relaxed(0x0, soc->iomux_base + IOMUX_CTRL_SET_OFFSET);
+
+       return 0;
+}
+
+static DEFINE_NOIRQ_DEV_PM_OPS(amb_pinctrl_pm_ops,
+                              amb_pinctrl_suspend_noirq,
+                              amb_pinctrl_resume_noirq);
+
+static const struct amb_pinctrl_data cv75_pinctrl_data =3D {
+       .ds0 =3D {
+               0x314, 0x320, 0x32c,
+       },
+       .ds1 =3D {
+               0x318, 0x324, 0x330,
+       },
+       .ds2 =3D {
+               0x31c, 0x328, 0x334,
+       },
+       .pull_en =3D {
+               0x60, 0x64, 0x68,
+       },
+       .pull_dir =3D {
+               0x7c, 0x80, 0x84,
+       },
+       .have_ds2 =3D true,
+       .clk_au_dedicated_pin =3D 96,
+};
+
+static const struct of_device_id amb_pinctrl_dt_match[] =3D {
+       {
+               .compatible =3D "ambarella,cv75-pinctrl",
+               .data =3D &cv75_pinctrl_data,
+       },
+       {},
+};
+MODULE_DEVICE_TABLE(of, amb_pinctrl_dt_match);
+
+static void amb_pinctrl_remove(struct platform_device *pdev)
+{
+       struct amb_pinctrl_soc_data *soc =3D platform_get_drvdata(pdev);
+       unsigned int i;
+
+       for (i =3D 0; i < soc->bank_num; i++)
+               irq_set_chained_handler_and_data(soc->irq[i], NULL, NULL);
+
+       if (soc->domain)
+               irq_domain_remove(soc->domain);
+}
+
+static struct platform_driver amb_pinctrl_driver =3D {
+       .probe  =3D amb_pinctrl_probe,
+       .remove =3D amb_pinctrl_remove,
+       .driver =3D {
+               .name   =3D "ambarella-pinctrl",
+               .of_match_table =3D of_match_ptr(amb_pinctrl_dt_match),
+               .pm =3D pm_sleep_ptr(&amb_pinctrl_pm_ops),
+       },
+};
+
+static int __init amb_pinctrl_drv_register(void)
+{
+       return platform_driver_register(&amb_pinctrl_driver);
+}
+arch_initcall(amb_pinctrl_drv_register);
+
+MODULE_AUTHOR("Cao Rongrong <rrcao@ambarella.com>");
+MODULE_DESCRIPTION("Ambarella SoC pinctrl driver");
+MODULE_LICENSE("GPL");
--
2.34.1

NOTE: This email (including attachments) contain Ambarella Proprietary and/=
or Confidential Information and is intended solely for the use of the indiv=
idual(s) to whom it is addressed. Any unauthorized review, use, disclosure,=
 distribute, copy, or print is prohibited. If you are not an intended recip=
ient, please contact the sender by reply email and destroy all copies of th=
e original message. Thank you.
