Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B80C4332F
	for <linux-serial@archiver.kernel.org>; Mon,  7 Nov 2022 08:56:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbiKGI4Z (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 7 Nov 2022 03:56:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbiKGI4M (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 7 Nov 2022 03:56:12 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B60A167C8
        for <linux-serial@vger.kernel.org>; Mon,  7 Nov 2022 00:56:09 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id b9so15154866ljr.5
        for <linux-serial@vger.kernel.org>; Mon, 07 Nov 2022 00:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P4yobrH389xViJ4SBZFWFfQcSb3b4iE/4kaJv9Tjz9k=;
        b=C8nwMjrXclHLiiA9mnqL7dMI7CotpWmWWcW8tJTYs5IfQImFCwFYQGGd0msXx23n8Z
         PwyeSQFpKxiermhIXfHOr8zVnhtZw1M14z0/XLC/6UccJ1v2rQ+ehmzoqPlIisbvuGrD
         7v3eDxi19pA3Z/5NbNmx2E/IcIRrxdJ4PUPyOxfVmQl1uUTVIqy/hpNUHdwo/W4/6Bm4
         uKQDYjX/nbXKAudwwhePEemXKJn6bOc2ZxunHxTC+nHIwgBNKTYk0nELI/2CCnE/zQMf
         82kFR86JK+DZoJAhFRO6+nvCjVeSjVnFR0zwnWigQ//8SJZrzcWgVBbw6Pi9EBbsyY/z
         PLEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P4yobrH389xViJ4SBZFWFfQcSb3b4iE/4kaJv9Tjz9k=;
        b=P0zMDVeoVqK+i/f1OU6GAwd+aRZ6RDx3QJMJJ8Yf+UE5lR4y+yq0cdE+bib1KxMJwT
         0YSrrxmeFrCjM/ou48Rq+iJb8kd96Z3aghWrzDHhPF7E4Kw5p491p/ELuiaybtOhL+YZ
         pRuu57P+gso3S1fGWwlO+74UD73Cep0JJSf+7o5ATGh1pmZd2KBwQCTFOE2yD95Y+zi8
         3+j63NydhAXZSVxEmbPtQcQrqFUK3Mn4QHUULOp0H/nYXWROIrARkIg2moZ6SVlJW+zp
         5Mt7wO9pDy/K5e7uP/xz4NGmxKkLSmqm6lIJWDVzhT9BbUuIaALzmCRGnD1AORiH27WR
         /+qw==
X-Gm-Message-State: ACrzQf2vHvZZyb7FKSPo3RfLL3U+TyVXUtzYSiNWWvFO5Mfh7XY1vZj9
        kqqblTdrYZZLQScMqn651veLkQ==
X-Google-Smtp-Source: AMsMyM4ZERp7BWFG36Cafz3vkYEC3LGMahSlKJC0z0UT6sIbju2zMZTPur0IwA5eMDswCZOMP2wVnw==
X-Received: by 2002:a2e:c4a:0:b0:277:3931:6dc9 with SMTP id o10-20020a2e0c4a000000b0027739316dc9mr18055896ljd.45.1667811367911;
        Mon, 07 Nov 2022 00:56:07 -0800 (PST)
Received: from [192.168.0.20] (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id e23-20020a196917000000b004979df1c1fasm1145290lfc.61.2022.11.07.00.56.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 00:56:06 -0800 (PST)
Message-ID: <d7e7e6cb-eeb4-49b1-595b-8b44c519b586@linaro.org>
Date:   Mon, 7 Nov 2022 09:56:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] tty: serial: samsung_tty: Fix clk resource leak issue
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>,
        Xiu Jianfeng <xiujianfeng@huawei.com>
Cc:     alim.akhtar@samsung.com, jirislaby@kernel.org, ben-linux@fluff.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.or
References: <20221107062120.20321-1-xiujianfeng@huawei.com>
 <Y2iw+QdyfGGNz9pU@kroah.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Y2iw+QdyfGGNz9pU@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 07/11/2022 08:17, Greg KH wrote:
> On Mon, Nov 07, 2022 at 02:21:20PM +0800, Xiu Jianfeng wrote:
>> In the s3c24xx_serial_get_options(), calling clk_get() without clk_put()
>> will cause clk resource leak issue, this patch fixes it.
>>
>> Fixes: b497549a035c ("[ARM] S3C24XX: Split serial driver into core and per-cpu drivers")
>> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
>> ---
>>  drivers/tty/serial/samsung_tty.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
>> index 77d1363029f5..8a3bb9832172 100644
>> --- a/drivers/tty/serial/samsung_tty.c
>> +++ b/drivers/tty/serial/samsung_tty.c
>> @@ -2529,9 +2529,10 @@ s3c24xx_serial_get_options(struct uart_port *port, int *baud,
>>  		sprintf(clk_name, "clk_uart_baud%d", clk_sel);
>>  
>>  		clk = clk_get(port->dev, clk_name);
>> -		if (!IS_ERR(clk))
>> +		if (!IS_ERR(clk)) {
>>  			rate = clk_get_rate(clk);
>> -		else
>> +			clk_put(clk);
>> +		} else
> 
> How was this tested?

The driver has such potential missing clk_put in few other places as
well: here on success path and few error paths after calling
s3c24xx_serial_enable_baudclk(). Yet I am concerned that none of these
paths were actually tested...

Best regards,
Krzysztof

