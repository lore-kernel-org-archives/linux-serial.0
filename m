Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 104F5C433E6
	for <linux-serial@archiver.kernel.org>; Mon,  1 Mar 2021 10:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D361564E10
	for <linux-serial@archiver.kernel.org>; Mon,  1 Mar 2021 10:30:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234435AbhCAK3z (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 1 Mar 2021 05:29:55 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:10268 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234436AbhCAK3w (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 1 Mar 2021 05:29:52 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 121ARlbj002304;
        Mon, 1 Mar 2021 11:28:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=0iba9ds30bxpbJDZZJN9+EAyGhkT4XykKVq3jr281PQ=;
 b=ev38jqefIMorbnUTPQ6Kefjkh03E84Y5ZK++8Ldi7gYQucan/f6wD08NVT6/CKFLffNS
 nlEkAlj5c9CZPo8MFSJyw7DAIlUpNkeNrFWBuVgWHBPIHz/zk2fWcYYjZ13bECoCu+E+
 KWM4Q3xsLWNT+W9k6G/9atLaLLX9mo9htQ2vOz02pRnkin4PbJjp7DQcAAOGUNtLIfJV
 K9CLvDEAq0S7uCw0asm7s5hR0du+DlkluhSeIQ0abFTlysVIY6b+9HRQ2qJkM6YkJc8k
 K9UTSP9CpNKj37OojLQcG1fKDHi8a1t9Xa1glKCcKcRBgWiKa9Puhc0T0nxt9lg+XFuA Yg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 36yfdxua6d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Mar 2021 11:28:54 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 30925100034;
        Mon,  1 Mar 2021 11:28:53 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0B72922671E;
        Mon,  1 Mar 2021 11:28:53 +0100 (CET)
Received: from [10.211.4.172] (10.75.127.51) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 1 Mar
 2021 11:28:51 +0100
Subject: Re: [PATCH v2 1/2] tty/serial: Add rx-tx-swap OF option to
 stm32-usart
To:     Martin Devera <devik@eaxlabs.cz>, <linux-kernel@vger.kernel.org>
CC:     <devicetree@vger.kernel.org>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        <linux-serial@vger.kernel.org>, Jiri Slaby <jirislaby@kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Le Ray <erwan.leray@st.com>
References: <CAL_JsqK8+M=Vg0PiDXP2f1LrEp4hSVea6piAASMGu1H=pxme6Q@mail.gmail.com>
 <20210227164157.30971-1-devik@eaxlabs.cz>
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Message-ID: <439a0d7a-cc0e-764b-7ed8-668b5a85f4a7@foss.st.com>
Date:   Mon, 1 Mar 2021 11:28:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210227164157.30971-1-devik@eaxlabs.cz>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG3NODE2.st.com (10.75.127.8) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-01_05:2021-02-26,2021-03-01 signatures=0
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 2/27/21 5:41 PM, Martin Devera wrote:
> STM32 F7/H7 usarts supports RX & TX pin swapping.
> Add option to turn it on.
> Tested on STM32MP157.
> 
> Signed-off-by: Martin Devera <devik@eaxlabs.cz>
> ---
>  drivers/tty/serial/stm32-usart.c | 3 ++-
>  drivers/tty/serial/stm32-usart.h | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
> index b3675cf25a69..3650c8798061 100644
> --- a/drivers/tty/serial/stm32-usart.c
> +++ b/drivers/tty/serial/stm32-usart.c
> @@ -758,7 +758,7 @@ static void stm32_usart_set_termios(struct uart_port *port,
>  	cr1 = USART_CR1_TE | USART_CR1_RE;
>  	if (stm32_port->fifoen)
>  		cr1 |= USART_CR1_FIFOEN;
> -	cr2 = 0;
> +	cr2 = stm32_port->swap ? USART_CR2_SWAP : 0;

Hi Martin,

Same could be done in the startup routine, that enables the port for
reception (as described in Documentation/driver-api/serial/driver.rst)

>  	cr3 = readl_relaxed(port->membase + ofs->cr3);
>  	cr3 &= USART_CR3_TXFTIE | USART_CR3_RXFTCFG_MASK | USART_CR3_RXFTIE
>  		| USART_CR3_TXFTCFG_MASK;
> @@ -1078,6 +1078,7 @@ static struct stm32_port *stm32_usart_of_get_port(struct platform_device *pdev)
>  	stm32_ports[id].hw_flow_control =
>  		of_property_read_bool (np, "st,hw-flow-ctrl") /*deprecated*/ ||
>  		of_property_read_bool (np, "uart-has-rtscts");
> +	stm32_ports[id].swap = of_property_read_bool(np, "rx-tx-swap");

The swap option/bit is available starting with stm32f7 (e.g. not on
stm32f4).

This could be added to compatible data, e.g. as done for other
capabilities in stm32-usart.h. E.g you could add a "has_swap" in struct
stm32_usart_config, then use it at probe time:
	if (cfg->has_swap)
		stm32_ports[id].swap = ...;

Thanks for your patch,
Best regards,
Fabrice

>  	stm32_ports[id].port.line = id;
>  	stm32_ports[id].cr1_irq = USART_CR1_RXNEIE;
>  	stm32_ports[id].cr3_irq = 0;
> diff --git a/drivers/tty/serial/stm32-usart.h b/drivers/tty/serial/stm32-usart.h
> index cb4f327c46db..2f054e2dc0ab 100644
> --- a/drivers/tty/serial/stm32-usart.h
> +++ b/drivers/tty/serial/stm32-usart.h
> @@ -271,6 +271,7 @@ struct stm32_port {
>  	int last_res;
>  	bool tx_dma_busy;	 /* dma tx busy               */
>  	bool hw_flow_control;
> +	bool swap;		 /* swap RX & TX pins */
>  	bool fifoen;
>  	int wakeirq;
>  	int rdr_mask;		/* receive data register mask */
> 
