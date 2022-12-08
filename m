Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F31C3A5A7
	for <linux-serial@archiver.kernel.org>; Thu,  8 Dec 2022 10:19:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbiLHKTd (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 8 Dec 2022 05:19:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiLHKTc (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 8 Dec 2022 05:19:32 -0500
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D9145098
        for <linux-serial@vger.kernel.org>; Thu,  8 Dec 2022 02:19:31 -0800 (PST)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B88rKLL015635;
        Thu, 8 Dec 2022 11:18:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=cv1giWJxvloYGvycnb0GrTiCbuEh6nvGPcawGHX/NYI=;
 b=a3C+0UrZVk/cWukrn0jwOYezw5N67658N+wA2POv54LTqepYFZfTyfZNRnrLx8P3YUcz
 TuWShXmx18C3pVwH6jBmoQqxot/FMQvAHmdzThK1sesE95rorqQVcsXKbxJ+kmXANM1S
 v1P6nI2PIksAY2bZLzWwEMiAEkP45Xy93LaKh6+I1ZpjuUrmTmaAv5exh3qD/eHmlwkL
 rO/UkY0unqZzAh475Ib+h3IdvkETB6gYrEy3WV9vSxdJ8yKuYeX6OS8OUF5oaRM1mg7i
 pmPoNTM0C1xFNtg9ioAeZEEY52Vz99WHcQ4dQxLfeB10y1nWFObVcqAKIr/xfmFbEEab kw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3maxau4v09-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Dec 2022 11:18:52 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 26E2310002A;
        Thu,  8 Dec 2022 11:18:46 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0480021B537;
        Thu,  8 Dec 2022 11:18:46 +0100 (CET)
Received: from [10.201.20.168] (10.201.20.168) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.13; Thu, 8 Dec
 2022 11:18:45 +0100
Message-ID: <34ec91a2-2089-65ba-d5bb-fed03cda63b7@foss.st.com>
Date:   Thu, 8 Dec 2022 11:18:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] serial: stm32: Move hard IRQ handling to threaded
 interrupt context
Content-Language: en-US
To:     Marek Vasut <marex@denx.de>
CC:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Erwan Le Ray <erwan.leray@foss.st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jean Philippe Romain <jean-philippe.romain@foss.st.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-serial@vger.kernel.org>
References: <20221207195929.160267-1-marex@denx.de>
From:   Valentin CARON <valentin.caron@foss.st.com>
In-Reply-To: <20221207195929.160267-1-marex@denx.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.20.168]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-08_04,2022-12-08_01,2022-06-22_01
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Marek,

I've got a patch in the same spirit in downstream.
The test campaign reveals performance issues with this patch.

In fact, hard IRQ have been introduced in stm32-usart driver to solve 
performance issues due to short FIFO size (16 bytes).

We are currently testing another patch, similar as your RFC proposition, 
for RT context.
But results are not ready yet. We can wait them before merging this big 
change into driver ?

Thanks,
Valentin

