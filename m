Return-Path: <SRS0=hLv5=BX=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8AD0C433E1
	for <linux-serial@archiver.kernel.org>; Thu, 13 Aug 2020 14:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC41A2078D
	for <linux-serial@archiver.kernel.org>; Thu, 13 Aug 2020 14:38:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UiI7Xafr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbgHMOiO (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 13 Aug 2020 10:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbgHMOiL (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 13 Aug 2020 10:38:11 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F1AAC061757
        for <linux-serial@vger.kernel.org>; Thu, 13 Aug 2020 07:38:11 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id o184so3032197vsc.0
        for <linux-serial@vger.kernel.org>; Thu, 13 Aug 2020 07:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y6e/nI0YX/Z0FZJ6qvQEpeo95aT0kvFqQguxS7NKbAA=;
        b=UiI7Xafr19bNrPmU8TEItSoYfoynx+8eUIqrC4pf6rjUTAZP5Rv3EWFear/qC7Z4ho
         0J+zH1Z0Fqc5BkcXT10PVJwDigdH4q0eUsLvyNuNac3xaDKHKZ6CdkKXHBBgYz2loPGu
         9H5gz+nvWgSfpQtiOSxHJM67YIMn+Sm9lb9ak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y6e/nI0YX/Z0FZJ6qvQEpeo95aT0kvFqQguxS7NKbAA=;
        b=VvGkpTfc3I56uhXsvsLmLPwi6h4Tn+pAhJ2+bCybEMi0nxj7k7FOny3TZ4U0JnEbMg
         58zBBnQPRG5VH0zfAV8+uVVjP1BiicxnjK6GUfW6We6lf8yHxITWWFN6gmkyvfqj0LwM
         BUHOVVDMiXJGLCw6AwfS5hgu0qth1ma/QpO7gIDDScP9JuRSY2Kif8ohfbwv6cBj24TY
         JECsY6lz6AQy1TlG94qkCOcf/qKE+9Pk9dvrOTMWweG30s6b2h9VtQ0ZWmtzsnfgULeO
         J7MaXYQiyMtE7zqQJ2YRFyhNZLPHGK+8rEwjBEKxntEFhIbtM2l698w44W24uJVLZTI7
         PxBw==
X-Gm-Message-State: AOAM532/b5g/0l/g9n25EyeKF74tJkLvpQOFyANVneclCr9VjmqcHCiW
        EML0sJaCVJbM5Q6j6/7sZC3ua6rkfz0=
X-Google-Smtp-Source: ABdhPJyQV2VmcxN8EnwYFWWdbXevgijDFhySDUfxyz46KoSyXDnfNzFk8kOOA6Z1U7uKb78TdcdmCw==
X-Received: by 2002:a67:77d4:: with SMTP id s203mr3622468vsc.162.1597329490223;
        Thu, 13 Aug 2020 07:38:10 -0700 (PDT)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com. [209.85.222.47])
        by smtp.gmail.com with ESMTPSA id m139sm826308vke.28.2020.08.13.07.38.09
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2020 07:38:09 -0700 (PDT)
Received: by mail-ua1-f47.google.com with SMTP id k18so587875uao.11
        for <linux-serial@vger.kernel.org>; Thu, 13 Aug 2020 07:38:09 -0700 (PDT)
X-Received: by 2002:ab0:37d3:: with SMTP id e19mr3486210uav.64.1597329488557;
 Thu, 13 Aug 2020 07:38:08 -0700 (PDT)
MIME-Version: 1.0
References: <1595333413-30052-1-git-send-email-sumit.garg@linaro.org>
 <1595333413-30052-3-git-send-email-sumit.garg@linaro.org> <CAD=FV=XUNqun3d+C_7GpgntGWRXwLSLnXKStLUz8iqZoGKu8zg@mail.gmail.com>
 <CAFA6WYNq-Z5WD=AqJn2_DEg0F6G1CYte2y5Snc964vsgCnr0Bw@mail.gmail.com>
In-Reply-To: <CAFA6WYNq-Z5WD=AqJn2_DEg0F6G1CYte2y5Snc964vsgCnr0Bw@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 13 Aug 2020 07:37:57 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vu3PGSUzargD-6e2XOw=Eh7CZaQ_+a09dr8SR1T8eE2g@mail.gmail.com>
Message-ID: <CAD=FV=Vu3PGSUzargD-6e2XOw=Eh7CZaQ_+a09dr8SR1T8eE2g@mail.gmail.com>
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

On Thu, Aug 13, 2020 at 7:19 AM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> On Thu, 13 Aug 2020 at 05:29, Doug Anderson <dianders@chromium.org> wrote:
> >
> > Hi,
> >
> > On Tue, Jul 21, 2020 at 5:11 AM Sumit Garg <sumit.garg@linaro.org> wrote:
> > >
> > > Add NMI framework APIs in serial core which can be leveraged by serial
> > > drivers to have NMI driven serial transfers. These APIs are kept under
> > > CONFIG_CONSOLE_POLL as currently kgdb initializing uart in polling mode
> > > is the only known user to enable NMI driven serial port.
> > >
> > > The general idea is to intercept RX characters in NMI context, if those
> > > are specific to magic sysrq then allow corresponding handler to run in
> > > NMI context. Otherwise defer all other RX and TX operations to IRQ work
> > > queue in order to run those in normal interrupt context.
> > >
> > > Also, since magic sysrq entry APIs will need to be invoked from NMI
> > > context, so make those APIs NMI safe via deferring NMI unsafe work to
> > > IRQ work queue.
> > >
> > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > ---
> > >  drivers/tty/serial/serial_core.c | 120 ++++++++++++++++++++++++++++++++++++++-
> > >  include/linux/serial_core.h      |  67 ++++++++++++++++++++++
> > >  2 files changed, 185 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> > > index 57840cf..6342e90 100644
> > > --- a/drivers/tty/serial/serial_core.c
> > > +++ b/drivers/tty/serial/serial_core.c
> > > @@ -3181,8 +3181,14 @@ static bool uart_try_toggle_sysrq(struct uart_port *port, unsigned int ch)
> > >                 return true;
> > >         }
> > >
> > > +#ifdef CONFIG_CONSOLE_POLL
> > > +       if (in_nmi())
> > > +               irq_work_queue(&port->nmi_state.sysrq_toggle_work);
> > > +       else
> > > +               schedule_work(&sysrq_enable_work);
> > > +#else
> > >         schedule_work(&sysrq_enable_work);
> > > -
> > > +#endif
> >
> > It should be a very high bar to have #ifdefs inside functions.  I
> > don't think this meets it.  Instead maybe something like this
> > (untested and maybe slightly wrong syntax, but hopefully makes
> > sense?):
> >
> > Outside the function:
> >
> > #ifdef CONFIG_CONSOLE_POLL
> > #define queue_port_nmi_work(port, work_type)
> > irq_work_queue(&port->nmi_state.work_type)
> > #else
> > #define queue_port_nmi_work(port, work_type)
> > #endif
> >
> > ...and then:
> >
> > if (IS_ENABLED(CONFIG_CONSOLE_POLL) && in_nmi())
> >   queue_port_nmi_work(port, sysrq_toggle_work);
> > else
> >   schedule_work(&sysrq_enable_work);
> >
> > ---
> >
> > The whole double-hopping is really quite annoying.  I guess
> > schedule_work() can't be called from NMI context but can be called
> > from IRQ context?  So you need to first transition from NMI context to
> > IRQ context and then go and schedule the work?  Almost feels like we
> > should just fix schedule_work() to do this double-hop for you if
> > called from NMI context.  Seems like you could even re-use the list
> > pointers in the work_struct to keep the queue of people who need to be
> > scheduled from the next irq_work?  Worst case it seems like you could
> > add a schedule_work_nmi() that would do all the hoops for you.  ...but
> > I also know very little about NMI so maybe I'm being naive.
> >
>
> Thanks for this suggestion and yes indeed we could make
> schedule_work() NMI safe and in turn get rid of all this #ifdefs. Have
> a look at below changes:
>
> diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
> index 26de0ca..1daf1b4 100644
> --- a/include/linux/workqueue.h
> +++ b/include/linux/workqueue.h
> @@ -14,6 +14,7 @@
>  #include <linux/atomic.h>
>  #include <linux/cpumask.h>
>  #include <linux/rcupdate.h>
> +#include <linux/irq_work.h>
>
>  struct workqueue_struct;
>
> @@ -106,6 +107,7 @@ struct work_struct {
>  #ifdef CONFIG_LOCKDEP
>         struct lockdep_map lockdep_map;
>  #endif
> +       struct irq_work iw;

Hrm, I was thinking you could just have a single queue per CPU then
you don't need to add all this extra data to every single "struct
work_struct".  I was thinking you could use the existing list node in
the "struct work_struct" to keep track of the list of things.  ...but
maybe my idea this isn't actually valid because the linked list might
be in use if we're scheduling work that's already pending / running?

In any case, I worry that people won't be happy with the extra
overhead per "struct work_struct".  Can we reduce it at all?  It still
does feel like you could get by with a single global queue and thus
you wouldn't need to store the function pointer and flags with every
"struct work_struct", right?  So all you'd need is a single pointer
for the linked list?  I haven't actually tried implementing this,
though, so I could certainly be wrong.


-Doug
