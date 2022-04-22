Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 045C1C433EF
	for <linux-serial@archiver.kernel.org>; Fri, 22 Apr 2022 12:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447531AbiDVMdS (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 22 Apr 2022 08:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447513AbiDVMdR (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 22 Apr 2022 08:33:17 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD3A56C3B
        for <linux-serial@vger.kernel.org>; Fri, 22 Apr 2022 05:30:23 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id o20-20020a05600c511400b0038ebbbb2ad8so5303798wms.0
        for <linux-serial@vger.kernel.org>; Fri, 22 Apr 2022 05:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=BoMVUFOEl6nR+FPyhiLBNUhDYjBNRueFaMw3cK0djfg=;
        b=OS02zn8X0KgjK9iT9Xgk16HCgAt33owcXhXxaYbK3kIjjJj/yoAwIZIl0xhse1yIFe
         O3ZYcXjEg478fq+/nX9frDJkZVaHZTldmZ+h+ZpmNZ5d0Ea91Qcn5ahbRWFbQ5Nn24B4
         WEqUCsC4H9QeiL3lT88hNFBmoWykZeBLJUjp1uWtahTnjJzwWNJ6cIVp9G/lBDHsJPyb
         +VMnIOu+bcMJRbCWjxfeO4Gr0ehqtFEnkdsnXGx4GAk8gxv4sFmsl2kBRZRf1zmoRC7N
         ayMEUxl0pKrgkEijMCdti/qjBDvgOlQyue9W60uRaCwYDPg/vOwpACJpSjactVpzQhKC
         TUTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=BoMVUFOEl6nR+FPyhiLBNUhDYjBNRueFaMw3cK0djfg=;
        b=2ytybsfbEaBi7CJb17BJWdvxV3jt1xRvYRaBne3TzrWU1r0wYrmqOYLpAlAXc55OIp
         RSovgyvWFoe8A/ZIJE3TKrjdihRPZT6bb2rXdNea3XQKB0HnGehITsi1cJ9ODFDJ4bx5
         T+kSrgsR0/pFiKVURj3+FGiVnu5uo5IZQQbCtTARsvzbfrMv1vl8Ib0Nt/Eyy721l48x
         cHHcMOq4eTFp+y7E4G/2L1SgAt2JbjJLRqxewHkxNtcS/+14IJHkx7W1buYcGRZnqCGB
         V5KjJrURfGc6HHwpBoEk4wFN3Sb5+kauSmO0cYX2Q8ofDYGmpB1UxDaziXnebUVOvemS
         rqtw==
X-Gm-Message-State: AOAM533Mx8Ru6vIpACaxx3n4sVxOcIK12Jor9WotxYFgEiEYtEeqKdYf
        NAsHjYIsyvbZXrGTbkOXp6rxz3BBxwrDX9bB
X-Google-Smtp-Source: ABdhPJwoZXt4bknR+hx1/TNbRlb+8yw8nHVeheySphVKUd/dY2/71ZZMppN8uXv7A3bTsypj7rUQyA==
X-Received: by 2002:a05:600c:35c9:b0:392:8e2a:d7aa with SMTP id r9-20020a05600c35c900b003928e2ad7aamr4130493wmq.34.1650630621966;
        Fri, 22 Apr 2022 05:30:21 -0700 (PDT)
Received: from ?IPV6:2001:861:44c0:66c0:3ce1:1ed1:5e14:cd49? ([2001:861:44c0:66c0:3ce1:1ed1:5e14:cd49])
        by smtp.gmail.com with ESMTPSA id t4-20020adfe104000000b00205b50f04f0sm1630593wrz.86.2022.04.22.05.30.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Apr 2022 05:30:21 -0700 (PDT)
Message-ID: <c4805983-7e07-73cf-39c2-5dc5728029f4@baylibre.com>
Date:   Fri, 22 Apr 2022 14:30:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH V3 2/2] tty: serial: meson: Added S4 SOC compatibility
Content-Language: en-US
To:     Yu Tu <yu.tu@amlogic.com>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <20220422111320.19234-1-yu.tu@amlogic.com>
 <20220422111320.19234-3-yu.tu@amlogic.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
In-Reply-To: <20220422111320.19234-3-yu.tu@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 22/04/2022 13:13, Yu Tu wrote:
> Make UART driver compatible with S4 SOC UART. Meanwhile, the S4 SOC
> UART uses 12MHz as the clock source for baud rate calculations.
> 
> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
> ---
>   drivers/tty/serial/meson_uart.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
> index 58bd2723c004..c748e5dd5348 100644
> --- a/drivers/tty/serial/meson_uart.c
> +++ b/drivers/tty/serial/meson_uart.c
> @@ -790,11 +790,19 @@ static int meson_uart_remove(struct platform_device *pdev)
>   	return 0;
>   }
>   
> +static struct meson_uart_data s4_uart_data = {
> +	.has_xtal_div2 = true,
> +};
> +
>   static const struct of_device_id meson_uart_dt_match[] = {
>   	{ .compatible = "amlogic,meson6-uart" },
>   	{ .compatible = "amlogic,meson8-uart" },
>   	{ .compatible = "amlogic,meson8b-uart" },
>   	{ .compatible = "amlogic,meson-gx-uart" },
> +	{
> +		.compatible = "amlogic,meson-s4-uart",
> +		.data = (void *)&s4_uart_data,
> +	},
>   	{ /* sentinel */ },
>   };
>   MODULE_DEVICE_TABLE(of, meson_uart_dt_match);

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
