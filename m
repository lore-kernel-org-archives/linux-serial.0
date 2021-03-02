Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 482E8C433DB
	for <linux-serial@archiver.kernel.org>; Wed,  3 Mar 2021 02:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CF1D64E7A
	for <linux-serial@archiver.kernel.org>; Wed,  3 Mar 2021 02:21:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349201AbhCCCRg (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 2 Mar 2021 21:17:36 -0500
Received: from ms9.eaxlabs.cz ([147.135.177.209]:50686 "EHLO ms9.eaxlabs.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1835437AbhCBTHp (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 2 Mar 2021 14:07:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=eaxlabs.cz; s=mail;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=qZKGz3W2e4Y6Uv/wOhPkXx90yaEZmGLymSnEX5ezPbw=;
        b=pe+fT21PnkusIjFGGDZcXYQNIw0YEvWCIwTprKhgG+giPVS/wTju96qQV79ZdgqL6gFREGewGjkagf+Fb5rXHIVPGUNZ8muEwzQTfSmA8ZzzjvJy2d+pWGtTgqugoWN5Jod+DPhlWI+R+ooIOAsOkSVaA22PEzT/eKRGLZE+wIQ=;
Received: from [82.99.129.6] (helo=[10.76.6.112])
        by ms9.eaxlabs.cz with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <devik@eaxlabs.cz>)
        id 1lHAMF-00035H-3H; Tue, 02 Mar 2021 20:07:01 +0100
Subject: Re: [PATCH v3 2/2] tty/serial: Add rx-tx-swap OF option to
 stm32-usart
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jiri Slaby <jirislaby@kernel.org>, Le Ray <erwan.leray@st.com>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
References: <439a0d7a-cc0e-764b-7ed8-668b5a85f4a7@foss.st.com>
 <20210302131558.19375-1-devik@eaxlabs.cz>
 <20210302131558.19375-2-devik@eaxlabs.cz>
 <aeefa74e-fa19-6c31-5240-0f14fca89298@foss.st.com>
From:   Martin DEVERA <devik@eaxlabs.cz>
Message-ID: <13416deb-2a37-dd8e-ed2a-50b74f204f52@eaxlabs.cz>
Date:   Tue, 2 Mar 2021 20:06:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <aeefa74e-fa19-6c31-5240-0f14fca89298@foss.st.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 3/2/21 6:44 PM, Fabrice Gasnier wrote:
> On 3/2/21 2:15 PM, Martin Devera wrote:
>> STM32 F7/H7 usarts supports RX & TX pin swapping.
>> Add option to turn it on.
>> Tested on STM32MP157.
>>
>> Signed-off-by: Martin Devera <devik@eaxlabs.cz>
>> ---
>>   drivers/tty/serial/stm32-usart.c | 11 ++++++++++-
>>   drivers/tty/serial/stm32-usart.h |  5 +++++
>>   2 files changed, 15 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
>> index b3675cf25a69..d390f7da1441 100644
>> --- a/drivers/tty/serial/stm32-usart.c
>> +++ b/drivers/tty/serial/stm32-usart.c
>> @@ -644,6 +644,12 @@ static int stm32_usart_startup(struct uart_port *port)
>>   	if (ret)
>>   		return ret;
>>   
>> +	if (stm32_port->swap) {
>> +		val = readl_relaxed(port->membase + ofs->cr2);
>> +		val |= USART_CR2_SWAP;
>> +		writel_relaxed(val, port->membase + ofs->cr2);
>> +	}
>> +
>>   	/* RX FIFO Flush */
>>   	if (ofs->rqr != UNDEF_REG)
>>   		stm32_usart_set_bits(port, ofs->rqr, USART_RQR_RXFRQ);
>> @@ -758,7 +764,7 @@ static void stm32_usart_set_termios(struct uart_port *port,
>>   	cr1 = USART_CR1_TE | USART_CR1_RE;
>>   	if (stm32_port->fifoen)
>>   		cr1 |= USART_CR1_FIFOEN;
>> -	cr2 = 0;
>> +	cr2 = stm32_port->swap ? USART_CR2_SWAP : 0;
>>   	cr3 = readl_relaxed(port->membase + ofs->cr3);
>>   	cr3 &= USART_CR3_TXFTIE | USART_CR3_RXFTCFG_MASK | USART_CR3_RXFTIE
>>   		| USART_CR3_TXFTCFG_MASK;
>> @@ -1006,6 +1012,9 @@ static int stm32_usart_init_port(struct stm32_port *stm32port,
>>   			return stm32port->wakeirq ? : -ENODEV;
>>   	}
>>   
>> +	stm32port->swap = stm32port->info->cfg.has_swap &&
>> +		of_property_read_bool(pdev->dev.of_node, "rx-tx-swap");
>> +
>>   	stm32port->fifoen = stm32port->info->cfg.has_fifo;
>>   
>>   	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> diff --git a/drivers/tty/serial/stm32-usart.h b/drivers/tty/serial/stm32-usart.h
>> index cb4f327c46db..bd18dd1c1bcd 100644
>> --- a/drivers/tty/serial/stm32-usart.h
>> +++ b/drivers/tty/serial/stm32-usart.h
>> @@ -25,6 +25,7 @@ struct stm32_usart_offsets {
>>   struct stm32_usart_config {
>>   	u8 uart_enable_bit; /* USART_CR1_UE */
>>   	bool has_7bits_data;
>> +	bool has_swap;
>>   	bool has_wakeup;
>>   	bool has_fifo;
>>   	int fifosize;
>> @@ -55,6 +56,7 @@ struct stm32_usart_info stm32f4_info = {
>>   	.cfg = {
>>   		.uart_enable_bit = 13,
>>   		.has_7bits_data = false,
>> +		.has_swap = false,
> Hi Martin,
>
> Only one minor comment from me here. No need to add a false (zero)
> initialization in this struct. I'm not sure why this is the case for the
> has_7bits_data here...
>
> With that fixed, you can add my:
> Acked-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
>
The has_7bits_data was what made me a bit unsure. Ok fixed now.
Thank you for your review.

Martin

