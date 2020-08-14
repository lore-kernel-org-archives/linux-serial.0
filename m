Return-Path: <SRS0=xWBg=BY=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E4A2C433E1
	for <linux-serial@archiver.kernel.org>; Fri, 14 Aug 2020 14:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55336207DA
	for <linux-serial@archiver.kernel.org>; Fri, 14 Aug 2020 14:44:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oQUuPT7L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbgHNOoM (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 14 Aug 2020 10:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727870AbgHNOoM (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 14 Aug 2020 10:44:12 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC46C061385
        for <linux-serial@vger.kernel.org>; Fri, 14 Aug 2020 07:44:12 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id u15so2719336uau.10
        for <linux-serial@vger.kernel.org>; Fri, 14 Aug 2020 07:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Amv9QIiHfjtn876TD4rggI0HRc+PqFCwXxxaILu+uJE=;
        b=oQUuPT7L0xdiY8xjAMJQ87XG8vQcYVqFZwy2yTZmgKZ7gpQCNP+W4dK54ss8qP8pIG
         LvxugT9QMOVE0N2m0V42xK+3b2aC3e3yeXG+TEI77xHH5usLHfjRPW1oNhv3gzH0Pqoz
         v2mjuN3J8RHveggm0kxOgNauW1U4mKDLhObdw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Amv9QIiHfjtn876TD4rggI0HRc+PqFCwXxxaILu+uJE=;
        b=T3XAVv1Znup/bFEE87Vbz3qd/hHaWGdcGI19a60cZ9oc7fJkiWuF7njjKTwTmk/LS7
         YNXjH2rj8gIyNApKFPSe13yK5L7TuR269+v9fe+FHi+xVbabIgsMo0pfaG+irbHFDcRy
         Vt2L9etcBBa0Sdz1aGtCkvDO5HnVw7ooL/LH/h+aJXNKV8W1cxnpobTFnbmGserIwSKU
         Tcg71Cvr+XEkMEXhDd5VXB2TWFCLFE4S5T60qjNmHoS2uN9AvN0504Ydl7rb+S8xWrm7
         moDrTHJFH6d6OJC00PrwEtOZ/alkxP/IoFB7Ry5kZc+yHjZfIqsnV6/K9Rb6Cpkpg9yl
         l7Ww==
X-Gm-Message-State: AOAM5339MBxOlUHI6Ip8uVU1dNLZ+7gsMX9eLrQqoF6GAesaMzP2dnnM
        V9kefcuSy804Diebcgw5YUqcLDKCs8f3PA==
X-Google-Smtp-Source: ABdhPJxOyBTgvauYZwhBmxFc5klO6zMrS3JgVqxarcd/FroJ1PJVJdDJzzrXiWdouSnFVDLbkpVDsA==
X-Received: by 2002:a9f:3630:: with SMTP id r45mr1590726uad.31.1597416250774;
        Fri, 14 Aug 2020 07:44:10 -0700 (PDT)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com. [209.85.217.53])
        by smtp.gmail.com with ESMTPSA id y9sm1112268uay.14.2020.08.14.07.44.09
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Aug 2020 07:44:09 -0700 (PDT)
Received: by mail-vs1-f53.google.com with SMTP id n4so4750205vsl.10
        for <linux-serial@vger.kernel.org>; Fri, 14 Aug 2020 07:44:09 -0700 (PDT)
X-Received: by 2002:a67:d714:: with SMTP id p20mr1801455vsj.119.1597416248940;
 Fri, 14 Aug 2020 07:44:08 -0700 (PDT)
MIME-Version: 1.0
References: <1595333413-30052-1-git-send-email-sumit.garg@linaro.org>
 <1595333413-30052-3-git-send-email-sumit.garg@linaro.org> <CAD=FV=XUNqun3d+C_7GpgntGWRXwLSLnXKStLUz8iqZoGKu8zg@mail.gmail.com>
 <CAFA6WYNq-Z5WD=AqJn2_DEg0F6G1CYte2y5Snc964vsgCnr0Bw@mail.gmail.com>
 <CAD=FV=Vu3PGSUzargD-6e2XOw=Eh7CZaQ_+a09dr8SR1T8eE2g@mail.gmail.com> <CAFA6WYPJ_w+R15NRKK5BzZtTxKq8Gh_mGswuYbW0cYZoBYLhxw@mail.gmail.com>
In-Reply-To: <CAFA6WYPJ_w+R15NRKK5BzZtTxKq8Gh_mGswuYbW0cYZoBYLhxw@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 14 Aug 2020 07:43:57 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XA91CcyGMHKmnMG4LD7HO1d65Fuq3nDWDH_NKPOh+n3Q@mail.gmail.com>
Message-ID: <CAD=FV=XA91CcyGMHKmnMG4LD7HO1d65Fuq3nDWDH_NKPOh+n3Q@mail.gmail.com>
Subject: Re: [RFC 2/5] serial: core: Add framework to allow NMI aware serial drivers
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linux-serial@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net,
        Jiri Slaby <jslaby@suse.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Jason Wessel <jason.wessel@windriver.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

On Fri, Aug 14, 2020 at 4:17 AM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> On Thu, 13 Aug 2020 at 20:08, Doug Anderson <dianders@chromium.org> wrote:
> >
> > Hi,
> >
> > On Thu, Aug 13, 2020 at 7:19 AM Sumit Garg <sumit.garg@linaro.org> wrote:
> > >
> > > On Thu, 13 Aug 2020 at 05:29, Doug Anderson <dianders@chromium.org> wrote:
> > > >
> > > > Hi,
> > > >
> > > > On Tue, Jul 21, 2020 at 5:11 AM Sumit Garg <sumit.garg@linaro.org> wrote:
> > > > >
> > > > > Add NMI framework APIs in serial core which can be leveraged by serial
> > > > > drivers to have NMI driven serial transfers. These APIs are kept under
> > > > > CONFIG_CONSOLE_POLL as currently kgdb initializing uart in polling mode
> > > > > is the only known user to enable NMI driven serial port.
> > > > >
> > > > > The general idea is to intercept RX characters in NMI context, if those
> > > > > are specific to magic sysrq then allow corresponding handler to run in
> > > > > NMI context. Otherwise defer all other RX and TX operations to IRQ work
> > > > > queue in order to run those in normal interrupt context.
> > > > >
> > > > > Also, since magic sysrq entry APIs will need to be invoked from NMI
> > > > > context, so make those APIs NMI safe via deferring NMI unsafe work to
> > > > > IRQ work queue.
> > > > >
> > > > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > > > ---
> > > > >  drivers/tty/serial/serial_core.c | 120 ++++++++++++++++++++++++++++++++++++++-
> > > > >  include/linux/serial_core.h      |  67 ++++++++++++++++++++++
> > > > >  2 files changed, 185 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> > > > > index 57840cf..6342e90 100644
> > > > > --- a/drivers/tty/serial/serial_core.c
> > > > > +++ b/drivers/tty/serial/serial_core.c
> > > > > @@ -3181,8 +3181,14 @@ static bool uart_try_toggle_sysrq(struct uart_port *port, unsigned int ch)
> > > > >                 return true;
> > > > >         }
> > > > >
> > > > > +#ifdef CONFIG_CONSOLE_POLL
> > > > > +       if (in_nmi())
> > > > > +               irq_work_queue(&port->nmi_state.sysrq_toggle_work);
> > > > > +       else
> > > > > +               schedule_work(&sysrq_enable_work);
> > > > > +#else
> > > > >         schedule_work(&sysrq_enable_work);
> > > > > -
> > > > > +#endif
> > > >
> > > > It should be a very high bar to have #ifdefs inside functions.  I
> > > > don't think this meets it.  Instead maybe something like this
> > > > (untested and maybe slightly wrong syntax, but hopefully makes
> > > > sense?):
> > > >
> > > > Outside the function:
> > > >
> > > > #ifdef CONFIG_CONSOLE_POLL
> > > > #define queue_port_nmi_work(port, work_type)
> > > > irq_work_queue(&port->nmi_state.work_type)
> > > > #else
> > > > #define queue_port_nmi_work(port, work_type)
> > > > #endif
> > > >
> > > > ...and then:
> > > >
> > > > if (IS_ENABLED(CONFIG_CONSOLE_POLL) && in_nmi())
> > > >   queue_port_nmi_work(port, sysrq_toggle_work);
> > > > else
> > > >   schedule_work(&sysrq_enable_work);
> > > >
> > > > ---
> > > >
> > > > The whole double-hopping is really quite annoying.  I guess
> > > > schedule_work() can't be called from NMI context but can be called
> > > > from IRQ context?  So you need to first transition from NMI context to
> > > > IRQ context and then go and schedule the work?  Almost feels like we
> > > > should just fix schedule_work() to do this double-hop for you if
> > > > called from NMI context.  Seems like you could even re-use the list
> > > > pointers in the work_struct to keep the queue of people who need to be
> > > > scheduled from the next irq_work?  Worst case it seems like you could
> > > > add a schedule_work_nmi() that would do all the hoops for you.  ...but
> > > > I also know very little about NMI so maybe I'm being naive.
> > > >
> > >
> > > Thanks for this suggestion and yes indeed we could make
> > > schedule_work() NMI safe and in turn get rid of all this #ifdefs. Have
> > > a look at below changes:
> > >
> > > diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
> > > index 26de0ca..1daf1b4 100644
> > > --- a/include/linux/workqueue.h
> > > +++ b/include/linux/workqueue.h
> > > @@ -14,6 +14,7 @@
> > >  #include <linux/atomic.h>
> > >  #include <linux/cpumask.h>
> > >  #include <linux/rcupdate.h>
> > > +#include <linux/irq_work.h>
> > >
> > >  struct workqueue_struct;
> > >
> > > @@ -106,6 +107,7 @@ struct work_struct {
> > >  #ifdef CONFIG_LOCKDEP
> > >         struct lockdep_map lockdep_map;
> > >  #endif
> > > +       struct irq_work iw;
> >
> > Hrm, I was thinking you could just have a single queue per CPU then
> > you don't need to add all this extra data to every single "struct
> > work_struct".  I was thinking you could use the existing list node in
> > the "struct work_struct" to keep track of the list of things.  ...but
> > maybe my idea this isn't actually valid because the linked list might
> > be in use if we're scheduling work that's already pending / running?
> >
> > In any case, I worry that people won't be happy with the extra
> > overhead per "struct work_struct".  Can we reduce it at all?  It still
> > does feel like you could get by with a single global queue and thus
> > you wouldn't need to store the function pointer and flags with every
> > "struct work_struct", right?  So all you'd need is a single pointer
> > for the linked list?  I haven't actually tried implementing this,
> > though, so I could certainly be wrong.
>
> Let me try to elaborate here:
>
> Here we are dealing with 2 different layers of deferring work, one is
> irq_work (NMI safe) using "struct irq_work" and other is normal
> workqueue (NMI unsafe) using "struct work_struct".
>
> So when we are in NMI context, the only option is to use irq_work to
> defer work and need to pass reference to "struct irq_work". Now in
> following irq_work function:
>
> +void queue_work_nmi(struct irq_work *iw)
> +{
> +       struct work_struct *work = container_of(iw, struct work_struct, iw);
> +
> +       queue_work(system_wq, work);
> +}
> +EXPORT_SYMBOL(queue_work_nmi);
>
> we can't find a reference to "struct work_struct" until there is 1:1
> mapping with "struct irq_work". So we require a way to establish this
> mapping and having "struct irq_work" as part of "struct work_struct"
> tries to achieve that. If you have any better way to achieve this, I
> can use that instead.

So I guess the two options to avoid the overhead are:

1. Create a new struct:

struct nmi_queuable_work_struct {
  struct work_struct work;
  struct irq_work iw;
};

Then the overhead is only needed for those that want this
functionality.  Those people would need to use a variant
nmi_schedule_work() which, depending on in_nmi(), would either
schedule it directly or use the extra work.

Looks like Daniel already responded and suggested this.


2. Something that duplicates the code of at least part of irq_work and
therefore saves the need to store the function pointer.  Think of it
this way: if you made a whole copy of irq_work that was hardcoded to
just call the function you wanted then you wouldn't need to store a
function pointer.  This is, of course, excessive.  I was trying to
figure out if you could do less by only copying the NMI-safe
linked-list manipulation, but this is probably impossible and not
worth it anyway.

-Doug
