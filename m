Return-Path: <SRS0=8zSm=4N=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF2DEC35DF9
	for <linux-serial@archiver.kernel.org>; Tue, 25 Feb 2020 09:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DB1821556
	for <linux-serial@archiver.kernel.org>; Tue, 25 Feb 2020 09:25:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="CNrpU/ek";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pzyggnDL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729934AbgBYJZ6 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 25 Feb 2020 04:25:58 -0500
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:47121 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729864AbgBYJZ5 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 25 Feb 2020 04:25:57 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id BC1BC78F3;
        Tue, 25 Feb 2020 04:25:55 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 25 Feb 2020 04:25:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=nki7hg+DLb+LW3cxP+SwROR+cnJ
        R+MqfxqVnGr2duAA=; b=CNrpU/ekmicNTXjrXMK46MT/xoYrxQRasvQkHmHlaCB
        MJiZIcVRwR3T+kNFNgEAyi5u8YFQSGn1pnMCtbjhrukLwTxNfdT7ZB5zn5RouLFW
        sLX+VZy7ewKSf6/6Dbujh8FDGa1Gv4diAQUvZ5ZKhxnr9jOKJxFZbO541f1DhKgm
        EL50uJE09tJXVYYivijufgu8g4Hj7nT8b3tJqG1sGo7FqqTjyxLd24bLBTKm8ENH
        pz9kuNoD7dH6KQp+T2krihVszTiuMEZjFbYkZh1ByiguCZslhxO4RadvVaExUcsy
        1TI1IY/Wdtzw+gtgNSPLCLQS6HcVuldf3PyoK9JjNAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=nki7hg
        +DLb+LW3cxP+SwROR+cnJR+MqfxqVnGr2duAA=; b=pzyggnDLON+Vs2GFqxRNJW
        FKsEt0jeWnLbt/t7zYN7btoC3Dw0dI8Y73ADrRkOekeD1D4SVPfhVIqmOD/YqTDp
        T/dlkiBHLogjUKRHyfGpAGnt5oNYsnypKGEoT+Nigl21nUb6ewUqaydtdSToKTYF
        sEUJP3VZUDpoJGLsb/klWdskyZrDJsoXmrcugrCJg/MktenkhXEJJUVypRpNz0FW
        on4OA6R24HyKi0qa9kPsxSdIcMpLaPXmLOzOIv/fHKC403l3Oz7kKhgNZdxn+zuP
        +AzVh6bWsRVd/nb/GXmb81cuxUk2vE65eXaEjuhxcu+ZFzpG5tDsuFdWlG5bV9Kg
        ==
X-ME-Sender: <xms:IehUXku5uA3VwPmYClCAmrDxOEnq_hVOW3k8-FUU81GG0dCDcusH4w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrledvgddtfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucffohhmrghinh
    epghhithhhuhgsrdgtohhmnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnh
    hordhtvggthh
X-ME-Proxy: <xmx:IehUXiDe1GTOv-rQV1n8OB4stQIZ32Mmn_QhmjQD3cWiKGcFZB_OxA>
    <xmx:IehUXg9ikAf1K3zWbZNRmpkabY8oZys5nuOUanMLMVWHMoTdpGTe3A>
    <xmx:IehUXg5PoDSzBIjx0OmXvj4360YmDWdmk5uQRhHOmbwqPY5f3Uy4XA>
    <xmx:I-hUXjlqlvn2nfYWRiLuvibf7LbMKWWdKbAt9nyH-Mt5LiHJ7J-XiA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 25A4B328005D;
        Tue, 25 Feb 2020 04:25:53 -0500 (EST)
Date:   Tue, 25 Feb 2020 10:25:51 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Mateusz Holenko <mholenko@antmicro.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, Stafford Horne <shorne@gmail.com>,
        Karol Gugala <kgugala@antmicro.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Filip Kokosinski <fkokosinski@antmicro.com>,
        Pawel Czarnecki <pczarnecki@internships.antmicro.com>,
        Joel Stanley <joel@jms.id.au>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/5] drivers/soc/litex: add LiteX SoC Controller driver
Message-ID: <20200225092551.6htlplwf23qbgm3n@gilmour.lan>
References: <20200225094437.4170502-0-mholenko@antmicro.com>
 <20200225094437.4170502-3-mholenko@antmicro.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="x7mexyhwnqnezsei"
