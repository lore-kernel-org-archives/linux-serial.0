Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13071C433F5
	for <linux-serial@archiver.kernel.org>; Mon,  2 May 2022 11:14:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384678AbiEBLRc (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 2 May 2022 07:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384673AbiEBLRb (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 2 May 2022 07:17:31 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60AA95FAF
        for <linux-serial@vger.kernel.org>; Mon,  2 May 2022 04:14:03 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 772BA83D07;
        Mon,  2 May 2022 13:14:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1651490041;
        bh=GYeUZKMtocbMmxb4L7AIL1pIKQna8kVZpFNC+YLY+e4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=m/4RKntesSV7zzPBjofMnDfi3iQJbggoKREF7VeiBeDO9QIhomoWCSY1nApegAHer
         pgUBUE00mPByxE8ZXhslInwPd4KtoasjqWHSNYOl3YGCGN8b2mKbo351NinKUNmOar
         POXESDTBRwhdBbE3gx2qR6j/hrWNVEDq/z29pbOiOvuIy8G24moufAqnPK+GHc/2AY
         IFcYFnbW9Z6/DKewFm8+yq74BMD4Y0xjccUCxdLWhj9zNdit1fr/w6A0Bw1cLVfIBn
         FrTvcbDL3ep9SUkNPA8iyq1u1s1mNhh0PQVVoStG4agccgrB7Alepy7AJBRaL8rah/
         qLTV6nWIVzvlA==
Message-ID: <18f886d9-924b-e32b-e298-90e998b30662@denx.de>
Date:   Mon, 2 May 2022 13:13:59 +0200
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
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <702dcede-ff97-b074-20bf-7c695f988d40@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.5 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 5/2/22 10:44, Erwan LE RAY wrote:
> Hi Marek,

Hi,

> On 4/30/22 18:28, Marek Vasut wrote:
>> In case the RS485 mode is emulated using GPIO RTS, use the TC interrupt
>> to deassert the GPIO RTS, otherwise the GPIO RTS stays asserted after a
>> transmission ended and the RS485 cannot work.
>>
> Could you please add a cover letter to explain the rational of the first 
> patch ? I understood the goal of the first by reading the commit message 
> of this second patch.

The rationale is trivial -- make sure we don't have five copies of the 
same block of code in the driver.

>> diff --git a/drivers/tty/serial/stm32-usart.c 
>> b/drivers/tty/serial/stm32-usart.c
>> index 224f359c6051e..764415b8e8f03 100644
>> --- a/drivers/tty/serial/stm32-usart.c
>> +++ b/drivers/tty/serial/stm32-usart.c
>> @@ -417,6 +417,14 @@ static void 
>> stm32_usart_tx_interrupt_enable(struct uart_port *port)
>>           stm32_usart_set_bits(port, ofs->cr1, USART_CR1_TXEIE);
>>   }
>> +static void stm32_usart_tc_interrupt_enable(struct uart_port *port)
>> +{
>> +    struct stm32_port *stm32_port = to_stm32_port(port);
>> +    const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
>> +
>> +    stm32_usart_set_bits(port, ofs->cr1, USART_CR1_TCIE);
>> +}
>> +
> I don't see the added value of this helper (only 1 instruction used 1 
> time), and other Interrupt Enabled bits are already set/unset in others 
> functions of this driver.
> To keep an homogeneous code in the driver, could you please remove this 
> helper and set TCIE directly when you need it ?

Should I also remove stm32_usart_tx_interrupt_enable() / 
stm32_usart_tx_interrupt_disable() , which does the same thing for other 
bits in the interrupt register ?

That sounds to me like making the code harder to read, not easier.

[...]
