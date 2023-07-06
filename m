Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04049C001DF
	for <linux-serial@archiver.kernel.org>; Thu,  6 Jul 2023 07:09:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233208AbjGFHJc (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 6 Jul 2023 03:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233760AbjGFHJY (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 6 Jul 2023 03:09:24 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BADB1727
        for <linux-serial@vger.kernel.org>; Thu,  6 Jul 2023 00:09:23 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4fb863edcb6so394616e87.0
        for <linux-serial@vger.kernel.org>; Thu, 06 Jul 2023 00:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688627361; x=1691219361;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=e+3UxZtzHVgpN6AySbetYQrNrrAcbanGA/ITUARrZTA=;
        b=joyw8U0qByKFtglxOZnIe4fsCxJKWScziH7T+kOstAb0UKThqasBr5CdPEY5B1i2wr
         m8bJPFWK+EcfKKZXrttWGePda170qVCwdehzgiI/9cO1iau6sLuw+OokUf36N4AAc/ix
         1emyeXwHLEDabZWynbCxNkxcohY1NXf7bY54Omq0JDF0RN0bNtAetf0qaSaBsiQIa5h2
         G+GD6+cGPDTzmC3Lh/QGA7s/eYZ2VvVtoVZrIRx2Tv+rP1mJn1A3GX4qpIWc0M3y0tu1
         pJq+4yNyTAfSYFXOGnL4z1ScNb6DNI7ypt70EIWSkceScCrzjY1pmvUL8bhvIg7GkleD
         8ylw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688627361; x=1691219361;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e+3UxZtzHVgpN6AySbetYQrNrrAcbanGA/ITUARrZTA=;
        b=lMxdwYy92Ac/K0aJbm/V//QgRTbN3vtRt5hkze8yipy98odpzMv7e9Vh/KSizC0gno
         wG2IBs0owSWHD2ZvJSIApwPENmZpJ2NmShBqiaUKoLgOZzcpzhfDD4eGVM6o8jU0F77y
         C04pgevcOSmmVwjbf2aS1Dg2SwuiiNTGVu1pLEceNorP/Tg/dEl0O5Cl1uUSEaOobr9d
         yhFlam3o9CyJzfCs7ewChaAHauXoX9rl3a/EDpesuKhd/8bJVnVY4Uw3jf9MSLqkrVEn
         uJTC+7lJzSi9xEbW/1SLWMpXSpZdRCUa7KtwH3+TohzsI+uS0kuwc5m7WDMlHKfM2MW3
         zhkA==
X-Gm-Message-State: ABy/qLZ+HvfD5W7p9DPKuZc5qNLOf+J1OEoj3+nIv4fIx+W5j1vSxcFC
        fqYFq4mWzvSM0oNShkvgw1ELHw==
X-Google-Smtp-Source: APBJJlFON4bLuwxCrqhdPT27/apuffS9FmUkfshZ1Q98OKa5xztSFTpSlUmvsazqmjuaOs8p4DyYvA==
X-Received: by 2002:a05:6512:1ca:b0:4f5:1418:e230 with SMTP id f10-20020a05651201ca00b004f51418e230mr734913lfp.52.1688627361586;
        Thu, 06 Jul 2023 00:09:21 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:15d1:2748:ead4:bdff? ([2a01:e0a:982:cbb0:15d1:2748:ead4:bdff])
        by smtp.gmail.com with ESMTPSA id v19-20020a1cf713000000b003fbb00599e4sm4227903wmh.2.2023.07.06.00.09.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jul 2023 00:09:21 -0700 (PDT)
Message-ID: <80b3c16b-fbf0-4c52-af1f-b9965cdeab5a@linaro.org>
Date:   Thu, 6 Jul 2023 09:09:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 5/7] tty: serial: meson: add independent uart_data for
 A1 SoC family
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
References: <20230705181833.16137-1-ddrokosov@sberdevices.ru>
 <20230705181833.16137-6-ddrokosov@sberdevices.ru>
Organization: Linaro Developer Services
In-Reply-To: <20230705181833.16137-6-ddrokosov@sberdevices.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 05/07/2023 20:18, Dmitry Rokosov wrote:
> Implement separate uart_data to ensure proper devname value for the A1
> SoC family. Use 'ttyS' devname, as required by the A1 architecture,
> instead of the legacy gx architecture.
> 
> Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> ---
>   drivers/tty/serial/meson_uart.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
> index 6a63184b8091..84cf10b0ca5c 100644
> --- a/drivers/tty/serial/meson_uart.c
> +++ b/drivers/tty/serial/meson_uart.c
> @@ -818,6 +818,11 @@ static struct meson_uart_data meson_g12a_uart_data = {
>   	.has_xtal_div2 = true,
>   };
>   
> +static struct meson_uart_data meson_a1_uart_data = {
> +	.uart_driver = &MESON_UART_DRIVER(ttyS),
> +	.has_xtal_div2 = false,
> +};
> +
>   static struct meson_uart_data meson_s4_uart_data = {
>   	.uart_driver = &MESON_UART_DRIVER(ttyS),
>   	.has_xtal_div2 = true,
> @@ -836,6 +841,10 @@ static const struct of_device_id meson_uart_dt_match[] = {
>   		.compatible = "amlogic,meson-s4-uart",
>   		.data = (void *)&meson_s4_uart_data,
>   	},
> +	{
> +		.compatible = "amlogic,meson-a1-uart",
> +		.data = (void *)&meson_a1_uart_data,
> +	},
>   	{ /* sentinel */ },
>   };
>   MODULE_DEVICE_TABLE(of, meson_uart_dt_match);

With the real struct name:

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
