Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE32CC4332F
	for <linux-serial@archiver.kernel.org>; Wed, 10 Nov 2021 09:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC4EE6115B
	for <linux-serial@archiver.kernel.org>; Wed, 10 Nov 2021 09:50:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbhKJJxA convert rfc822-to-8bit (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 10 Nov 2021 04:53:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbhKJJw7 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 10 Nov 2021 04:52:59 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5D9C061764
        for <linux-serial@vger.kernel.org>; Wed, 10 Nov 2021 01:50:12 -0800 (PST)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1mkkF7-00078w-ST; Wed, 10 Nov 2021 10:50:09 +0100
Received: from pza by lupine with local (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1mkkF5-0004G9-VB; Wed, 10 Nov 2021 10:50:07 +0100
Message-ID: <59e1e68131b37b7c22109d79acad75a6e63a890c.camel@pengutronix.de>
Subject: Re: [PATCH v2 2/2] serial:sunplus-uart:Add Sunplus SoC UART Driver
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Hammer Hsieh <hammerh0314@gmail.com>, gregkh@linuxfoundation.org,
        robh+dt@kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jirislaby@kernel.org
Cc:     tony.huang@sunplus.com, wells.lu@sunplus.com,
        Hammer Hsieh <hammer.hsieh@sunplus.com>
Date:   Wed, 10 Nov 2021 10:50:07 +0100
In-Reply-To: <1636530670-6995-3-git-send-email-hammer.hsieh@sunplus.com>
References: <1635752903-14968-1-git-send-email-hammer.hsieh@sunplus.com>
         <1636530670-6995-1-git-send-email-hammer.hsieh@sunplus.com>
         <1636530670-6995-3-git-send-email-hammer.hsieh@sunplus.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

On Wed, 2021-11-10 at 15:51 +0800, Hammer Hsieh wrote:
[...]
> +struct sunplus_uart_port {
> +	char name[16];
> +	struct uart_port uport;
> +	struct sunplus_dma_info *uartdma_rx;
> +	struct sunplus_dma_info *uartdma_tx;
> +	struct clk *clk;
> +	struct reset_control *rstc;
> +	unsigned int pllsys_rate;
> +	struct gpio_desc *rts_gpio;
> +	struct hrtimer rts_check_tx_empty;
> +	struct hrtimer rts_delay_before_send;
> +	struct hrtimer rts_delay_after_send;
> +};
> +struct sunplus_uart_port sunplus_uart_ports[UART_NR];

Does this have to be a global array? I would expect these to be
allocated in the probe function, one at a time.

[...]
> +static int sunplus_uart_probe(struct platform_device *pdev)
> +{
> +	struct resource *res_mem;
> +	struct uart_port *port;
> +	struct clk *clk, *pllsys;
> +	unsigned int pllsys_rate;
> +	int ret, irq;
> +	int idx_offset, idx;
> +	int idx_which_uart;
> +	char peri_name[16];
> +
> +	if (pdev->dev.of_node) {
> +		pdev->id = of_alias_get_id(pdev->dev.of_node, "serial");
> +		if (pdev->id < 0)
> +			pdev->id = of_alias_get_id(pdev->dev.of_node, "uart");
> +	}
> +
> +	idx_offset = -1;
> +
> +	if (IS_UARTDMARX_ID(pdev->id))
> +		idx_offset = 0;
> +	else if (IS_UARTDMATX_ID(pdev->id))
> +		idx_offset = UART_DMARX_NR;
> +
> +	/* init txdma or rxdma */
> +	if (idx_offset >= 0) {
> +		clk = devm_clk_get(&pdev->dev, NULL);

Should this be requested by name? Looking at the binding, this could be
UADMA or HWUA?

> +		if (IS_ERR(clk))
> +			return PTR_ERR(clk);
> +
> +		ret = clk_prepare_enable(clk);
> +		if (ret)
> +			return ret;

I suggest to move this down after all required resources are available.
Otherwise you'll have to either disable the clock in the error paths, or
you are left with a running clock if anything below fails.

> +		if (idx_offset == 0)
> +			idx = idx_offset + pdev->id - ID_BASE_DMARX;
> +		else
> +			idx = idx_offset + pdev->id - ID_BASE_DMATX;
> +
> +		res_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +		if (!res_mem)
> +			return -ENODEV;
> +
> +		sprintf(peri_name, "PERI%d", (idx & 0x01));
> +
> +		clk = devm_clk_get(&pdev->dev, peri_name);
> +		if (IS_ERR(clk))
> +			return PTR_ERR(clk);
> +
> +		ret = clk_prepare_enable(clk);

Same as above.

> +		if (ret)
> +			return ret;
> +
> +		sunplus_uartdma[idx].addr_phy =
> +			(unsigned long)(res_mem->start);
> +		sunplus_uartdma[idx].membase =
> +			devm_ioremap_resource(&pdev->dev, res_mem);
> +
> +		if (IS_ERR(sunplus_uartdma[idx].membase))
> +			return PTR_ERR(sunplus_uartdma[idx].membase);
> +
> +		if (IS_UARTDMARX_ID(pdev->id)) {
> +			irq = platform_get_irq(pdev, 0);
> +			if (irq < 0)
> +				return -ENODEV;
> +
> +			sunplus_uartdma[idx].irq = irq;
> +		} else {
> +			res_mem = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +			if (!res_mem)
> +				return -ENODEV;
> +
> +			sunplus_uartdma[idx].gdma_membase =
> +				devm_ioremap_resource(&pdev->dev, res_mem);
> +
> +			if (IS_ERR(sunplus_uartdma[idx].gdma_membase))
> +				return -EINVAL;
> +		}
> +
> +		if (of_property_read_u32(pdev->dev.of_node, "which-uart", &idx_which_uart) != 0) {
> +			dev_err(&pdev->dev, "\"which-uart\" is not assigned.");
> +			return -EINVAL;
> +		}
> +
> +		if (idx_which_uart >= UART_NR) {
> +			dev_err(&pdev->dev, "\"which-uart\" is not valid.");
> +			return -EINVAL;
> +		}
> +
> +		sunplus_uartdma[idx].which_uart = idx_which_uart;
> +
> +		return 0;
> +	} else if (pdev->id < 0 || pdev->id >= UART_NR)
> +		return -EINVAL;
> +
> +	/* init uart */
> +	port = &sunplus_uart_ports[pdev->id].uport;
> +	if (port->membase)
> +		return -EBUSY;
> +
> +	memset(port, 0, sizeof(*port));
> +
> +	res_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res_mem)
> +		return -ENODEV;
> +
> +	port->dev = &pdev->dev;
> +	port->mapbase = res_mem->start;
> +
> +	port->membase = devm_ioremap_resource(&pdev->dev, res_mem);
> +	if (IS_ERR(port->membase))
> +		return PTR_ERR(port->membase);
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return -ENODEV;
> +
> +	uart_get_rs485_mode(port);
> +	sunplus_uart_ports[pdev->id].rts_gpio =
> +		devm_gpiod_get(&pdev->dev, "rts", GPIOD_OUT_LOW);
> +	port->rs485_config = sunplus_uart_config_rs485;
> +	sunplus_uart_ports[pdev->id].rts_check_tx_empty.function = NULL;
> +	sunplus_uart_ports[pdev->id].rts_delay_before_send.function = NULL;
> +	sunplus_uart_ports[pdev->id].rts_delay_after_send.function = NULL;
> +	if (port->rs485.flags & SER_RS485_ENABLED)
> +		sunplus_uart_rs485_on(port);
> +
> +	sunplus_uart_ports[pdev->id].clk = devm_clk_get(&pdev->dev, NULL);

Here the same nameless clock as in the loop above is requested again.
Should this be UADMA or HWUA?

> +	if (IS_ERR(sunplus_uart_ports[pdev->id].clk))
> +		return PTR_ERR(sunplus_uart_ports[pdev->id].clk);
> +
> +	ret = clk_prepare_enable(sunplus_uart_ports[pdev->id].clk);
> +	if (ret)
> +		return ret;

Same comment as above. Better to request the reset control before
enabling the clock, for example.

> +
> +	sunplus_uart_ports[pdev->id].rstc =
> +		devm_reset_control_get(&pdev->dev, NULL);

Please use devm_reset_control_get_exclusive() instead.

> +
> +	if (IS_ERR(sunplus_uart_ports[pdev->id].rstc))
> +		return PTR_ERR(sunplus_uart_ports[pdev->id].rstc);
> +
> +	ret = reset_control_deassert(sunplus_uart_ports[pdev->id].rstc);
> +	if (ret)
> +		return ret;
> +
> +	clk = sunplus_uart_ports[pdev->id].clk;
> +	if (IS_ERR(clk))

This can't ever be true, the code above already returned in this case.

[...]
> +static int sunplus_uart_remove(struct platform_device *pdev)
> +{
> +#ifdef CONFIG_PM_RUNTIME_UART
> +	if (pdev->id != 0) {
> +		pm_runtime_disable(&pdev->dev);
> +		pm_runtime_set_suspended(&pdev->dev);
> +	}
> +#endif
> +	uart_remove_one_port(&sunplus_uart_driver,
> +		&sunplus_uart_ports[pdev->id].uport);
> +
> +	if (pdev->id < UART_NR) {
> +		clk_disable_unprepare(sunplus_uart_ports[pdev->id].clk);
> +		reset_control_assert(sunplus_uart_ports[pdev->id].rstc);
> +	}

What about the PERI clocks? This seems to leave them enabled.

regards
Philipp
