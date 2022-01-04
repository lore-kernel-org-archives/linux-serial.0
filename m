Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23CA8C433F5
	for <linux-serial@archiver.kernel.org>; Tue,  4 Jan 2022 07:17:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233104AbiADHR6 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 4 Jan 2022 02:17:58 -0500
Received: from mail-ed1-f46.google.com ([209.85.208.46]:37873 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbiADHR6 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 4 Jan 2022 02:17:58 -0500
Received: by mail-ed1-f46.google.com with SMTP id o6so144858442edc.4;
        Mon, 03 Jan 2022 23:17:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=pOAXZ90y+NqNgM4bMsWBaGvAJnnSkQQXCw6loSgl2/0=;
        b=XYdPiyPhm42BJoz5DA3nMwmgWfa6nsyyb3s6hvozNJ9/hjmr9c84cmcFuV3uSnWEow
         JnkOT1MkU75P+ZBoVGeqsUNMyS+LIB5NbTFzfXsTkB3tbbrSw8BlFj2F8/T2YbMEHTDe
         ijwGeqLgTIbwZNkjudxsL5bwG58N0bG9EZy2pE8a82Eaj2wP+Yv7/9zH9RTVRREvWqKk
         HKtJzorDpWofQ2UEw7qjJcNXubBmkDWZuReZpohHaF3C1dWMUTfAZ8VS1pzv2g8ELs9Y
         O2UZX0239BvNFX4dI/qvkDh1pMp36zai1OCOSFj+Ju+HhfEKFAWmCdXPoT0Ti+O2Al2I
         ZOIw==
X-Gm-Message-State: AOAM532NyvCdQ5JaWR1DTpA4PwuAc74Q4HHyF1bb3xPupo8PrbnfrpRy
        WLJuGuHy4kwtvjNB/nb04GY=
X-Google-Smtp-Source: ABdhPJxyS+tzswPsc9YapgmN417/e8DdnMTszn/Q2wP39cAGpiC/unR8VNCGRsayLdvZRy6T0izOmQ==
X-Received: by 2002:a05:6402:1a4f:: with SMTP id bf15mr48104233edb.260.1641280677169;
        Mon, 03 Jan 2022 23:17:57 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id j11sm14371994edv.0.2022.01.03.23.17.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jan 2022 23:17:56 -0800 (PST)
Message-ID: <50ceeac0-adb1-30c1-ecc7-ddd4fb94a99c@kernel.org>
Date:   Tue, 4 Jan 2022 08:17:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2] serial: 8250: Move Alpha-specific quirk out of the
 core
