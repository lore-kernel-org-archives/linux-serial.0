Return-Path: <SRS0=ea2O=BO=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E85C433E0
	for <linux-serial@archiver.kernel.org>; Tue,  4 Aug 2020 10:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AEA522B40
	for <linux-serial@archiver.kernel.org>; Tue,  4 Aug 2020 10:02:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="bq1bkIKO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729468AbgHDKCd (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 4 Aug 2020 06:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728034AbgHDKCc (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 4 Aug 2020 06:02:32 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3E8C06174A
        for <linux-serial@vger.kernel.org>; Tue,  4 Aug 2020 03:02:32 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id s15so10282606pgc.8
        for <linux-serial@vger.kernel.org>; Tue, 04 Aug 2020 03:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=riXu/2/aXHb7X0RUY3XkMyj1+NWtwawTi6boW6JF9KI=;
        b=bq1bkIKOjyz6FQL2X/uLOPKt7dNSJDDTrLy29YQ7DQiGLRWcgBbxdHhvOQc6v0hICg
         ZM0nfRtBvLTuPpar+f3qvvP8qvfD4dBg406goXiv8JdBfsIri+pflXSGd4nNatMTeV/D
         b+cX2nz8ws9fx2EI/G/Ns3LCBkBjwZymX+Lui5LbO50/Zx8J78umcYGIYKZkLlzIO7ZH
         Id4LGbZYOMizZuWLDx4ilevr9OJgZIJ4KbJ3tC9EcAUv6C7lxs/pvkQOaoXBZN/o3XDB
         FkZIJeHXrWo1KhmXVyhAk0sCHUiQh3qcWZ1E/XG6ns9F/I3NvdoCmjHyhUaEfx72SUi0
         PE6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=riXu/2/aXHb7X0RUY3XkMyj1+NWtwawTi6boW6JF9KI=;
        b=LzQcn1yx4VnAQwrbGISgJjubmeM3Zssdy2DLfEjs/Zwc504ra97q3b9rhV6+f14Bv3
         X6PxIko3HhEh+YYrl3gIS7OBM/vizwUFiwY6qZb4POu/UsyIcXT6lnXUPYtbW7PL7888
         OGRY+S0CsaYGBuw9k+58uLkcdxpOzQQ1TJLhscVOn37i/jK5IwS178oDh81fDtPflif4
         99FhL6LLTY0pOYzGs/S7ggbJ8Bq2jDUZiNaFUzdaoSpTdjSf4/jAiX4YrZBF79ZHk1VA
         Mn/wPf5HNiZWzTZ8d/gFzL6AtV2mZpt9RPBiXXkiVtruv1kOXuDBf3NK9PZ6wA2Edbvt
         Ph9A==
X-Gm-Message-State: AOAM533dJHTDWwIB847AgY+pm2LOo4bL5Kt37QPtpchIrFrHrYkLQ5wu
        3qFxjWT+Y4nvwcdXgZWjXe85HHVZoQT4Bw==
X-Google-Smtp-Source: ABdhPJx1/jQocOGHWM5vmM80JmxMSf9jxCOomAzQuwLOJuR0B19iRmnNz9k7BTN+XURjo+IweTTFMw==
X-Received: by 2002:a05:6a00:81:: with SMTP id c1mr20658104pfj.189.1596535351975;
        Tue, 04 Aug 2020 03:02:31 -0700 (PDT)
Received: from [192.168.10.94] (124-171-83-152.dyn.iinet.net.au. [124.171.83.152])
        by smtp.gmail.com with ESMTPSA id u29sm10432204pfl.180.2020.08.04.03.02.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2020 03:02:31 -0700 (PDT)
Subject: Re: [RFC PATCH kernel] serial_core: Check for port state when tty is
 in error state
To:     linux-serial@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org
References: <20200728124359.980-1-aik@ozlabs.ru>
From:   Alexey Kardashevskiy <aik@ozlabs.ru>
Autocrypt: addr=aik@ozlabs.ru; keydata=
 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
Message-ID: <eb3cf1b2-8519-1722-22aa-6182ee734a27@ozlabs.ru>
Date:   Tue, 4 Aug 2020 20:02:27 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200728124359.980-1-aik@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Ping?

