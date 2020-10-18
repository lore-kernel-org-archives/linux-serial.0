Return-Path: <SRS0=dZFG=DZ=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E24BDC433DF
	for <linux-serial@archiver.kernel.org>; Sun, 18 Oct 2020 00:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71A6D20878
	for <linux-serial@archiver.kernel.org>; Sun, 18 Oct 2020 00:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pjFVxaXU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439991AbgJRAcS (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 17 Oct 2020 20:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439988AbgJRAcS (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 17 Oct 2020 20:32:18 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD3DC061755;
        Sat, 17 Oct 2020 17:32:18 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id w11so3155265pll.8;
        Sat, 17 Oct 2020 17:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S2bgd+e0UALuCUEud5wAO2L9WRMFqabg5wBMLwiT87k=;
        b=pjFVxaXUBBMCfuuUGpTiKvOrwQ7p5OEsH4c9gfBpA/m7AgY78k0FkAr3CdLobBNJqD
         MxXy0AiEfaJl0L3EzaWFNgA9zqQ5TF+J3lWaD0M27UYvPDAjZJPv83ZEow+nrLqBHl11
         SaASWnUACNAMTfRXsI5WwO0YHV80ETMhXVwPR7AjM9tsrtnpV7lybJdab7xNExG6fW1e
         dbQ5u+yuaMHwVMoUtKv+eEOA5bGe0f/OnllXtaBktDK00+d+RUR/NzDdBNgTsWvk3Cf8
         qkYrSFMQ603eDlt05bW3P7m7wMUT1Wz+vQpFfyJwj29s/li0BT53qDKjZH2AFfTOuqhi
         9+9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S2bgd+e0UALuCUEud5wAO2L9WRMFqabg5wBMLwiT87k=;
        b=Ai6ssQcGnmcD4UL8Qk5NbE4L66UgLVVUlMWB/ZMju5yqo3grEBfnUZpiStXQ7plOlN
         Es1ruwQ4ZUhR1JzOJh6/MNJgQEMrOkoV9Y6AVnf/La9lCxOJpi9wpfPgK0FAQYkQ/H1C
         Nr9Bso4/CE2GGscfaRbRHIWo+5+KuDUyNjXbII/HdyrSIhPHMZnSGfEmhEalnrNMj4DS
         mqgUD7b7tLXgt/HUfyuq1mq0L1W2xz/yUg93HtoMi/2chGKUWxuuH4I8pBKfX9XD8tAw
         o3mtcDaZt72lNjq5oNFgelx8AP5JILGHljGEFuePpTCzpV909XQAYPviSOt7pZ2mktyi
         upHA==
X-Gm-Message-State: AOAM533NZ3eFBzaggdXdB5r5sNuR7goH0SE7NWw67f8ON+NS7AYSSowY
        WFB1X24pw9DeBAekdDxPdIvwib+t60Cr4+fr/pw=
X-Google-Smtp-Source: ABdhPJxN6AqUcUwkYK2418A4yZbLATLA5NxZ1dHaSQzR0vBsOg/qcHLwKnad60pPI9dcsmaS+V7M9ff8iYJXzbeWejs=
X-Received: by 2002:a17:90b:1b47:: with SMTP id nv7mr11003426pjb.101.1602981137603;
 Sat, 17 Oct 2020 17:32:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200923161950.6237-1-Sergey.Semin@baikalelectronics.ru> <20200923161950.6237-4-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20200923161950.6237-4-Sergey.Semin@baikalelectronics.ru>
From:   Jonathan Liu <net147@gmail.com>
Date:   Sun, 18 Oct 2020 11:32:06 +1100
Message-ID: <CANwerB2GzDiM__UzzfHRn9ENvXYVabRZq8J9ArHcDmWT9zEKNA@mail.gmail.com>
Subject: Re: [PATCH 3/3] serial: 8250_dw: Fix clk-notifier/port suspend deadlock
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        linux-serial@vger.kernel.org, Will Deacon <will@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, 23 Sep 2020 at 16:19, Serge Semin
<Sergey.Semin@baikalelectronics.ru> wrote:
>
> It has been discovered that there is a potential deadlock between
> the clock-change-notifier thread and the UART port suspending one:
>
>    CPU0 (suspend CPU/UART)   CPU1 (update clock)
>             ----                    ----
>    lock(&port->mutex);
>                              lock((work_completion)(&data->clk_work));
>                              lock(&port->mutex);
>    lock((work_completion)(&data->clk_work));
>
>    *** DEADLOCK ***
>
> The best way to fix this is to eliminate the CPU0
> port->mutex/work-completion scenario. So we suggest to register and
> unregister the clock-notifier during the DW APB UART port probe/remove
> procedures, instead of doing that at the points of the port
> startup/shutdown.
>
> Link: https://lore.kernel.org/linux-serial/f1cd5c75-9cda-6896-a4e2-42c5bfc3f5c3@redhat.com
>
> Fixes: cc816969d7b5 ("serial: 8250_dw: Fix common clocks usage race condition")
> Reported-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

Tested-by: Jonathan Liu <net147@gmail.com>

Fixes hang while closing the serial port on RK3399 that I was
experiencing often with Linux 5.9.
After applying this patch, it no longer hangs while closing the serial port.
No problems while rebooting either.

Thanks.

Regards,
Jonathan
