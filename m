Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45824C3DA7D
	for <linux-serial@archiver.kernel.org>; Thu,  5 Jan 2023 14:57:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234020AbjAEO5a (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 5 Jan 2023 09:57:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232676AbjAEO52 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 5 Jan 2023 09:57:28 -0500
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E26C762
        for <linux-serial@vger.kernel.org>; Thu,  5 Jan 2023 06:57:26 -0800 (PST)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 305DZJw2011073;
        Thu, 5 Jan 2023 15:56:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=Mew+7fmHkIYYdhg84QO79/nh/BSAmntjt9cf0imkRPU=;
 b=nZx+6Jb2NxpxcWihscTNZ46ouc23twO6yRv0F+JKQHzHFSoanTSm79yrJBDSRgjKlk5I
 OAZkOSzqirmPB3Hx68phUpT4rLLtj8r0klvPd2/KE+ofrkisGqaYfhHiL7yIqw8flsJ/
 +KivJIfwB69tl4/9MgaosOIn/4QMvgrKtKrbIUFUeDROx14qsTOZ4yYG3OeOFzrMBqdi
 sXkghhNA16UfixGpZCQOGHqslWCyuQe+8q6fYkyq35ijPcwPHFLpQZgL0+wy9fvf3Ulb
 Zav4cjcSe/QNDT/M+EGrODbCcjZR1IGk1b0Q4BeVj67NeGMspWENe9THob20+wAHukYC Kw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3mtbcq9q2k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Jan 2023 15:56:55 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4905310002A;
        Thu,  5 Jan 2023 15:56:54 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3A95926027C;
        Thu,  5 Jan 2023 15:56:54 +0100 (CET)
Received: from [10.201.20.168] (10.201.20.168) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.13; Thu, 5 Jan
 2023 15:56:53 +0100
Message-ID: <b4e13643-0494-329a-2d41-06da985b9dfe@foss.st.com>
Date:   Thu, 5 Jan 2023 15:56:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3] serial: stm32: Merge hard IRQ and threaded IRQ
 handling into single IRQ handler
Content-Language: en-US
To:     Marek Vasut <marex@denx.de>
CC:     <linux-serial@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Erwan Le Ray <erwan.leray@foss.st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20221216115338.7150-1-marex@denx.de>
From:   Valentin CARON <valentin.caron@foss.st.com>
In-Reply-To: <20221216115338.7150-1-marex@denx.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.20.168]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-05_06,2023-01-05_01,2022-06-22_01
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Marek,

It is OK for me.

Tested-by: Valentin Caron <valentin.caron@foss.st.com>

Thanks,
Valentin

On 12/16/22 12:53, Marek Vasut wrote:
> Requesting an interrupt with IRQF_ONESHOT will run the primary handler
> in the hard-IRQ context even in the force-threaded mode. The
> force-threaded mode is used by PREEMPT_RT in order to avoid acquiring
> sleeping locks (spinlock_t) in hard-IRQ context. This combination
> makes it impossible and leads to "sleeping while atomic" warnings.
>
> Use one interrupt handler for both handlers (primary and secondary)
> and drop the IRQF_ONESHOT flag which is not needed.
>
> Fixes: e359b4411c283 ("serial: stm32: fix threaded interrupt handling")
> Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
> Cc: Erwan Le Ray <erwan.leray@foss.st.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jirislaby@kernel.org>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Valentin Caron <valentin.caron@foss.st.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-stm32@st-md-mailman.stormreply.com
> To: linux-serial@vger.kernel.org
> ---
> V2: - Update patch subject, was:
>        serial: stm32: Move hard IRQ handling to threaded interrupt context
>      - Use request_irq() instead, rename the IRQ handler function
> V3: - Update the commit message per suggestion from Sebastian
>      - Add RB from Sebastian
>      - Add Fixes tag
> ---
>   drivers/tty/serial/stm32-usart.c | 29 +++++++----------------------
>   1 file changed, 7 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
> index dfdbcf092facc..bbbab8dc2bfa9 100644
> --- a/drivers/tty/serial/stm32-usart.c
> +++ b/drivers/tty/serial/stm32-usart.c
> @@ -752,8 +752,9 @@ static irqreturn_t stm32_usart_interrupt(int irq, void *ptr)
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
> @@ -793,27 +794,13 @@ static irqreturn_t stm32_usart_interrupt(int irq, void *ptr)
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
> @@ -1016,10 +1003,8 @@ static int stm32_usart_startup(struct uart_port *port)
>   	u32 val;
>   	int ret;
>   
> -	ret = request_threaded_irq(port->irq, stm32_usart_interrupt,
> -				   stm32_usart_threaded_interrupt,
> -				   IRQF_ONESHOT | IRQF_NO_SUSPEND,
> -				   name, port);
> +	ret = request_irq(port->irq, stm32_usart_interrupt,
> +			  IRQF_NO_SUSPEND, name, port);
>   	if (ret)
>   		return ret;
>   