Content-Disposition: inline
In-Reply-To: <20200225094437.4170502-3-mholenko@antmicro.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--x7mexyhwnqnezsei
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 25, 2020 at 09:46:57AM +0100, Mateusz Holenko wrote:
> From: Pawel Czarnecki <pczarnecki@internships.antmicro.com>
>
> This commit adds driver for the FPGA-based LiteX SoC
> Controller from LiteX SoC builder.
>
> Co-developed-by: Mateusz Holenko <mholenko@antmicro.com>
> Signed-off-by: Mateusz Holenko <mholenko@antmicro.com>
> Signed-off-by: Pawel Czarnecki <pczarnecki@internships.antmicro.com>
> ---
>
> Notes:
>     This commit has been introduced in v3 of the patchset.
>
>     It includes a simplified version of common 'litex.h'
>     header introduced in v2 of the patchset.
>
>  MAINTAINERS                        |   2 +
>  drivers/soc/Kconfig                |   1 +
>  drivers/soc/Makefile               |   1 +
>  drivers/soc/litex/Kconfig          |  14 ++
>  drivers/soc/litex/Makefile         |   3 +
>  drivers/soc/litex/litex_soc_ctrl.c | 233 +++++++++++++++++++++++++++++
>  include/linux/litex.h              |  45 ++++++
>  7 files changed, 299 insertions(+)
>  create mode 100644 drivers/soc/litex/Kconfig
>  create mode 100644 drivers/soc/litex/Makefile
>  create mode 100644 drivers/soc/litex/litex_soc_ctrl.c
>  create mode 100644 include/linux/litex.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ec925c081dd2..22a67514ace3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9730,6 +9730,8 @@ M:	Karol Gugala <kgugala@antmicro.com>
>  M:	Mateusz Holenko <mholenko@antmicro.com>
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/*/litex,*.yaml
> +F:	drivers/soc/litex/litex_soc_ctrl.c
> +F:	include/linux/litex.h
>
>  LIVE PATCHING
>  M:	Josh Poimboeuf <jpoimboe@redhat.com>
> diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
> index 1778f8c62861..78add2a163be 100644
> --- a/drivers/soc/Kconfig
> +++ b/drivers/soc/Kconfig
> @@ -9,6 +9,7 @@ source "drivers/soc/bcm/Kconfig"
>  source "drivers/soc/fsl/Kconfig"
>  source "drivers/soc/imx/Kconfig"
>  source "drivers/soc/ixp4xx/Kconfig"
> +source "drivers/soc/litex/Kconfig"
>  source "drivers/soc/mediatek/Kconfig"
>  source "drivers/soc/qcom/Kconfig"
>  source "drivers/soc/renesas/Kconfig"
> diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
> index 8b49d782a1ab..fd016b51cddd 100644
> --- a/drivers/soc/Makefile
> +++ b/drivers/soc/Makefile
> @@ -14,6 +14,7 @@ obj-$(CONFIG_ARCH_GEMINI)	+= gemini/
>  obj-$(CONFIG_ARCH_MXC)		+= imx/
>  obj-$(CONFIG_ARCH_IXP4XX)	+= ixp4xx/
>  obj-$(CONFIG_SOC_XWAY)		+= lantiq/
> +obj-$(CONFIG_LITEX_SOC_CONTROLLER) += litex/
>  obj-y				+= mediatek/
>  obj-y				+= amlogic/
>  obj-y				+= qcom/
> diff --git a/drivers/soc/litex/Kconfig b/drivers/soc/litex/Kconfig
> new file mode 100644
> index 000000000000..22c78cda0b83
> --- /dev/null
> +++ b/drivers/soc/litex/Kconfig
> @@ -0,0 +1,14 @@
> +# SPDX-License_Identifier: GPL-2.0
> +
> +menu "Enable LiteX SoC Builder specific drivers"
> +
> +config LITEX_SOC_CONTROLLER
> +	tristate "Enable LiteX SoC Controller driver"
> +	help
> +	This option enables the SoC Controller Driver which verifies
> +	LiteX CSR access and provides common litex_get_reg/litex_set_reg
> +	accessors.
> +	All drivers that use functions from litex.h must depend on
> +	LITEX_SOC_CONTROLLER
> +
> +endmenu
> diff --git a/drivers/soc/litex/Makefile b/drivers/soc/litex/Makefile
> new file mode 100644
> index 000000000000..98ff7325b1c0
> --- /dev/null
> +++ b/drivers/soc/litex/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License_Identifier: GPL-2.0
> +
> +obj-$(CONFIG_LITEX_SOC_CONTROLLER)	+= litex_soc_ctrl.o
> diff --git a/drivers/soc/litex/litex_soc_ctrl.c b/drivers/soc/litex/litex_soc_ctrl.c
> new file mode 100644
> index 000000000000..b810782da3a5
> --- /dev/null
> +++ b/drivers/soc/litex/litex_soc_ctrl.c
> @@ -0,0 +1,233 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * LiteX SoC Controller Driver
> + *
> + * Copyright (C) 2020 Antmicro
> + *
> + */
> +
> +#include <linux/litex.h>
> +#include <linux/device.h>
> +#include <linux/errno.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/printk.h>
> +#include <linux/module.h>
> +#include <linux/errno.h>
> +#include <linux/io.h>
> +
> +/*
> + * The parameters below are true for LiteX SoC
> + * configured for 8-bit CSR Bus, 32-bit aligned.
> + *
> + * Supporting other configurations will require
> + * extending the logic in this header.
> + */
> +#define LITEX_REG_SIZE             0x4
> +#define LITEX_SUBREG_SIZE          0x1
> +#define LITEX_SUBREG_SIZE_BIT      (LITEX_SUBREG_SIZE * 8)
> +
> +static DEFINE_SPINLOCK(csr_lock);
> +
> +static inline unsigned long read_pointer_with_barrier(
> +	const volatile void __iomem *addr)
> +{
> +	unsigned long val;
> +
> +	__io_br();
> +	val = *(const volatile unsigned long __force *)addr;
> +	__io_ar();
> +	return val;
> +}
> +
> +static inline void write_pointer_with_barrier(
> +	volatile void __iomem *addr, unsigned long val)
> +{
> +	__io_br();
> +	*(volatile unsigned long __force *)addr = val;
> +	__io_ar();
> +}

