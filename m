Return-Path: <SRS0=jxo+=BD=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F9A8C433E3
	for <linux-serial@archiver.kernel.org>; Fri, 24 Jul 2020 14:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E02C320674
	for <linux-serial@archiver.kernel.org>; Fri, 24 Jul 2020 14:08:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="nL2GZGR4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbgGXOI4 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 24 Jul 2020 10:08:56 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:54056 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726366AbgGXOI4 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 24 Jul 2020 10:08:56 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06OE7MMf001019;
        Fri, 24 Jul 2020 16:08:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=5cYw65X/B4b0U29TAOJF77qqocP+kCYLxZVn9J0Z6yo=;
 b=nL2GZGR4ulnqIC7c5WtV7dmfE+e9PiuZCQniOPJdI1i2Q0BtbB1lCsZ04aT7X0ncITFD
 zpNeGcGV1NvB3LoTheLbaD5dPPHcQ2TJoGqFIs1pis7dk8nnCaW1XChtSWPIdasBVS06
 OinAVuFulnA5N+pEqqW1+YnYpMhRSsEdnO42MmHifEybZMN7tiYJJ0+Bwu5LKbInjXaV
 Fo6BztSMli6lLowHbOXn6ygU3bWLK9QeoZDMUEH8QJXaYLn1GvGPXHYIBglEI8xV793E
 DIpsN2j3FtBIYek6A84akorJkF3KZ4hSQMfHZjcXpUVi7aNVNGrSGQWUcLL+OOotrdEs ig== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 32bsahgrtu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Jul 2020 16:08:48 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 08934100034;
        Fri, 24 Jul 2020 16:08:48 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E7EF82BE23F;
        Fri, 24 Jul 2020 16:08:47 +0200 (CEST)
Received: from [10.48.1.149] (10.75.127.47) by SFHDAG5NODE3.st.com
 (10.75.127.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 24 Jul
 2020 16:08:47 +0200
Subject: Re: [PATCH] tty: serial: Add RS485 RTS GPIO control
To:     Marek Vasut <marex@denx.de>, <linux-serial@vger.kernel.org>
CC:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        Erwan LE RAY <erwan.leray@st.com>
References: <20200724101418.146234-1-marex@denx.de>
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
Message-ID: <55316724-acfd-df68-d0de-4d009184658a@st.com>
Date:   Fri, 24 Jul 2020 16:08:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200724101418.146234-1-marex@denx.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG4NODE2.st.com (10.75.127.11) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-24_04:2020-07-24,2020-07-24 signatures=0
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 7/24/20 12:14 PM, Marek Vasut wrote:
> While the STM32 does support RS485 drive-enable control within the
> UART IP itself, some systems have the drive-enable line connected
> to a pin which cannot be pinmuxed as RTS. Add support for toggling
> the RTS GPIO line using the modem control GPIOs to provide at least
> some sort of emulation.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: Manivannan Sadhasivam <mani@kernel.org>
> Cc: Fabrice Gasnier <fabrice.gasnier@st.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Hi Marek,

You could add stm32 in the commit title.
'git log --oneline' gives "serial: stm32: ..." most of the time here.

Also could you please CC STM32 maintainers and mailing list?

Please find other remark below.

> ---
>  drivers/tty/serial/stm32-usart.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
> index d1c5e536a167..22c8477571ce 100644
> --- a/drivers/tty/serial/stm32-usart.c
> +++ b/drivers/tty/serial/stm32-usart.c
> @@ -34,6 +34,7 @@
>  #include "serial_mctrl_gpio.h"
>  #include "stm32-usart.h"
>  
> +static void stm32_set_mctrl(struct uart_port *port, unsigned int mctrl);
>  static void stm32_stop_tx(struct uart_port *port);
>  static void stm32_transmit_chars(struct uart_port *port);
>  
> @@ -129,9 +130,13 @@ static int stm32_config_rs485(struct uart_port *port,
>  		if (rs485conf->flags & SER_RS485_RTS_ON_SEND) {
>  			cr3 &= ~USART_CR3_DEP;
>  			rs485conf->flags &= ~SER_RS485_RTS_AFTER_SEND;
> +			stm32_set_mctrl(port,
> +					stm32_port->port.mctrl & ~TIOCM_RTS);


Calling stm32_set_mctrl() will also set or clear bit in cr3.
But right after the if() {} else {} statement here there's a:
- writel_relaxed(cr3, port->membase + ofs->cr3);

That's basically overwritten... I guess that's undesired.

So I suggest to simply call mctrl_gpio_set() instead. This is probably
all you need here ?

>  		} else {
>  			cr3 |= USART_CR3_DEP;
>  			rs485conf->flags |= SER_RS485_RTS_AFTER_SEND;
> +			stm32_set_mctrl(port,
> +					stm32_port->port.mctrl | TIOCM_RTS);
>  		}
>  
>  		writel_relaxed(cr3, port->membase + ofs->cr3);
> @@ -847,9 +852,13 @@ static void stm32_set_termios(struct uart_port *port, struct ktermios *termios,
>  		if (rs485conf->flags & SER_RS485_RTS_ON_SEND) {
>  			cr3 &= ~USART_CR3_DEP;
>  			rs485conf->flags &= ~SER_RS485_RTS_AFTER_SEND;
> +			stm32_set_mctrl(port,
> +					stm32_port->port.mctrl & ~TIOCM_RTS);
>  		} else {
>  			cr3 |= USART_CR3_DEP;
>  			rs485conf->flags |= SER_RS485_RTS_AFTER_SEND;
> +			stm32_set_mctrl(port,
> +					stm32_port->port.mctrl | TIOCM_RTS);

Same as above.

Best Regards,
Fabrice

>  		}
>  
>  	} else {
> 
