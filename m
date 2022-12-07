Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C2E5C352A1
	for <linux-serial@archiver.kernel.org>; Wed,  7 Dec 2022 16:55:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiLGQzs (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 7 Dec 2022 11:55:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiLGQzr (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 7 Dec 2022 11:55:47 -0500
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13CCE60EAC
        for <linux-serial@vger.kernel.org>; Wed,  7 Dec 2022 08:55:46 -0800 (PST)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 4E2C78517E;
        Wed,  7 Dec 2022 17:55:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1670432144;
        bh=pa5LnN0rg2cNrWesp4RkUZMPcdAlTgmUHajOJk2mH0k=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=hjFnAdUTF6h7T9Lz7XvZ86nWkADpoBDFTCPK8gKztzkqW3FyaQlayx8lq7DL1Pu7Y
         y+DkA9AysSi1kogdaZeVU5yhHXP1ov5rqmgKvc7DwbsaRjt/xclver0IUlamzf4GBi
         YwC8FEHsbF6PjKvWYNk0x3e81/sKaXDcjZSXJl+10AdmQQTbs9kujBz76d+dViBrgA
         gt59y35lbSMi61nq1IeQDdQVNF/WwvXcEn9BsGmq7TKBzOIudS4ArW76fprxVGBAsW
         INlb7pFMoq+oxNztyD/21kNR7qhmzn96uz61OTzThql4/v4cPulNs2fYCEc7yBeWCp
         UxIn3OadyXqBg==
Message-ID: <d69c213f-c447-63ad-fbea-b77df11f503a@denx.de>
Date:   Wed, 7 Dec 2022 17:55:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] [RFC] serial: stm32: Move stm32_usart_transmit_chars() to
 interrupt thread
Content-Language: en-US
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-serial@vger.kernel.org,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Erwan Le Ray <erwan.leray@foss.st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jean Philippe Romain <jean-philippe.romain@foss.st.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Caron <valentin.caron@foss.st.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com, johan@kernel.org
References: <20221207013012.395585-1-marex@denx.de>
 <Y5BLvE/2RTJsUVms@linutronix.de>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <Y5BLvE/2RTJsUVms@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 12/7/22 09:15, Sebastian Andrzej Siewior wrote:
> On 2022-12-07 02:30:12 [+0100], Marek Vasut wrote:
>> Avoid locking in hard interrupt context, move the stm32_usart_transmit_chars()
>> into the threaded IRQ handler. This fixes the following splat with preempt-rt:
>>
>>   BUG: scheduling while atomic: (mount)/1289/0x00010001
>>   Modules linked in:
>>   Preemption disabled at:
>>   [<c0119127>] irq_enter_rcu+0xb/0x42
>>   CPU: 0 PID: 1289 Comm: (mount) Not tainted 6.1.0-rc7-rt5-stable-standard-00006-gd70aeccb9f0f #17
>>   Hardware name: STM32 (Device Tree Support)
>>    unwind_backtrace from show_stack+0xb/0xc
>>    show_stack from dump_stack_lvl+0x2b/0x34
>>    dump_stack_lvl from __schedule_bug+0x53/0x80
>>    __schedule_bug from __schedule+0x47/0x404
>>    __schedule from schedule_rtlock+0x15/0x34
>>    schedule_rtlock from rtlock_slowlock_locked+0x1d7/0x57e
>>    rtlock_slowlock_locked from rt_spin_lock+0x29/0x3c
>>    rt_spin_lock from stm32_usart_interrupt+0xa9/0x110
>>    stm32_usart_interrupt from __handle_irq_event_percpu+0x73/0x14e
>>    __handle_irq_event_percpu from handle_irq_event_percpu+0x9/0x22
>>    handle_irq_event_percpu from handle_irq_event+0x53/0x76
>>    handle_irq_event from handle_fasteoi_irq+0x65/0xa8
>>    handle_fasteoi_irq from handle_irq_desc+0xf/0x18
>>    handle_irq_desc from gic_handle_irq+0x45/0x54
>>    gic_handle_irq from generic_handle_arch_irq+0x19/0x2c
>>    generic_handle_arch_irq from call_with_stack+0xd/0x10
>>
>> Signed-off-by: Marek Vasut <marex@denx.de>
>> ---
>> Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
>> Cc: Erwan Le Ray <erwan.leray@foss.st.com>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: Jean Philippe Romain <jean-philippe.romain@foss.st.com>
>> Cc: Jiri Slaby <jirislaby@kernel.org>
>> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
>> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Valentin Caron <valentin.caron@foss.st.com>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-stm32@st-md-mailman.stormreply.com
>> To: linux-serial@vger.kernel.org
>> ---
>>   drivers/tty/serial/stm32-usart.c | 19 +++++++++++++------
>>   1 file changed, 13 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
>> index a1490033aa164..56357a7962edc 100644
>> --- a/drivers/tty/serial/stm32-usart.c
>> +++ b/drivers/tty/serial/stm32-usart.c
>> @@ -791,11 +791,8 @@ static irqreturn_t stm32_usart_interrupt(int irq, void *ptr)
>>   		}
>>   	}
> 
> Why is this handler running as the primary handler to begin with?
> There is
>   stm32_usart_rs485_rts_disable()
>   -> mctrl_gpio_set()
>      -> gpiod_set_array_value()
>         -> gpiod_set_array_value_complex()
>           -> gpio_chip_set_multiple()
> 	    -> gc->set_multiple() || gc->set() ?
>           -> bitmap_alloc() boom
> 
> I don't know if the underlying gpiod is always using a raw_spinlock_t
> but that bitmap_alloc() (depending on FASTPATH_NGPIO()) is not going to
> work.
> pm_wakeup_dev_event() is also using a spinlock_t.
> 
> 
>> -	if ((sr & USART_SR_TXE) && !(stm32_port->tx_ch)) {
>> -		spin_lock(&port->lock);
>> -		stm32_usart_transmit_chars(port);
>> -		spin_unlock(&port->lock);
>> -	}
>> +	if ((sr & USART_SR_TXE) && !(stm32_port->tx_ch))
>> +		return IRQ_WAKE_THREAD;
> 
> Before that, there is a "stm32_port->throttled" check using the very
> same lock.
> 
>>   	if (stm32_usart_rx_dma_enabled(port))
>>   		return IRQ_WAKE_THREAD;

Is the suggestion therefore to completely remove the hard IRQ handler 
and move everything into the threaded IRQ handler ?

Are there any drawbacks of doing that to a serial port driver ?
