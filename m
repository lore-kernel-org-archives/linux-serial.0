Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 366C6C433F5
	for <linux-serial@archiver.kernel.org>; Thu,  7 Apr 2022 14:03:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236594AbiDGOFF (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 7 Apr 2022 10:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235366AbiDGOFF (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 7 Apr 2022 10:05:05 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22761DA0AB
        for <linux-serial@vger.kernel.org>; Thu,  7 Apr 2022 07:03:04 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id w4so7962565wrg.12
        for <linux-serial@vger.kernel.org>; Thu, 07 Apr 2022 07:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=Yez/wOgS2wGIwd8n8IZ3uYevPlJ/v5ArOMM4z5S2Ndg=;
        b=T4EZ03WqYGu4YI/VvHId+EDY0bU01pqcKiPmsOqHb54jAO+NHZMQDjRR1QarkAy+vN
         xn1T9jOxXarlTTEq/8EsClZrslDVQI9KLZZUCER5BotLTh/jkRXwkra1Os+Gj2Dy+an4
         D8K2xb1mfTYt0j4wC/tLiFbtmj7rZi34q9f/60FtbZ+nrIUIaHZjL8TvJ8pNAJheEvs/
         OnIcttPMU66BZ5WsnFM7Raqxi5xOJHS8DxuCo2+nb1foMXG7Ks6FGT7p1HLnyTEUibda
         JQv+SJNcx8o3xR7ywZ68YDcfszUEPVcYicPGE/afFp11tjrBY89LXSfTSjob9GO2GiIL
         ZNfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=Yez/wOgS2wGIwd8n8IZ3uYevPlJ/v5ArOMM4z5S2Ndg=;
        b=wf5IjyQEbHJReZHJpfXgR659IIX/pt8HsnPj8jIGP1tT77btqzagxXMJeHvSaVAa/9
         D9XEfIGpYYX1ymwmfST++v2xBBzBLgQlVtdr19nWDuYytcwRD8+8IzI+nvnNgrtlXvge
         V+s2v3t6h62bJxiPfBgAjpd7ndd8zdIMTz7vhleyTpj/DAovXAAuyD+KFp8v/VUiYoLv
         O1XOP9fXrpiwXnnOUqET28qte1tACi6PhczhSFCs/WF5EDZx64q/3h0qKtKUdOSMnZH6
         k0ionkpLHF/oNXrBdOECrqxYFD5n773uu772jKyHj2XclvmEGoZoJ6ckd+pnd63PFa0j
         GPPQ==
X-Gm-Message-State: AOAM531DHJb8zxAqFna9tzqjngvky/o6HYhmRs7CnRbQc4nYQB7SB+Wf
        3Q3Nk7rPaPejFxv2bUgX2WSOwg==
X-Google-Smtp-Source: ABdhPJyTSyAhQPnkr/lCtybwrnyNOglgocgsV+yActqtpl7PefGTEkGKJ2kjdDsApqaF9gaKCXOSBQ==
X-Received: by 2002:a5d:6d8d:0:b0:206:966:5f8 with SMTP id l13-20020a5d6d8d000000b00206096605f8mr11410626wrs.498.1649340182567;
        Thu, 07 Apr 2022 07:03:02 -0700 (PDT)
Received: from [10.1.3.188] (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id d20-20020a05600c34d400b0038caf684679sm9953386wmq.0.2022.04.07.07.03.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Apr 2022 07:03:02 -0700 (PDT)
Message-ID: <bedff186-8ce4-3cfd-aa67-f0375daf29b4@baylibre.com>
Date:   Thu, 7 Apr 2022 16:03:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/3] tty: serial: meson: Added 12Mhz as the clock source
 for calculating baud rate
Content-Language: en-US
To:     Yu Tu <yu.tu@amlogic.com>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <20220407081355.13602-1-yu.tu@amlogic.com>
 <20220407081355.13602-3-yu.tu@amlogic.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
In-Reply-To: <20220407081355.13602-3-yu.tu@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 07/04/2022 10:13, Yu Tu wrote:
> Starting with the g12A chip, add a 12Mhz clock to calculate the baud
> rate, since the BT module uses 3Mhz baud rate. 8Mhz calculations can
> lead to baud rate bias, causing some problems.

The commit message isn't clear enough, 12MHz is a new intermediate clock
rate, not a new clock source of the UART module.

Please explain a /2 divider over XTAL was introduced since G12A, and
is preferred to be used over the still present /3 divider since it
provides much closer frequencies vs the request baudrate.

> 
> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
> ---
>   drivers/tty/serial/meson_uart.c | 25 +++++++++++++++++++++++--
>   1 file changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
> index 8e59624935af..7e77693a1318 100644
> --- a/drivers/tty/serial/meson_uart.c
> +++ b/drivers/tty/serial/meson_uart.c
> @@ -68,6 +68,7 @@
>   #define AML_UART_BAUD_MASK		0x7fffff
>   #define AML_UART_BAUD_USE		BIT(23)
>   #define AML_UART_BAUD_XTAL		BIT(24)
> +#define AML_UART_BAUD_XTAL_DIV2		BIT(27)
>   
>   #define AML_UART_PORT_NUM		12
>   #define AML_UART_PORT_OFFSET		6
> @@ -80,6 +81,10 @@ static struct uart_driver meson_uart_driver;
>   
>   static struct uart_port *meson_ports[AML_UART_PORT_NUM];
>   
> +struct meson_uart_data {
> +	bool has_xtal_div2;
> +};
> +
>   static void meson_uart_set_mctrl(struct uart_port *port, unsigned int mctrl)
>   {
>   }
> @@ -293,13 +298,20 @@ static int meson_uart_startup(struct uart_port *port)
>   
>   static void meson_uart_change_speed(struct uart_port *port, unsigned long baud)
>   {
> -	u32 val;
> +	struct meson_uart_data *private_data = port->private_data;
> +	u32 val = 0;
>   
>   	while (!meson_uart_tx_empty(port))
>   		cpu_relax();
>   
>   	if (port->uartclk == 24000000) {
> -		val = DIV_ROUND_CLOSEST(port->uartclk / 3, baud) - 1;
> +		unsigned int xtal_div = 3;
> +
> +		if (private_data->has_xtal_div2) {
> +			xtal_div = 2;
> +			val |= AML_UART_BAUD_XTAL_DIV2;
> +		}
> +		val |= DIV_ROUND_CLOSEST(port->uartclk / xtal_div, baud) - 1;
>   		val |= AML_UART_BAUD_XTAL;
>   	} else {
>   		val =  DIV_ROUND_CLOSEST(port->uartclk / 4, baud) - 1;
> @@ -691,6 +703,7 @@ static int meson_uart_probe_clocks(struct platform_device *pdev,
>   
>   static int meson_uart_probe(struct platform_device *pdev)
>   {
> +	struct meson_uart_data *private_data;
>   	struct resource *res_mem;
>   	struct uart_port *port;
>   	u32 fifosize = 64; /* Default is 64, 128 for EE UART_0 */
> @@ -733,6 +746,13 @@ static int meson_uart_probe(struct platform_device *pdev)
>   	if (!port)
>   		return -ENOMEM;
>   
> +	private_data = devm_kzalloc(&pdev->dev, sizeof(struct meson_uart_data), GFP_KERNEL);
> +	if (!private_data)
> +		return -ENOMEM;
> +
> +	if ((bool)device_get_match_data(&pdev->dev))
> +		private_data->has_xtal_div2 = true;

It should be much cleaner to pass meson_uart_data to meson_uart_dt_match .data,
and then you can retrieve device_get_match_data() and put the result into
port->private_data.
This will avoid a devm_kzalloc().

Then in meson_uart_change_speed() change the test to check for NULL private_data:
if (private_data && private_data->has_xtal_div2)

> +
>   	ret = meson_uart_probe_clocks(pdev, port);
>   	if (ret)
>   		return ret;
> @@ -749,6 +769,7 @@ static int meson_uart_probe(struct platform_device *pdev)
>   	port->x_char = 0;
>   	port->ops = &meson_uart_ops;
>   	port->fifosize = fifosize;
> +	port->private_data = private_data;
>   
>   	meson_ports[pdev->id] = port;
>   	platform_set_drvdata(pdev, port);

Neil
