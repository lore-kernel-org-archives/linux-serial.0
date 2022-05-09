Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C63EC433F5
	for <linux-serial@archiver.kernel.org>; Mon,  9 May 2022 17:44:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239769AbiEIRsC (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 9 May 2022 13:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239877AbiEIRrJ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 9 May 2022 13:47:09 -0400
Received: from smtp.smtpout.orange.fr (smtp03.smtpout.orange.fr [80.12.242.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE1B2725D1
        for <linux-serial@vger.kernel.org>; Mon,  9 May 2022 10:43:13 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.180.246])
        by smtp.orange.fr with ESMTPA
        id o7PanVLJYZe7jo7PannEiN; Mon, 09 May 2022 19:43:11 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Mon, 09 May 2022 19:43:11 +0200
X-ME-IP: 86.243.180.246
Message-ID: <d76c13b2-16a0-d53f-0cc9-562fa96f373d@wanadoo.fr>
Date:   Mon, 9 May 2022 19:43:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v1 1/2] serial: 8250_dw: Use devm_add_action_or_reset()
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
References: <20220509172129.37770-1-andriy.shevchenko@linux.intel.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20220509172129.37770-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Le 09/05/2022 à 19:21, Andy Shevchenko a écrit :
> Slightly simplify ->probe() and drop a few goto labels by using
> devm_add_action_or_reset() for clock and reset cleanup.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   drivers/tty/serial/8250/8250_dw.c | 63 +++++++++++++++----------------
>   1 file changed, 31 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
> index 7934e4658281..e7ef61899576 100644
> --- a/drivers/tty/serial/8250/8250_dw.c
> +++ b/drivers/tty/serial/8250/8250_dw.c
> @@ -484,6 +484,16 @@ static void dw8250_quirks(struct uart_port *p, struct dw8250_data *data)
>   	}
>   }
>   
> +static void dw8250_clk_disable_unprepare(void *data)
> +{
> +	clk_disable_unprepare(data);
> +}

Hi,

we already have several time this function in different drivers.
Maybe, it would be nice to have something standart for it.

A devm_clk_prepare_enable() or something devm-helpers.h ([1])

Just my 2c.

CJ

[1]: 
https://elixir.bootlin.com/linux/v5.18-rc6/source/include/linux/devm-helpers.h

> +
> +static void dw8250_reset_control_assert(void *data)
> +{
> +	reset_control_assert(data);
> +}
> +
>   static int dw8250_probe(struct platform_device *pdev)
>   {
>   	struct uart_8250_port uart = {}, *up = &uart;
> @@ -585,35 +595,43 @@ static int dw8250_probe(struct platform_device *pdev)
>   	if (err)
>   		dev_warn(dev, "could not enable optional baudclk: %d\n", err);
>   
> +	err = devm_add_action_or_reset(dev, dw8250_clk_disable_unprepare, data->clk);
> +	if (err)
> +		return err;
> +
>   	if (data->clk)
>   		p->uartclk = clk_get_rate(data->clk);
>   
>   	/* If no clock rate is defined, fail. */
>   	if (!p->uartclk) {
>   		dev_err(dev, "clock rate not defined\n");
> -		err = -EINVAL;
> -		goto err_clk;
> +		return -EINVAL;
>   	}
>   
>   	data->pclk = devm_clk_get_optional(dev, "apb_pclk");
> -	if (IS_ERR(data->pclk)) {
> -		err = PTR_ERR(data->pclk);
> -		goto err_clk;
> -	}
> +	if (IS_ERR(data->pclk))
> +		return PTR_ERR(data->pclk);
>   
>   	err = clk_prepare_enable(data->pclk);
>   	if (err) {
>   		dev_err(dev, "could not enable apb_pclk\n");
> -		goto err_clk;
> +		return err;
>   	}
>   
> +	err = devm_add_action_or_reset(dev, dw8250_clk_disable_unprepare, data->pclk);
> +	if (err)
> +		return err;
> +
>   	data->rst = devm_reset_control_get_optional_exclusive(dev, NULL);
> -	if (IS_ERR(data->rst)) {
> -		err = PTR_ERR(data->rst);
> -		goto err_pclk;
> -	}
> +	if (IS_ERR(data->rst))
> +		return PTR_ERR(data->rst);
> +
>   	reset_control_deassert(data->rst);
>   
> +	err = devm_add_action_or_reset(dev, dw8250_reset_control_assert, data->rst);
> +	if (err)
> +		return err;
> +
>   	dw8250_quirks(p, data);
>   
>   	/* If the Busy Functionality is not implemented, don't handle it */
> @@ -631,10 +649,8 @@ static int dw8250_probe(struct platform_device *pdev)
>   	}
>   
>   	data->data.line = serial8250_register_8250_port(up);
> -	if (data->data.line < 0) {
> -		err = data->data.line;
> -		goto err_reset;
> -	}
> +	if (data->data.line < 0)
> +		return data->data.line;
>   
>   	/*
>   	 * Some platforms may provide a reference clock shared between several
> @@ -655,17 +671,6 @@ static int dw8250_probe(struct platform_device *pdev)
>   	pm_runtime_enable(dev);
>   
>   	return 0;
> -
> -err_reset:
> -	reset_control_assert(data->rst);
> -
> -err_pclk:
> -	clk_disable_unprepare(data->pclk);
> -
> -err_clk:
> -	clk_disable_unprepare(data->clk);
> -
> -	return err;
>   }
>   
>   static int dw8250_remove(struct platform_device *pdev)
> @@ -683,12 +688,6 @@ static int dw8250_remove(struct platform_device *pdev)
>   
>   	serial8250_unregister_port(data->data.line);
>   
> -	reset_control_assert(data->rst);
> -
> -	clk_disable_unprepare(data->pclk);
> -
> -	clk_disable_unprepare(data->clk);
> -
>   	pm_runtime_disable(dev);
>   	pm_runtime_put_noidle(dev);
>   

