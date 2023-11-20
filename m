Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B7D6C197A0
	for <linux-serial@archiver.kernel.org>; Mon, 20 Nov 2023 07:13:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbjKTHNG (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 20 Nov 2023 02:13:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbjKTHNF (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 20 Nov 2023 02:13:05 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD0979F
        for <linux-serial@vger.kernel.org>; Sun, 19 Nov 2023 23:13:01 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-50970c2115eso5807576e87.1
        for <linux-serial@vger.kernel.org>; Sun, 19 Nov 2023 23:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1700464380; x=1701069180; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wLaWQRdfr6nMXYi7OACSu7/8cprPzA6DbFJtJv63SGI=;
        b=bhRTW9ZrHM0RzAcHbQyMaZfux5E72+Ag+0SrZKQhkGWe6dnziCmxPDxsVzNogxYp1p
         Q4UJZ1bC9ImHvK+f/caoxlsJvH0N3iis2wAn2+jq+EhjoeAfYj8V46J0muRpLT/lmeni
         ElXMUEU/ZIgA6wiXguOYZxoI4FeD0EvlWiL6Adz3SKVhGKQkkWUTq82LbPHoXHaSNLpj
         MTNBW0K3/ZKFP4Rg6zV0bdlO9HydRoHfCSqrVll4Wa6peswsXOU7DX+p4J2QSYwkXQ+0
         VJuVdVMJG0+qWWNPJMYaTyFjXdpF2I1Q2fT/KaBZfweLOmyNeuEqUddk2A7c28+UCYJm
         LrWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700464380; x=1701069180;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wLaWQRdfr6nMXYi7OACSu7/8cprPzA6DbFJtJv63SGI=;
        b=j3Im99trLx+5nfohBW8x9gCAsLmXre4ooo9pGGk6Ttxc8Ck+vq43EffmZS+mEwi0Jr
         5Fchmmz9vJi7TUmCGpVwdpoL48+pEBWdo50kVzmacZup/lPnN77DKPEVhwuR6xXl7/ED
         5uv+YgPzTXPd8uiSfY+SwSWMdrX5OlNZvEUPuIyReJ2YQbnRADFqBnQc+Mp0DcqRfuGB
         g+k5zO+dB/lLAAqu2AFkcBVVgQUcBemN8ZQ/eR9Nl9MoZaPno6H9VhLW8gnSllLVdNc/
         fZvG+MMzIN1iA3haQsScXbFWTXZq25Fy/XJJO/ceyRZb3fjjGNP+A6f20dYpekHjzOy8
         mnaw==
X-Gm-Message-State: AOJu0Yy64QgEk7XeMaHpfdDqFsomzPGcStAgp6KSzN1FibU4FDeC+OG4
        Ojd9eBZxo5siPgd+53ILpYn2EQ==
X-Google-Smtp-Source: AGHT+IHHFMPQE7uzRJ7hggvhdnwod6oYenlYn43gfqLBGmts/lNT/cwsHue+sv5rh25AhF8PCpDjiA==
X-Received: by 2002:a05:6512:358f:b0:502:a4f4:ced9 with SMTP id m15-20020a056512358f00b00502a4f4ced9mr4139590lfr.62.1700464379945;
        Sun, 19 Nov 2023 23:12:59 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.183])
        by smtp.gmail.com with ESMTPSA id d15-20020adffd8f000000b003316debbde4sm8229214wrr.48.2023.11.19.23.12.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Nov 2023 23:12:59 -0800 (PST)
Message-ID: <e37ce03e-4e41-4262-9f54-bcbab3bb1421@tuxon.dev>
Date:   Mon, 20 Nov 2023 09:12:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] serial: atmel: convert not to use
 dma_request_slave_channel()
Content-Language: en-US
To:     Jiri Slaby <jirislaby@kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Richard Genoud <richard.genoud@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <f2e9790d8b49aeba8b43ce018d30a35b837ac1eb.1700409299.git.christophe.jaillet@wanadoo.fr>
 <ccfcf2a5-c04b-4781-8658-d63044b9b9c6@tuxon.dev>
 <5c2ec2ff-459e-4bb7-b287-8a06005c86f5@kernel.org>
From:   claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <5c2ec2ff-459e-4bb7-b287-8a06005c86f5@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On 20.11.2023 09:04, Jiri Slaby wrote:
> On 20. 11. 23, 7:14, claudiu beznea wrote:
>> Hi, Christophe,
>>
>> On 19.11.2023 17:55, Christophe JAILLET wrote:
>>> dma_request_slave_channel() is deprecated. dma_request_chan() should
>>> be used directly instead.
>>>
>>> Switch to the preferred function and update the error handling accordingly.
>>>
>>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>>> ---
>>> v2: Also update atmel_prepare_rx_dma()
>>> ---
>>>   drivers/tty/serial/atmel_serial.c | 16 ++++++++++++----
>>>   1 file changed, 12 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/tty/serial/atmel_serial.c
>>> b/drivers/tty/serial/atmel_serial.c
>>> index 1946fafc3f3e..6aeb4648843b 100644
>>> --- a/drivers/tty/serial/atmel_serial.c
>>> +++ b/drivers/tty/serial/atmel_serial.c
>>> @@ -1013,14 +1013,18 @@ static int atmel_prepare_tx_dma(struct uart_port
>>> *port)
>>>       struct device *mfd_dev = port->dev->parent;
>>>       dma_cap_mask_t        mask;
>>>       struct dma_slave_config config;
>>> +    struct dma_chan *chan;
>>
>> There is no need for this.
> 
> How'd you avoid crash in here then:
>         if (atmel_port->chan_tx)
>                 atmel_release_tx_dma(port);
> ?

I wanted to say that instead of adding the chan variable the
atmel_port->chan_tx would be used instead.

> 
> thanks,
