Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6330C433DB
	for <linux-serial@archiver.kernel.org>; Mon, 11 Jan 2021 09:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C69B22AAD
	for <linux-serial@archiver.kernel.org>; Mon, 11 Jan 2021 09:58:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728444AbhAKJ65 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 11 Jan 2021 04:58:57 -0500
Received: from mail-ej1-f49.google.com ([209.85.218.49]:33695 "EHLO
        mail-ej1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728179AbhAKJ65 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 11 Jan 2021 04:58:57 -0500
Received: by mail-ej1-f49.google.com with SMTP id b9so23949715ejy.0;
        Mon, 11 Jan 2021 01:58:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=udVCXM7Wn35aQirz5a19QL8QpKzWmV0LS9M/curg0D0=;
        b=hewb9nzUIuPy/0EnWdpiHotg1K2M4IuKAsiXEqsP6AznGy8pd7hJEJc3G4CRtuR1gE
         1jCQtTZw58KkgZ0arMyaYC/Jd9sboJJpYvuVC3u5Ts7HpG1GmKLSnRRWi7HqxhsCwR5Q
         p36li4Hdk/1n8kDjTjADHU7vdIfilyCRdQsdt0DWku1ZDsV23a5z6VOmf3FiJQFjmNm1
         cixzdH2HiXlrJ3RJW91END9fcK3nrYsx1q0lYU52ApqALQcli0Fl7/7c2+Q7R6HDotYP
         QPU4UMeA70AUmQOOYIp5x2QhPNQ3kkGi2n0lXfrInLGiuKUbuYeR/5IxYeZtdoL3ukaT
         Z/qg==
X-Gm-Message-State: AOAM530HVVDrnYXtSRUUQOv3A71vIEHKd1xAX4rpXuWZTkRNLWnteigM
        m6k4BhXoAK8yw7ZiN8HxCBCL4CbU42sdXg==
X-Google-Smtp-Source: ABdhPJyVCsq5rTpUoTohT6CO72JxfdIzcL6xyKG3YEeMy01WtRt4r8yKJY30OCuOioOtV5QLCMAfsA==
X-Received: by 2002:a17:906:edb2:: with SMTP id sa18mr9801943ejb.264.1610359094509;
        Mon, 11 Jan 2021 01:58:14 -0800 (PST)
Received: from ?IPv6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id r21sm7390769eds.91.2021.01.11.01.58.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jan 2021 01:58:13 -0800 (PST)
Subject: Re: [PATCH v2 2/8] serial: stm32: fix code cleaning warnings and
 checks
To:     Erwan Le Ray <erwan.leray@foss.st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Valentin Caron <valentin.caron@foss.st.com>
References: <20210106162203.28854-1-erwan.leray@foss.st.com>
 <20210106162203.28854-3-erwan.leray@foss.st.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <72c81157-4bd1-6a3e-2415-92a2fb29ab6d@kernel.org>
Date:   Mon, 11 Jan 2021 10:58:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210106162203.28854-3-erwan.leray@foss.st.com>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 06. 01. 21, 17:21, Erwan Le Ray wrote:
> --- a/drivers/tty/serial/stm32-usart.c
> +++ b/drivers/tty/serial/stm32-usart.c
...
> @@ -973,18 +971,17 @@ static int stm32_init_port(struct stm32_port *stm32port,
>   	struct resource *res;
>   	int ret;
>   
> +	ret = platform_get_irq(pdev, 0);
> +	if (ret <= 0)
> +		return ret ? : -ENODEV;
> +
>   	port->iotype	= UPIO_MEM;
>   	port->flags	= UPF_BOOT_AUTOCONF;
>   	port->ops	= &stm32_uart_ops;
>   	port->dev	= &pdev->dev;
>   	port->fifosize	= stm32port->info->cfg.fifosize;
>   	port->has_sysrq = IS_ENABLED(CONFIG_SERIAL_STM32_CONSOLE);
> -
> -	ret = platform_get_irq(pdev, 0);
> -	if (ret <= 0)
> -		return ret ? : -ENODEV;
>   	port->irq = ret;

I would move this set from ret above too. Or introduce a new variable, 
e.g. "irq".

thanks,
-- 
js
suse labs