ps. Greg, your name came up in "git format-patch -M --stdout -1 HEAD |
./scripts/get_maintainer.pl --norolestats --l" ;)


On 28/07/2020 22:43, Alexey Kardashevskiy wrote:
> At the moment opening a serial device node (such as /dev/ttyS3)
> succeeds even if there is no actual serial device behind it.
> Reading/writing/ioctls (most) expectantly fail as the uart port is not
> initialized (the type is PORT_UNKNOWN) and the TTY_IO_ERROR error state
> bit is set fot the tty.
> 
> However syzkaller (a syscall fuzzer) found that setting line discipline
> does not have these checks all the way down to io_serial_out() in
> 8250_port.c (8250 is the default choice made by univ8250_console_init()).
> As the result of PORT_UNKNOWN, uart_port::iobase is NULL which
> a platform translates onto some address accessing which produces a crash
> like below.
> 
> This adds tty_io_error() to uart_set_ldisc() to prevent the crash.
> 
> The example of crash on PPC64/pseries:
> 
> BUG: Unable to handle kernel data access on write at 0xc00a000000000001
> Faulting instruction address: 0xc000000000c9c9cc
> cpu 0x0: Vector: 300 (Data Access) at [c00000000c6d7800]
>     pc: c000000000c9c9cc: io_serial_out+0xcc/0xf0
>     lr: c000000000c9c9b4: io_serial_out+0xb4/0xf0
>     sp: c00000000c6d7a90
>    msr: 8000000000009033
>    dar: c00a000000000001
>  dsisr: 42000000
>   current = 0xc00000000cd22500
>   paca    = 0xc0000000035c0000   irqmask: 0x03   irq_happened: 0x01
>     pid   = 1371, comm = syz-executor.0
> Linux version 5.8.0-rc7-le-guest_syzkaller_a+fstn1 (aik@fstn1-p1) (gcc (Ubunt
> untu) 2.30) #660 SMP Tue Jul 28 22:29:22 AEST 2020
> enter ? for help
> [c00000000c6d7a90] c0000000018a8cc0 _raw_spin_lock_irq+0xb0/0xe0 (unreliable)
> [c00000000c6d7ad0] c000000000c9bdc0 serial8250_do_set_ldisc+0x140/0x180
> [c00000000c6d7b10] c000000000c9bea4 serial8250_set_ldisc+0xa4/0xb0
> [c00000000c6d7b50] c000000000c91138 uart_set_ldisc+0xb8/0x160
> [c00000000c6d7b90] c000000000c5a22c tty_set_ldisc+0x23c/0x330
> [c00000000c6d7c20] c000000000c4c220 tty_ioctl+0x990/0x12f0
> [c00000000c6d7d20] c00000000056357c ksys_ioctl+0x14c/0x180
> [c00000000c6d7d70] c0000000005635f0 sys_ioctl+0x40/0x60
> [c00000000c6d7db0] c00000000003b814 system_call_exception+0x1a4/0x330
> [c00000000c6d7e20] c00000000000d368 system_call_common+0xe8/0x214
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
> 
> While looking at it, I noticed that a bunch of callbacks are prone to
> this bug and since I wanted to fix them all with minimum effort,
> I tried checking for PORT_UNKNOWN in uart_port_check() but it breaks
> device opening. Another approach could be checking for uart_port::iobase
> in 8250 (and probably uart_port::membase as well) but this will make
> the rest of the code to think the device is ok while there is no device
> at all.
> 
> What would the correct approach be and what is the expectation?
> 
> The fact that /dev/ttyS3 opened in the first place is confusing already.
> 
> ---
>  drivers/tty/serial/serial_core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index c15e208d9bec..cdece1c8e123 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -1467,6 +1467,9 @@ static void uart_set_ldisc(struct tty_struct *tty)
>  	struct uart_state *state = tty->driver_data;
>  	struct uart_port *uport;
>  
> +	if (tty_io_error(tty))
> +		return;
> +
>  	mutex_lock(&state->port.mutex);
>  	uport = uart_port_check(state);
>  	if (uport && uport->ops && uport->ops->set_ldisc)
> 

-- 
Alexey
