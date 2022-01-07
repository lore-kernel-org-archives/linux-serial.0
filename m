Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C66C433EF
	for <linux-serial@archiver.kernel.org>; Fri,  7 Jan 2022 08:30:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233223AbiAGIav (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 7 Jan 2022 03:30:51 -0500
Received: from mail-wm1-f47.google.com ([209.85.128.47]:52066 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232742AbiAGIau (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 7 Jan 2022 03:30:50 -0500
Received: by mail-wm1-f47.google.com with SMTP id e5so3399333wmq.1
        for <linux-serial@vger.kernel.org>; Fri, 07 Jan 2022 00:30:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6YdoKCJ0yFXaDbmaY2fvU6cSwNNqScCWlTrr/D1fbK0=;
        b=JXBSuQBYpE7c3y9jLGUAj5L7I2KBXH4HtJVxSksdGumvKJT38fz0l5hNaekSr1tuuJ
         QiK3kvO3/NwlqyDbh0n1pX38A8C4o4pwSHajDyL/8LGeHTDy/WfZeg1rIAqWLwURFZ4Y
         lUL/t750V03DG6AkFBoni3fqYMdbadIKrpCbO1b/XwZfNjkmgQlbFUodv/nlo0mPYlFf
         VFF8TU8AyWEhgg9xRAWlb5sLvDW5kT0EcSgmEi6msINlfEMWGQBkNTHcmhAWKfXnbQjZ
         8XSaMUatKMyXAzrOEXFeQweFMQJfdvXIkOiP0scIwVVrlPMevCORGn1VC/7SslKEeBX0
         OL1Q==
X-Gm-Message-State: AOAM533P2UbgzQ2AALVI3ly3plTc/+RavxlMFzk/usKKxI/bn9TIlzOI
        UQcu+P/0Bqn57gt9EryDOTw=
X-Google-Smtp-Source: ABdhPJwugvuWae4Ll/l/HKIIQcFOda75jh4b4KQMgEDPMDnvupumx1YzPQy+8C+/SgRnnhrqw7vuAw==
X-Received: by 2002:a05:600c:4f91:: with SMTP id n17mr10209453wmq.195.1641544249796;
        Fri, 07 Jan 2022 00:30:49 -0800 (PST)
Received: from [192.168.1.49] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id k14sm36589wrn.59.2022.01.07.00.30.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jan 2022 00:30:49 -0800 (PST)
Message-ID: <ffe14471-b5da-fe97-a679-f1066ed13bd2@kernel.org>
Date:   Fri, 7 Jan 2022 09:30:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH] serial: pl010: Drop CR register reset on set_termios
Content-Language: en-US
To:     Lukas Wunner <lukas@wunner.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        Philipp Rosenberger <p.rosenberger@kunbus.com>,
        linux-serial@vger.kernel.org
References: <fcaff16e5b1abb4cc3da5a2879ac13f278b99ed0.1641128728.git.lukas@wunner.de>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <fcaff16e5b1abb4cc3da5a2879ac13f278b99ed0.1641128728.git.lukas@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 02. 01. 22, 18:42, Lukas Wunner wrote:
> pl010_set_termios() briefly resets the CR register to zero.
> 
> Where does this register write come from?
> 
> The PL010 driver's IRQ handler ambauart_int() originally modified the CR
> register without holding the port spinlock.  ambauart_set_termios() also
> modified that register.  To prevent concurrent read-modify-writes by the
> IRQ handler and to prevent transmission while changing baudrate,
> ambauart_set_termios() had to disable interrupts.  That is achieved by
> writing zero to the CR register.
> 
> However in 2004 the PL010 driver was amended to acquire the port
> spinlock in the IRQ handler, obviating the need to disable interrupts in
> ->set_termios():
> https://git.kernel.org/history/history/c/157c0342e591
> 
> That rendered the CR register write obsolete.  Drop it.
> 
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: Russell King <rmk+kernel@armlinux.org.uk>
> ---
>   drivers/tty/serial/amba-pl010.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/tty/serial/amba-pl010.c b/drivers/tty/serial/amba-pl010.c
> index e744b953ca34..47654073123d 100644
> --- a/drivers/tty/serial/amba-pl010.c
> +++ b/drivers/tty/serial/amba-pl010.c
> @@ -446,14 +446,11 @@ pl010_set_termios(struct uart_port *port, struct ktermios *termios,
>   	if ((termios->c_cflag & CREAD) == 0)
>   		uap->port.ignore_status_mask |= UART_DUMMY_RSR_RX;
>   
> -	/* first, disable everything */
>   	old_cr = readb(uap->port.membase + UART010_CR) & ~UART010_CR_MSIE;
>   
>   	if (UART_ENABLE_MS(port, termios->c_cflag))
>   		old_cr |= UART010_CR_MSIE;
>   
> -	writel(0, uap->port.membase + UART010_CR);
> -

Isn't the write of zero followed by the original CR value needed to 
actually start the chip with the updated baud rate?

What are you trying to fix?

>   	/* Set baud rate */
>   	quot -= 1;
>   	writel((quot & 0xf00) >> 8, uap->port.membase + UART010_LCRM);

thanks,
-- 
js
suse labs