What's wrong with readl/writel ?

> +/*
> + * LiteX SoC Generator, depending on the configuration,
> + * can split a single logical CSR (Control & Status Register)
> + * into a series of consecutive physical registers.
> + *
> + * For example, in the configuration with 8-bit CSR Bus,
> + * 32-bit aligned (the default one for 32-bit CPUs) a 32-bit
> + * logical CSR will be generated as four 32-bit physical registers,
> + * each one containing one byte of meaningful data.
> + *
> + * For details see: https://github.com/enjoy-digital/litex/issues/314
> + *
> + * The purpose of `litex_set_reg`/`litex_get_reg` is to implement
> + * the logic of writing to/reading from the LiteX CSR in a single
> + * place that can be then reused by all LiteX drivers.
> + */
> +void litex_set_reg(
> +	void __iomem *reg, unsigned long reg_size, unsigned long val)
> +{
> +	unsigned long shifted_data, shift, i;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&csr_lock, flags);
> +
> +	for (i = 0; i < reg_size; ++i) {
> +		shift = ((reg_size - i - 1) * LITEX_SUBREG_SIZE_BIT);
> +		shifted_data = val >> shift;
> +		write_pointer_with_barrier(
> +			reg + (LITEX_REG_SIZE * i), shifted_data);
> +	}
> +
> +	spin_unlock_irqrestore(&csr_lock, flags);
> +}
> +
> +unsigned long litex_get_reg(
> +	void __iomem *reg, unsigned long reg_size)
> +{
> +	unsigned long shifted_data, shift, i;
> +	unsigned long result = 0;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&csr_lock, flags);
> +
> +	for (i = 0; i < reg_size; ++i) {
> +		shifted_data = read_pointer_with_barrier(
> +			reg + (LITEX_REG_SIZE * i));
> +		shift = ((reg_size - i - 1) * LITEX_SUBREG_SIZE_BIT);
> +		result |= (shifted_data << shift);
> +	}
> +
> +	spin_unlock_irqrestore(&csr_lock, flags);
> +
> +	return result;
> +}

I'm not sure what's supposed to be in that register, but usually it
will either be abstracted away through a framework since letting each
and every driver poke into the same register is not really ideal, or
if you really have to do it, using a syscon.

