Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE377C001B1
	for <linux-serial@archiver.kernel.org>; Tue,  4 Jul 2023 14:42:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbjGDOmp (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 4 Jul 2023 10:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbjGDOmo (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 4 Jul 2023 10:42:44 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB2DE47
        for <linux-serial@vger.kernel.org>; Tue,  4 Jul 2023 07:42:42 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3143b70d6easo1835275f8f.2
        for <linux-serial@vger.kernel.org>; Tue, 04 Jul 2023 07:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688481761; x=1691073761;
        h=content-transfer-encoding:in-reply-to:subject:organization
         :references:cc:to:content-language:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7I1HGKSoHPJQCrADN3stYlXqVtErLhFKLkSbV3x2NPg=;
        b=gQQTQQ7z+QUYIegjOnT5WKrESNqIjr+ymCLZCba0sGb+yo2dY+GDsrFPGy0vEzeFtI
         aSAmP6QB/tQI+k59EAmg47lKd+w8NE0EKQtxZlZJIdJ44BrwojDdxwesRneDqf+5eU2k
         rbKDwOEAJkwl/5JD53hJjb/zeJ71CBqwflbVdC+x2gQ/iRiDEjA09iaXTEw+aGXi7CYu
         VYAEGOdjKY0/a5HPq3N+xGvcveI7yFz0GSH2zJDbFk2y1HWvQtvhCv8nueZ4pmRyPSmC
         lB8rrdRm+JsHpY2XoUgec8qhJ9Uh/crvAgwJtQ+RJ9udfkhRkQQw2pTGJQmFOptZf0Us
         gpWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688481761; x=1691073761;
        h=content-transfer-encoding:in-reply-to:subject:organization
         :references:cc:to:content-language:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7I1HGKSoHPJQCrADN3stYlXqVtErLhFKLkSbV3x2NPg=;
        b=AmF9dgYsdGjpNRxonDHivw7jyu0JsUWxF1hw8gST0Ld0A1D8Wir+e0OdCgOpmTnsUJ
         xuPY/+qxJYBV9p4eahGGPu60CSITZeFlAbNsXs85HB2f32VmrqcL5yVHXnYgC2TjrlEO
         SHG+TvaXDoKLFrR3Yaa8kS2W082EzTL9LDiFM/EdYqhKtqQCsUNfOsH9G6jOI8yNc8aE
         vv55dkyERkOff0XZq7bziGUsDa+KlZtSK6M6AEvIi37aXjGdvIR1FIV4UzWCGPpOCYfl
         U5eJi9M8qXVXzyXFtbuuBlr+e7rqJww9kOGAzJz5MPjBglHT4errs40rVGGua7q0lmCb
         XYBg==
X-Gm-Message-State: ABy/qLZFDoWMYWiaX96ay5Wnt6lmPQhDby2NXqt0mFLzK9+wRdS2xolF
        8T+DRBJyuq5T9xGPhCxbMuv5Yg==
X-Google-Smtp-Source: APBJJlE5bf9Y7F1mi/S9+6pvxe7U5EYXioqtBgDCChvXvg4cDfkJm0j26dBhe9t27DuVfd/7/Xzl6w==
X-Received: by 2002:adf:ef4e:0:b0:314:25c6:7f6d with SMTP id c14-20020adfef4e000000b0031425c67f6dmr10385496wrp.14.1688481760882;
        Tue, 04 Jul 2023 07:42:40 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:106:cd85:84ae:7b? ([2a01:e0a:982:cbb0:106:cd85:84ae:7b])
        by smtp.gmail.com with ESMTPSA id z5-20020adfd0c5000000b003143aa0ca8asm4266162wrh.13.2023.07.04.07.42.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jul 2023 07:42:40 -0700 (PDT)
Message-ID: <eb0dab5b-2fc7-728c-c6e0-43d2db422ed5@linaro.org>
Date:   Tue, 4 Jul 2023 16:42:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Content-Language: en-US
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jbrunet@baylibre.com, jirislaby@kernel.org, khilman@baylibre.com,
        martin.blumenstingl@googlemail.com
Cc:     kelvin.zhang@amlogic.com, xianwei.zhao@amlogic.com,
        kernel@sberdevices.ru, rockosov@gmail.com,
        linux-amlogic@lists.infradead.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230704135936.14697-1-ddrokosov@sberdevices.ru>
 <20230704135936.14697-4-ddrokosov@sberdevices.ru>
Organization: Linaro Developer Services
Subject: Re: [PATCH v1 3/5] tty: serial: meson: apply ttyS devname instead of
 ttyAML for new SoCs
In-Reply-To: <20230704135936.14697-4-ddrokosov@sberdevices.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 04/07/2023 15:59, Dmitry Rokosov wrote:
> It is worth noting that the devname ttyS is a widely recognized tty name
> and is commonly used by many uart device drivers. Given the established
> usage and compatibility concerns, it may not be feasible to change the
> devname for older SoCs. However, for new definitions, it is acceptable
> and even recommended to use a new devname to help ensure clarity and
> avoid any potential conflicts on lower or upper software levels. In
> addition, modify the meson_uart_dt match data for g12a, a1, and s4 to
> their appropriate values to ensure proper devname values and
> functionality.

I'm not confident about modifying a global struct from a probe,
I think you should add a separate meson_uart_driver/meson_serial_console couple
with ttyS instead of ttyAML, refer to the right uart_driver in meson_uart_data
and in probe() register it and pass it to uart_add_one_port().

Neil

> 
> For more information please refer to IRC discussion at [1].
> 
> Links:
>      [1]: https://libera.irclog.whitequark.org/linux-amlogic/2023-07-03
> 
> Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> ---
>   drivers/tty/serial/meson_uart.c | 33 +++++++++++++++++++++++++++++++--
>   1 file changed, 31 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
> index 87c0eb5f2dba..361f9326b527 100644
> --- a/drivers/tty/serial/meson_uart.c
> +++ b/drivers/tty/serial/meson_uart.c
> @@ -82,6 +82,7 @@ static struct uart_driver meson_uart_driver;
>   static struct uart_port *meson_ports[AML_UART_PORT_NUM];
>   
>   struct meson_uart_data {
> +	const char *dev_name;
>   	bool has_xtal_div2;
>   };
>   
> @@ -683,6 +684,7 @@ static int meson_uart_probe_clocks(struct platform_device *pdev,
>   
>   static int meson_uart_probe(struct platform_device *pdev)
>   {
> +	const struct meson_uart_data *priv_data;
>   	struct resource *res_mem;
>   	struct uart_port *port;
>   	u32 fifosize = 64; /* Default is 64, 128 for EE UART_0 */
> @@ -729,6 +731,18 @@ static int meson_uart_probe(struct platform_device *pdev)
>   	if (ret)
>   		return ret;
>   
> +	priv_data = device_get_match_data(&pdev->dev);
> +
> +	if (priv_data) {
> +		struct console *cons = meson_uart_driver.cons;
> +
> +		meson_uart_driver.dev_name = priv_data->dev_name;
> +
> +		if (cons)
> +			strscpy(cons->name, priv_data->dev_name,
> +				sizeof(cons->name));
> +	}
> +
>   	if (!meson_uart_driver.state) {
>   		ret = uart_register_driver(&meson_uart_driver);
>   		if (ret)
> @@ -748,7 +762,7 @@ static int meson_uart_probe(struct platform_device *pdev)
>   	port->x_char = 0;
>   	port->ops = &meson_uart_ops;
>   	port->fifosize = fifosize;
> -	port->private_data = (void *)device_get_match_data(&pdev->dev);
> +	port->private_data = (void *)priv_data;
>   
>   	meson_ports[pdev->id] = port;
>   	platform_set_drvdata(pdev, port);
> @@ -780,6 +794,17 @@ static int meson_uart_remove(struct platform_device *pdev)
>   }
>   
>   static struct meson_uart_data meson_g12a_uart_data = {
> +	.dev_name = "ttyAML",
> +	.has_xtal_div2 = true,
> +};
> +
> +static struct meson_uart_data meson_a1_uart_data = {
> +	.dev_name = "ttyS",
> +	.has_xtal_div2 = false,
> +};
> +
> +static struct meson_uart_data meson_s4_uart_data = {
> +	.dev_name = "ttyS",
>   	.has_xtal_div2 = true,
>   };
>   
> @@ -794,7 +819,11 @@ static const struct of_device_id meson_uart_dt_match[] = {
>   	},
>   	{
>   		.compatible = "amlogic,meson-s4-uart",
> -		.data = (void *)&meson_g12a_uart_data,
> +		.data = (void *)&meson_s4_uart_data,
> +	},
> +	{
> +		.compatible = "amlogic,meson-a1-uart",
> +		.data = (void *)&meson_a1_uart_data,
>   	},
>   	{ /* sentinel */ },
>   };

