Return-Path: <SRS0=iWX9=B3=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D149EC433E3
	for <linux-serial@archiver.kernel.org>; Mon, 17 Aug 2020 12:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90DE82075B
	for <linux-serial@archiver.kernel.org>; Mon, 17 Aug 2020 12:29:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JrkF1v5G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbgHQM3X (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 17 Aug 2020 08:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728038AbgHQM3R (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 17 Aug 2020 08:29:17 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17EAC061342
        for <linux-serial@vger.kernel.org>; Mon, 17 Aug 2020 05:29:16 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id y2so8238915ljc.1
        for <linux-serial@vger.kernel.org>; Mon, 17 Aug 2020 05:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kaS9QGr/CoVL2sSV275Tul/9GvZ4IxXLL+meMexP+eg=;
        b=JrkF1v5GRUEC2PkvtUTHwlReaCu7YQgc+YTXcxfj7rn/lcJVaYSnogIyX9TJnW3uwo
         88NNquO2upSOLuEi0fFBrL97SBHRI1GrNf9LEl0wUBsdO8Odnx5RmSKFb4nWHwCcjCTA
         kUpfEMpcTJj2GmlgUkuf/ExfqiL6+S6xWQXYwdO3X91RDW5IXmH6I5UBZ8HlYrMstETJ
         4Agk10IcnHSys3q2qkNUGniPWa9wK+/FcvK/SlhSrXuoL3136FFoZ4fAnRzdzCo7X9B9
         lbkFh4kCkKgk0RHiKm5wSkcnmNcXQp9t9oaSKpTWpO5x5jk+dFTI2B4hRRHF6uTA2E1j
         HKUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kaS9QGr/CoVL2sSV275Tul/9GvZ4IxXLL+meMexP+eg=;
        b=IjKN+UDDOo3X+NVEeW49QZSNCMWtsJp1FopE72l0fiKWFHbsRacarZmAaXg5kCKArn
         cfHnHcJ2brVVB1icKtTzLM42iG5hOERoaMZsIIPvbQqbKga5TPsjKvnZ9TaxTSMdQjLP
         lLrOUSnqWJAC+K+99TVYJnqWtZ88F/61K822dGcuwo4sy1tHVaQ7h0ktFwAFNY10vPVw
         rtIGUc17rtPBFbH6z06wGmwxMsvO02oBp/r9fPXpVwhOipru+j816Gw3ngjEuvdoSGvv
         RF9tLV7jUSN7pe5NQRrEYB5nPdOzbrMQSYwkFhb0jo7BFbBobItSFoHZNVMbd+H0o/6U
         ayxA==
X-Gm-Message-State: AOAM533d1p+PIxUQTMuLASyxjynVXq4eKrUcAep6uNGajBV3OqlhQXnW
        wTIXkRsMe5cJ1z5mvqwIFPlJ/IONLlV5VjY0GMqhxQ==
X-Google-Smtp-Source: ABdhPJxycajF68k7LfbWmGKMEmchQ5vYrDZoKIW7NZDRjvDhKjzMA+vUCrbjICqJuG9WgO/B1/FzG0EDVSoe2KCqce8=
X-Received: by 2002:a2e:b6cc:: with SMTP id m12mr6559788ljo.256.1597667354932;
 Mon, 17 Aug 2020 05:29:14 -0700 (PDT)
MIME-Version: 1.0
References: <1595333413-30052-1-git-send-email-sumit.garg@linaro.org>
 <1595333413-30052-3-git-send-email-sumit.garg@linaro.org> <CAD=FV=XUNqun3d+C_7GpgntGWRXwLSLnXKStLUz8iqZoGKu8zg@mail.gmail.com>
 <CAFA6WYNq-Z5WD=AqJn2_DEg0F6G1CYte2y5Snc964vsgCnr0Bw@mail.gmail.com>
 <CAD=FV=Vu3PGSUzargD-6e2XOw=Eh7CZaQ_+a09dr8SR1T8eE2g@mail.gmail.com>
 <CAFA6WYPJ_w+R15NRKK5BzZtTxKq8Gh_mGswuYbW0cYZoBYLhxw@mail.gmail.com> <CAD=FV=XA91CcyGMHKmnMG4LD7HO1d65Fuq3nDWDH_NKPOh+n3Q@mail.gmail.com>
In-Reply-To: <CAD=FV=XA91CcyGMHKmnMG4LD7HO1d65Fuq3nDWDH_NKPOh+n3Q@mail.gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 17 Aug 2020 17:59:03 +0530
Message-ID: <CAFA6WYMAza8bJtow3_+8PEeXgHFym-6CHt73ePi5tMnW-jr26g@mail.gmail.com>
Subject: Re: [RFC 2/5] serial: core: Add framework to allow NMI aware serial drivers
To:     Doug Anderson <dianders@chromium.org>
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

On Fri, 14 Aug 2020 at 20:14, Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Fri, Aug 14, 2020 at 4:17 AM Sumit Garg <sumit.garg@linaro.org> wrote:
> >
> > On Thu, 13 Aug 2020 at 20:08, Doug Anderson <dianders@chromium.org> wrote:
> > >
> > > Hi,
> > >
> > > On Thu, Aug 13, 2020 at 7:19 AM Sumit Garg <sumit.garg@linaro.org> wrote:
> > > >
> > > > On Thu, 13 Aug 2020 at 05:29, Doug Anderson <dianders@chromium.org> wrote:
> > > > >
> > > > > Hi,
> > > > >
> > > > > On Tue, Jul 21, 2020 at 5:11 AM Sumit Garg <sumit.garg@linaro.org> wrote:
> > > > > >
> > > > > > Add NMI framework APIs in serial core which can be leveraged by serial
> > > > > > drivers to have NMI driven serial transfers. These APIs are kept under
> > > > > > CONFIG_CONSOLE_POLL as currently kgdb initializing uart in polling mode
> > > > > > is the only known user to enable NMI driven serial port.
> > > > > >
> > > > > > The general idea is to intercept RX characters in NMI context, if those
> > > > > > are specific to magic sysrq then allow corresponding handler to run in
> > > > > > NMI context. Otherwise defer all other RX and TX operations to IRQ work
> > > > > > queue in order to run those in normal interrupt context.
> > > > > >
> > > > > > Also, since magic sysrq entry APIs will need to be invoked from NMI
> > > > > > context, so make those APIs NMI safe via deferring NMI unsafe work to
> > > > > > IRQ work queue.
> > > > > >
> > > > > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > > > > ---
> > > > > >  drivers/tty/serial/serial_core.c | 120 ++++++++++++++++++++++++++++++++++++++-
> > > > > >  include/linux/serial_core.h      |  67 ++++++++++++++++++++++
> > > > > >  2 files changed, 185 insertions(+), 2 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> > > > > > index 57840cf..6342e90 100644
> > > > > > --- a/drivers/tty/serial/serial_core.c
> > > > > > +++ b/drivers/tty/serial/serial_core.c
> > > > > > @@ -3181,8 +3181,14 @@ static bool uart_try_toggle_sysrq(struct uart_port *port, unsigned int ch)
> > > > > >                 return true;
> > > > > >         }
> > > > > >
> > > > > > +#ifdef CONFIG_CONSOLE_POLL
> > > > > > +       if (in_nmi())
> > > > > > +               irq_work_queue(&port->nmi_state.sysrq_toggle_work);
> > > > > > +       else
> > > > > > +               schedule_work(&sysrq_enable_work);
> > > > > > +#else
> > > > > >         schedule_work(&sysrq_enable_work);
> > > > > > -
> > > > > > +#endif
> > > > >
> > > > > It should be a very high bar to have #ifdefs inside functions.  I
> > > > > don't think this meets it.  Instead maybe something like this
> > > > > (untested and maybe slightly wrong syntax, but hopefully makes
> > > > > sense?):
> > > > >
> > > > > Outside the function:
> > > > >
> > > > > #ifdef CONFIG_CONSOLE_POLL
> > > > > #define queue_port_nmi_work(port, work_type)
> > > > > irq_work_queue(&port->nmi_state.work_type)
> > > > > #else
> > > > > #define queue_port_nmi_work(port, work_type)
> > > > > #endif
> > > > >
> > > > > ...and then:
> > > > >
> > > > > if (IS_ENABLED(CONFIG_CONSOLE_POLL) && in_nmi())
> > > > >   queue_port_nmi_work(port, sysrq_toggle_work);
> > > > > else
> > > > >   schedule_work(&sysrq_enable_work);
> > > > >
> > > > > ---
> > > > >
> > > > > The whole double-hopping is really quite annoying.  I guess
> > > > > schedule_work() can't be called from NMI context but can be called
> > > > > from IRQ context?  So you need to first transition from NMI context to
> > > > > IRQ context and then go and schedule the work?  Almost feels like we
> > > > > should just fix schedule_work() to do this double-hop for you if
> > > > > called from NMI context.  Seems like you could even re-use the list
> > > > > pointers in the work_struct to keep the queue of people who need to be
> > > > > scheduled from the next irq_work?  Worst case it seems like you could
> > > > > add a schedule_work_nmi() that would do all the hoops for you.  ...but
> > > > > I also know very little about NMI so maybe I'm being naive.
> > > > >
> > > >
> > > > Thanks for this suggestion and yes indeed we could make
> > > > schedule_work() NMI safe and in turn get rid of all this #ifdefs. Have
> > > > a look at below changes:
> > > >
> > > > diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
> > > > index 26de0ca..1daf1b4 100644
> > > > --- a/include/linux/workqueue.h
> > > > +++ b/include/linux/workqueue.h
> > > > @@ -14,6 +14,7 @@
> > > >  #include <linux/atomic.h>
> > > >  #include <linux/cpumask.h>
> > > >  #include <linux/rcupdate.h>
> > > > +#include <linux/irq_work.h>
> > > >
> > > >  struct workqueue_struct;
> > > >
> > > > @@ -106,6 +107,7 @@ struct work_struct {
> > > >  #ifdef CONFIG_LOCKDEP
> > > >         struct lockdep_map lockdep_map;
> > > >  #endif
> > > > +       struct irq_work iw;
> > >
> > > Hrm, I was thinking you could just have a single queue per CPU then
> > > you don't need to add all this extra data to every single "struct
> > > work_struct".  I was thinking you could use the existing list node in
> > > the "struct work_struct" to keep track of the list of things.  ...but
> > > maybe my idea this isn't actually valid because the linked list might
> > > be in use if we're scheduling work that's already pending / running?
> > >
> > > In any case, I worry that people won't be happy with the extra
> > > overhead per "struct work_struct".  Can we reduce it at all?  It still
> > > does feel like you could get by with a single global queue and thus
> > > you wouldn't need to store the function pointer and flags with every
> > > "struct work_struct", right?  So all you'd need is a single pointer
> > > for the linked list?  I haven't actually tried implementing this,
> > > though, so I could certainly be wrong.
> >
> > Let me try to elaborate here:
> >
> > Here we are dealing with 2 different layers of deferring work, one is
> > irq_work (NMI safe) using "struct irq_work" and other is normal
> > workqueue (NMI unsafe) using "struct work_struct".
> >
> > So when we are in NMI context, the only option is to use irq_work to
> > defer work and need to pass reference to "struct irq_work". Now in
> > following irq_work function:
> >
> > +void queue_work_nmi(struct irq_work *iw)
> > +{
> > +       struct work_struct *work = container_of(iw, struct work_struct, iw);
> > +
> > +       queue_work(system_wq, work);
> > +}
> > +EXPORT_SYMBOL(queue_work_nmi);
> >
> > we can't find a reference to "struct work_struct" until there is 1:1
> > mapping with "struct irq_work". So we require a way to establish this
> > mapping and having "struct irq_work" as part of "struct work_struct"
> > tries to achieve that. If you have any better way to achieve this, I
> > can use that instead.
>
> So I guess the two options to avoid the overhead are:
>
> 1. Create a new struct:
>
> struct nmi_queuable_work_struct {
>   struct work_struct work;
>   struct irq_work iw;
> };
>
> Then the overhead is only needed for those that want this
> functionality.  Those people would need to use a variant
> nmi_schedule_work() which, depending on in_nmi(), would either
> schedule it directly or use the extra work.
>
> Looks like Daniel already responded and suggested this.
>
>
> 2. Something that duplicates the code of at least part of irq_work and
> therefore saves the need to store the function pointer.  Think of it
> this way: if you made a whole copy of irq_work that was hardcoded to
> just call the function you wanted then you wouldn't need to store a
> function pointer.  This is, of course, excessive.  I was trying to
> figure out if you could do less by only copying the NMI-safe
> linked-list manipulation, but this is probably impossible and not
> worth it anyway.
>

Thanks for your suggestions. I came up with an approach without any
overhead (see my reply to Daniel).

-Sumit

> -Doug