> +static int accessors_ok;
> +
> +/*
> + * Check if accessors are safe to be used by other drivers
> + * returns true if yes - false if not
> + */
> +int litex_check_accessors(void)
> +{
> +	return accessors_ok;
> +}
> +
> +#define SCRATCH_REG_OFF         0x04
> +#define SCRATCH_REG_SIZE        4
> +#define SCRATCH_REG_VALUE       0x12345678
> +#define SCRATCH_TEST_VALUE      0xdeadbeef
> +
> +/*
> + * Check LiteX CSR read/write access
> + *
> + * This function reads and writes a scratch register in order
> + * to verify if CSR access works.
> + *
> + * In case any problems are detected, the driver should panic
> + * and not set `accessors_ok` flag. As a result no other
> + * LiteX driver should access CSR bus.
> + *
> + * Access to the LiteX CSR is, by design, done in CPU native
> + * endianness. The driver should not dynamically configure
> + * access functions when the endianness mismatch is detected.
> + * Such situation indicates problems in the soft SoC design
> + * and should be solved at the LiteX generator level,
> + * not in the software.

I guess that's why you don't use readl/writel. Then
__raw_readl/__raw_writel?

> + */
> +static int litex_check_csr_access(void __iomem *reg_addr)
> +{
> +	unsigned long reg;
> +
> +	reg = litex_get_reg(reg_addr + SCRATCH_REG_OFF, SCRATCH_REG_SIZE);
> +
> +	if (reg != SCRATCH_REG_VALUE) {
> +		panic("Scratch register read error! Expected: 0x%x but got: 0x%lx",
> +			SCRATCH_REG_VALUE, reg);
> +		return -EINVAL;
> +	}
> +
> +	litex_set_reg(reg_addr + SCRATCH_REG_OFF,
> +		SCRATCH_REG_SIZE, SCRATCH_TEST_VALUE);
> +	reg = litex_get_reg(reg_addr + SCRATCH_REG_OFF, SCRATCH_REG_SIZE);
> +
> +	if (reg != SCRATCH_TEST_VALUE) {
> +		panic("Scratch register write error! Expected: 0x%x but got: 0x%lx",
> +			SCRATCH_TEST_VALUE, reg);
> +		return -EINVAL;
> +	}
> +
> +	/* restore original value of the SCRATCH register */
> +	litex_set_reg(reg_addr + SCRATCH_REG_OFF,
> +		SCRATCH_REG_SIZE, SCRATCH_REG_VALUE);
> +
> +	/* Set flag for other drivers */
> +	accessors_ok = 1;
> +	pr_info("LiteX SoC Controller driver initialized");
> +
> +	return 0;
> +}
> +
> +struct litex_soc_ctrl_device {
> +	void __iomem *base;
> +};
> +
> +static const struct of_device_id litex_soc_ctrl_of_match[] = {
> +	{.compatible = "litex,soc_controller"},
> +	{},
> +};
> +
> +MODULE_DEVICE_TABLE(of, litex_soc_ctrl_of_match);
> +
> +static int litex_soc_ctrl_probe(struct platform_device *pdev)
> +{
> +	struct device *dev;
> +	struct device_node *node;
> +	const struct of_device_id *id;
> +	struct litex_soc_ctrl_device *soc_ctrl_dev;
> +	struct resource *res;
> +
> +	dev = &pdev->dev;
> +	node = dev->of_node;
> +	if (!node)
> +		return -ENODEV;
> +
> +	id = of_match_node(litex_soc_ctrl_of_match, node);
> +	if (!id)
> +		return -ENODEV;

That's pretty much guaranteed.

> +	soc_ctrl_dev = devm_kzalloc(dev, sizeof(*soc_ctrl_dev), GFP_KERNEL);
> +	if (IS_ERR_OR_NULL(soc_ctrl_dev))
> +		return -ENOMEM;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (IS_ERR_OR_NULL(res))
> +		return -EBUSY;
> +
> +	soc_ctrl_dev->base = devm_of_iomap(dev, node, 0, &res->end);
> +	if (IS_ERR_OR_NULL(soc_ctrl_dev->base))
> +		return -EIO;

devm_platform_ioremap_resource ?

> +	return litex_check_csr_access(soc_ctrl_dev->base);
> +}
> +
> +static int litex_soc_ctrl_remove(struct platform_device *pdev)
> +{
> +	return 0;
> +}

You can leave the remove hook out entirely if you don't have anything
in it.

Maxime

--x7mexyhwnqnezsei
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXlToHwAKCRDj7w1vZxhR
xbnyAQCsONo1TAC7jB14ftnPre4uUrMUWWWFOO2TnyPdAAlRAgEA4MwYCyEGzPv8
r57WflQQJarGZkqi/10w+VLoIvEqRAs=
=QnRW
-----END PGP SIGNATURE-----

--x7mexyhwnqnezsei--
