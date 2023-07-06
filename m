Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED158C001B0
	for <linux-serial@archiver.kernel.org>; Thu,  6 Jul 2023 07:09:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233488AbjGFHJb (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 6 Jul 2023 03:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233754AbjGFHJR (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 6 Jul 2023 03:09:17 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38CE01BDC
        for <linux-serial@vger.kernel.org>; Thu,  6 Jul 2023 00:09:14 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b6fdaf6eefso4507641fa.0
        for <linux-serial@vger.kernel.org>; Thu, 06 Jul 2023 00:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688627352; x=1691219352;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=plmZ0h8i9sq4RHWU4DDCLjYO4HpotTDagLCFOMDhSlY=;
        b=xIwiu9Y6vbnS82nhfebFqnQdHjPSKebEsBwnSxUMm8JSAlTWAmIDYrEWOS4xAXETiq
         CMdRmqIz4OLiv4jNcTZw5JVgjC3Z6/ZxOZez6DTQioXnT4GNfRjVHI+dR+UvoU0msYVl
         nUOsbabplWcjcarlchb96kV8mVpAeH8aPr5zf2UStLpILjApZd5ja8PNdbDC6H3TDak6
         nbrpTxpywB2jiqZZIvb309RDW+2sxuE850yGXtilfurszckER6Z3aBZkWM0TYc/lbZX/
         elkmAYi9vB8frufrILukrR/SNpDXADzidXh+Gdi5q9Jn5QTpuuB/OGjQfWltff2awozg
         Pe8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688627352; x=1691219352;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=plmZ0h8i9sq4RHWU4DDCLjYO4HpotTDagLCFOMDhSlY=;
        b=YD2iq7uo6CF/egeKzcx2r8tqIjYzRtX38j3MIToTFbjZCvKaCN23rp1jNKb95Siuvb
         BzeDTgrP2+5nbp+20fcKBULWt2ZgeHhOaDtxLUt7UeeuUln8B18McB5FevDIzK0rBSbI
         I9a75FYVoB2TzZITGoZuMzhiQD9JNM51VrEyZir7LXb/DQA1SYK5KtYo20afLExDirHH
         bY0GnSSTnvqLrFGUL9uX2XtDJvNxdYhMiVNvssN8WVNV8YzHSjR7Qr3ZSRd9ZBIK/AlL
         XftNeUboBaETJ65nikahkUwEJm4S2Di2mQOY5w7VvUoj3BgNN7FbD3BsuTwB6xRCRwv7
         Niew==
X-Gm-Message-State: ABy/qLYCtxF9vSx9I4DUkmJ4cDxCscEGGbvpl3m19VtCL6VaD9Vl6ctm
        MYrpxv7v8Zt1whvs0LVQTw18mw==
X-Google-Smtp-Source: APBJJlGQIR7wFWC4Jxx97JnuXfSxfTwE5u86C3BNsee1uxgxFPIMdNLES68r80nFrhLiA2eZWixj4g==
X-Received: by 2002:a2e:7802:0:b0:2b6:c236:b040 with SMTP id t2-20020a2e7802000000b002b6c236b040mr683275ljc.12.1688627352432;
        Thu, 06 Jul 2023 00:09:12 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:15d1:2748:ead4:bdff? ([2a01:e0a:982:cbb0:15d1:2748:ead4:bdff])
        by smtp.gmail.com with ESMTPSA id c3-20020a5d4143000000b003143d80d11dsm1006985wrq.112.2023.07.06.00.09.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jul 2023 00:09:11 -0700 (PDT)
Message-ID: <62de5067-f651-67d8-3779-46b1fe0bdd08@linaro.org>
Date:   Thu, 6 Jul 2023 09:09:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 4/7] tty: serial: meson: introduce separate uart_data
 for S4 SoC family
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
 <20230705181833.16137-5-ddrokosov@sberdevices.ru>
Organization: Linaro Developer Services
In-Reply-To: <20230705181833.16137-5-ddrokosov@sberdevices.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 05/07/2023 20:18, Dmitry Rokosov wrote:
> In order to use the correct devname value for the S4 SoC family, it
> is imperative that we implement separate uart_data. Unlike the legacy
> g12a architecture, the S4 architecture should employ the use of 'ttyS'
> devname.
> 
> Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> ---
>   drivers/tty/serial/meson_uart.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
> index ad0748a10db7..6a63184b8091 100644
> --- a/drivers/tty/serial/meson_uart.c
> +++ b/drivers/tty/serial/meson_uart.c
> @@ -818,6 +818,11 @@ static struct meson_uart_data meson_g12a_uart_data = {
>   	.has_xtal_div2 = true,
>   };
>   
> +static struct meson_uart_data meson_s4_uart_data = {
> +	.uart_driver = &MESON_UART_DRIVER(ttyS),
> +	.has_xtal_div2 = true,
> +};
> +
>   static const struct of_device_id meson_uart_dt_match[] = {
>   	{ .compatible = "amlogic,meson6-uart" },
>   	{ .compatible = "amlogic,meson8-uart" },
> @@ -829,7 +834,7 @@ static const struct of_device_id meson_uart_dt_match[] = {
>   	},
>   	{
>   		.compatible = "amlogic,meson-s4-uart",
> -		.data = (void *)&meson_g12a_uart_data,
> +		.data = (void *)&meson_s4_uart_data,
>   	},
>   	{ /* sentinel */ },
>   };

With the real struct name:

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
