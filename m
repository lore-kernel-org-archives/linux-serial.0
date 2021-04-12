Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C00C433B4
	for <linux-serial@archiver.kernel.org>; Mon, 12 Apr 2021 14:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C5266128E
	for <linux-serial@archiver.kernel.org>; Mon, 12 Apr 2021 14:04:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242111AbhDLOFC (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 12 Apr 2021 10:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242107AbhDLOFC (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 12 Apr 2021 10:05:02 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17445C061574;
        Mon, 12 Apr 2021 07:04:43 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id f15so4785854iob.5;
        Mon, 12 Apr 2021 07:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2ZmPHR9GUafARGNI7sj7W1J+ANavVOrnfghsbNP17iA=;
        b=Nzm5jd0z+ScBOsDtaS1gPR5gW8RY669tautb/riCPzi6VH4NJa8tWcRNm7Mp9hmzaj
         P0vu1MfkC2trCzisIMXblpD34gl+kFDABuSf7ojWpSJvGfGmdoCTyxQZoRiWSYIm0P2O
         FxBxFDEzRPVUBSlJH65MN72t/vt6/tXcS7VuCZtIof05kCUoF896xDPjwkPeSEobPIyX
         XLtf2HRyHV7JoQ+cFZISWEfzSa7i6+Aopw+eQNV2ySjcEtIwLHdX2S2fDf9FegbBmUfl
         vQ+dU+IMcTmdIZsF5m0iu6K/7BQtV3iLIAKuuszOSq3COyezEIOztNQyfU7vSdhk+iWt
         7v2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2ZmPHR9GUafARGNI7sj7W1J+ANavVOrnfghsbNP17iA=;
        b=OX/p1Oe/MRBaoVIEpQe11AtVsguN9SxZrOepfHbSoynvXzrr6dc29C19u2VZGrKwfO
         l73EvjPpnRl/FbXJLOwvZuUl5g8EEliqg5Zw54Fsvm7TzSOsJwPprBhV1HAb45hQ+1wM
         kGl/Q05hZ5B/gBRMweNUphS18GTgaVMLjw1yaUCQX+LoywkIXFAVvlfGL611Li3OV/sl
         8GBTjw1/9/AphyK7obiuIQhBjlWvaLXwh59pF6nDIqSlsAQv2b4gv1zULxY+GQI3Q6JQ
         TedQxZcieK9GFYNDA5FEjgcg9xgubRZDUIQ9mxNlz9gUj/EKvvKVdp9V5gfAJVoPEdKt
         tSbA==
X-Gm-Message-State: AOAM531f+Tfe0HRq1EkLK8avnJyiwwBMfTr5m0cDtyaX44SrMI2irS8J
        2TjQEPpzHgIx+DitHT0YXPK+8wtwyGBinLUYGUGf/1haYARQyw==
X-Google-Smtp-Source: ABdhPJwLkUno1GOuKAFL2x5ktrw1BS4bEuoKWA8A1X/t1s5rPTHHM4olT0s016lO8j69XLXgjMXLOVPDBF3rwWcU1Ro=
X-Received: by 2002:a5d:9d13:: with SMTP id j19mr23217873ioj.110.1618236282497;
 Mon, 12 Apr 2021 07:04:42 -0700 (PDT)
MIME-Version: 1.0
References: <1618219898-4600-1-git-send-email-dillon.minfei@gmail.com> <YHRGPpQ03XgBMkiy@hovoldconsulting.com>
In-Reply-To: <YHRGPpQ03XgBMkiy@hovoldconsulting.com>
From:   dillon min <dillon.minfei@gmail.com>
Date:   Mon, 12 Apr 2021 22:04:06 +0800
Message-ID: <CAL9mu0JF-9hy3Z_ytpEO+hzKh0D+f-0gYaUBEA0v28EOHpC80w@mail.gmail.com>
Subject: Re: [PATCH v2] serial: stm32: optimize spin lock usage
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>, jirislaby@kernel.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        kernel test robot <lkp@intel.com>,
        linux-serial@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        Gerald Baeza <gerald.baeza@foss.st.com>,
        Erwan Le Ray <erwan.leray@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Johan,

Yes, there is no deadlock. my fault.
I forget the local_irq_save() plus spin_lock() is spin_lock_irqsave().

Thanks for your review. please ignore this patch.

Best regards

Dillon

On Mon, Apr 12, 2021 at 9:08 PM Johan Hovold <johan@kernel.org> wrote:
>
> On Mon, Apr 12, 2021 at 05:31:38PM +0800, dillon.minfei@gmail.com wrote:
> > From: dillon min <dillon.minfei@gmail.com>
> >
> > To avoid potential deadlock in spin_lock usage, use spin_lock_irqsave,
> > spin_trylock_irqsave(), spin_unlock_irqrestore() in process context.
>
> This doesn't make much sense as console_write can be called in any
> context. And where's the deadlock you claim to be fixing here?
>
> > remove unused local_irq_save/restore call.
> >
> > Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
> > Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> > Cc: Gerald Baeza <gerald.baeza@foss.st.com>
> > Cc: Erwan Le Ray <erwan.leray@foss.st.com>
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: dillon min <dillon.minfei@gmail.com>
> > ---
> > v2: remove unused code from stm32_usart_threaded_interrupt() according from
> >     Greg's review.
> >
> >  drivers/tty/serial/stm32-usart.c | 8 +++-----
> >  1 file changed, 3 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
> > index b3675cf25a69..b1ba5e36e36e 100644
> > --- a/drivers/tty/serial/stm32-usart.c
> > +++ b/drivers/tty/serial/stm32-usart.c
> > @@ -1354,13 +1354,12 @@ static void stm32_usart_console_write(struct console *co, const char *s,
> >       u32 old_cr1, new_cr1;
> >       int locked = 1;
> >
> > -     local_irq_save(flags);
> >       if (port->sysrq)
> >               locked = 0;
> >       else if (oops_in_progress)
> > -             locked = spin_trylock(&port->lock);
> > +             locked = spin_trylock_irqsave(&port->lock, flags);
> >       else
> > -             spin_lock(&port->lock);
> > +             spin_lock_irqsave(&port->lock, flags);
> >
> >       /* Save and disable interrupts, enable the transmitter */
> >       old_cr1 = readl_relaxed(port->membase + ofs->cr1);
> > @@ -1374,8 +1373,7 @@ static void stm32_usart_console_write(struct console *co, const char *s,
> >       writel_relaxed(old_cr1, port->membase + ofs->cr1);
> >
> >       if (locked)
> > -             spin_unlock(&port->lock);
> > -     local_irq_restore(flags);
> > +             spin_unlock_irqrestore(&port->lock, flags);
> >  }
> >
> >  static int stm32_usart_console_setup(struct console *co, char *options)
>
> Johan
