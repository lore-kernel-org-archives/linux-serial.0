Return-Path: <SRS0=Wt+Y=CL=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC285C433E2
	for <linux-serial@archiver.kernel.org>; Wed,  2 Sep 2020 08:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B29E52087C
	for <linux-serial@archiver.kernel.org>; Wed,  2 Sep 2020 08:08:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="jybDDGW7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbgIBII3 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 2 Sep 2020 04:08:29 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:5312 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726183AbgIBII2 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 2 Sep 2020 04:08:28 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08287vJ9006324;
        Wed, 2 Sep 2020 10:08:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=m1tOEat9dlyp2tK0W6y7i2myaafq9v/uzRQ/+m7V5W8=;
 b=jybDDGW7SKUMTjAMN5J2f+aaae2nNwMHk51BRIDeZoFuK50G9QRDsLCvksd0DBC6N1um
 hR/Vlyq1LTp7jAzys1wf18+rDFFx3zaH24RaSzmltIjvCam9kfrvZF7HVeGPBGrZOxEL
 PcazPj6W2JfbhL4/3cF72BtVUaDd9EFA2XZupiHLV65hmhEk/AulrKytW7wumaovt/5n
 9pusN0PaLzK+JRYhwEIWlw8+uqPWRVVF96ifuKm6QyQTD6JPKHdb9veVD8x2odpExfV8
 sSoSvHm9jyg49+xAdPRV0DO5LO3mfSdPQD6k83ubbwO9PUTU6dD04xGbjKqFPHNfDdAO 6A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 337cg1m8r6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Sep 2020 10:08:19 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7236F100034;
        Wed,  2 Sep 2020 10:08:19 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 467132A4D68;
        Wed,  2 Sep 2020 10:08:19 +0200 (CEST)
