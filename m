Return-Path: <SRS0=xWBg=BY=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 718DEC433E1
	for <linux-serial@archiver.kernel.org>; Fri, 14 Aug 2020 14:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4726020866
	for <linux-serial@archiver.kernel.org>; Fri, 14 Aug 2020 14:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CvF2QHFp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728455AbgHNONa (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 14 Aug 2020 10:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbgHNON2 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 14 Aug 2020 10:13:28 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E189C061384
        for <linux-serial@vger.kernel.org>; Fri, 14 Aug 2020 07:13:28 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id 88so8505932wrh.3
        for <linux-serial@vger.kernel.org>; Fri, 14 Aug 2020 07:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6PZ8SEi14GOn4eemrIumaJvvtU1n1XVq4pJkW36yXBk=;
        b=CvF2QHFp4dtQ8JSyPXKF4iGM14sojy/LnkFyiEUZklVNL1xzcPzwFs2iqNHaNDjS86
         ZpST3rYJBrzHscIRaafOFU2hMTn9TMdku2PNOzgX9/q5xsYpX1GoMn9lwxL8qN/rdGLK
         JipZDXfuXtLOuDg9qNUBQ+tU0MBOUf7/3v5XpgmhEn4xB9ZPa4Qphj/1kczmJxscKFZu
         aRA9x5Xp8Imp0pgZE2KIyCC6/O4/t0m5dTwZCEAPDuIst0Rlkt7m4hC0UPiwMVWiSVus
         XZC5ra2JLCZ8uRObVZhzBfMsm9tbKB1jlSrBLrmvTfsPnL4s2nlZtrb1jHgDy09AtoSi
         Bw1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6PZ8SEi14GOn4eemrIumaJvvtU1n1XVq4pJkW36yXBk=;
        b=kc1ZjXAfnxbQmfsrC39PUSVhoETP9Jh6dOrllgQ1/zumxM/ClSk5ErnPrmNMrhiCFG
         LGNn6DE5sgpeZiDV6Uco7t4oDDnGGiRNXxW1Ey5ikENEEvWY8HG+7DRRIDLf2JcbEfBX
         sa2RGtSSHV54ZYew+nWbWHKTRx+hHKoGdbw4pyLBAUVpIyaog8qaTStRwaP6Y2QOPXTW
         oO/5zliOM1psMyRiPISxaQSRwL7wXbfllqt/4gDagwsaI2YcWRuYt20l4PwDvIzMRKVe
         mkQQM5aN04NKXMMajASO2J5y6LaUM2otGYIIVV7TkG8UYB7MqQQCfrJC9HagaQtqU37q
         Cq5g==
X-Gm-Message-State: AOAM5330NHUD9ssIgyuVg0wYvK2l2qeHMisPZep5dO7F7TcnQMNw3LCQ
        +DrjEIdcG5DdQGSDGzODMN+8zQ==
X-Google-Smtp-Source: ABdhPJxCC8utsMF5rcTC7pd5UreHosbOWpzJm+pexx9q3NTFjU3YtRWzMBbuKfztaLE4yRhty81uRQ==
X-Received: by 2002:a5d:5588:: with SMTP id i8mr2939341wrv.177.1597414406559;
        Fri, 14 Aug 2020 07:13:26 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id b11sm14153744wrq.32.2020.08.14.07.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 07:13:24 -0700 (PDT)
Date:   Fri, 14 Aug 2020 15:13:22 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net,
        Jiri Slaby <jslaby@suse.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Jason Wessel <jason.wessel@windriver.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [RFC 2/5] serial: core: Add framework to allow NMI aware serial
 drivers
Message-ID: <20200814141322.lffebtamfjt2qrym@holly.lan>
References: <1595333413-30052-1-git-send-email-sumit.garg@linaro.org>
 <1595333413-30052-3-git-send-email-sumit.garg@linaro.org>
 <CAD=FV=XUNqun3d+C_7GpgntGWRXwLSLnXKStLUz8iqZoGKu8zg@mail.gmail.com>
 <CAFA6WYNq-Z5WD=AqJn2_DEg0F6G1CYte2y5Snc964vsgCnr0Bw@mail.gmail.com>
 <CAD=FV=Vu3PGSUzargD-6e2XOw=Eh7CZaQ_+a09dr8SR1T8eE2g@mail.gmail.com>
 <CAFA6WYPJ_w+R15NRKK5BzZtTxKq8Gh_mGswuYbW0cYZoBYLhxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFA6WYPJ_w+R15NRKK5BzZtTxKq8Gh_mGswuYbW0cYZoBYLhxw@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Aug 14, 2020 at 04:47:11PM +0530, Sumit Garg wrote:
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

Perhaps don't consider this to be "fixing schedule_work()" but providing
an NMI-safe alternative to schedule_work().

Does it look better if you create a new type to map the two structures
together. Alternatively are there enough existing use-cases to want to
extend irq_work_queue() with irq_work_schedule() or something similar?


Daniel.
