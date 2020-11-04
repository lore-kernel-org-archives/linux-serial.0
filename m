Return-Path: <SRS0=3oyo=EK=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B21ECC2D0A3
	for <linux-serial@archiver.kernel.org>; Wed,  4 Nov 2020 20:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 552E020759
	for <linux-serial@archiver.kernel.org>; Wed,  4 Nov 2020 20:04:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731510AbgKDUEt (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 4 Nov 2020 15:04:49 -0500
Received: from mleia.com ([178.79.152.223]:55478 "EHLO mail.mleia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731503AbgKDUEt (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 4 Nov 2020 15:04:49 -0500
Received: from mail.mleia.com (localhost [127.0.0.1])
        by mail.mleia.com (Postfix) with ESMTP id 0747A416CD3;
        Wed,  4 Nov 2020 20:04:48 +0000 (UTC)
Subject: Re: [PATCH 19/36] tty: serial: lpc32xx_hs: Remove unused variable
 'tmp'
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Kevin Wells <kevin.wells@nxp.com>,
        Roland Stigge <stigge@antcom.de>, linux-serial@vger.kernel.org
References: <20201104193549.4026187-1-lee.jones@linaro.org>
 <20201104193549.4026187-20-lee.jones@linaro.org>
From:   Vladimir Zapolskiy <vz@mleia.com>
Message-ID: <208ff62b-c6c0-4b2c-250c-7951f422ba54@mleia.com>
Date:   Wed, 4 Nov 2020 22:04:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201104193549.4026187-20-lee.jones@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20201104_200448_073610_BFADF4C5 
X-CRM114-Status: GOOD (  16.54  )
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Lee,

On 11/4/20 9:35 PM, Lee Jones wrote:
> Fixes the following W=1 kernel build warning(s):
> 
>   drivers/tty/serial/lpc32xx_hs.c: In function ‘__serial_uart_flush’:
>   drivers/tty/serial/lpc32xx_hs.c:244:6: warning: variable ‘tmp’ set but not used [-Wunused-but-set-variable]
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jirislaby@kernel.org>
> Cc: Vladimir Zapolskiy <vz@mleia.com>
> Cc: Sylvain Lemieux <slemieux.tyco@gmail.com>
> Cc: Kevin Wells <kevin.wells@nxp.com>
> Cc: Roland Stigge <stigge@antcom.de>
> Cc: linux-serial@vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>   drivers/tty/serial/lpc32xx_hs.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/lpc32xx_hs.c b/drivers/tty/serial/lpc32xx_hs.c
> index b5898c9320361..1fa098d7aec4b 100644
> --- a/drivers/tty/serial/lpc32xx_hs.c
> +++ b/drivers/tty/serial/lpc32xx_hs.c
> @@ -241,12 +241,11 @@ static unsigned int __serial_get_clock_div(unsigned long uartclk,
>   
>   static void __serial_uart_flush(struct uart_port *port)
>   {
> -	u32 tmp;
>   	int cnt = 0;
>   
>   	while ((readl(LPC32XX_HSUART_LEVEL(port->membase)) > 0) &&
>   	       (cnt++ < FIFO_READ_LIMIT))
> -		tmp = readl(LPC32XX_HSUART_FIFO(port->membase));
> +		readl(LPC32XX_HSUART_FIFO(port->membase));
>   }
>   
>   static void __serial_lpc32xx_rx(struct uart_port *port)
> 

Thank you for the change.

Acked-by: Vladimir Zapolskiy <vz@mleia.com>

I'm sure the change is correct, likely the local variable was introduced
to prevent an unwanted probable optimization by some odd/ancient compiler.

--
Best wishes,
Vladimir
