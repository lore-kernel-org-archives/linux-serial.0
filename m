Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A36CAC4332D
	for <linux-serial@archiver.kernel.org>; Fri, 15 Jan 2021 02:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C09823AF8
	for <linux-serial@archiver.kernel.org>; Fri, 15 Jan 2021 02:33:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732119AbhAOCdc convert rfc822-to-8bit (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 14 Jan 2021 21:33:32 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:2979 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732041AbhAOCdc (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 14 Jan 2021 21:33:32 -0500
Received: from dggemi402-hub.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4DH4vD0fFdzR3wk;
        Fri, 15 Jan 2021 10:31:52 +0800 (CST)
Received: from DGGEMI529-MBS.china.huawei.com ([169.254.5.72]) by
 dggemi402-hub.china.huawei.com ([10.3.17.135]) with mapi id 14.03.0509.000;
 Fri, 15 Jan 2021 10:32:41 +0800
From:   zhangqiumiao <zhangqiumiao1@huawei.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "Chenxiang (EulerOS)" <rose.chen@huawei.com>,
        "Yanan (Euler)" <yanan@huawei.com>
Subject: Re: [PATCH v3] tty: make pl011 serial port driver support 485 mode
Thread-Topic: [PATCH v3] tty: make pl011 serial port driver support 485 mode
Thread-Index: Adbq3ptkIAave/tYR++q7vAdgjWI4A==
Date:   Fri, 15 Jan 2021 02:32:39 +0000
Message-ID: <BEEC2888CE24964AA5C6EAB9EA9DA122272F78@dggemi529-mbs.china.huawei.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.136.113.59]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Jan 14, 2021 at 08:28:30PM +0800, zhangqiumiao1@huawei.com wrote:
> From: Qiumiao Zhang <zhangqiumiao1@huawei.com>
> 
> make pl011 serial port support 485 mode full duplex communication
> 
> Signed-off-by: Qiumiao Zhang <zhangqiumiao1@huawei.com>
> ---
> Changes in v3:
>   -Fix busy loop forever in pl011_tx_empty
>   -Move the definition of cr into uart_amba_port
>   -run checkpatch with no error or warning
> 
> Changes in v2:
>   -Fix two compilation errors
> 
>  drivers/tty/serial/amba-pl011.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/drivers/tty/serial/amba-pl011.c 
> b/drivers/tty/serial/amba-pl011.c index c255476..9da10a4 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -44,6 +44,7 @@
> 
>  #include "amba-pl011.h"
> 
> +#define ISEMPTY			1
>  #define UART_NR			14
> 
>  #define SERIAL_AMBA_MAJOR	204
> @@ -264,6 +265,7 @@ struct uart_amba_port {
>  	unsigned int		fifosize;	/* vendor-specific */
>  	unsigned int		old_cr;		/* state during shutdown */
>  	unsigned int		fixed_baud;	/* vendor-set fixed baud rate */
> +	unsigned int		cr;
>  	char			type[12];
>  #ifdef CONFIG_DMA_ENGINE
>  	/* DMA stuff */
> @@ -1284,6 +1286,8 @@ static inline bool pl011_dma_rx_running(struct uart_amba_port *uap)
>  #define pl011_dma_flush_buffer	NULL
>  #endif
> 
> +static unsigned int pl011_tx_empty(struct uart_port *port);
> +
>  static void pl011_stop_tx(struct uart_port *port)  {
>  	struct uart_amba_port *uap =
> @@ -1292,6 +1296,17 @@ static void pl011_stop_tx(struct uart_port *port)
>  	uap->im &= ~UART011_TXIM;
>  	pl011_write(uap->im, uap, REG_IMSC);
>  	pl011_dma_tx_stop(uap);
> +	if (port->rs485.flags & SER_RS485_ENABLED) {
> +		while(pl011_tx_empty(port) != ISEMPTY) ;

I intend to change this to:
        while(pl011_tx_empty(port) != ISEMPTY)
			cpu_relax();
Is this ok?

> +
> +		uap->cr = pl011_read(uap, REG_CR);
> +		if (port->rs485.flags & SER_RS485_RTS_AFTER_SEND) {
> +			uap->cr |= UART011_CR_RTS;
> +		} else {
> +			uap->cr &= ~UART011_CR_RTS;
> +		}

Checkpatch doesn't find the problem here. Please tell me what's wrong here?

thanks,

Qiumiao Zhang