Received: from [10.48.1.149] (10.75.127.46) by SFHDAG5NODE3.st.com
 (10.75.127.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 2 Sep
 2020 10:08:18 +0200
Subject: Re: [PATCH V3] serial: stm32: Add RS485 RTS GPIO control again
To:     Marek Vasut <marex@denx.de>, <linux-serial@vger.kernel.org>
CC:     Alexandre Torgue <alexandre.torgue@st.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Erwan LE RAY <erwan.leray@st.com>
References: <20200831171045.205691-1-marex@denx.de>
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
Message-ID: <2ed8eeba-4c67-9c9b-5264-72171aab066a@st.com>
Date:   Wed, 2 Sep 2020 10:08:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200831171045.205691-1-marex@denx.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG1NODE1.st.com (10.75.127.1) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-02_03:2020-09-02,2020-09-02 signatures=0
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 8/31/20 7:10 PM, Marek Vasut wrote:
> While the STM32 does support RS485 drive-enable control within the
> UART IP itself, some systems have the drive-enable line connected
> to a pin which cannot be pinmuxed as RTS. Add support for toggling
> the RTS GPIO line using the modem control GPIOs to provide at least
> some sort of emulation.
> 
> Fixes: 7df5081cbf5e ("serial: stm32: Add RS485 RTS GPIO control")
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Alexandre Torgue <alexandre.torgue@st.com>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: Manivannan Sadhasivam <mani@kernel.org>
> Cc: Fabrice Gasnier <fabrice.gasnier@st.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-stm32@st-md-mailman.stormreply.com
> ---
> V2: Use mctrl_gpio_set() instead of stm32_set_mctrl()
> V3: - Actually toggle the RTS line before and after TX
>     - Undo 7df5081cbf5e ("serial: stm32: Add RS485 RTS GPIO control")
>       which was previous version of this patch ; I messed up.
> ---
>  drivers/tty/serial/stm32-usart.c | 33 ++++++++++++++++++++++++--------
>  1 file changed, 25 insertions(+), 8 deletions(-)


Hi Marek,

This seems sensible. I've few comments on the commit tittle and commit
message:
- tittle: this could be named as a "fix" rather than "add... again" ?
- I may have missed it... Is it a V3 ?

Could explain what is being fixed? Why moving the mctrl_gpio_* calls
away from the stm32_config_rs485()/set_termios() routines to the
start_tx/stop_tx ops improves/fixes the RS485 RTS GPIO control (what was
wrong) ?

Thanks,
Best regards,
Fabrice

> 
> diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
> index 143300a80090..23f7453441ae 100644
> --- a/drivers/tty/serial/stm32-usart.c
> +++ b/drivers/tty/serial/stm32-usart.c
> @@ -129,13 +129,9 @@ static int stm32_config_rs485(struct uart_port *port,
>  		if (rs485conf->flags & SER_RS485_RTS_ON_SEND) {
>  			cr3 &= ~USART_CR3_DEP;
>  			rs485conf->flags &= ~SER_RS485_RTS_AFTER_SEND;
> -			mctrl_gpio_set(stm32_port->gpios,
> -					stm32_port->port.mctrl & ~TIOCM_RTS);
>  		} else {
>  			cr3 |= USART_CR3_DEP;
>  			rs485conf->flags |= SER_RS485_RTS_AFTER_SEND;
> -			mctrl_gpio_set(stm32_port->gpios,
> -					stm32_port->port.mctrl | TIOCM_RTS);
>  		}
>  
>  		writel_relaxed(cr3, port->membase + ofs->cr3);
> @@ -541,17 +537,42 @@ static void stm32_disable_ms(struct uart_port *port)
>  /* Transmit stop */
>  static void stm32_stop_tx(struct uart_port *port)
>  {
> +	struct stm32_port *stm32_port = to_stm32_port(port);
> +	struct serial_rs485 *rs485conf = &port->rs485;
> +
>  	stm32_tx_interrupt_disable(port);
> +
> +	if (rs485conf->flags & SER_RS485_ENABLED) {
> +		if (rs485conf->flags & SER_RS485_RTS_ON_SEND) {
> +			mctrl_gpio_set(stm32_port->gpios,
> +					stm32_port->port.mctrl & ~TIOCM_RTS);
> +		} else {
> +			mctrl_gpio_set(stm32_port->gpios,
> +					stm32_port->port.mctrl | TIOCM_RTS);
> +		}
> +	}
>  }
>  
>  /* There are probably characters waiting to be transmitted. */
>  static void stm32_start_tx(struct uart_port *port)
>  {
> +	struct stm32_port *stm32_port = to_stm32_port(port);
> +	struct serial_rs485 *rs485conf = &port->rs485;
>  	struct circ_buf *xmit = &port->state->xmit;
>  
>  	if (uart_circ_empty(xmit))
>  		return;
>  
> +	if (rs485conf->flags & SER_RS485_ENABLED) {
> +		if (rs485conf->flags & SER_RS485_RTS_ON_SEND) {
> +			mctrl_gpio_set(stm32_port->gpios,
> +					stm32_port->port.mctrl | TIOCM_RTS);
> +		} else {
> +			mctrl_gpio_set(stm32_port->gpios,
> +					stm32_port->port.mctrl & ~TIOCM_RTS);
> +		}
> +	}
> +
>  	stm32_transmit_chars(port);
>  }
>  
> @@ -851,13 +872,9 @@ static void stm32_set_termios(struct uart_port *port, struct ktermios *termios,
>  		if (rs485conf->flags & SER_RS485_RTS_ON_SEND) {
>  			cr3 &= ~USART_CR3_DEP;
>  			rs485conf->flags &= ~SER_RS485_RTS_AFTER_SEND;
> -			mctrl_gpio_set(stm32_port->gpios,
> -					stm32_port->port.mctrl & ~TIOCM_RTS);
>  		} else {
>  			cr3 |= USART_CR3_DEP;
>  			rs485conf->flags |= SER_RS485_RTS_AFTER_SEND;
> -			mctrl_gpio_set(stm32_port->gpios,
> -					stm32_port->port.mctrl | TIOCM_RTS);
>  		}
>  
>  	} else {
> 