Content-Language: en-US
To:     Lukas Wunner <lukas@wunner.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Ulrich Teichert <krypton@ulrich-teichert.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        Philipp Rosenberger <p.rosenberger@kunbus.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
References: <b83d069cb516549b8a5420e097bb6bdd806f36fc.1640695609.git.lukas@wunner.de>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <b83d069cb516549b8a5420e097bb6bdd806f36fc.1640695609.git.lukas@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 28. 12. 21, 18:22, Lukas Wunner wrote:
> struct uart_8250_port contains mcr_mask and mcr_force members whose
> sole purpose is to work around an Alpha-specific quirk.  This code
> doesn't belong in the core where it is executed by everyone else,
> so move it to a proper ->set_mctrl callback which is used on the
> affected Alpha machine only.
> 
> The quirk was introduced in January 1995:
> https://git.kernel.org/pub/scm/linux/kernel/git/history/history.git/diff/drivers/char/serial.c?h=1.1.83
> 
> The members in struct uart_8250_port were added in 2002:
> https://git.kernel.org/history/history/c/4524aad27854
> 
> The quirk applies to non-PCI Alphas and arch/alpha/Kconfig specifies
> "select FORCE_PCI if !ALPHA_JENSEN".  So apparently the only affected
> machine is the EISA-based Jensen that Linus was working on back then:
> https://lore.kernel.org/all/CAHk-=wj1JWZ3sCrGz16nxEj7=0O+srMg6Ah3iPTDXSPKEws_SA@mail.gmail.com/
> 
> Up until now the quirk is not applied unless CONFIG_PCI is disabled.
> If users forget to do that or run a generic Alpha kernel, the serial
> ports aren't usable on Jensen.  Avoid by confining the quirk to
> CONFIG_ALPHA_JENSEN instead of !CONFIG_PCI.  On generic Alpha kernels,
> auto-detect at runtime whether the quirk needs to be applied.
> 
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: Russell King <rmk+kernel@armlinux.org.uk>
> Cc: Ulrich Teichert <krypton@ulrich-teichert.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> ---
> Changes in v2:
> * Also apply quirk when running a generic Alpha kernel on a Jensen.
> * Fix outdated reference to the quirk in sunsu.c.
> 
>   drivers/tty/serial/8250/8250.h       | 12 ++----------
>   drivers/tty/serial/8250/8250_alpha.c | 21 +++++++++++++++++++++
>   drivers/tty/serial/8250/8250_core.c  |  9 ++++-----
>   drivers/tty/serial/8250/8250_port.c  |  2 +-
>   drivers/tty/serial/8250/Makefile     |  2 ++
>   drivers/tty/serial/sunsu.c           |  3 ++-
>   include/linux/serial_8250.h          |  2 --
>   7 files changed, 32 insertions(+), 19 deletions(-)
>   create mode 100644 drivers/tty/serial/8250/8250_alpha.c
> 
> diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
> index 6473361525d1..db784ace25d8 100644
> --- a/drivers/tty/serial/8250/8250.h
> +++ b/drivers/tty/serial/8250/8250.h
> @@ -241,16 +241,8 @@ static inline int serial8250_in_MCR(struct uart_8250_port *up)
>   	return mctrl;
>   }
>   
> -#if defined(__alpha__) && !defined(CONFIG_PCI)
> -/*
> - * Digital did something really horribly wrong with the OUT1 and OUT2
> - * lines on at least some ALPHA's.  The failure mode is that if either
> - * is cleared, the machine locks up with endless interrupts.
> - */
> -#define ALPHA_KLUDGE_MCR  (UART_MCR_OUT2 | UART_MCR_OUT1)
> -#else
> -#define ALPHA_KLUDGE_MCR 0
> -#endif
> +bool alpha_jensen(void);
> +void alpha_jensen_set_mctrl(struct uart_port *port, unsigned int mctrl);
>   
>   #ifdef CONFIG_SERIAL_8250_PNP
>   int serial8250_pnp_init(void);
> diff --git a/drivers/tty/serial/8250/8250_alpha.c b/drivers/tty/serial/8250/8250_alpha.c
> new file mode 100644
> index 000000000000..58e70328aa4d
> --- /dev/null
> +++ b/drivers/tty/serial/8250/8250_alpha.c
> @@ -0,0 +1,21 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +#include <asm/machvec.h>
> +#include "8250.h"
> +
> +bool alpha_jensen(void)
> +{
> +	return !strcmp(alpha_mv.vector_name, "Jensen");
> +}
> +
> +void alpha_jensen_set_mctrl(struct uart_port *port, unsigned int mctrl)
> +{
> +	/*
> +	 * Digital did something really horribly wrong with the OUT1 and OUT2
> +	 * lines on Alpha Jensen.  The failure mode is that if either is
> +	 * cleared, the machine locks up with endless interrupts.
> +	 */
> +	mctrl |= TIOCM_OUT1 | TIOCM_OUT2;
> +
> +	serial8250_do_set_mctrl(port, mctrl);
> +}
> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
> index 1ce193daea7f..01d30f6ed8fb 100644
> --- a/drivers/tty/serial/8250/8250_core.c
> +++ b/drivers/tty/serial/8250/8250_core.c
> @@ -509,11 +509,10 @@ static void __init serial8250_isa_init_ports(void)
>   
>   		up->ops = &univ8250_driver_ops;
>   
> -		/*
> -		 * ALPHA_KLUDGE_MCR needs to be killed.
> -		 */
> -		up->mcr_mask = ~ALPHA_KLUDGE_MCR;
> -		up->mcr_force = ALPHA_KLUDGE_MCR;
> +		if (IS_ENABLED(CONFIG_ALPHA_JENSEN) ||
> +		    (IS_ENABLED(CONFIG_ALPHA_GENERIC) && alpha_jensen()))

It'd be definitely nicer, if here was only "if (alpha_jensen())". The 
rest would be done in the header or in 8250_alpha.c.

Or even create an empty __weak arch_serial8250_set_defaults() and also 
one non-empty in arch/alpha/?

thanks,
-- 
js
suse labs
