Return-Path: <SRS0=SE5Q=D4=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1585C56201
	for <linux-serial@archiver.kernel.org>; Wed, 21 Oct 2020 07:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F66222249
	for <linux-serial@archiver.kernel.org>; Wed, 21 Oct 2020 07:54:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502090AbgJUHys (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 21 Oct 2020 03:54:48 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:57879 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502072AbgJUHyr (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 21 Oct 2020 03:54:47 -0400
Received: from [192.168.100.1] ([82.252.139.38]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MbBQU-1jtbGx3EMK-00bXUA; Wed, 21 Oct 2020 09:54:24 +0200
Subject: Re: [PATCH] serial: pmac_zilog: don't init if zilog is not available
To:     Finn Thain <fthain@telegraphics.com.au>,
        Brad Boyer <brad@allandria.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
        Joshua Thompson <funaho@jurai.org>,
        linux-serial@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-m68k@lists.linux-m68k.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>
References: <20201020162303.1730562-1-laurent@vivier.eu>
 <20201020162844.GA865546@kroah.com>
 <468bbbef-4745-3b16-b6f4-30b46ebcdc33@vivier.eu>
 <20201020173745.GA882703@kroah.com>
 <387fd2aa-b181-c41f-0581-0a7e79a44e41@vivier.eu>
 <20201020183246.GA912431@kroah.com>
 <b52e7fde-8874-3c53-ca13-7709656b69fb@vivier.eu>
 <20201020224446.GA15066@allandria.com>
 <alpine.LNX.2.23.453.2010211038390.6@nippy.intranet>
From:   Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <311d17ed-75fa-a7fe-6c70-177a6eec4519@vivier.eu>
Date:   Wed, 21 Oct 2020 09:54:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <alpine.LNX.2.23.453.2010211038390.6@nippy.intranet>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:sK3pQorlW5Y3AulDsX1Ord5gsV8qBNs3mw3a/mAQyWRqBslpDKS
 TTXNZXWvucPxkxxVcDklBC4WLo3/+/MYtao9kL4q7Mn99ujykcYOnDb8mVydvyuSSpDoXta
 rNs4BrqVqKSI/BA1XBd5Tt9ls3WBGR2Mb71leVy2+Y4kmvk74Y/hV5ccAB5F6EJhCYd2COp
 fpXLxRUzIxt1TIxtiWXPw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hk9fdEHY5Iw=:N+J0UeWG/JRWPOOe+Ar6iX
 IOAOBw4+tU7HyPcQGuhzJmWerHmf1OiBpF+NaOKjuVT4HTrDa0eOBoVhUeQGo+McBVbVrKCy2
 3dIXZXQZRQyBdnZPasA/PjLCGeSFn/OvH98/5NG2bz4esiSvDBf7jnjZgZkb8xL8g1qkiJRVg
 MbBrYrzpJPP1o7hEoAPmlK/xlkKwF6TgPCU6PXHlVJ2odK/ZT1C7k7bSUuYUqTV+6WiyuHqfW
 15oXvAPb6K73yOZAObjN6r0sWsd4oE4ON2LJCQzBmztSKuw/+yZMudmUkUJAup1VoFFtV2zuD
 lqj1s1b52mc+4eEjgQyZA4iYD75AD68GPT0KWBBHbO6Jjca5j69yBDMdc3yiHy8p3MQW5EhJM
 tgHX5q4wGz3kdF7mJU3lJ3hUHprSyR6/xUxg4QM5rUUEX9aUU5bD56rufGRaJ+iDk7bWNYXfZ
 7TzwzWXnwA==
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Le 21/10/2020 à 01:43, Finn Thain a écrit :
> On Tue, 20 Oct 2020, Brad Boyer wrote:
> 
>>
>> Wouldn't it be better to rearrange this code to only run if the devices 
>> are present? This is a macio driver on pmac and a platform driver on 
>> mac, so shouldn't it be possible to only run this code when the 
>> appropriate entries are present in the right data structures?
>>
>> I didn't look at a lot of the other serial drivers, but some other mac 
>> drivers have recently been updated to no longer have MACH_IS_MAC checks 
>> due to being converted to platform drivers.
>>
> 
> Actually, it's not simply a platform driver or macio driver. I think the 
> console is supposed to be registered before the normal bus matching takes 
> place. Hence this comment in pmac_zilog.c,
> 
>         /* 
>          * First, we need to do a direct OF-based probe pass. We
>          * do that because we want serial console up before the
>          * macio stuffs calls us back, and since that makes it
>          * easier to pass the proper number of channels to
>          * uart_register_driver()
>          */
> 
> Laurent, can we avoid the irq == 0 warning splat like this?
> 
> diff --git a/drivers/tty/serial/pmac_zilog.c b/drivers/tty/serial/pmac_zilog.c
> index 96e7aa479961..7db600cd8cc7 100644
> --- a/drivers/tty/serial/pmac_zilog.c
> +++ b/drivers/tty/serial/pmac_zilog.c
> @@ -1701,8 +1701,10 @@ static int __init pmz_init_port(struct uart_pmac_port *uap)
>  	int irq;
>  
>  	r_ports = platform_get_resource(uap->pdev, IORESOURCE_MEM, 0);
> +	if (!r_ports)
> +		return -ENODEV;
>  	irq = platform_get_irq(uap->pdev, 0);
> -	if (!r_ports || irq <= 0)
> +	if (irq <= 0)
>  		return -ENODEV;
>  
>  	uap->port.mapbase  = r_ports->start;
> 

No, this doesn't fix the problem.

The message is still:

[    0.000000] ------------[ cut here ]------------
[    0.000000] WARNING: CPU: 0 PID: 0 at drivers/base/platform.c:224
platform_get_irq_optional+0x7a/0x80
[    0.000000] 0 is an invalid IRQ number
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 5.9.0+ #324
[    0.000000] Stack from 004e7f24:
                       004e7f24 0046c1d3 0046c1d3 0002cb26 004985fb
000000e0 00000009 00000000
                       0002cb6a 004985fb 000000e0 002a5b86 00000009
00000000 004e7f70 00553cc4
                       00000000 00000000 00000000 004985df 004e7f90
004e7ff8 002a5b86 004985fb
                       000000e0 00000009 004985df 004eb290 002a5bd2
004eb290 00000000 00553cc4
                       0057bb66 00553cc4 00573d6e 004eb290 00000000
00573d38 0021c42c 00573e06
                       00553cc4 0046df15 00583a7c 00573e58 00564b74
0005299a 0055ce34 00000000
[    0.000000] Call Trace: [<0002cb26>] __warn+0xb2/0xb4
[    0.000000]  [<0002cb6a>] warn_slowpath_fmt+0x42/0x64
[    0.000000]  [<002a5b86>] platform_get_irq_optional+0x7a/0x80
[    0.000000]  [<002a5b86>] platform_get_irq_optional+0x7a/0x80
[    0.000000]  [<002a5bd2>] platform_get_irq+0x16/0x42
[    0.000000]  [<00573d6e>] pmz_init_port+0x36/0x9e
[    0.000000]  [<00573d38>] pmz_init_port+0x0/0x9e
[    0.000000]  [<0021c42c>] strlen+0x0/0x14
[    0.000000]  [<00573e06>] pmz_probe+0x30/0x7e
[    0.000000]  [<00573e58>] pmz_console_init+0x4/0x22
[    0.000000]  [<00564b74>] console_init+0x1e/0x20
[    0.000000]  [<0005299a>] printk+0x0/0x18
[    0.000000]  [<0055ce34>] start_kernel+0x332/0x4c4
[    0.000000]  [<0055b8c6>] _sinittext+0x8c6/0x1268
[    0.000000] ---[ end trace 32d780b8cd50b829 ]---

Thanks,
Laurent
