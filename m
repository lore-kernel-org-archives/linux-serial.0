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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE8AC433B4
	for <linux-serial@archiver.kernel.org>; Fri, 16 Apr 2021 00:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA204610CB
	for <linux-serial@archiver.kernel.org>; Fri, 16 Apr 2021 00:06:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235595AbhDPAGq (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 15 Apr 2021 20:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234874AbhDPAGp (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 15 Apr 2021 20:06:45 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A632C061574;
        Thu, 15 Apr 2021 17:06:22 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id r5so13513696ilb.2;
        Thu, 15 Apr 2021 17:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EWbin3LRnkS15U3EHv3eMCbIAS87ffxpyM/9vbY3Lzg=;
        b=D/8Cbc+BN57QKfzgwDW602fm8QeBD/eeS3yntMAWrteS6+/3g21Z5e1/9WBDXdFYTE
         vtDueXKy6V+q5igsW+YMOVVL+WSpCPlKgMZUam388Ui+W4fSqb4ES859pl91hx9Cfwqg
         vBIyve5sxN1/be1PKrW5VFFHgx7q0H8p3Egy4OePZ/Mg2j1Zhl+kTs5jMS00r/jV+WMv
         Ydqw3LCvU8ZkIN07dh5zQTffrg4OkuDx1C+QBnyNdPckJ3RXHvZ//5H4reT3dVjNs/ef
         V9bV6Xpc9tzZxHD3Acw3Xz9roOjaWnw8m0SZyFKIKQ65OCDz9AfS5GN96uF2e3jurshu
         xUUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EWbin3LRnkS15U3EHv3eMCbIAS87ffxpyM/9vbY3Lzg=;
        b=DanfMpcsV3NJS8vap9fzbMTjp2AN+s/uc7Jx3qZpQbT+C/iN+Xo9TTDnzc7pJhbpyI
         Zbdxjl0F8cMDDTfJsDyntO81JFxokihmw0Y+X4hjLELOODJEMDkjaACSdGBlp8A+U7F/
         Mu1dyKqQMzvaD0ygxj8n2tKbaA6pe3NgkMjxxRh+af7WxgSo4srAws57KxzejHGvfwtf
         mRvKBiepV9KqV4me6omqBbqwwaebcE5YX5JGVscYC2QSUfPRQt5QKjfEJskh4XDk34Nf
         wSoGxC9H9fUOITjs9g2mL62B9FkMrhfk8oNfds0iBZXDY+c8uUBonr9rpmT9VhkAprUB
         NVIA==
X-Gm-Message-State: AOAM532LCxPNPlnKTTKTY64xl3n0oFJ06euzrh6el6P04f1G3SUalBGW
        pdPqevcLF3C00kCqaNpyu1aerCX5sXY5vdxSu24=
X-Google-Smtp-Source: ABdhPJwYIVpY2PiGRL1ChoH7zY0yI9AASv+74317Ulc/lWUi9fukeFxGcFYreC0d7uiC2RamHfxQi/QgpeYsxRTi0P8=
X-Received: by 2002:a05:6e02:1baf:: with SMTP id n15mr4893724ili.148.1618531581637;
 Thu, 15 Apr 2021 17:06:21 -0700 (PDT)
MIME-Version: 1.0
References: <1618219898-4600-1-git-send-email-dillon.minfei@gmail.com>
 <YHRGPpQ03XgBMkiy@hovoldconsulting.com> <CAL9mu0JF-9hy3Z_ytpEO+hzKh0D+f-0gYaUBEA0v28EOHpC80w@mail.gmail.com>
 <CAL9mu0Ke97FUZ03jvdH8Lz2qRnVY82B7tAEtjbhW97sPOVkAxQ@mail.gmail.com> <e17fddfb-f9b8-238f-da74-a4746f33134f@foss.st.com>
In-Reply-To: <e17fddfb-f9b8-238f-da74-a4746f33134f@foss.st.com>
From:   Hua Dillon <dillonhua@gmail.com>
Date:   Fri, 16 Apr 2021 08:06:10 +0800
Message-ID: <CAPTRvHksyOR-XoLUOA+fCf33CWj--Y8jUiN99qMFcnxrQ3M_FA@mail.gmail.com>
Subject: Re: [PATCH v2] serial: stm32: optimize spin lock usage
To:     Erwan LE RAY <erwan.leray@foss.st.com>
Cc:     dillon min <dillon.minfei@gmail.com>,
        Johan Hovold <johan@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>, jirislaby@kernel.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        kernel test robot <lkp@intel.com>,
        linux-serial@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        Gerald Baeza <gerald.baeza@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Erwan,

Erwan LE RAY <erwan.leray@foss.st.com> =E4=BA=8E2021=E5=B9=B44=E6=9C=8816=
=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=881:10=E5=86=99=E9=81=93=EF=BC=
=9A
>
> Hi Dillon,
>
> STM32MP151 is mono-core, but both STM32MP153 and STM32MP157 are
> dual-core (see
> https://www.st.com/content/st_com/en/products/microcontrollers-microproce=
ssors/stm32-arm-cortex-mpus.html).
> So your point is fully relevant, thanks.

Thanks.
>
> ST already fixed the same issue in st-asc.c driver in the past (see
> ef49ffd8), because a systematic deadlock was detected with RT kernel.
>
> You proposed a first implementation in your patch, and a second one in
> the discussion. It seems that your initial proposal (ie your V2 patch)
> is the most standard one (implemented in 6 drivers). The second
> implementation is implemented by only 1 company.
>
> It looks that the solution is to avoid locking in the sysrq case and
> trylock in the oops_in_progress case (see detailed analysis in
> 677fe555cbfb1).

Thanks for the detail information. the V2 patch didn't cover this case:

    stm32_usart_threaded_interrupt()
      spin_lock(&port->lock);
      ...
      uart_handle_sysrq_char();
        sysrq_function();
          printk();
            stm32_usart_console_write();
              locked =3D spin_trylock_irqsave(&port->lock); //better
than no lock(locked =3D 0) if other uart interrupt coming at this point

Find a same solution on fsl_lpuart.c
commit abf1e0a98083fd0a1069ce68ad8c92bfb97a57db

Thanks.

Best regards
Dillon
>
> So your initial patch looks to the right proposal, but it would be safer
> if Greg could confirm it.
>
> BR, Erwan.
>
>
> On 4/13/21 1:44 AM, dillon min wrote:
> > Hi Johan, Erwan
> >
> > It seems still a bit of a problem in the current version, not deadlock
> > but access register at the same time.
> >
> > For driver , we should consider it running under smp, let's think
> > about it for this case:
> >
> > static void stm32_usart_console_write(struct console *co, const char *s=
,
> >                                        unsigned int cnt)
> > {
> >           .....
> >           local_irq_save(flags);
> >           if (port->sysrq)
> >                      locked =3D 0;
> >           .....
> >           access register cr1, tdr, isr
> >           .....
> >
> >           local_irq_restore(flags);
> > }
> >
> > if port->sysrq is 1, stm32_usart_console_write() just disable local
> > irq response by local_irq_save(), at the time of access register cr1,
> > tdr, isr. an TXE interrupt raised, for other cores(I know stm32
> > mpu/mcu do not have multi cores, just assume it has), it still has a
> > chance to handle interrupt.  Then there is no lock to protect the uart
> > register.
> >
> > changes to below, should be more safe:
> >
> > .....
> > if (port->sysrq || oops_in_progress)
> >        locked =3D spin_trylock_irqsave(&port->lock, flags);
> > else
> >        spin_lock_irqsave(&port->lock, flags);
> >
> > ....
> >
> > if (locked)
> >       spin_unlock_irqrestore(&port->lock, flags);
> >
> > For current stm32 soc, it shouldn't happen. just a reminder for future.
> >
> > Thanks.
> >
> > Dillon
> >
> > On Mon, Apr 12, 2021 at 10:04 PM dillon min <dillon.minfei@gmail.com> w=
rote:
> >>
> >> Hi Johan,
> >>
> >> Yes, there is no deadlock. my fault.
> >> I forget the local_irq_save() plus spin_lock() is spin_lock_irqsave().
> >>
> >> Thanks for your review. please ignore this patch.
> >>
> >> Best regards
> >>
> >> Dillon
> >>
> >> On Mon, Apr 12, 2021 at 9:08 PM Johan Hovold <johan@kernel.org> wrote:
> >>>
> >>> On Mon, Apr 12, 2021 at 05:31:38PM +0800, dillon.minfei@gmail.com wro=
te:
> >>>> From: dillon min <dillon.minfei@gmail.com>
> >>>>
> >>>> To avoid potential deadlock in spin_lock usage, use spin_lock_irqsav=
e,
> >>>> spin_trylock_irqsave(), spin_unlock_irqrestore() in process context.
> >>>
> >>> This doesn't make much sense as console_write can be called in any
> >>> context. And where's the deadlock you claim to be fixing here?
> >>>
> >>>> remove unused local_irq_save/restore call.
> >>>>
> >>>> Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
> >>>> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> >>>> Cc: Gerald Baeza <gerald.baeza@foss.st.com>
> >>>> Cc: Erwan Le Ray <erwan.leray@foss.st.com>
> >>>> Reported-by: kernel test robot <lkp@intel.com>
> >>>> Signed-off-by: dillon min <dillon.minfei@gmail.com>
> >>>> ---
> >>>> v2: remove unused code from stm32_usart_threaded_interrupt() accordi=
ng from
> >>>>      Greg's review.
> >>>>
> >>>>   drivers/tty/serial/stm32-usart.c | 8 +++-----
> >>>>   1 file changed, 3 insertions(+), 5 deletions(-)
> >>>>
> >>>> diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/s=
tm32-usart.c
> >>>> index b3675cf25a69..b1ba5e36e36e 100644
> >>>> --- a/drivers/tty/serial/stm32-usart.c
> >>>> +++ b/drivers/tty/serial/stm32-usart.c
> >>>> @@ -1354,13 +1354,12 @@ static void stm32_usart_console_write(struct=
 console *co, const char *s,
> >>>>        u32 old_cr1, new_cr1;
> >>>>        int locked =3D 1;
> >>>>
> >>>> -     local_irq_save(flags);
> >>>>        if (port->sysrq)
> >>>>                locked =3D 0;
> >>>>        else if (oops_in_progress)
> >>>> -             locked =3D spin_trylock(&port->lock);
> >>>> +             locked =3D spin_trylock_irqsave(&port->lock, flags);
> >>>>        else
> >>>> -             spin_lock(&port->lock);
> >>>> +             spin_lock_irqsave(&port->lock, flags);
> >>>>
> >>>>        /* Save and disable interrupts, enable the transmitter */
> >>>>        old_cr1 =3D readl_relaxed(port->membase + ofs->cr1);
> >>>> @@ -1374,8 +1373,7 @@ static void stm32_usart_console_write(struct c=
onsole *co, const char *s,
> >>>>        writel_relaxed(old_cr1, port->membase + ofs->cr1);
> >>>>
> >>>>        if (locked)
> >>>> -             spin_unlock(&port->lock);
> >>>> -     local_irq_restore(flags);
> >>>> +             spin_unlock_irqrestore(&port->lock, flags);
> >>>>   }
> >>>>
> >>>>   static int stm32_usart_console_setup(struct console *co, char *opt=
ions)
> >>>
> >>> Johan
