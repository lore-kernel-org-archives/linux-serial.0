Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45549EB64DD
	for <linux-serial@archiver.kernel.org>; Tue, 18 Jul 2023 08:40:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbjGRIkG (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 18 Jul 2023 04:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231942AbjGRIkF (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 18 Jul 2023 04:40:05 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BED2135
        for <linux-serial@vger.kernel.org>; Tue, 18 Jul 2023 01:40:04 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b701e1ca63so82448421fa.1
        for <linux-serial@vger.kernel.org>; Tue, 18 Jul 2023 01:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689669602; x=1690274402;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=woIb3SjHXD99MqsCp0i8NLJW/epsC4Wb4octK3c74H8=;
        b=CyPEb8cUR13YpK+EGscbjkqWOOcir6/Stq/pc/Gk4qj30CPyvIwDeob9p9VIBi7i9L
         c/LBwxL94QikRpPDzurawrSuIgaO3nGKiQk/dHaye+8Rbv/1Ey0GCFCL35x4YDSUNqKj
         AkWKAUTKukjyVUJqhGHYNdDh+KUyux9DI/EiBqcnmA8QyAQQuGlDCqXSAO0Q8iBx21L2
         CRBdmuyBwSvWl4hEtZAzThC84JoGN95JvIDeGlGdSqwBCMBM5fcZFaP2TiaLJJ28ByQU
         5DFenuqQp7J2fQ2WEdd4BelTkrFNA/Q0p1u+OVqJDVus9uUPbfX4nhZLTd7sYUztGQoe
         Dhzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689669602; x=1690274402;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=woIb3SjHXD99MqsCp0i8NLJW/epsC4Wb4octK3c74H8=;
        b=JI8yJ4nfkFiM8AsPblC7joXumr8n+80/wVsXMTgh40xYPaZC2dF0+Vgzug59xRvSm6
         5JS7Ey/YHOFx7Yb3HYKlvH6Kghbjl3+MAqMFNpAuy6v+wYqJT8sESLW25AiMbDRGIYBM
         hQ0LSKgHRbUebQGxcXxqKsg4HX/vAieT31TyccwFTvSHoz7gCp/AdifVJXk3xALydnHe
         w2vVQs9Y5lrGbb7E1B6ZdeQdQIxyGGTQKW2ClIclDtp6FFLe0R7BHS711DpBh1lZ7f9k
         kJAIt0TdCYLznxC1oU4BHMz9jw5OhFb+EGDXckG/gZtknSVpJREj2Y7P6H6THASGE0EO
         b5lw==
X-Gm-Message-State: ABy/qLZb5/QMOfvRu2YK1NIL8bkSS8eOvdQ+VRKjemS/lW8Q+RdFV2Gs
        jfwEf0qkQIxllDE4Yh5WCtmOZg==
X-Google-Smtp-Source: APBJJlEXMa6a/aCnbA/M/4W2DhmsQJGnLpxBUTBmwq6Wr4WMSsGoZSD9nmG2ddD54+XPSSm7jCv99w==
X-Received: by 2002:a2e:980a:0:b0:2b6:dd85:1206 with SMTP id a10-20020a2e980a000000b002b6dd851206mr9880471ljj.49.1689669602433;
        Tue, 18 Jul 2023 01:40:02 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id q17-20020a2e9691000000b002b6ee1e8893sm359746lji.95.2023.07.18.01.40.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 01:40:02 -0700 (PDT)
Message-ID: <02cc38f9-d742-9695-eb0f-0a5fca096c3a@linaro.org>
Date:   Tue, 18 Jul 2023 11:40:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] tty: serial: add missing clk_put()
Content-Language: en-GB
To:     sunran001@208suo.com, gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230718075401.16668-1-xujianghui@cdjrlc.com>
 <047273ae4e4c25eb7b81fd69d761161e@208suo.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <047273ae4e4c25eb7b81fd69d761161e@208suo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 18/07/2023 10:55, sunran001@208suo.com wrote:
> This patch fixes the following Coccinelle error:
> 
> ./drivers/tty/serial/bcm63xx_uart.c:854:2-8: ERROR: missing clk_put;
> clk_get on line 849 and execution via conditional on line 853
> 
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>   drivers/tty/serial/bcm63xx_uart.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/tty/serial/bcm63xx_uart.c 
> b/drivers/tty/serial/bcm63xx_uart.c
> index 55e82d0bf92d..7353b683952d 100644
> --- a/drivers/tty/serial/bcm63xx_uart.c
> +++ b/drivers/tty/serial/bcm63xx_uart.c
> @@ -851,6 +851,7 @@ static int bcm_uart_probe(struct platform_device *pdev)
>           clk = of_clk_get(pdev->dev.of_node, 0);
> 
>       if (IS_ERR(clk))
> +        clk_put(clk);

No!

First, calling clk_put() on the error pointer is incorrect. This will 
throw a warning in __clk_put(), but generally passing an error pointer 
to another function can cause different kinds of breakage.

Second, you have added the line, but this also moved the return 
statement out of the if condition. This way all bcm_uart_probe() calls 
will end up with -ENODEV return value.

Please stop blindly fixing the coccinelle warnings. Take care to read 
and understand the code.

>           return -ENODEV;
> 
>       port->iotype = UPIO_MEM;

-- 
With best wishes
Dmitry

