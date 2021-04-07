Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C9CEC433B4
	for <linux-serial@archiver.kernel.org>; Wed,  7 Apr 2021 13:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D755761353
	for <linux-serial@archiver.kernel.org>; Wed,  7 Apr 2021 13:11:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233528AbhDGNL7 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 7 Apr 2021 09:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232797AbhDGNL7 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 7 Apr 2021 09:11:59 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E496CC061756;
        Wed,  7 Apr 2021 06:11:49 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id c16so18688666oib.3;
        Wed, 07 Apr 2021 06:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Mk71yyN1xvENIr0yVo76bh0xoPMN0ue85ZdzJkrLLm4=;
        b=elyENxHDmbUSBrhTlLcISp/1lX4HwoReG+EZshBnSTM/OqM4S7kXvF6Gx6JT5A/LkP
         qNq5iVTlE6uS80uz5xQ6YD0bwFiDD4eineDiKh1zq1oktSV1k2KDCMwm4pcttiLoWx0M
         IBbCZiJQ8dSyBk0uCY5ffyQJSuWsq3ixEp/nklSyOZ1Hq51k/LFilAU2pYvfcMV3+5Bk
         5tFLZt3xy97bkyOjVjKIreov1GtITQfqKMq6rtNljJPKu9ZwdKrT092K5fO+AXXKpQRl
         W33TPZJHxCmMC19rCAz78F0Xx41R8lxRJSa3d4wzBDRFVVKKUkAliX9/VNhn2Z5mWFKY
         V3Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Mk71yyN1xvENIr0yVo76bh0xoPMN0ue85ZdzJkrLLm4=;
        b=cSyxCFRGokSfnj6Zj0JAxtb2tij29RVClSvfeGruR1me/vOYV+4qV8g1vH6xMNu3jY
         fMs6mTMGmvOqVQ+d3uIvGMoLZyZOUO7mTTfinnPeHhMTqU2fCCvwSLrl8Ap9kedYQhV+
         1KdUMidl7B9CqHs+PLSGJhttuLixyTwBu0JjelVUFD+Fnw1AIoItMZt4cVCFDwtTgqxE
         IaZE1/fGgH6YsPf+FsBFcjuI3WSu2DclFdlxDyC4KwsEioxY+7fRac1A6xzYITfzHTEh
         lmqn5anjBa/P/KpgDSeUdj5xGoNe+Xyi+eUohevqBa3+6YtKCSAOsAIoF1686jSib/9L
         COfA==
X-Gm-Message-State: AOAM531+o8+8iHy5XsZG1/1cZ+70EvGoBSfZyKpBpSN8/SLNXMZSbYOR
        nl23GIa4U/xI2SV1p0F5lA0=
X-Google-Smtp-Source: ABdhPJyxIjWaIzTQQGQZvL8iBOAWn0/1fK3xVrypBycdFQp7gMLb5AGahGF6/gjnYQ3w/0WlH/NOgg==
X-Received: by 2002:a05:6808:10c5:: with SMTP id s5mr2193331ois.58.1617801109221;
        Wed, 07 Apr 2021 06:11:49 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e15sm5292139otk.64.2021.04.07.06.11.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Apr 2021 06:11:48 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v2 1/1] serial: sh-sci: Respect deferred probe when
 getting IRQ
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
References: <20210407101713.8694-1-andriy.shevchenko@linux.intel.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <33a5ee25-d4c9-b5c2-b5f9-05316b1139c0@roeck-us.net>
Date:   Wed, 7 Apr 2021 06:11:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210407101713.8694-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 4/7/21 3:17 AM, Andy Shevchenko wrote:
> With platform_get_irq() and its optional variant it's possible to get
> a deferred probe error code. Since the commit ed7027fdf4ec ("driver core:
> platform: Make platform_get_irq_optional() optional") the error code
> can be distinguished from no IRQ case. With this, rewrite IRQ resource
> handling in sh-sci driver to follow above and allow to respect deferred
> probe.
> 
> Fixes: ed7027fdf4ec ("driver core: platform: Make platform_get_irq_optional() optional")
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

This patch alone causes a hard hang early during boot. It works if applied
together with ed7027fdf4ec. Ultimately that means that ed7027fdf4ec introduces
a functional change, and will need to be applied very carefully. A cursory
glance through callers of platform_get_irq_optional() shows that many
do not handle this correctly: various drivers handle a return value of 0
as valid interrupt, and others treat errors other than -ENXIO as fatal.

Also, each patch on its own causes failures on sh, which is problematic
when applying them even as series. See below for an idea how to
address that.

> ---
> v2: fixed a typo: i -> 0
>  drivers/tty/serial/sh-sci.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
> index ad2c189e8fc8..574f68ba50ff 100644
> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -2899,13 +2899,6 @@ static int sci_init_single(struct platform_device *dev,
>  	port->mapbase = res->start;
>  	sci_port->reg_size = resource_size(res);
>  
> -	for (i = 0; i < ARRAY_SIZE(sci_port->irqs); ++i) {
> -		if (i)
> -			sci_port->irqs[i] = platform_get_irq_optional(dev, i);
> -		else
> -			sci_port->irqs[i] = platform_get_irq(dev, i);
> -	}
> -
>  	/* The SCI generates several interrupts. They can be muxed together or
>  	 * connected to different interrupt lines. In the muxed case only one
>  	 * interrupt resource is specified as there is only one interrupt ID.
> @@ -2913,12 +2906,17 @@ static int sci_init_single(struct platform_device *dev,
>  	 * from the SCI, however those signals might have their own individual
>  	 * interrupt ID numbers, or muxed together with another interrupt.
>  	 */
> +	sci_port->irqs[0] = platform_get_irq(dev, 0);
>  	if (sci_port->irqs[0] < 0)
> -		return -ENXIO;
> +		return sci_port->irqs[0];
>  
> -	if (sci_port->irqs[1] < 0)
> -		for (i = 1; i < ARRAY_SIZE(sci_port->irqs); i++)
> +	for (i = 1; i < ARRAY_SIZE(sci_port->irqs); ++i) {
> +		sci_port->irqs[i] = platform_get_irq_optional(dev, i);
> +		if (sci_port->irqs[i] < 0)
> +			return sci_port->irqs[i];
> +		if (sci_port->irqs[i] == 0)
>  			sci_port->irqs[i] = sci_port->irqs[0];

Since sh never gets -EPROBE_DEFER, the following code can be applied
on its own and does not depend on ed7027fdf4ec.

	sci_port->irqs[i] = platform_get_irq_optional(dev, i);
	if (sci_port->irqs[i] <= 0)
		sci_port->irqs[i] = sci_port->irqs[0];

With this change, sh images boot in qemu both with and without ed7027fdf4ec.

Thanks,
Guenter

> +	}
>  
>  	sci_port->params = sci_probe_regmap(p);
>  	if (unlikely(sci_port->params == NULL))
> 

