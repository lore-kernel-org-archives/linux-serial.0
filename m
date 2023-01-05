Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F073BC54EBD
	for <linux-serial@archiver.kernel.org>; Thu,  5 Jan 2023 20:47:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235482AbjAEUrE (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 5 Jan 2023 15:47:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235430AbjAEUrD (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 5 Jan 2023 15:47:03 -0500
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50F6AE63
        for <linux-serial@vger.kernel.org>; Thu,  5 Jan 2023 12:47:01 -0800 (PST)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 8F693855ED;
        Thu,  5 Jan 2023 21:46:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1672951619;
        bh=Ts70kyLCR6lX3KKTUrPlDmVX0MnBSxV9GtAQsnuBGqo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=gLEXOrk1UTP5pTqVJilPXARQnJWVErH8nIucxwtgD8TCRsPYErxjYYPdxgGgpJalq
         IDBjA9UZsCgf0itJSiYk16AxiorvWzyvGsBIDugldvoGfF5g59svluirTeccEZ0QmV
         xTMl7jEyOQEUQqw8aoJVgJqzAagtaQqB62y/VasEMw/goo1aCTEcdajfAgVxkXPhFF
         JW/vSvT2ky7y8En+JraBXCiFWoIuQWQmao0pPpf+uSaXTX2k86HRJVCzTyY+u+YXlQ
         bACQHkun+xucFOwvGwjF6qSPGsKXHX0tvvFKYoOG8AogEvq0IuRRAiT4GpHPhWRX3j
         Ze8ZDJved9R+A==
Message-ID: <a66988fd-af44-63cd-e962-47ffa6205a6a@denx.de>
Date:   Thu, 5 Jan 2023 21:46:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3] serial: stm32: Merge hard IRQ and threaded IRQ
 handling into single IRQ handler
Content-Language: en-US
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-serial@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Erwan Le Ray <erwan.leray@foss.st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Caron <valentin.caron@foss.st.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
References: <20221216115338.7150-1-marex@denx.de>
 <Y6sHr5kuxUoahlzJ@hovoldconsulting.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <Y6sHr5kuxUoahlzJ@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 12/27/22 15:56, Johan Hovold wrote:

[...]

>> @@ -793,27 +794,13 @@ static irqreturn_t stm32_usart_interrupt(int irq, void *ptr)
>>   	}
>>   
>>   	if ((sr & USART_SR_TXE) && !(stm32_port->tx_ch)) {
>> -		spin_lock(&port->lock);
>> +		spin_lock_irqsave(&port->lock, flags);
>>   		stm32_usart_transmit_chars(port);
>> -		spin_unlock(&port->lock);
>> +		spin_unlock_irqrestore(&port->lock, flags);
> 
> This is not needed as the handler runs with interrupts disabled.

On SMP system, another thread on another core can call 
stm32_usart_transmit_chars() . I don't think removing the locking is 
correct ?

> 
>>   	}
>>   
>> -	if (stm32_usart_rx_dma_enabled(port))
>> -		return IRQ_WAKE_THREAD;
>> -	else
>> -		return IRQ_HANDLED;
>> -}
>> -
>> -static irqreturn_t stm32_usart_threaded_interrupt(int irq, void *ptr)
>> -{
>> -	struct uart_port *port = ptr;
>> -	struct tty_port *tport = &port->state->port;
>> -	struct stm32_port *stm32_port = to_stm32_port(port);
>> -	unsigned int size;
>> -	unsigned long flags;
>> -
>>   	/* Receiver timeout irq for DMA RX */
>> -	if (!stm32_port->throttled) {
>> +	if (stm32_usart_rx_dma_enabled(port) && !stm32_port->throttled) {
>>   		spin_lock_irqsave(&port->lock, flags);
> 
> But you could change this to spin_lock() now.

[...]
