Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4774C07E9D
	for <linux-serial@archiver.kernel.org>; Thu, 29 Sep 2022 07:35:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232380AbiI2Hfb (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 29 Sep 2022 03:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbiI2Hfa (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 29 Sep 2022 03:35:30 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB9051402;
        Thu, 29 Sep 2022 00:35:23 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id h7so753405wru.10;
        Thu, 29 Sep 2022 00:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=GRl+oMu7Ig6loanPDrU5KffQs98gJpdl7SVPVmkpeUs=;
        b=XptR0Jko0ezYV8xZfhTNdfModNf63g9qzI2uE70iHH7JMDPV/Mey2Fr9Z1bwojW5Dx
         Wr2tbrsMShd/hytA/qhsWyu2OllTuU45th9ttL1P438klGwOAy9E8kIl9jUlT930LGkE
         MHFDaeTiX1XkAjfXR2pe8FtEv0R4LAUfF5g86ngPsIVUajnYxA2Doe6AvppEMvg6Mvlr
         O4T46clxAg8BdZEpDYJYs2jiVt6QcnrFe5WJ/GeWgGqo80Qfpp7vNfUfjQlgT1dyAbym
         AI6IcavxukZgrcMuyyTEUlujiw/B7nM+sU22BLxYRYc0Gajetj4u2LEyt2qlPJXWts4L
         5+rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=GRl+oMu7Ig6loanPDrU5KffQs98gJpdl7SVPVmkpeUs=;
        b=omZH1iQe4nFnA08lvfehxSYqzxls8JNArZXaAH7ozL4n4YWLCIXN/gI3fclpaZtwQs
         FN7Jqn/+xJZZKMKC4b5pYSeoWyyMsxgyjbOxCw0n4RbCBteOZi4tTfElaJ/rOUYUEiF/
         RH4kqgUFIW/sRVV1znb91d83AoCOOgSWmWFk5txY3qUHG1CbdRSX70iGmPGMsZrsHyUB
         I6s3RTQ9zcoLz3rrXHqvdpy5/zD9ic8U4f8aDL/MnvivArBj4nwPaCNiC0DfyWhiJL7A
         HM65WkHA0psHnLN0r8o1/+A6xzW+uKrjKoPeIiQfPlUT+7S8779knmAHpjRPMQbEi/Ig
         b8RQ==
X-Gm-Message-State: ACrzQf20w5j2j5pLw6KjhElEup/V804dHPp6LmeXszsatlt3+1RLArum
        YmMDjpg3es9x17wijpufwhg=
X-Google-Smtp-Source: AMsMyM4EvRgq4gnZR1Iisps+1a9RfHGEa3bzDN7qrMsXr6sMPIvBaj2TODLQj9wFNMRjx2/q8J9W4A==
X-Received: by 2002:a5d:6389:0:b0:22c:c497:4668 with SMTP id p9-20020a5d6389000000b0022cc4974668mr1132561wru.61.1664436921870;
        Thu, 29 Sep 2022 00:35:21 -0700 (PDT)
Received: from [192.168.178.202] (54.161.185.81.rev.sfr.net. [81.185.161.54])
        by smtp.gmail.com with ESMTPSA id o9-20020a05600c510900b003a5c244fc13sm4055195wms.2.2022.09.29.00.35.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 00:35:21 -0700 (PDT)
Message-ID: <ceefc4c1-128b-6582-6074-378ad3ae7e0a@gmail.com>
Date:   Thu, 29 Sep 2022 09:35:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH -next] tty: serial: atmel: driver depends on COMMON_CLK
Content-Language: fr
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Sergiu Moga <sergiu.moga@microchip.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
References: <20220929054851.7723-1-rdunlap@infradead.org>
From:   Richard Genoud <richard.genoud@gmail.com>
In-Reply-To: <20220929054851.7723-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,
Le 29/09/2022 à 07:48, Randy Dunlap a écrit :
> Since atmel_serial.c uses interfaces that are provided by
> the COMMON_CLK Kconfig symbol, the driver should depend on
> COMMON_CLK to prevent build errors.
> 
> ld: drivers/tty/serial/atmel_serial.o: in function `atmel_serial_pm':
> atmel_serial.c:(.text+0x1553): undefined reference to `__clk_is_enabled'
> ld: drivers/tty/serial/atmel_serial.o: in function `atmel_set_termios':
> atmel_serial.c:(.text+0x1dfe): undefined reference to `__clk_is_enabled'
> 
> Fixes: 5e3ce1f26129 ("tty: serial: atmel: Make the driver aware of the existence of GCLK")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Sergiu Moga <sergiu.moga@microchip.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Richard Genoud <richard.genoud@gmail.com>
> Cc: linux-serial@vger.kernel.org
> Cc: Jiri Slaby <jirislaby@kernel.org>

There's already a patch fixing this, acked by Nicolas :
https://lkml.org/lkml/2022/9/26/1587

> ---
>   drivers/tty/serial/Kconfig |    1 +
>   1 file changed, 1 insertion(+)
> 
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -128,6 +128,7 @@ config SERIAL_SB1250_DUART_CONSOLE
>   config SERIAL_ATMEL
>   	bool "AT91 on-chip serial port support"
>   	depends on ARCH_AT91 || COMPILE_TEST
> +	depends on COMMON_CLK
>   	select SERIAL_CORE
>   	select SERIAL_MCTRL_GPIO if GPIOLIB
>   	select MFD_AT91_USART

Thanks !

Regards,
Richard
