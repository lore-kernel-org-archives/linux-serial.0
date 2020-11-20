Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA06C5519F
	for <linux-serial@archiver.kernel.org>; Fri, 20 Nov 2020 11:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3590222244
	for <linux-serial@archiver.kernel.org>; Fri, 20 Nov 2020 11:25:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbgKTLZQ (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 20 Nov 2020 06:25:16 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:7962 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728129AbgKTLZQ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 20 Nov 2020 06:25:16 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4CcvN926DKzhdJ2;
        Fri, 20 Nov 2020 19:24:57 +0800 (CST)
Received: from [127.0.0.1] (10.57.60.129) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Fri, 20 Nov 2020
 19:25:03 +0800
Subject: Re: [PATCH] tty: serial: replace spin_lock_irqsave by spin_lock in
 hard IRQ
To:     Johan Hovold <johan@kernel.org>, Tian Tao <tiantao6@hisilicon.com>
CC:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <afaerber@suse.de>, <manivannan.sadhasivam@linaro.org>,
        <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1605776489-16283-1-git-send-email-tiantao6@hisilicon.com>
 <X7d85DKvisjA3nYv@localhost>
From:   "tiantao (H)" <tiantao6@huawei.com>
Message-ID: <9ce93d7b-f769-58ed-e6bf-95c34bd0123e@huawei.com>
Date:   Fri, 20 Nov 2020 19:25:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <X7d85DKvisjA3nYv@localhost>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.57.60.129]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



ÔÚ 2020/11/20 16:23, Johan Hovold Ð´µÀ:
> On Thu, Nov 19, 2020 at 05:01:29PM +0800, Tian Tao wrote:
>> The code has been in a irq-disabled context since it is hard IRQ. There
>> is no necessity to do it again.
>>
>> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
>> ---
>>   drivers/tty/serial/owl-uart.c | 5 ++---
>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/tty/serial/owl-uart.c b/drivers/tty/serial/owl-uart.c
>> index c149f8c3..472fdaf 100644
>> --- a/drivers/tty/serial/owl-uart.c
>> +++ b/drivers/tty/serial/owl-uart.c
>> @@ -251,10 +251,9 @@ static void owl_uart_receive_chars(struct uart_port *port)
>>   static irqreturn_t owl_uart_irq(int irq, void *dev_id)
>>   {
>>   	struct uart_port *port = dev_id;
>> -	unsigned long flags;
>>   	u32 stat;
>>   
>> -	spin_lock_irqsave(&port->lock, flags);
>> +	spin_lock(&port->lock);
> 
> Same thing here; this will break with forced irq threading (i.e.
> "threadirqs") since the console code can still end up being called from
> interrupt context.
As the following code shows, owl_uart_irq does not run in the irq 
threading context.
  ret = request_irq(port->irq, owl_uart_irq, IRQF_TRIGGER_HIGH,
                         "owl-uart", port);
         if (ret)
                 return ret;

> 
>>   	stat = owl_uart_read(port, OWL_UART_STAT);
>>   
>> @@ -268,7 +267,7 @@ static irqreturn_t owl_uart_irq(int irq, void *dev_id)
>>   	stat |= OWL_UART_STAT_RIP | OWL_UART_STAT_TIP;
>>   	owl_uart_write(port, stat, OWL_UART_STAT);
>>   
>> -	spin_unlock_irqrestore(&port->lock, flags);
>> +	spin_unlock(&port->lock);
>>   
>>   	return IRQ_HANDLED;
>>   }
> 
> Johan
> 
> .
> 

