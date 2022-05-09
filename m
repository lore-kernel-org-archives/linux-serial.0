Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9013AC433EF
	for <linux-serial@archiver.kernel.org>; Mon,  9 May 2022 07:51:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233481AbiEIHzL (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 9 May 2022 03:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235841AbiEIHkm (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 9 May 2022 03:40:42 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B43177065
        for <linux-serial@vger.kernel.org>; Mon,  9 May 2022 00:36:48 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id q23so18148679wra.1
        for <linux-serial@vger.kernel.org>; Mon, 09 May 2022 00:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=6y0i+8IvUfpM15cKXcNjuJU/4mkCpkZfX4YXWqvQ1Js=;
        b=lhqV1BbqxVLsXAlcHPqFKn2QZeiHzCGSZ3xMHe5C150zWMV3iQdJFB4oLBPwcDwTgz
         fmtjWtTzoWHg3AHPShPOmwUZHOQXvEsTXw0ThO+dwUG8HFsKio0RSx2j4AKE1BITDeDz
         /v6xz61ilCoaSDQ2UNdVxgqGLQNZxZLBpfdSfpnehNLRF2t86P8WpCfbPPirLw2/H7FD
         V6ZsfLw9UHL89Smoe8CqgTK2EWy/87Jzvzm92hH6bx0b1jdgAipRJj2ZZZ2+gV5sTZXE
         /G1ADH9jSggWv1urk9UdeEH2G1JCS4SFCHLE61bexKvjxaq51Fd37yK1nj+0a609lfDy
         eUig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=6y0i+8IvUfpM15cKXcNjuJU/4mkCpkZfX4YXWqvQ1Js=;
        b=Nz+0RC2xrVNOv41sqidpFJQBI01h71lSubMhB+ur9zL/pBMhMFszBi6WivpYh6uxwk
         0jjb5EU/+VTqPpQgELmklmAECcPh43aiS3mL10qUpXk5rDsJhdcxMd8rPQIjsNwmwK+b
         9xpHQ0m2mue43iw9ROvT2eD2HEcRCajV+aBhSIeGBfKtBJbktL6/Z6N+VmFbhqBLCBqj
         e8HttTin4rMmS62qM2OMfYSnnBSM9lq1t8ToHddctGNcM/4iiiqXH4L7tepWlPC8MSAq
         qWM+ikWHPcStWKljd4r98ltDmy8FKSCWQN1/TZAbntQDOk5TLXZdhV7blAnUjU8nvRvN
         L4Nw==
X-Gm-Message-State: AOAM532LZtjC8DFzUNTC7bG6zi6vEWGVSqGWLscqzg/Q5ZBwbhryNs+1
        s4lPls9Y8SRjDeStSLjr7UGcIKmqwaBPSOJ1
X-Google-Smtp-Source: ABdhPJy2RhLQ+p1zNBH1qCsIEwkacJo/ZUmf6kHo7ueOOQy2OiKWAzP3ct7aOKYz4lFrNtdvWV9wRw==
X-Received: by 2002:a5d:4703:0:b0:20a:ce3c:7528 with SMTP id y3-20020a5d4703000000b0020ace3c7528mr12556104wrq.688.1652081799169;
        Mon, 09 May 2022 00:36:39 -0700 (PDT)
Received: from ?IPV6:2001:861:44c0:66c0:23c8:2656:fd52:f1cb? ([2001:861:44c0:66c0:23c8:2656:fd52:f1cb])
        by smtp.gmail.com with ESMTPSA id 11-20020a05600c264b00b0039444973258sm18402407wmy.0.2022.05.09.00.36.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 May 2022 00:36:38 -0700 (PDT)
Message-ID: <cf593ff3-bf57-ccd3-9a25-b28cc604d6f4@baylibre.com>
Date:   Mon, 9 May 2022 09:36:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v1] serial: meson: acquire port->lock in startup()
Content-Language: en-US
To:     John Ogness <john.ogness@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
References: <20220508103547.626355-1-john.ogness@linutronix.de>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
In-Reply-To: <20220508103547.626355-1-john.ogness@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 08/05/2022 12:35, John Ogness wrote:
> The uart_ops startup() callback is called without interrupts
> disabled and without port->lock locked, relatively late during the
> boot process (from the call path of console_on_rootfs()). If the
> device is a console, it was already previously registered and could
> be actively printing messages.
> 
> Since the startup() callback is reading/writing registers used by
> the console write() callback (AML_UART_CONTROL), its access must
> be synchronized using the port->lock. Currently it is not.
> 
> The startup() callback is the only function that explicitly enables
> interrupts. Without the synchronization, it is possible that
> interrupts become accidentally permanently disabled.
> 
> CPU0                           CPU1
> meson_serial_console_write     meson_uart_startup
> --------------------------     ------------------
> spin_lock(port->lock)
> val = readl(AML_UART_CONTROL)
> uart_console_write()
>                                 writel(INT_EN, AML_UART_CONTROL)
> writel(val, AML_UART_CONTROL)
> spin_unlock(port->lock)
> 
> Add port->lock synchronization to meson_uart_startup() to avoid
> racing with meson_serial_console_write().
> 
> Also add detailed comments to meson_uart_reset() explaining why it
> is *not* using port->lock synchronization.
> 
> Link: https://lore.kernel.org/lkml/2a82eae7-a256-f70c-fd82-4e510750906e@samsung.com
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>   drivers/tty/serial/meson_uart.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
> index 2bf1c57e0981..39021dac09cc 100644
> --- a/drivers/tty/serial/meson_uart.c
> +++ b/drivers/tty/serial/meson_uart.c
> @@ -253,6 +253,14 @@ static const char *meson_uart_type(struct uart_port *port)
>   	return (port->type == PORT_MESON) ? "meson_uart" : NULL;
>   }
>   
> +/*
> + * This function is called only from probe() using a temporary io mapping
> + * in order to perform a reset before setting up the device. Since the
> + * temporarily mapped region was successfully requested, there can be no
> + * console on this port at this time. Hence it is not necessary for this
> + * function to acquire the port->lock. (Since there is no console on this
> + * port at this time, the port->lock is not initialized yet.)
> + */
>   static void meson_uart_reset(struct uart_port *port)
>   {
>   	u32 val;
> @@ -267,9 +275,12 @@ static void meson_uart_reset(struct uart_port *port)
>   
>   static int meson_uart_startup(struct uart_port *port)
>   {
> +	unsigned long flags;
>   	u32 val;
>   	int ret = 0;
>   
> +	spin_lock_irqsave(&port->lock, flags);
> +
>   	val = readl(port->membase + AML_UART_CONTROL);
>   	val |= AML_UART_CLEAR_ERR;
>   	writel(val, port->membase + AML_UART_CONTROL);
> @@ -285,6 +296,8 @@ static int meson_uart_startup(struct uart_port *port)
>   	val = (AML_UART_RECV_IRQ(1) | AML_UART_XMIT_IRQ(port->fifosize / 2));
>   	writel(val, port->membase + AML_UART_MISC);
>   
> +	spin_unlock_irqrestore(&port->lock, flags);
> +
>   	ret = request_irq(port->irq, meson_uart_interrupt, 0,
>   			  port->name, port);
>   
> 
> base-commit: 672c0c5173427e6b3e2a9bbb7be51ceeec78093a

Thanks for fixing this, it may also fix an uart apparent lockup I encountered
several time while developing on the platform, but the target was still alive
so it matches.

So I'll add:
Fixes: ff7693d079e5 ("ARM: meson: serial: add MesonX SoC on-chip uart driver")

and

Acked-by: Neil Armstrong <narmstrong@baylibre.com>
