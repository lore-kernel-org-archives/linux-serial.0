Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58CC0C2B9F4
	for <linux-serial@archiver.kernel.org>; Fri, 25 Jun 2021 06:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25ACA6008E
	for <linux-serial@archiver.kernel.org>; Fri, 25 Jun 2021 06:01:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbhFYGEA (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 25 Jun 2021 02:04:00 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:41751 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbhFYGEA (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 25 Jun 2021 02:04:00 -0400
Received: by mail-wr1-f47.google.com with SMTP id f15so9245463wro.8;
        Thu, 24 Jun 2021 23:01:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=a2BnCJpAPmMnW016bHj05vszYD4Yd+B9qTL6NPUz9K0=;
        b=KU2rYbWUY7WKqPEZxG+rzyKN7/JAye/vW7WVNPzmcw2JvhGUhJLxtlIR1EjoCcFcvk
         4BpoiJXuGfoCy750xKuIwOTk/Zg6ZWaVpdsInCIyrwIpsLmxgloLmoHO4iqoz/NoiCO7
         u/sx4+f3s8zqnWlAcOulpqBLmFbWMWrTvdlDc13QAWaLqkAEHo5EkTZEzXDj3u1OM+Sd
         CpQy8ejIxTViA+06D10TE20CLBNVxR/Y959Y/QR1YKRY8WRV08qn80WX4PvvA4BWTrLl
         zj66KVK3Q8aS1/U7KTlclPhBFqq3vFCVTvT4MqUnIL1+t5/b7FYyj3fVSIu0updnXFI8
         QBzg==
X-Gm-Message-State: AOAM531X8WFth3gnTsaoG8cgix0h1us9zgakMd8CA+uZIVJS5RRkwH+q
        r2zpq/wxX3IzK8bsOck/OE57sTjugfM=
X-Google-Smtp-Source: ABdhPJxPprFP0lePHqc4Vof6Wrz9FcgQ6LcthBQdObjZxkFIaHDu8z6whoxkBi3Y/3O3VnUsXodfeQ==
X-Received: by 2002:adf:ef0d:: with SMTP id e13mr8723147wro.155.1624600897617;
        Thu, 24 Jun 2021 23:01:37 -0700 (PDT)
Received: from [192.168.1.49] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id o2sm5130226wrp.53.2021.06.24.23.01.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jun 2021 23:01:37 -0700 (PDT)
Subject: Re: [PATCH v2] serial: amba-pl011: add RS485 support
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     linux@armlinux.org.uk, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210618145153.1906-1-LinoSanfilippo@gmx.de>
 <YNSA1H0cFKiPUn6N@kroah.com> <5d7a4351-2adc-ea31-3290-91d91bd5a5d4@gmx.de>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <db436292-4115-0755-57d8-d63986f84453@kernel.org>
Date:   Fri, 25 Jun 2021 08:01:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <5d7a4351-2adc-ea31-3290-91d91bd5a5d4@gmx.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 25. 06. 21, 2:15, Lino Sanfilippo wrote:
>>> +static int pl011_rs485_config(struct uart_port *port,
>>> +			      struct serial_rs485 *rs485)
>>> +{
>>> +	struct uart_amba_port *uap =
>>> +		container_of(port, struct uart_amba_port, port);
>>> +
>>> +	/* pick sane settings if the user hasn't */
>>> +	if (!!(rs485->flags & SER_RS485_RTS_ON_SEND) ==
>>
>> Why the !! in an if statement?
>>
>>> +	    !!(rs485->flags & SER_RS485_RTS_AFTER_SEND)) {
>>
>> Same here, why?
>>
> 
> This was copied from serial8250_em485_config(). But I think we can simply use
> 
> 	if (rs485->flags & SER_RS485_RTS_AFTER_SEND)
> 		rs485->flags &= ~SER_RS485_RTS_ON_SEND;
> 	else
> 		rs485->flags |= SER_RS485_RTS_ON_SEND;
> 
> instead. I will adjust the code accordingly.

This is different. You want to set ON_SEND when none is set. And unset 
AFTER_SEND when both are set. In your code, when both are set, you leave 
AFTER_SEND.

regards,
-- 
js
suse labs
