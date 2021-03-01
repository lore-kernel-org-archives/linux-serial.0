Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2410C4332D
	for <linux-serial@archiver.kernel.org>; Tue,  2 Mar 2021 05:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B65176186A
	for <linux-serial@archiver.kernel.org>; Tue,  2 Mar 2021 05:07:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233298AbhCBC0e (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 1 Mar 2021 21:26:34 -0500
Received: from ms9.eaxlabs.cz ([147.135.177.209]:38660 "EHLO ms9.eaxlabs.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233254AbhCAWlq (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 1 Mar 2021 17:41:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=eaxlabs.cz; s=mail;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=kFsI78mY/ZRsnqmIBcnHXfh7nTVcK0J3fpNvfJ5QymU=;
        b=FB6mU5YXCt5R4qgHXWiXGdw2IAjfsEkKwNHCKp8N+JrrsZKpQT34V8BhtNqd/cbpVZ/TzXpYvmACGINyRgpUokHqf6loTYJsHN4FMO0RZzcxxyNAB1x2EGaeoOQHlFQmoUUXoVBxqHHPZW6Sh6gL/oPmGUEqSto3uCN9LaZWOng=;
Received: from [82.99.129.6] (helo=[10.76.6.112])
        by ms9.eaxlabs.cz with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <devik@eaxlabs.cz>)
        id 1lGrDH-0006uv-Ol; Mon, 01 Mar 2021 23:40:29 +0100
Subject: Re: [PATCH v2 1/2] tty/serial: Add rx-tx-swap OF option to
 stm32-usart
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-serial@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Le Ray <erwan.leray@st.com>
References: <CAL_JsqK8+M=Vg0PiDXP2f1LrEp4hSVea6piAASMGu1H=pxme6Q@mail.gmail.com>
 <20210227164157.30971-1-devik@eaxlabs.cz>
 <439a0d7a-cc0e-764b-7ed8-668b5a85f4a7@foss.st.com>
From:   Martin DEVERA <devik@eaxlabs.cz>
Message-ID: <fbdce86c-a17f-7626-51e4-9e48ea25001e@eaxlabs.cz>
Date:   Mon, 1 Mar 2021 23:40:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <439a0d7a-cc0e-764b-7ed8-668b5a85f4a7@foss.st.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 3/1/21 11:28 AM, Fabrice Gasnier wrote:
> On 2/27/21 5:41 PM, Martin Devera wrote:
>> STM32 F7/H7 usarts supports RX & TX pin swapping.
>> Add option to turn it on.
>> Tested on STM32MP157.
>>
>> Signed-off-by: Martin Devera <devik@eaxlabs.cz>
>> ---
>>   drivers/tty/serial/stm32-usart.c | 3 ++-
>>   drivers/tty/serial/stm32-usart.h | 1 +
>>   2 files changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
>> index b3675cf25a69..3650c8798061 100644
>> --- a/drivers/tty/serial/stm32-usart.c
>> +++ b/drivers/tty/serial/stm32-usart.c
>> @@ -758,7 +758,7 @@ static void stm32_usart_set_termios(struct uart_port *port,
>>   	cr1 = USART_CR1_TE | USART_CR1_RE;
>>   	if (stm32_port->fifoen)
>>   		cr1 |= USART_CR1_FIFOEN;
>> -	cr2 = 0;
>> +	cr2 = stm32_port->swap ? USART_CR2_SWAP : 0;
> Hi Martin,
>
> Same could be done in the startup routine, that enables the port for
> reception (as described in Documentation/driver-api/serial/driver.rst)
Hello Fabrice,

I already incorporated all your comments but I'm struggling with the one 
above.
The code must be in stm32_usart_set_termios too, because CR2 is modified.
What is the reason to have it in startup() ?
Is it because USART can be started without calling set_termios at all ? Like
to reuse bootloader's last settings ?

Thanks, Martin

