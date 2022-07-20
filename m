Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A01C433EF
	for <linux-serial@archiver.kernel.org>; Wed, 20 Jul 2022 15:02:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbiGTPCa (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 20 Jul 2022 11:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbiGTPC3 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 20 Jul 2022 11:02:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC94F53D0B;
        Wed, 20 Jul 2022 08:02:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 62CAEB8202A;
        Wed, 20 Jul 2022 15:02:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEB88C341CB;
        Wed, 20 Jul 2022 15:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658329346;
        bh=YtXNC0/HbHYd73S2MobPGIYi5L9P9glepVHyLjo+yIE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WeS2QTCfdwxKUm2Er62+u2E95wrofLc1yybYMswFHp+dmQrUiVQBwIosgsXsPshzR
         jzgW5Rup6xg+AjB29uFeFNMvj+5+92NYhLGzFumjtIEBqUUfSmkJ7mjeckEmvKg9ch
         Ab0u0GqcnDcGYjeskkdr0Xvitv7QSCGnSXsuYk5knmzkF8HQFpPtdg0v2rYkfff+QI
         qh1HIxmTG1e6Sgg/2lmhnzisZBsjuiKwN/oXF2h66/iaaT6U/kfPs1qSm18/X8W5mI
         jAfJUhciK/zABb2FduQ4o/v3x+QFIM7PhMRKW3+UeP3yCaGhHLZCnxnU3IS4i7lpuO
         1quOQ4/YMlycQ==
Received: by mail-ua1-f46.google.com with SMTP id e19so714319uaa.0;
        Wed, 20 Jul 2022 08:02:25 -0700 (PDT)
X-Gm-Message-State: AJIora+20BbG7wzpqa8l0YlXe/7H01rZRYKck7LfMmhslbqKtJfl9joe
        yamQMwZ/71NUaRP1r/HKaQG1HN2YUPVXsKnWcw==
X-Google-Smtp-Source: AGRyM1u2rvqON7In/cjBTV1BEYMObzvukL/7uaEqk3luqEFv5gH/ltfpcdvrVdJNgSqhpGcgP0J7P/PCo3+FieGYmTM=
X-Received: by 2002:a05:6130:291:b0:383:3b9:7024 with SMTP id
 q17-20020a056130029100b0038303b97024mr14187591uac.43.1658329344829; Wed, 20
 Jul 2022 08:02:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220720142612.19779-1-shubhrajyoti.datta@xilinx.com> <20220720142612.19779-3-shubhrajyoti.datta@xilinx.com>
In-Reply-To: <20220720142612.19779-3-shubhrajyoti.datta@xilinx.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 20 Jul 2022 09:02:13 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLP-vKMPvKLt3PXDeW+rTOAKVX68Wo8tGyezFgJ+VTYjA@mail.gmail.com>
Message-ID: <CAL_JsqLP-vKMPvKLt3PXDeW+rTOAKVX68Wo8tGyezFgJ+VTYjA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] serial: pl011: Add support for Xilinx Uart
To:     Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Cc:     "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        git <git@xilinx.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Jul 20, 2022 at 8:26 AM Shubhrajyoti Datta
<shubhrajyoti.datta@xilinx.com> wrote:
>
> From: Raviteja Narayanam <raviteja.narayanam@xilinx.com>
>
> The xilinx uart used in Versal SOC follows arm pl011 implementation
> with just a minor change in data bus width. The minimum data
> transaction width in Versal SOC is 32-bit as specified in the
> TRM (Chapter 39: Transaction attributes). Pl011 defaults to 16-bit
> in the driver.
> So, add the xilinx uart as platform device with properties specified
> in 'vendor_data' structure.
>
> Signed-off-by: Raviteja Narayanam <raviteja.narayanam@xilinx.com>
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> ---
>  drivers/tty/serial/amba-pl011.c | 33 +++++++++++++++++++++++++++++++--
>  1 file changed, 31 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> index 97ef41cb2721..096a56f64d17 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -152,6 +152,21 @@ static const struct vendor_data vendor_sbsa = {
>         .fixed_options          = true,
>  };
>
> +static const struct vendor_data vendor_xlnx = {
> +       .reg_offset             = pl011_std_offsets,
> +       .ifls                   = UART011_IFLS_RX4_8 | UART011_IFLS_TX4_8,
> +       .fr_busy                = UART01x_FR_BUSY,
> +       .fr_dsr                 = UART01x_FR_DSR,
> +       .fr_cts                 = UART01x_FR_CTS,
> +       .fr_ri                  = UART011_FR_RI,
> +       .access_32b             = true,
> +       .oversampling           = false,
> +       .dma_threshold          = false,
> +       .cts_event_workaround   = false,
> +       .always_enabled         = true,
> +       .fixed_options          = false,
> +};
> +
>  #ifdef CONFIG_ACPI_SPCR_TABLE
>  static const struct vendor_data vendor_qdt_qdf2400_e44 = {
>         .reg_offset             = pl011_std_offsets,
> @@ -2581,6 +2596,7 @@ static int __init pl011_early_console_setup(struct earlycon_device *device,
>  }
>  OF_EARLYCON_DECLARE(pl011, "arm,pl011", pl011_early_console_setup);
>  OF_EARLYCON_DECLARE(pl011, "arm,sbsa-uart", pl011_early_console_setup);
> +OF_EARLYCON_DECLARE(pl011, "arm,xlnx-uart", pl011_early_console_setup);
>
>  /*
>   * On Qualcomm Datacenter Technologies QDF2400 SOCs affected by
> @@ -2824,6 +2840,7 @@ static int sbsa_uart_probe(struct platform_device *pdev)
>  {
>         struct uart_amba_port *uap;
>         struct resource *r;
> +       int xlnx_uart = 0;
>         int portnr, ret;
>         int baudrate;
>
> @@ -2834,6 +2851,7 @@ static int sbsa_uart_probe(struct platform_device *pdev)
>         if (pdev->dev.of_node) {
>                 struct device_node *np = pdev->dev.of_node;
>
> +               xlnx_uart = of_device_is_compatible(np, "arm,xlnx-uart");
>                 ret = of_property_read_u32(np, "current-speed", &baudrate);
>                 if (ret)
>                         return ret;
> @@ -2863,13 +2881,23 @@ static int sbsa_uart_probe(struct platform_device *pdev)
>  #endif
>                 uap->vendor = &vendor_sbsa;
>
> +       uap->port.ops   = &sbsa_uart_pops;

SBSA is only a subset of PL011 functionality. I don't think you want
to use that. Is there some reason you can't set uap->port.iotype to
UPIO_MEM32 based on 'reg-io-width' in pl011_probe()? The console setup
would need something too, but it should be the same as 8250 setup
IIRC.

> +
> +       if (xlnx_uart) {
> +               uap->vendor = &vendor_xlnx;
> +               uap->clk = devm_clk_get(&pdev->dev, NULL);
> +               if (IS_ERR(uap->clk))
> +                       return PTR_ERR(uap->clk);
> +
> +               uap->port.ops = &amba_pl011_pops;

None of this would be needed either.

> +       }
> +
>         uap->reg_offset = uap->vendor->reg_offset;
>         uap->fifosize   = 32;
>         uap->port.iotype = uap->vendor->access_32b ? UPIO_MEM32 : UPIO_MEM;
> -       uap->port.ops   = &sbsa_uart_pops;
>         uap->fixed_baud = baudrate;
>
> -       snprintf(uap->type, sizeof(uap->type), "SBSA");
> +       snprintf(uap->type, sizeof(uap->type), "%s\n", (xlnx_uart ? "xlnx_uart" : "SBSA"));
>
>         r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>
> @@ -2893,6 +2921,7 @@ static int sbsa_uart_remove(struct platform_device *pdev)
>
>  static const struct of_device_id sbsa_uart_of_match[] = {
>         { .compatible = "arm,sbsa-uart", },
> +       { .compatible = "arm,xlnx-uart", },
>         {},
>  };
>  MODULE_DEVICE_TABLE(of, sbsa_uart_of_match);
> --
> 2.17.1
>
