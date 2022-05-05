Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD18C433F5
	for <linux-serial@archiver.kernel.org>; Thu,  5 May 2022 01:02:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234023AbiEEBGG (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 4 May 2022 21:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234018AbiEEBGF (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 4 May 2022 21:06:05 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0BF246B3D
        for <linux-serial@vger.kernel.org>; Wed,  4 May 2022 18:02:27 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 5BD788021F;
        Thu,  5 May 2022 03:02:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1651712544;
        bh=pWrURzubWu+p/NpTsyL688Pw7a3ZTUEd1pN76BWk2CI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Lc2xswilLZZ+NnESnlhBrCD368bj8HeNoDssmFqANNiPglLqbJXjEmed8QRb5ojxU
         MQUhdRm4MtX3e1uUYuGQfRmylFhym63G9gLfw687Yw4Y08QhiG8pIcb8X5Fsrq5xN8
         AJ6vdcSvW6tAI1rvh02YSYDxIxqdkOhOUwKeMygVYEqROpb8DQVXuooTkdgXwZUy6T
         buvblAul7yoNAzBpnDmBlYXRzVgADmwKPWnqtGxzBnGXDcdey6jQbhii1SlAh6LihQ
         W2aNyt4LoxTgVJWYKGldgLZ/AJ+DAUu1nciwzDV1CXE2RP1x9laVHiTCg22t8zCWkp
         6CnwnM0cbOqfA==
Message-ID: <5adb61a1-7959-cab3-2be6-ab7555ed7876@denx.de>
Date:   Thu, 5 May 2022 03:02:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 2/2] serial: stm32: Use TC interrupt to deassert GPIO RTS
 in RS485 mode
Content-Language: en-US
To:     Erwan LE RAY <erwan.leray@foss.st.com>,
        linux-serial@vger.kernel.org
Cc:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jean Philippe Romain <jean-philippe.romain@foss.st.com>,
        Valentin Caron <valentin.caron@foss.st.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
References: <20220430162845.244655-1-marex@denx.de>
 <20220430162845.244655-2-marex@denx.de>
 <702dcede-ff97-b074-20bf-7c695f988d40@foss.st.com>
 <18f886d9-924b-e32b-e298-90e998b30662@denx.de>
 <57896136-5e08-b9fe-2e3e-0eff4388e064@foss.st.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <57896136-5e08-b9fe-2e3e-0eff4388e064@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.5 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 5/4/22 17:54, Erwan LE RAY wrote:

Hi,

[...]

>>>> diff --git a/drivers/tty/serial/stm32-usart.c 
>>>> b/drivers/tty/serial/stm32-usart.c
>>>> index 224f359c6051e..764415b8e8f03 100644
>>>> --- a/drivers/tty/serial/stm32-usart.c
>>>> +++ b/drivers/tty/serial/stm32-usart.c
>>>> @@ -417,6 +417,14 @@ static void 
>>>> stm32_usart_tx_interrupt_enable(struct uart_port *port)
>>>>           stm32_usart_set_bits(port, ofs->cr1, USART_CR1_TXEIE);
>>>>   }
>>>> +static void stm32_usart_tc_interrupt_enable(struct uart_port *port)
>>>> +{
>>>> +    struct stm32_port *stm32_port = to_stm32_port(port);
>>>> +    const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
>>>> +
>>>> +    stm32_usart_set_bits(port, ofs->cr1, USART_CR1_TCIE);
>>>> +}
>>>> +
>>> I don't see the added value of this helper (only 1 instruction used 1 
>>> time), and other Interrupt Enabled bits are already set/unset in 
>>> others functions of this driver.
>>> To keep an homogeneous code in the driver, could you please remove 
>>> this helper and set TCIE directly when you need it ?
>>
>> Should I also remove stm32_usart_tx_interrupt_enable() / 
>> stm32_usart_tx_interrupt_disable() , which does the same thing for 
>> other bits in the interrupt register ?
>>
> In stm32_usart_tx_interrupt_enable() / 
> stm32_usart_tx_interrupt_disable() case, 2 bits are configured 
> differently under a condition, and stm32_usart_tx_interrupt_disable() is 
> called 4 times in the driver. The factorization is triggered by the 
> multiple calls to this code.

stm32_usart_tc_interrupt_{en,dis}able() is called 3 times after 2/2, so 
having 3 copies of the same code sprinkled across the driver seems iffy 
at best. Also, stm32_usart_tc_interrupt_{en,dis}able() handles the 
register offset ($ofs variable), that would also have to be duplicated 
all over the driver. I don't like that, it would make the code harder to 
read.

> In your proposal, the helper is executing a single instruction

The helper first has to figure out the register offset from this $ofs 
table which is at least two instructions, and then does register RMW 
which are at least three instructions on arm32.

>, and is 
> called only once

Thrice in total.

> , reason why I suggested to enable / disable the TCIE 
> directly in your new functions stm32_usart_tc_interrupt_enable() / 
> stm32_usart_tc_interrupt_disable().
> 
>> That sounds to me like making the code harder to read, not easier.
Seems we have a coding style preference stall here.