On 12/7/22 20:59, Marek Vasut wrote:
> Avoid locking in hard interrupt context, move the entirety of hard IRQ
> context code into the threaded IRQ handler. This fixes the following
> splat with preempt-rt enabled:
>
>   BUG: scheduling while atomic: (mount)/1289/0x00010001
>   Modules linked in:
>   Preemption disabled at:
>   [<c0119127>] irq_enter_rcu+0xb/0x42
>   CPU: 0 PID: 1289 Comm: (mount) Not tainted 6.1.0-rc7-rt5-stable-standard-00006-gd70aeccb9f0f #17
>   Hardware name: STM32 (Device Tree Support)
>    unwind_backtrace from show_stack+0xb/0xc
>    show_stack from dump_stack_lvl+0x2b/0x34
>    dump_stack_lvl from __schedule_bug+0x53/0x80
>    __schedule_bug from __schedule+0x47/0x404
>    __schedule from schedule_rtlock+0x15/0x34
>    schedule_rtlock from rtlock_slowlock_locked+0x1d7/0x57e
>    rtlock_slowlock_locked from rt_spin_lock+0x29/0x3c
>    rt_spin_lock from stm32_usart_interrupt+0xa9/0x110
>    stm32_usart_interrupt from __handle_irq_event_percpu+0x73/0x14e
>    __handle_irq_event_percpu from handle_irq_event_percpu+0x9/0x22
>    handle_irq_event_percpu from handle_irq_event+0x53/0x76
>    handle_irq_event from handle_fasteoi_irq+0x65/0xa8
>    handle_fasteoi_irq from handle_irq_desc+0xf/0x18
>    handle_irq_desc from gic_handle_irq+0x45/0x54
>    gic_handle_irq from generic_handle_arch_irq+0x19/0x2c
>    generic_handle_arch_irq from call_with_stack+0xd/0x10
>
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
> Cc: Erwan Le Ray <erwan.leray@foss.st.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jean Philippe Romain <jean-philippe.romain@foss.st.com>
> Cc: Jiri Slaby <jirislaby@kernel.org>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Valentin Caron <valentin.caron@foss.st.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-stm32@st-md-mailman.stormreply.com
> To: linux-serial@vger.kernel.org
> ---
>   drivers/tty/serial/stm32-usart.c | 27 +++++++--------------------
>   1 file changed, 7 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
> index a1490033aa164..f5bce0be02676 100644
> --- a/drivers/tty/serial/stm32-usart.c
> +++ b/drivers/tty/serial/stm32-usart.c
> @@ -745,14 +745,15 @@ static void stm32_usart_transmit_chars(struct uart_port *port)
>   	}
>   }
>   
> -static irqreturn_t stm32_usart_interrupt(int irq, void *ptr)
> +static irqreturn_t stm32_usart_threaded_interrupt(int irq, void *ptr)
>   {
>   	struct uart_port *port = ptr;
>   	struct tty_port *tport = &port->state->port;
>   	struct stm32_port *stm32_port = to_stm32_port(port);
>   	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
> -	u32 sr;
> +	unsigned long flags;
>   	unsigned int size;
> +	u32 sr;
>   
>   	sr = readl_relaxed(port->membase + ofs->isr);
>   
> @@ -792,27 +793,13 @@ static irqreturn_t stm32_usart_interrupt(int irq, void *ptr)
>   	}
>   
>   	if ((sr & USART_SR_TXE) && !(stm32_port->tx_ch)) {
> -		spin_lock(&port->lock);
> +		spin_lock_irqsave(&port->lock, flags);
>   		stm32_usart_transmit_chars(port);
> -		spin_unlock(&port->lock);
> +		spin_unlock_irqrestore(&port->lock, flags);
>   	}
>   
> -	if (stm32_usart_rx_dma_enabled(port))
> -		return IRQ_WAKE_THREAD;
> -	else
> -		return IRQ_HANDLED;
> -}
> -
> -static irqreturn_t stm32_usart_threaded_interrupt(int irq, void *ptr)
> -{
> -	struct uart_port *port = ptr;
> -	struct tty_port *tport = &port->state->port;
> -	struct stm32_port *stm32_port = to_stm32_port(port);
> -	unsigned int size;
> -	unsigned long flags;
> -
>   	/* Receiver timeout irq for DMA RX */
> -	if (!stm32_port->throttled) {
> +	if (stm32_usart_rx_dma_enabled(port) && !stm32_port->throttled) {
>   		spin_lock_irqsave(&port->lock, flags);
>   		size = stm32_usart_receive_chars(port, false);
>   		uart_unlock_and_check_sysrq_irqrestore(port, flags);
> @@ -1015,7 +1002,7 @@ static int stm32_usart_startup(struct uart_port *port)
>   	u32 val;
>   	int ret;
>   
> -	ret = request_threaded_irq(port->irq, stm32_usart_interrupt,
> +	ret = request_threaded_irq(port->irq, NULL,
>   				   stm32_usart_threaded_interrupt,
>   				   IRQF_ONESHOT | IRQF_NO_SUSPEND,
>   				   name, port);
