Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.7 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E75FC48BE5
	for <linux-serial@archiver.kernel.org>; Wed, 16 Jun 2021 06:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03255613BF
	for <linux-serial@archiver.kernel.org>; Wed, 16 Jun 2021 06:18:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbhFPGUJ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 16 Jun 2021 02:20:09 -0400
Received: from mail-ej1-f47.google.com ([209.85.218.47]:43556 "EHLO
        mail-ej1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbhFPGUJ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 16 Jun 2021 02:20:09 -0400
Received: by mail-ej1-f47.google.com with SMTP id nb6so1819423ejc.10;
        Tue, 15 Jun 2021 23:18:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9a9qyUphW3s0CGsYm8ttvYCQCKXWvSpf1HL+27z8QW8=;
        b=uj7uj6nI2sbtu50QXp9uEjTBQNWC3nYoZhWc7DmUGSt9zrqnwyVcXwSpGvUkYZAKoH
         4GUvIagJDXnwC9OeN9fYVPl+dh9xWi1SSqPiSJ2eNYmUfswtFzaf/jJNWXEv0JM7Chn6
         7XOPe61tV7WaN+2cGFl2nXDek41SmA8z1TkTHryv3H+//abwtmVTlWYA0T7V7F9usScp
         4sqaFyq6r2jPqSy35DkcOMqtxRMngspN90yP/VjzFdoLHSes8KSFWtZEqafTDEQ65DaQ
         1KpS6XD/sNpbHNjpemu1Iq87gVmRdbPKZ1eqmcxCIbcuLCbGDbMSBYXPa+2qRhjoysJ1
         AdrA==
X-Gm-Message-State: AOAM533SLfKgOtqDF5PWggS6aJc2R6KMlFfx+P86Rje8YWBJIFgDnpuv
        gKkbkcBIM6tVh4T7i9B18zZEvQkGZfE=
X-Google-Smtp-Source: ABdhPJwzHVZX4Ev+IXHg2PqEMD3Z6TJAkvcxUGu8B+NUNesinhBoStuxVviQJgnTwZyugiHlJqe2vQ==
X-Received: by 2002:a17:906:b24a:: with SMTP id ce10mr3511669ejb.83.1623824282553;
        Tue, 15 Jun 2021 23:18:02 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id v7sm916032edx.38.2021.06.15.23.18.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jun 2021 23:18:01 -0700 (PDT)
Subject: Re: [PATCH] serial: amba-pl011: add RS485 support
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>, gregkh@linuxfoundation.org
Cc:     linux@armlinux.org.uk, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210610135004.7585-1-LinoSanfilippo@gmx.de>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <5f00ff43-9287-4027-7d80-474da957703c@kernel.org>
Date:   Wed, 16 Jun 2021 08:18:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210610135004.7585-1-LinoSanfilippo@gmx.de>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 10. 06. 21, 15:50, Lino Sanfilippo wrote:
> Add basic support for RS485: Provide a callback to configure rs485
> settings. Handle the RS485 specific part in the functions
> pl011_rs485_tx_start() and pl011_rs485_tx_stop() which extend the generic
> start/stop callbacks.
> Beside via IOCTL from userspace RS485 can be enabled by means of the
> device tree property "rs485-enabled-at-boot-time".
> 
> Signed-off-by: Lino Sanfilippo <LinoSanfilippo@gmx.de>
> ---
> This patch has been tested with a Raspberry Pi CM3.
> 
>   drivers/tty/serial/amba-pl011.c | 143 +++++++++++++++++++++++++++++++-
>   1 file changed, 140 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> index 78682c12156a..36e8b938cdba 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
...
> @@ -1380,6 +1415,31 @@ static bool pl011_tx_char(struct uart_amba_port *uap, unsigned char c,
>   	return true;
>   }
>   
> +static void pl011_rs485_tx_start(struct uart_amba_port *uap)
> +{
> +	struct uart_port *port = &uap->port;
> +	u32 cr;
> +
> +	/* Enable transmitter */
> +	cr = pl011_read(uap, REG_CR);
> +	cr |= UART011_CR_TXE;
> +	/* Disable receiver if half-duplex */
> +	if (!(port->rs485.flags & SER_RS485_RX_DURING_TX))
> +		cr &= ~UART011_CR_RXE;
> +
> +	if (port->rs485.flags & SER_RS485_RTS_ON_SEND)
> +		cr &= ~UART011_CR_RTS;
> +	else
> +		cr |= UART011_CR_RTS;
> +
> +	pl011_write(cr, uap, REG_CR);
> +
> +	if (port->rs485.delay_rts_before_send)
> +		mdelay(port->rs485.delay_rts_before_send);

This is up to 1 second delay with interrupts disabled. Definitely not 
nice. 8250 clamps this to 100 ms at least, why did you choose 1000 ms?

> +
> +	uap->rs485_tx_started = true;
> +}
> +
>   /* Returns true if tx interrupts have to be (kept) enabled  */
>   static bool pl011_tx_chars(struct uart_amba_port *uap, bool from_irq)
>   {
...
> @@ -1941,6 +2021,7 @@ pl011_set_termios(struct uart_port *port, struct ktermios *termios,
>   	unsigned int lcr_h, old_cr;
>   	unsigned long flags;
>   	unsigned int baud, quot, clkdiv;
> +	unsigned int bits;
>   
>   	if (uap->vendor->oversampling)
>   		clkdiv = 8;
> @@ -1968,25 +2049,32 @@ pl011_set_termios(struct uart_port *port, struct ktermios *termios,
>   	switch (termios->c_cflag & CSIZE) {
>   	case CS5:
>   		lcr_h = UART01x_LCRH_WLEN_5;
> +		bits = 7;
>   		break;
>   	case CS6:
>   		lcr_h = UART01x_LCRH_WLEN_6;
> +		bits = 8;
>   		break;
>   	case CS7:
>   		lcr_h = UART01x_LCRH_WLEN_7;
> +		bits = 9;
>   		break;
>   	default: // CS8
>   		lcr_h = UART01x_LCRH_WLEN_8;
> +		bits = 10;
>   		break;
>   	}
> -	if (termios->c_cflag & CSTOPB)
> +	if (termios->c_cflag & CSTOPB) {
>   		lcr_h |= UART01x_LCRH_STP2;
> +		bits++;
> +	}
>   	if (termios->c_cflag & PARENB) {
>   		lcr_h |= UART01x_LCRH_PEN;
>   		if (!(termios->c_cflag & PARODD))
>   			lcr_h |= UART01x_LCRH_EPS;
>   		if (termios->c_cflag & CMSPAR)
>   			lcr_h |= UART011_LCRH_SPS;
> +		bits++;
>   	}

You can do simply:
   bits = tty_get_frame_size(termios->c_cflag);
now:
https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/commit/?h=tty-testing&id=3ec2ff37230e1c961d4b0d0118dd23c46b5bcdbb


thanks,
-- 
js
