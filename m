Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27635C43331
	for <linux-serial@archiver.kernel.org>; Mon,  8 Mar 2021 17:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB6A365220
	for <linux-serial@archiver.kernel.org>; Mon,  8 Mar 2021 17:23:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbhCHRXZ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 8 Mar 2021 12:23:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:34890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231136AbhCHRXO (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 8 Mar 2021 12:23:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E798F650E0;
        Mon,  8 Mar 2021 17:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1615224194;
        bh=+JBDZq0kglZnqWBv7oJ3A3xQci9eK+6Cq7z8wX1ATnI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YXFJLZu1tEJMcTJGIn28HDUT/LM3GWp58/iKiRM1t3bs2F6Jp62yBfb3ibj1Hq5EB
         86PqtW8UeZsdiUgwPaDMYdmbVtoFHNAv/jyihrd5Yz6RaZNM3Y7e5e7dJ2+//5PuT2
         hV4SFOVk7FDLgf4KGv7SP5iwb/lEot/7rUIw/8l4=
Date:   Mon, 8 Mar 2021 18:23:11 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Al Cooper <alcooperx@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v4 2/2] serial: 8250: Add new 8250-core based Broadcom
 STB driver
Message-ID: <YEZdf9pgcauzr0Aa@kroah.com>
References: <20210308170522.4272-1-alcooperx@gmail.com>
 <20210308170522.4272-3-alcooperx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210308170522.4272-3-alcooperx@gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Mar 08, 2021 at 12:05:22PM -0500, Al Cooper wrote:
> +static void brcmuart_init_debugfs(struct brcmuart_priv *priv,
> +				  const char *device)
> +{
> +	priv->debugfs_dir = debugfs_create_dir(device, brcmuart_debugfs_root);
> +	priv->debugfs_file = debugfs_create_file("stats", 0444,
> +						 priv->debugfs_dir,
> +						 priv,
> +						 &debugfs_stats_fops);

No need to save this file *, you never do anything with it.

> +}
> +
> +
> +static int brcmuart_probe(struct platform_device *pdev)
> +{
> +	struct resource *regs;
> +	struct device_node *np = pdev->dev.of_node;
> +	const struct of_device_id *of_id = NULL;
> +	struct uart_8250_port *new_port;
> +	struct device *dev = &pdev->dev;
> +	struct brcmuart_priv *priv;
> +	struct clk *baud_mux_clk;
> +	struct uart_8250_port up;
> +	struct resource *irq;
> +	void __iomem *membase = 0;
> +	resource_size_t mapbase = 0;
> +	u32 clk_rate = 0;
> +	int ret;
> +	int x;
> +	int dma_irq;
> +	static const char * const reg_names[REGS_MAX] = {
> +		"uart", "dma_rx", "dma_tx", "dma_intr2", "dma_arb"
> +	};
> +
> +	irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> +	if (!irq) {
> +		dev_err(dev, "missing irq\n");
> +		return -EINVAL;
> +	}
> +	priv = devm_kzalloc(dev, sizeof(struct brcmuart_priv),
> +			GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	of_id = of_match_node(brcmuart_dt_ids, np);
> +	if (!of_id || !of_id->data)
> +		priv->rate_table = brcmstb_rate_table;
> +	else
> +		priv->rate_table = of_id->data;
> +
> +	for (x = 0; x < REGS_MAX; x++) {
> +		regs = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> +						reg_names[x]);
> +		if (!regs)
> +			break;
> +		priv->regs[x] =	devm_ioremap(dev, regs->start,
> +					     resource_size(regs));
> +		if (IS_ERR(priv->regs[x]))
> +			return PTR_ERR(priv->regs[x]);
> +		if (x == REGS_8250) {
> +			mapbase = regs->start;
> +			membase = priv->regs[x];
> +		}
> +	}
> +
> +	/* We should have just the uart base registers or all the registers */
> +	if (x != 1 && x != REGS_MAX) {
> +		dev_warn(dev, "%s registers not specified\n", reg_names[x]);
> +		return -EINVAL;
> +	}
> +
> +	/* if the DMA registers were specified, try to enable DMA */
> +	if (x > REGS_DMA_RX) {
> +		if (brcmuart_arbitration(priv, 1) == 0) {
> +			u32 txrev = 0;
> +			u32 rxrev = 0;
> +
> +			txrev = udma_readl(priv, REGS_DMA_RX, UDMA_RX_REVISION);
> +			rxrev = udma_readl(priv, REGS_DMA_TX, UDMA_TX_REVISION);
> +			if ((txrev >= UDMA_TX_REVISION_REQUIRED) &&
> +				(rxrev >= UDMA_RX_REVISION_REQUIRED)) {
> +
> +				/* Enable the use of the DMA hardware */
> +				priv->dma_enabled = true;
> +			} else {
> +				brcmuart_arbitration(priv, 0);
> +				dev_err(dev,
> +					"Unsupported DMA Hardware Revision\n");
> +			}
> +		} else {
> +			dev_err(dev,
> +				"Timeout arbitrating for UART DMA hardware\n");
> +		}
> +	}
> +
> +	of_property_read_u32(np, "clock-frequency", &clk_rate);
> +
> +	/* See if a Baud clock has been specified */
> +	baud_mux_clk = of_clk_get_by_name(np, "sw_baud");
> +	if (IS_ERR(baud_mux_clk)) {
> +		if (PTR_ERR(baud_mux_clk) == -EPROBE_DEFER)
> +			return -EPROBE_DEFER;
> +		dev_info(dev, "BAUD MUX clock not specified\n");
> +	} else {
> +		dev_info(dev, "BAUD MUX clock found\n");

These are not "info" messages, make them dev_dbg() please.

> +		ret = clk_prepare_enable(baud_mux_clk);
> +		if (ret)
> +			return ret;
> +		priv->baud_mux_clk = baud_mux_clk;
> +		init_real_clk_rates(dev, priv);
> +		clk_rate = priv->default_mux_rate;
> +	}
> +
> +	if (clk_rate == 0) {
> +		dev_err(dev, "clock-frequency or clk not defined\n");
> +		return -EINVAL;
> +	}
> +
> +	dev_info(dev, "DMA is %senabled\n", priv->dma_enabled ? "" : "not ");

When a driver is working properly, no need to say anything in the kernel
log.

This should be dev_info().

Much better overall, thanks for making the changes.

thanks,

greg k-h
