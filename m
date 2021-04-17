Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC525C433B4
	for <linux-serial@archiver.kernel.org>; Sat, 17 Apr 2021 13:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96405610A6
	for <linux-serial@archiver.kernel.org>; Sat, 17 Apr 2021 13:10:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbhDQNKv (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 17 Apr 2021 09:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236312AbhDQNI7 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 17 Apr 2021 09:08:59 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C80AC061760;
        Sat, 17 Apr 2021 06:08:32 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id d2so25367175ilm.10;
        Sat, 17 Apr 2021 06:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ulpGsJT6Bh0rpZeIediYCiOUyp80TRAFcGdkV8FE+eU=;
        b=iul605DudWrQIJEbm4Ba4B7WANizA4nPg0u0UlChQIQdrnPvfgy4ojszsuj3RiY5gk
         FmnvSVbAoqD9SPHXt3ZfBkd8sHJJoBk3Di1An+J/Xf9nEBSir5Ej5mkt5XwVB/2Q+9TM
         qaS33q+vNH9YQITVH2gkRVwErtgwdzBBOmbfUBFfyz4OwNUfeiJe7HB39UstffL1aO6j
         ofvlmzh798Lf8rGAaT6I+PHaHNnqwJXyg//pZvl256Mbc8GIm+pqEDekwQRGFCJIfzMf
         R9vdq2EPgEebMGy3BkrWJni+B544XLVWEPy8QhxFK9bXvrF0is/qdpeApS5P4sR/6vCD
         mqoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ulpGsJT6Bh0rpZeIediYCiOUyp80TRAFcGdkV8FE+eU=;
        b=RfUoYYzIscrwXnjKQl5IJVKEbhrwl711XBZUJbYKaFPDY8aObimZxTyQxxM3lmwQNR
         cpDtEJU6bJOxM+s21s4k4+CAWo1mCpMu8bVrsT9shW5tZY0cJOkhpz0LQw5JK6VbH8r1
         9m80OlgJYcQ7Clc7XFvOjpsIpg6k8LG4LGWAaEFHDrMdT4pr4VvjkU9aftGHiBOaT3uF
         h9o8ouS/dIFZ+VaSIHyc8Omhp7JUu8NGnrqE1XrjtvRQwvLCLWYBxT6jPpemhNGiuTwL
         sSg0p+KWrqmuFzieLaxPTaKTnMi8V2KdPHX484tpkCUiEfR8f6nw81+B+w5mLy5cECbG
         7oYw==
X-Gm-Message-State: AOAM532HyfIsE8BWxcxxD2wU1WzRsHyPgURh+X2WvQ/6DtCAsY2iIatv
        tZ3mJRPRPjlq88BdYvgKWb2dmmQj3yvrrdd/Jtc=
X-Google-Smtp-Source: ABdhPJzBCzAGi+Bz9p6VrUcood7f8uNgoXYxI8+ywBoimK1v/w3NieaJuwI5HbFjkAXeOjiqYsjWZHYsDYxHcMzBI5c=
X-Received: by 2002:a05:6e02:e0a:: with SMTP id a10mr10537215ilk.271.1618664911976;
 Sat, 17 Apr 2021 06:08:31 -0700 (PDT)
MIME-Version: 1.0
References: <1618567841-18546-1-git-send-email-dillon.minfei@gmail.com> <YHma7H3RoLyeH650@hovoldconsulting.com>
In-Reply-To: <YHma7H3RoLyeH650@hovoldconsulting.com>
From:   dillon min <dillon.minfei@gmail.com>
Date:   Sat, 17 Apr 2021 21:07:55 +0800
Message-ID: <CAL9mu0Kxny5JOGDk67ByMCVAJFOCF44rEOjbt68VxHz_2gZHrg@mail.gmail.com>
Subject: Re: [PATCH v3] serial: stm32: optimize spin lock usage
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        kernel test robot <lkp@intel.com>,
        Gerald Baeza <gerald.baeza@foss.st.com>,
        Erwan LE-RAY - foss <erwan.leray@foss.st.com>,
        linux-serial@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kbuild-all@lists.01.org, clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Johan,

On Fri, Apr 16, 2021 at 10:10 PM Johan Hovold <johan@kernel.org> wrote:
>
> On Fri, Apr 16, 2021 at 06:10:41PM +0800, dillon.minfei@gmail.com wrote:
> > From: dillon min <dillon.minfei@gmail.com>
> >
> > This patch aims to fix two potential bug:
> > - no lock to protect uart register in this case
> >
> >   stm32_usart_threaded_interrupt()
> >      spin_lock(&port->lock);
> >      ...
> >      stm32_usart_receive_chars()
> >        uart_handle_sysrq_char();
> >        sysrq_function();
> >        printk();
> >          stm32_usart_console_write();
> >            locked = 0; //since port->sysrq is not zero,
> >                          no lock to protect forward register
> >                          access.
> >
> > - if add spin_trylock_irqsave() to protect uart register for sysrq = 1 case,
> >   that might got recursive locking under UP.
> >   So, use uart_prepare_sysrq_char(), uart_unlock_and_check_sysrq()
> >   move sysrq handler position to irq/thread_d handler, just record
> >   sysrq_ch in stm32_usart_receive_chars() by uart_prepare_sysrq_char()
> >   delay the sysrq process to next interrupt handler.
> >
> >   new flow:
> >
> >   stm32_usart_threaded_interrupt()/stm32_usart_interrupt()
> >   spin_lock_irqsave(&port->lock);
> >   ...
> >   uart_unlock_and_check_sysrq();
> >      spin_unlock_irqrestore();
> >      handle_sysrq(sysrq_ch);
> >   stm32_usart_threaded_interrupt()//stm32_usart_interrupt() return
> >
> > Cc: Johan Hovold <johan@kernel.org>
> > Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
> > Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> > Cc: Gerald Baeza <gerald.baeza@foss.st.com>
> > Cc: Erwan Le Ray <erwan.leray@foss.st.com>
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: dillon min <dillon.minfei@gmail.com>
> > ---
> > v3: add uart_prepare_sysrq_char(), uart_unlock_and_check_sysrq() to move
> >     sysrq handler inside interrupt routinei to avoid recursive locking,
> >     according to Johan Hovold suggestion, thanks.
> >
> >  drivers/tty/serial/stm32-usart.c | 24 +++++++++++-------------
> >  1 file changed, 11 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
> > index b3675cf25a69..981f50ec784e 100644
> > --- a/drivers/tty/serial/stm32-usart.c
> > +++ b/drivers/tty/serial/stm32-usart.c
> > @@ -271,7 +271,7 @@ static void stm32_usart_receive_chars(struct uart_port *port, bool threaded)
> >                       }
> >               }
> >
> > -             if (uart_handle_sysrq_char(port, c))
> > +             if (uart_prepare_sysrq_char(port, c))
> >                       continue;
> >               uart_insert_char(port, sr, USART_SR_ORE, c, flag);
> >       }
> > @@ -457,9 +457,10 @@ static irqreturn_t stm32_usart_interrupt(int irq, void *ptr)
> >       struct uart_port *port = ptr;
> >       struct stm32_port *stm32_port = to_stm32_port(port);
> >       const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
> > +     unsigned long flags;
> >       u32 sr;
> >
> > -     spin_lock(&port->lock);
> > +     spin_lock_irqsave(&port->lock, flags);
> >
> >       sr = readl_relaxed(port->membase + ofs->isr);
> >
> > @@ -477,7 +478,7 @@ static irqreturn_t stm32_usart_interrupt(int irq, void *ptr)
> >       if ((sr & USART_SR_TXE) && !(stm32_port->tx_ch))
> >               stm32_usart_transmit_chars(port);
> >
> > -     spin_unlock(&port->lock);
> > +     uart_unlock_and_check_sysrq(port, flags);
> >
> >       if (stm32_port->rx_ch)
> >               return IRQ_WAKE_THREAD;
> > @@ -489,13 +490,14 @@ static irqreturn_t stm32_usart_threaded_interrupt(int irq, void *ptr)
> >  {
> >       struct uart_port *port = ptr;
> >       struct stm32_port *stm32_port = to_stm32_port(port);
> > +     unsigned long flags;
> >
> > -     spin_lock(&port->lock);
> > +     spin_lock_irqsave(&port->lock, flags);
>
> This essentially turns the threaded handler into a non-threaded one,
> which is a bad idea.
This change is only to adapt for uart_unlock_and_check_sysrq() need flags.
Found your patch has removed this parameter from
uart_unlock_and_check_sysrq(), so this changes should be removed.

>
> >       if (stm32_port->rx_ch)
> >               stm32_usart_receive_chars(port, true);
> >
> > -     spin_unlock(&port->lock);
> > +     uart_unlock_and_check_sysrq(port, flags);
> >
> >       return IRQ_HANDLED;
> >  }
>
> You also didn't base this patch on tty-next, which has a number of
> updates to this driver. Before noting that myself, I had fixed a couple
> of deadlocks in this driver which turned out to have been incidentally
> fixed by an unrelated path in -next.
Yes, my submission is based on linux-5.12. based on the component's
next branch is a good idea , to avoid conflict. thanks.
>
> I'll be posting a series that should fix up all of this.
Thanks
>
> Johan
