Return-Path: <SRS0=HiSo=DU=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 450DBC43467
	for <linux-serial@archiver.kernel.org>; Tue, 13 Oct 2020 14:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D57B224890
	for <linux-serial@archiver.kernel.org>; Tue, 13 Oct 2020 14:46:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=antmicro.com header.i=@antmicro.com header.b="ArYIHa/U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389350AbgJMOqA (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 13 Oct 2020 10:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389320AbgJMOqA (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 13 Oct 2020 10:46:00 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC808C0613D5
        for <linux-serial@vger.kernel.org>; Tue, 13 Oct 2020 07:45:59 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id c21so4316746ljj.0
        for <linux-serial@vger.kernel.org>; Tue, 13 Oct 2020 07:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=antmicro.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=b71QFZGMVhFJ2FKe4vMwlhrEgovb+AG1iRKQYzIzJFA=;
        b=ArYIHa/UUbT1afr6WWz+wsIs3AW/KyTGKOB9kQ+JWmQvPi47ZuSpjG7DEdpAkNgIun
         kefOBM+76S+rvobsG1mk40eNM4Z3nQbAblsfY2fIblXGaxvYxB9fehzi2xMPmg0V+OAQ
         kyPhd+VnHDaproaw0DJM4FFiQoxXRGKZrRg6g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=b71QFZGMVhFJ2FKe4vMwlhrEgovb+AG1iRKQYzIzJFA=;
        b=CdMZFVAGyqVZJWaI/WLP04FKQPf7ljc/2Hdtd/P5dLYamu3N5ES7BLyadmcgXEe5b9
         AJ6qNLit8kK+88tw3/ERtNOuTHH/7EbHPPjJoiYk6dZQA8eNaiyRUwBnF+abDORMRreH
         pNajbwGs3EEU7b/uZ+jjSzaegulD2/sbAVeYb5JInl1LUh9X3q+dnXLjcy6wniYy4/fK
         3VtxS2OzEjEtipHTsUXvj2s2WYfRQh+469CCqzXT8KAmyeibAMTr+GAwDnveDquwhTlX
         eQPOQmTlRVbo5JnYko6OQiwtiKblA2RxZ/eCDJ2hGQu13vnTA2MzLL1XLyMzBeDSjFs0
         1vZQ==
X-Gm-Message-State: AOAM532xFcx2t2UImxDI8SohXZaxkVemhU0tnepq2SyLPjyP5au9f8v0
        RBOoZ+wiWxb6WNcW9Hlt4nVtAA==
X-Google-Smtp-Source: ABdhPJwBxInBc7wEOBtBkIWVrsm9fvrVqo6Mjeky91c/jca0SF/midKpwwc0WlO9U4YOUocaIsraVA==
X-Received: by 2002:a2e:7815:: with SMTP id t21mr12065554ljc.217.1602600358032;
        Tue, 13 Oct 2020 07:45:58 -0700 (PDT)
Received: from localhost.localdomain (d79-196.icpnet.pl. [77.65.79.196])
        by smtp.gmail.com with ESMTPSA id v13sm3957561ljh.66.2020.10.13.07.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 07:45:57 -0700 (PDT)
Date:   Tue, 13 Oct 2020 16:45:52 +0200
From:   Mateusz Holenko <mholenko@antmicro.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org
Cc:     Stafford Horne <shorne@gmail.com>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Filip Kokosinski <fkokosinski@antmicro.com>,
        Pawel Czarnecki <pczarnecki@internships.antmicro.com>,
        Joel Stanley <joel@jms.id.au>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Maxime Ripard <mripard@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org, "Gabriel L. Somlo" <gsomlo@gmail.com>
Subject: [PATCH v12 3/5] drivers/soc/litex: add LiteX SoC Controller driver
Message-ID: <20201013164454.2002023-3-mholenko@antmicro.com>
References: <20201013164454.2002023-0-mholenko@antmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201013164454.2002023-0-mholenko@antmicro.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Pawel Czarnecki <pczarnecki@internships.antmicro.com>

This commit adds driver for the FPGA-based LiteX SoC
Controller from LiteX SoC builder.

Co-developed-by: Mateusz Holenko <mholenko@antmicro.com>
Signed-off-by: Mateusz Holenko <mholenko@antmicro.com>
Signed-off-by: Pawel Czarnecki <pczarnecki@internships.antmicro.com>
---

