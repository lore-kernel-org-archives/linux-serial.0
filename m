Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6DE6EB64D9
	for <linux-serial@archiver.kernel.org>; Thu,  6 Jul 2023 06:59:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbjGFG7N (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 6 Jul 2023 02:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjGFG7M (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 6 Jul 2023 02:59:12 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB2EFC
        for <linux-serial@vger.kernel.org>; Wed,  5 Jul 2023 23:59:10 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4f766777605so360380e87.1
        for <linux-serial@vger.kernel.org>; Wed, 05 Jul 2023 23:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688626749; x=1691218749;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=n9jFGb+PSmEKw8iM/L00npVmUzIMITjEUhyzwx30WLI=;
        b=bmDp52z15koXF7vGD+7OtpSMg8hXMZxBA5HXT+R2fq3fCMXEPDAL6DMaPcZrckr+L5
         kQRjAKeMtrn0RWYeixsJIdXvpfEkHydJscG8G8oy7nFvsV0WBJZHENFa7tyY87aufkrR
         WmysYoFxfFwHVOzn8HTqVamcfMl31dAG1T9yzKiB7GxN4HtGXPbjAW9dOOHZ/v8R+xB4
         RRpVHVhZgfR2oQNn2INzHjN1qzM1cJ5Rs5mMHwRzKjKJPwaAllJ0GoMiS/zgLRJzITyN
         5S4Aqakeq9i9MbDh1OAp0bkOvLRo0OiT0Jp/aihP30j9ohvhtEXwFROlJ8glr0V0hyLi
         a21Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688626749; x=1691218749;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n9jFGb+PSmEKw8iM/L00npVmUzIMITjEUhyzwx30WLI=;
        b=Bzk4zG+k9lnXjZoeWw4RLLtkRqtTB1nJEHG2ZVU+ru5J36QzQ+sQzfKBmeWHKNJ4xG
         hE95M98edYqHR0Xg9i28wIeMBJ9hMnp0BGyKNafBFNluSawMwEF4hzC67Z63hSYot/yj
         hjxAkn1Nu4Ip98Smpi0h/NcG3MI9DRJQnXMPwcB6JONZIYvDGVusI2os8ECm1Qid20R6
         D65X/w0ii6wV1gc8LyRTyB2KKXvJMbmmwfVdlq9nhcBfFJps4WQePu/jhkpUOlV11QST
         3fkU854YDI1miNlEOL+awno4EP6QJxlJBjCtAZLG9CnYMqeX2YIzYppQqb01+5vKcGwQ
         USew==
X-Gm-Message-State: ABy/qLZS6o2c9x2PTvZrkP7hDV5TASwUvOZCoTrvFm2JX6Lf+a3Yk1D5
        EY55+KPBQB2EgzTZOyHNO2KzUQ==
X-Google-Smtp-Source: APBJJlHTzvV9NhPMkxSawgnU9Y4RN/6R8ct5nXX+3GLyP9CpFEYnVs5XlufLfY0d5j2KuXPAyOMDFg==
X-Received: by 2002:a05:6512:451:b0:4f9:5ac3:4133 with SMTP id y17-20020a056512045100b004f95ac34133mr825472lfk.25.1688626748995;
        Wed, 05 Jul 2023 23:59:08 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:15d1:2748:ead4:bdff? ([2a01:e0a:982:cbb0:15d1:2748:ead4:bdff])
        by smtp.gmail.com with ESMTPSA id z8-20020adfdf88000000b003143bb5ecd5sm1001522wrl.69.2023.07.05.23.59.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jul 2023 23:59:08 -0700 (PDT)
Message-ID: <3beac94b-1a82-df36-1390-8321aa1a8e57@linaro.org>
Date:   Thu, 6 Jul 2023 08:59:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 1/7] tty: serial: meson: use dev_err_probe
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
 <20230705181833.16137-2-ddrokosov@sberdevices.ru>
Organization: Linaro Developer Services
In-Reply-To: <20230705181833.16137-2-ddrokosov@sberdevices.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 05/07/2023 20:18, Dmitry Rokosov wrote:
> Use dev_err_probe() helper for error checking and standard logging.
> It makes the driver's probe() function a little bit shorter.
> 
> Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> ---
>   drivers/tty/serial/meson_uart.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
> index 2501db5a7aaf..bca54f3d92a1 100644
> --- a/drivers/tty/serial/meson_uart.c
> +++ b/drivers/tty/serial/meson_uart.c
> @@ -726,8 +726,8 @@ static int meson_uart_probe(struct platform_device *pdev)
>   	of_property_read_u32(pdev->dev.of_node, "fifo-size", &fifosize);
>   
>   	if (meson_ports[pdev->id]) {
> -		dev_err(&pdev->dev, "port %d already allocated\n", pdev->id);
> -		return -EBUSY;
> +		return dev_err_probe(&pdev->dev, -EBUSY,
> +				     "port %d already allocated\n", pdev->id);
>   	}
>   
>   	port = devm_kzalloc(&pdev->dev, sizeof(struct uart_port), GFP_KERNEL);

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
