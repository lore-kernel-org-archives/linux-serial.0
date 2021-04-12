Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F48C433ED
	for <linux-serial@archiver.kernel.org>; Mon, 12 Apr 2021 13:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22EDC6128C
	for <linux-serial@archiver.kernel.org>; Mon, 12 Apr 2021 13:19:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238277AbhDLNUE (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 12 Apr 2021 09:20:04 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:5494 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S237579AbhDLNUE (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 12 Apr 2021 09:20:04 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13CDIDTg018924;
        Mon, 12 Apr 2021 15:19:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=8R7d3CTMS2VKwKA9wDvlbwBP8USe1r/2dAXdVNGhj58=;
 b=6fb+lsRSyKi7xpqxY5M+nTSIlLJpJIZIKGK8vAjyHYE0g+ipDxI7sK732PlF6x3LB7sr
 JNODjUKwTXg6g3dMuq2EihQ7P/pe+jsI/jZimGi5QTngn/nDH9GE8OIXsuCsd/8mb4wQ
 HAHxcaGP91cf/wYv96jatFG6NwFupwfb67+cFP0Dic26yKhQxGLQcIL+IiUO7nN5Zzjd
 GWNDO5JeJapY/812tAvK+2tihqzfrAR0L1YTv4gaNk6J7kIagTRpGKv+qWiK2vz+nwQp
 idIK+G1c+yIFS2IJBoXlQDrLDVrOCB16LIJmXkbW+tXHyLj6p9fnrYEWP3WjrX6EHfB+ Jg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 37v3a5nhak-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Apr 2021 15:19:30 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 25FBA10002A;
        Mon, 12 Apr 2021 15:19:29 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 12DB1248EE1;
        Mon, 12 Apr 2021 15:19:29 +0200 (CEST)
Received: from lmecxl0566.lme.st.com (10.75.127.49) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 12 Apr
 2021 15:19:28 +0200
Subject: Re: [Linux-stm32] [PATCH] serial: stm32: optimize spin lock usage
To:     dillon min <dillon.minfei@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>
CC:     <linux-serial@vger.kernel.org>,
        Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        <jirislaby@kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Valentin Caron <valentin.caron@foss.st.com>
References: <1618202061-8243-1-git-send-email-dillon.minfei@gmail.com>
 <YHPgGI6EmTzmVH7g@kroah.com>
 <CAL9mu0Lt-3_O7V5HLxd5Hbt9afx9ryBUzWqmsc+2n3SP7JS6ig@mail.gmail.com>
 <YHQEA9jn5uXQCtrN@kroah.com>
 <CAL9mu0+hi5eYEder1Mj2yjUN+eicJ9qG8Kr4GTC2mqfY405Jkg@mail.gmail.com>
From:   Erwan LE RAY <erwan.leray@foss.st.com>
Message-ID: <f3985d70-4f00-7442-de4e-e382b19e3e50@foss.st.com>
Date:   Mon, 12 Apr 2021 15:19:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAL9mu0+hi5eYEder1Mj2yjUN+eicJ9qG8Kr4GTC2mqfY405Jkg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-12_10:2021-04-12,2021-04-12 signatures=0
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Dillon,

Thanks for your patch.

Could you please elaborate the use case in your commit message ?

Best Regards, Erwan.

On 4/12/21 10:54 AM, dillon min wrote:
> Hi Greg,
> 
> On Mon, Apr 12, 2021 at 4:25 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>>
>> On Mon, Apr 12, 2021 at 02:50:20PM +0800, dillon min wrote:
>>> Hi Greg，
>>>
>>> Thanks for the quick response, please ignore the last private mail.
>>>
>>> On Mon, Apr 12, 2021 at 1:52 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>>>>
>>>> On Mon, Apr 12, 2021 at 12:34:21PM +0800, dillon.minfei@gmail.com wrote:
>>>>> From: dillon min <dillon.minfei@gmail.com>
>>>>>
>>>>> To avoid potential deadlock in spin_lock usage, change to use
>>>>> spin_lock_irqsave(), spin_unlock_irqrestore() in process(thread_fn) context.
>>>>> spin_lock(), spin_unlock() under handler context.
>>>>>
>>>>> remove unused local_irq_save/restore call.
>>>>>
>>>>> Signed-off-by: dillon min <dillon.minfei@gmail.com>
>>>>> ---
>>>>> Was verified on stm32f469-disco board. need more test on stm32mp platform.
>>>>>
>>>>>   drivers/tty/serial/stm32-usart.c | 27 +++++++++++++++++----------
>>>>>   1 file changed, 17 insertions(+), 10 deletions(-)
>>>>>
>>>>> diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
>>>>> index b3675cf25a69..c4c859b34367 100644
>>>>> --- a/drivers/tty/serial/stm32-usart.c
>>>>> +++ b/drivers/tty/serial/stm32-usart.c
>>>>> @@ -214,7 +214,7 @@ static void stm32_usart_receive_chars(struct uart_port *port, bool threaded)
>>>>>        struct tty_port *tport = &port->state->port;
>>>>>        struct stm32_port *stm32_port = to_stm32_port(port);
>>>>>        const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
>>>>> -     unsigned long c;
>>>>> +     unsigned long c, flags;
>>>>>        u32 sr;
>>>>>        char flag;
>>>>>
>>>>> @@ -276,9 +276,17 @@ static void stm32_usart_receive_chars(struct uart_port *port, bool threaded)
>>>>>                uart_insert_char(port, sr, USART_SR_ORE, c, flag);
>>>>>        }
>>>>>
>>>>> -     spin_unlock(&port->lock);
>>>>> +     if (threaded)
>>>>> +             spin_unlock_irqrestore(&port->lock, flags);
>>>>> +     else
>>>>> +             spin_unlock(&port->lock);
>>>>
>>>> You shouldn't have to check for this, see the other patches on the list
>>>> recently that fixed this up to not be an issue for irq handlers.
>>> Can you help to give more hints, or the commit id of the patch which
>>> fixed this. thanks.
>>>
>>> I'm still confused with this.
>>>
>>> The stm32_usart_threaded_interrupt() is a kthread context, once
>>> port->lock holds by this function, another serial interrupts raised,
>>> such as USART_SR_TXE,stm32_usart_interrupt() can't get the lock,
>>> there will be a deadlock. isn't it?
>>>
>>>   So, shouldn't I use spin_lock{_irqsave} according to the caller's context ?
>>
>> Please see 81e2073c175b ("genirq: Disable interrupts for force threaded
>> handlers") for when threaded irq handlers have irqs disabled, isn't that
>> the case you are trying to "protect" from here?
>>
>> Why is the "threaded" flag used at all?  The driver should not care.
>>
>> Also see 9baedb7baeda ("serial: imx: drop workaround for forced irq
>> threading") in linux-next for an example of how this was fixed up in a
>> serial driver.
>>
>> does that help?
>>
> Yes, it's really helpful. and 81e2073c175b should be highlighted in a doc.
> In my past knowledge, we should care about hard irq & thread_fn lock conflict.
> This patch has totally avoided patching code in the separate driver side.
> thanks.
> 
> I will just keep the changes in stm32_usart_console_write(), remove
> these code in
> thread_fn. update version 2 for you.
> 
> thanks.
> 
> Dillon,
>> thanks,
>>
>> greg k-h
> _______________________________________________
> Linux-stm32 mailing list
> Linux-stm32@st-md-mailman.stormreply.com
> https://st-md-mailman.stormreply.com/mailman/listinfo/linux-stm32
> 