Notes:
    Changes in v12:
    - removed unnecssary WARN on a failed validation (panic is enough)
    - simplified probe implementation
    - introduced litex_{read,write}{8,16,32,64}() fast accessors
    - added formal documentation of litex_get_reg()/litex_set_reg()
    - added LITEX config symbol
    - removed unnecessary header include
    - removed spin locks from CSR accessors

    Changes in v11:
    - removed an unnecessary comment left over from previous version
    - changed a multi-line comment to comply with the formatting rules
    - use WARN instad of BUG on a failed CSR validation

    Changes in v10:
    - added casting to avoid sparse warnings in the SoC Controller's driver
    
    Changes in v9:
    - added exporting of the `litex_set_reg`/`litex_get_reg` symbols

    Changes in v8:
    - removed `litex_check_accessors()` helper function
    - added crashing (BUG) on the failed LiteX CSR access test

    No changes in v7.

    Changes in v6:
    - added dependency on OF || COMPILE_TEST
    - used le32_to_cpu(readl(addr)) instead of __raw_readl
      and writel(cpu_to_le32(value), addr) instead of __raw_writel
      to take advantage of memory barriers provided by readl/writel

    Changes in v5:
    - removed helper accessors and used __raw_readl/__raw_writel instead
    - fixed checking for errors in litex_soc_ctrl_probe

    Changes in v4:
    - fixed indent in Kconfig's help section
    - fixed copyright header
    - changed compatible to "litex,soc-controller"
    - simplified litex_soc_ctrl_probe
    - removed unnecessary litex_soc_ctrl_remove
   
    This commit has been introduced in v3 of the patchset.
    
    It includes a simplified version of common 'litex.h'
    header introduced in v2 of the patchset.

 MAINTAINERS                        |   2 +
 drivers/soc/Kconfig                |   1 +
 drivers/soc/Makefile               |   1 +
 drivers/soc/litex/Kconfig          |  19 ++++
 drivers/soc/litex/Makefile         |   3 +
 drivers/soc/litex/litex_soc_ctrl.c | 178 +++++++++++++++++++++++++++++
 include/linux/litex.h              | 103 ++++++++++++++++
 7 files changed, 307 insertions(+)
 create mode 100644 drivers/soc/litex/Kconfig
 create mode 100644 drivers/soc/litex/Makefile
 create mode 100644 drivers/soc/litex/litex_soc_ctrl.c
 create mode 100644 include/linux/litex.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 39be98db7418..4d70a1b22a87 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9840,6 +9840,8 @@ M:	Karol Gugala <kgugala@antmicro.com>
 M:	Mateusz Holenko <mholenko@antmicro.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/*/litex,*.yaml
+F:	drivers/soc/litex/litex_soc_ctrl.c
+F:	include/linux/litex.h
 
 LIVE PATCHING
 M:	Josh Poimboeuf <jpoimboe@redhat.com>
diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
index 425ab6f7e375..d097d070f579 100644
--- a/drivers/soc/Kconfig
+++ b/drivers/soc/Kconfig
@@ -9,6 +9,7 @@ source "drivers/soc/bcm/Kconfig"
 source "drivers/soc/fsl/Kconfig"
 source "drivers/soc/imx/Kconfig"
 source "drivers/soc/ixp4xx/Kconfig"
+source "drivers/soc/litex/Kconfig"
 source "drivers/soc/mediatek/Kconfig"
 source "drivers/soc/qcom/Kconfig"
 source "drivers/soc/renesas/Kconfig"
diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
index 36452bed86ef..0b16108823ef 100644
--- a/drivers/soc/Makefile
+++ b/drivers/soc/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_ARCH_GEMINI)	+= gemini/
 obj-y				+= imx/
 obj-$(CONFIG_ARCH_IXP4XX)	+= ixp4xx/
 obj-$(CONFIG_SOC_XWAY)		+= lantiq/
+obj-$(CONFIG_LITEX_SOC_CONTROLLER) += litex/
 obj-y				+= mediatek/
 obj-y				+= amlogic/
 obj-y				+= qcom/
diff --git a/drivers/soc/litex/Kconfig b/drivers/soc/litex/Kconfig
new file mode 100644
index 000000000000..c974ec3846bc
--- /dev/null
+++ b/drivers/soc/litex/Kconfig
@@ -0,0 +1,19 @@
+# SPDX-License_Identifier: GPL-2.0
+
+menu "Enable LiteX SoC Builder specific drivers"
+
+config LITEX
+	bool
+
+config LITEX_SOC_CONTROLLER
+	tristate "Enable LiteX SoC Controller driver"
+	depends on OF || COMPILE_TEST
+	select LITEX
+	help
+	  This option enables the SoC Controller Driver which verifies
+	  LiteX CSR access and provides common litex_get_reg/litex_set_reg
+	  accessors.
+	  All drivers that use functions from litex.h must depend on
+	  LITEX.
+
+endmenu
diff --git a/drivers/soc/litex/Makefile b/drivers/soc/litex/Makefile
new file mode 100644
index 000000000000..98ff7325b1c0
--- /dev/null
+++ b/drivers/soc/litex/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License_Identifier: GPL-2.0
+
+obj-$(CONFIG_LITEX_SOC_CONTROLLER)	+= litex_soc_ctrl.o
diff --git a/drivers/soc/litex/litex_soc_ctrl.c b/drivers/soc/litex/litex_soc_ctrl.c
new file mode 100644
index 000000000000..08330c9872b0
--- /dev/null
+++ b/drivers/soc/litex/litex_soc_ctrl.c
@@ -0,0 +1,176 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * LiteX SoC Controller Driver
+ *
+ * Copyright (C) 2020 Antmicro <www.antmicro.com>
+ *
+ */
+
+#include <linux/litex.h>
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/printk.h>
+#include <linux/module.h>
+#include <linux/errno.h>
+#include <linux/io.h>
+
+/*
+ * LiteX SoC Generator, depending on the configuration, can split a single
+ * logical CSR (Control&Status Register) into a series of consecutive physical
+ * registers.
+ *
+ * For example, in the configuration with 8-bit CSR Bus, 32-bit aligned (the
+ * default one for 32-bit CPUs) a 32-bit logical CSR will be generated as four
+ * 32-bit physical registers, each one containing one byte of meaningful data.
+ *
+ * For details see: https://github.com/enjoy-digital/litex/wiki/CSR-Bus
+ *
+ * The purpose of `litex_set_reg`/`litex_get_reg` is to implement the logic
+ * of writing to/reading from the LiteX CSR in a single place that can be
+ * then reused by all LiteX drivers.
+ */
+
+/**
+ * litex_set_reg() - Writes the value to the LiteX CSR (Control&Status Register)
+ * @reg: Address of the CSR
+ * @reg_size: The width of the CSR expressed in the number of bytes
+ * @val: Value to be written to the CSR
+ *
+ * In the currently supported LiteX configuration (8-bit CSR Bus, 32-bit aligned),
+ * a 32-bit LiteX CSR is generated as 4 consecutive 32-bit physical registers,
+ * each one containing one byte of meaningful data.
+ *
+ * This function splits a single possibly multi-byte write into a series of
+ * single-byte writes with a proper offset.
+ */
+void litex_set_reg(void __iomem *reg, unsigned long reg_size,
+		    unsigned long val)
+{
+	unsigned long shifted_data, shift, i;
+
+	for (i = 0; i < reg_size; ++i) {
+		shift = ((reg_size - i - 1) * LITEX_SUBREG_SIZE_BIT);
+		shifted_data = val >> shift;
+
+		WRITE_LITEX_SUBREGISTER(shifted_data, reg, i);
+	}
+}
+EXPORT_SYMBOL_GPL(litex_set_reg);
+
+/**
+ * litex_get_reg() - Reads the value of the LiteX CSR (Control&Status Register)
+ * @reg: Address of the CSR
+ * @reg_size: The width of the CSR expressed in the number of bytes
+ *
+ * Return: Value read from the CSR
+ *
+ * In the currently supported LiteX configuration (8-bit CSR Bus, 32-bit aligned),
+ * a 32-bit LiteX CSR is generated as 4 consecutive 32-bit physical registers,
+ * each one containing one byte of meaningful data.
+ *
+ * This function generates a series of single-byte reads with a proper offset
+ * and joins their results into a single multi-byte value.
+ */
+unsigned long litex_get_reg(void __iomem *reg, unsigned long reg_size)
+{
+	unsigned long shifted_data, shift, i;
+	unsigned long result = 0;
+
+	for (i = 0; i < reg_size; ++i) {
+		shifted_data = READ_LITEX_SUBREGISTER(reg, i);
+
+		shift = ((reg_size - i - 1) * LITEX_SUBREG_SIZE_BIT);
+		result |= (shifted_data << shift);
+	}
+
+	return result;
+}
+EXPORT_SYMBOL_GPL(litex_get_reg);
+
+#define SCRATCH_REG_OFF         0x04
+#define SCRATCH_REG_VALUE       0x12345678
+#define SCRATCH_TEST_VALUE      0xdeadbeef
+
+/*
+ * Check LiteX CSR read/write access
+ *
+ * This function reads and writes a scratch register in order to verify if CSR
+ * access works.
+ *
+ * In case any problems are detected, the driver should panic.
+ *
+ * Access to the LiteX CSR is, by design, done in CPU native endianness.
+ * The driver should not dynamically configure access functions when
+ * the endianness mismatch is detected. Such situation indicates problems in
+ * the soft SoC design and should be solved at the LiteX generator level,
+ * not in the software.
+ */
+static int litex_check_csr_access(void __iomem *reg_addr)
+{
+	unsigned long reg;
+
+	reg = litex_read32(reg_addr + SCRATCH_REG_OFF);
+
+	if (reg != SCRATCH_REG_VALUE) {
+		panic("Scratch register read error - the system is probably broken! Expected: 0x%x but got: 0x%lx",
+			SCRATCH_REG_VALUE, reg);
+		return -EINVAL;
+	}
+
+	litex_write32(reg_addr + SCRATCH_REG_OFF, SCRATCH_TEST_VALUE);
+	reg = litex_read32(reg_addr + SCRATCH_REG_OFF);
+
+	if (reg != SCRATCH_TEST_VALUE) {
+		panic("Scratch register write error - the system is probably broken! Expected: 0x%x but got: 0x%lx",
+			SCRATCH_TEST_VALUE, reg);
+		return -EINVAL;
+	}
+
+	/* restore original value of the SCRATCH register */
+	litex_write32(reg_addr + SCRATCH_REG_OFF, SCRATCH_REG_VALUE);
+
+	pr_info("LiteX SoC Controller driver initialized");
+
+	return 0;
+}
+
+struct litex_soc_ctrl_device {
+	void __iomem *base;
+};
+
+static const struct of_device_id litex_soc_ctrl_of_match[] = {
+	{.compatible = "litex,soc-controller"},
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, litex_soc_ctrl_of_match);
+
+static int litex_soc_ctrl_probe(struct platform_device *pdev)
+{
+	struct litex_soc_ctrl_device *soc_ctrl_dev;
+
+	soc_ctrl_dev = devm_kzalloc(&pdev->dev, sizeof(*soc_ctrl_dev), GFP_KERNEL);
+	if (!soc_ctrl_dev)
+		return -ENOMEM;
+
+	soc_ctrl_dev->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(soc_ctrl_dev->base))
+		return PTR_ERR(soc_ctrl_dev->base);
+
+	return litex_check_csr_access(soc_ctrl_dev->base);
+}
+
+static struct platform_driver litex_soc_ctrl_driver = {
+	.driver = {
+		.name = "litex-soc-controller",
+		.of_match_table = of_match_ptr(litex_soc_ctrl_of_match)
+	},
+	.probe = litex_soc_ctrl_probe,
+};
+
+module_platform_driver(litex_soc_ctrl_driver);
+MODULE_DESCRIPTION("LiteX SoC Controller driver");
+MODULE_AUTHOR("Antmicro <www.antmicro.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/litex.h b/include/linux/litex.h
new file mode 100644
index 000000000000..72061018c172
--- /dev/null
+++ b/include/linux/litex.h
@@ -0,0 +1,102 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Common LiteX header providing
+ * helper functions for accessing CSRs.
+ *
+ * Implementation of the functions is provided by
+ * the LiteX SoC Controller driver.
+ *
+ * Copyright (C) 2019-2020 Antmicro <www.antmicro.com>
+ */
+
+#ifndef _LINUX_LITEX_H
+#define _LINUX_LITEX_H
+
+#include <linux/io.h>
+#include <linux/types.h>
+#include <linux/compiler_types.h>
+
+/*
+ * The parameters below are true for LiteX SoCs configured for 8-bit CSR Bus,
+ * 32-bit aligned.
+ *
+ * Supporting other configurations will require extending the logic in this
+ * header and in the LiteX SoC controller driver.
+ */
+#define LITEX_REG_SIZE	  0x4
+#define LITEX_SUBREG_SIZE	0x1
+#define LITEX_SUBREG_SIZE_BIT	 (LITEX_SUBREG_SIZE * 8)
+
+#define WRITE_LITEX_SUBREGISTER(val, base_offset, subreg_id) \
+	writel((u32 __force)cpu_to_le32(val), base_offset + (LITEX_REG_SIZE * subreg_id))
+
+#define READ_LITEX_SUBREGISTER(base_offset, subreg_id) \
+	le32_to_cpu((__le32 __force)readl(base_offset + (LITEX_REG_SIZE * subreg_id)))
+
+void litex_set_reg(void __iomem *reg, unsigned long reg_sz, unsigned long val);
+
+unsigned long litex_get_reg(void __iomem *reg, unsigned long reg_sz);
+
+static inline void litex_write8(void __iomem *reg, u8 val)
+{
+	WRITE_LITEX_SUBREGISTER(val, reg, 0);
+}
+
+static inline void litex_write16(void __iomem *reg, u16 val)
+{
+	WRITE_LITEX_SUBREGISTER(val >> 8, reg, 0);
+	WRITE_LITEX_SUBREGISTER(val, reg, 1);
+}
+
+static inline void litex_write32(void __iomem *reg, u32 val)
+{
+	WRITE_LITEX_SUBREGISTER(val >> 24, reg, 0);
+	WRITE_LITEX_SUBREGISTER(val >> 16, reg, 1);
+	WRITE_LITEX_SUBREGISTER(val >> 8, reg, 2);
+	WRITE_LITEX_SUBREGISTER(val, reg, 3);
+}
+
+static inline void litex_write64(void __iomem *reg, u64 val)
+{
+	WRITE_LITEX_SUBREGISTER(val >> 56, reg, 0);
+	WRITE_LITEX_SUBREGISTER(val >> 48, reg, 1);
+	WRITE_LITEX_SUBREGISTER(val >> 40, reg, 2);
+	WRITE_LITEX_SUBREGISTER(val >> 32, reg, 3);
+	WRITE_LITEX_SUBREGISTER(val >> 24, reg, 4);
+	WRITE_LITEX_SUBREGISTER(val >> 16, reg, 5);
+	WRITE_LITEX_SUBREGISTER(val >> 8, reg, 6);
+	WRITE_LITEX_SUBREGISTER(val, reg, 7);
+}
+
+static inline u8 litex_read8(void __iomem *reg)
+{
+	return READ_LITEX_SUBREGISTER(reg, 0);
+}
+
+static inline u16 litex_read16(void __iomem *reg)
+{
+	return (READ_LITEX_SUBREGISTER(reg, 0) << 8)
+		| (READ_LITEX_SUBREGISTER(reg, 1));
+}
+
+static inline u32 litex_read32(void __iomem *reg)
+{
+	return (READ_LITEX_SUBREGISTER(reg, 0) << 24)
+		| (READ_LITEX_SUBREGISTER(reg, 1) << 16)
+		| (READ_LITEX_SUBREGISTER(reg, 2) << 8)
+		| (READ_LITEX_SUBREGISTER(reg, 3));
+}
+
+static inline u64 litex_read64(void __iomem *reg)
+{
+	return ((u64)READ_LITEX_SUBREGISTER(reg, 0) << 56)
+		| ((u64)READ_LITEX_SUBREGISTER(reg, 1) << 48)
+		| ((u64)READ_LITEX_SUBREGISTER(reg, 2) << 40)
+		| ((u64)READ_LITEX_SUBREGISTER(reg, 3) << 32)
+		| ((u64)READ_LITEX_SUBREGISTER(reg, 4) << 24)
+		| ((u64)READ_LITEX_SUBREGISTER(reg, 5) << 16)
+		| ((u64)READ_LITEX_SUBREGISTER(reg, 6) << 8)
+		| ((u64)READ_LITEX_SUBREGISTER(reg, 7));
+}
+
+#endif /* _LINUX_LITEX_H */
-- 
2.25.1

