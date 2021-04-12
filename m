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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CEDDC433B4
	for <linux-serial@archiver.kernel.org>; Mon, 12 Apr 2021 23:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39B6061278
	for <linux-serial@archiver.kernel.org>; Mon, 12 Apr 2021 23:45:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239622AbhDLXpf (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 12 Apr 2021 19:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238646AbhDLXpf (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 12 Apr 2021 19:45:35 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE1D3C061574;
        Mon, 12 Apr 2021 16:45:15 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id c18so12561040iln.7;
        Mon, 12 Apr 2021 16:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C9NHfRlVevF4M8K/rHQEyVi0J60392z2vn7IG56hY1E=;
        b=HR2eqOSk+FnonmNwmQAIfbMDUnYeOBV3DWZdEKQZu/yWDhDOV4buDmV+PGPI9J1iJU
         Ls5quVrlRHuwlGZxfubXLN1MvZ1P9NTnNdZIPSI5Q1+jrcTNpvxPT0QV2FKuWZBvhmVK
         jA7//CSgMPE2dPpn+aY7EpIHHvUAXr1Z1SUWtzizy9KtD4qxQWePwaBC7wzhlIHAv69t
         jT3n6MwDEjIykpSGG6HQWg3rDPj8bcfGOGMveb/L0/tVWTTwG055rpcCEhRcKIFayf0J
         bZQjRV8iZiWKTdVpHnYzImsZwJT2SA5SRXbjyRt0R835c8x5XHS/NYxeODv4lg7LWINM
         9tLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C9NHfRlVevF4M8K/rHQEyVi0J60392z2vn7IG56hY1E=;
        b=jHpjGb4+5REORs7kR2ng2xHzKGj+5Da2hwoDwLhmzebPa5QsJTVSvrjbu98ekI9Rnj
         064iPuHO7CVu1f7m9z0P/RRz8RiyAq04EfsnjriuI0zuDlAq2y8UNFJx/5I0kBVx1oUC
         2/L0xLekQUsweg00YVxPBoWpNHsbNsAECnQrL8RbZex8TaT4vAHCiflq+w4ElKaVUfMT
         piwaqGFQw6Pnmk7Mj3MC0mlk9HUgQO+oMWaYPxdtkLH7qTZmsreOid7/Q0asn0mVIdvY
         0G3Eplis73jUQ32ZvecFdn8UF2QT77AxBaHnSRZfkQA2jxgWG7lj1ZG8EOep45DcGYfx
         j2Pw==
X-Gm-Message-State: AOAM531om4VE4OXMRbyWIKwUMFB/bmlS8qQe/tY6udPTaw1UWDhSVR9a
        vp9mz0/SCWGrk6Ql396/QsCGxCw8YguySawAhYQ=
X-Google-Smtp-Source: ABdhPJyeXPv5Sc4pLxLbt5dGfKVFKaeHr4aAjckko4WJVdRwhKS5xkaBI42lJ+w6qZ7qevywnVtfKDAGtJ6tdf4fNAE=
X-Received: by 2002:a05:6e02:672:: with SMTP id l18mr24345668ilt.271.1618271115374;
 Mon, 12 Apr 2021 16:45:15 -0700 (PDT)
MIME-Version: 1.0
References: <1618219898-4600-1-git-send-email-dillon.minfei@gmail.com>
 <YHRGPpQ03XgBMkiy@hovoldconsulting.com> <CAL9mu0JF-9hy3Z_ytpEO+hzKh0D+f-0gYaUBEA0v28EOHpC80w@mail.gmail.com>
In-Reply-To: <CAL9mu0JF-9hy3Z_ytpEO+hzKh0D+f-0gYaUBEA0v28EOHpC80w@mail.gmail.com>
From:   dillon min <dillon.minfei@gmail.com>
Date:   Tue, 13 Apr 2021 07:44:39 +0800
Message-ID: <CAL9mu0Ke97FUZ03jvdH8Lz2qRnVY82B7tAEtjbhW97sPOVkAxQ@mail.gmail.com>
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

Hi Johan, Erwan

It seems still a bit of a problem in the current version, not deadlock
but access register at the same time.

For driver , we should consider it running under smp, let's think
about it for this case:

static void stm32_usart_console_write(struct console *co, const char *s,
                                      unsigned int cnt)
{
         .....
         local_irq_save(flags);
         if (port->sysrq)
                    locked = 0;
         .....
         access register cr1, tdr, isr
         .....

         local_irq_restore(flags);
}

if port->sysrq is 1, stm32_usart_console_write() just disable local
irq response by local_irq_save(), at the time of access register cr1,
tdr, isr. an TXE interrupt raised, for other cores(I know stm32
mpu/mcu do not have multi cores, just assume it has), it still has a
chance to handle interrupt.  Then there is no lock to protect the uart
register.

changes to below, should be more safe:

.....
if (port->sysrq || oops_in_progress)
      locked = spin_trylock_irqsave(&port->lock, flags);
else
      spin_lock_irqsave(&port->lock, flags);

....

if (locked)
     spin_unlock_irqrestore(&port->lock, flags);

For current stm32 soc, it shouldn't happen. just a reminder for future.

Thanks.

Dillon

On Mon, Apr 12, 2021 at 10:04 PM dillon min <dillon.minfei@gmail.com> wrote:
>
> Hi Johan,
>
> Yes, there is no deadlock. my fault.
> I forget the local_irq_save() plus spin_lock() is spin_lock_irqsave().
>
> Thanks for your review. please ignore this patch.
>
> Best regards
>
> Dillon
>
> On Mon, Apr 12, 2021 at 9:08 PM Johan Hovold <johan@kernel.org> wrote:
> >
> > On Mon, Apr 12, 2021 at 05:31:38PM +0800, dillon.minfei@gmail.com wrote:
> > > From: dillon min <dillon.minfei@gmail.com>
> > >
> > > To avoid potential deadlock in spin_lock usage, use spin_lock_irqsave,
> > > spin_trylock_irqsave(), spin_unlock_irqrestore() in process context.
> >
> > This doesn't make much sense as console_write can be called in any
> > context. And where's the deadlock you claim to be fixing here?
> >
> > > remove unused local_irq_save/restore call.
> > >
> > > Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
> > > Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> > > Cc: Gerald Baeza <gerald.baeza@foss.st.com>
> > > Cc: Erwan Le Ray <erwan.leray@foss.st.com>
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Signed-off-by: dillon min <dillon.minfei@gmail.com>
> > > ---
> > > v2: remove unused code from stm32_usart_threaded_interrupt() according from
> > >     Greg's review.
> > >
> > >  drivers/tty/serial/stm32-usart.c | 8 +++-----
> > >  1 file changed, 3 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
> > > index b3675cf25a69..b1ba5e36e36e 100644
> > > --- a/drivers/tty/serial/stm32-usart.c
> > > +++ b/drivers/tty/serial/stm32-usart.c
> > > @@ -1354,13 +1354,12 @@ static void stm32_usart_console_write(struct console *co, const char *s,
> > >       u32 old_cr1, new_cr1;
> > >       int locked = 1;
> > >
> > > -     local_irq_save(flags);
> > >       if (port->sysrq)
> > >               locked = 0;
> > >       else if (oops_in_progress)
> > > -             locked = spin_trylock(&port->lock);
> > > +             locked = spin_trylock_irqsave(&port->lock, flags);
> > >       else
> > > -             spin_lock(&port->lock);
> > > +             spin_lock_irqsave(&port->lock, flags);
> > >
> > >       /* Save and disable interrupts, enable the transmitter */
> > >       old_cr1 = readl_relaxed(port->membase + ofs->cr1);
> > > @@ -1374,8 +1373,7 @@ static void stm32_usart_console_write(struct console *co, const char *s,
> > >       writel_relaxed(old_cr1, port->membase + ofs->cr1);
> > >
> > >       if (locked)
> > > -             spin_unlock(&port->lock);
> > > -     local_irq_restore(flags);
> > > +             spin_unlock_irqrestore(&port->lock, flags);
> > >  }
> > >
> > >  static int stm32_usart_console_setup(struct console *co, char *options)
> >
> > Johan
