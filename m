Return-Path: <SRS0=iWX9=B3=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 523C1C433E1
	for <linux-serial@archiver.kernel.org>; Mon, 17 Aug 2020 14:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1575820716
	for <linux-serial@archiver.kernel.org>; Mon, 17 Aug 2020 14:24:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EiPVoknU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728831AbgHQOYM (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 17 Aug 2020 10:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728669AbgHQOYJ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 17 Aug 2020 10:24:09 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66AE3C061342
        for <linux-serial@vger.kernel.org>; Mon, 17 Aug 2020 07:24:08 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id y2so8677275ljc.1
        for <linux-serial@vger.kernel.org>; Mon, 17 Aug 2020 07:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oU7e+jIr/cI/ou5kHSSsfha06PmR4hz2KnNYeE0ncyg=;
        b=EiPVoknUJcywffhSmPfzdZX8frrHNh4TAkgBe9sRQg3aMFUAzaAs2xuI7sPHuBYHoB
         nHj9iUvWbWAxExZAwF+zDwOjmhRgHvPsIGHZEWfKE0QIEXr5q7wH8wsfNinfWGErSQFI
         I2SaKX/XfpzOgiGFuDP2S+VJixH2ZWk27E5fDzpPZFfMTpP5S5l/WAFdODRP93oiMe7/
         fCAk7F5bKrO0MdBpTrTpwRmhCAvdu08zqb9Khk2U+fbXYaWwxo41vQZHzaQLskGEteZv
         JuP6grRSg6wimPHpZclWJJrhJmO+BjBhUBhzo6s8vu8nw+LGp8/sjVpC/6HuHj7TDfGo
         habw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oU7e+jIr/cI/ou5kHSSsfha06PmR4hz2KnNYeE0ncyg=;
        b=hVGkbek5kJM2wVcRL6FuOqg9oRBzhdGJXwAPmK3OWDUMQnyLKW1mnFEmMaW2LlvBd0
         k58pQ4S0hzjx6Wv6A2TPiJf3Z6nvDHLUTlKEYPiA1Ns8Ky2M247v/oVn3a14pqIPKfXG
         RSPzLUVun4a3hooCEftyj5UtiSk267lqKNFgSXSDuC62E2ZQoUVfafCCs08p+jcYbZR9
         m7ro56qJ2gIlmGi5H95qvctCrDjA3ma4VXp7xp6nQvz44AOHCKmSHpmQERLE/t2GTjBs
         pJNw5PSP6D1/rKce8burNVoXob+NFsw12/UTJLrYhUHAhjptSWb7Oeenz2nO48CD5arU
         aolg==
X-Gm-Message-State: AOAM533NmeHwnsoWv+PQMuBn+KSKwmPR3JwRqQho6U5cxsOXebBDEGEA
        HirM7dewbIsPiCqVFZ0zPbBNuVzApqFmPWzJ1Uet5g==
X-Google-Smtp-Source: ABdhPJzyYSgkPBQJajdoF5LqQQKz259BV4J6EumeZ8VPZ3rX9VyL6FgcFUgPSlYGKcwOcGR3OcWBpP+o0QJ6FOC/zXg=
X-Received: by 2002:a2e:3202:: with SMTP id y2mr7902509ljy.30.1597674246644;
 Mon, 17 Aug 2020 07:24:06 -0700 (PDT)
MIME-Version: 1.0
References: <1595333413-30052-1-git-send-email-sumit.garg@linaro.org>
 <1595333413-30052-3-git-send-email-sumit.garg@linaro.org> <CAD=FV=XUNqun3d+C_7GpgntGWRXwLSLnXKStLUz8iqZoGKu8zg@mail.gmail.com>
 <CAFA6WYNq-Z5WD=AqJn2_DEg0F6G1CYte2y5Snc964vsgCnr0Bw@mail.gmail.com>
 <CAD=FV=Vu3PGSUzargD-6e2XOw=Eh7CZaQ_+a09dr8SR1T8eE2g@mail.gmail.com>
 <CAFA6WYPJ_w+R15NRKK5BzZtTxKq8Gh_mGswuYbW0cYZoBYLhxw@mail.gmail.com>
 <20200814141322.lffebtamfjt2qrym@holly.lan> <CAFA6WYNAdELYCoOVQokgLNKhOYF9QK85UidgvyFfo4wsSNwKXw@mail.gmail.com>
 <CAD=FV=WiZi18zBwx9J0sKLdCqMCvxuQ=U0m21yNqhtaBfZEqzA@mail.gmail.com>
In-Reply-To: <CAD=FV=WiZi18zBwx9J0sKLdCqMCvxuQ=U0m21yNqhtaBfZEqzA@mail.gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 17 Aug 2020 19:53:55 +0530
Message-ID: <CAFA6WYOww8T7fmP-LtzS-EXG0iBbKEUOS5KrUU_7i+yqd_rFfQ@mail.gmail.com>
Subject: Re: [RFC 2/5] serial: core: Add framework to allow NMI aware serial drivers
To:     Doug Anderson <dianders@chromium.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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

On Mon, 17 Aug 2020 at 19:27, Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Mon, Aug 17, 2020 at 5:27 AM Sumit Garg <sumit.garg@linaro.org> wrote:
> >
> > Thanks for your suggestion, irq_work_schedule() looked even better
> > without any overhead, see below:
> >
> > diff --git a/include/linux/irq_work.h b/include/linux/irq_work.h
> > index 3082378..1eade89 100644
> > --- a/include/linux/irq_work.h
> > +++ b/include/linux/irq_work.h
> > @@ -3,6 +3,7 @@
> >  #define _LINUX_IRQ_WORK_H
> >
> >  #include <linux/smp_types.h>
> > +#include <linux/workqueue.h>
> >
> >  /*
> >   * An entry can be in one of four states:
> > @@ -24,6 +25,11 @@ struct irq_work {
> >         void (*func)(struct irq_work *);
> >  };
> >
> > +struct irq_work_schedule {
> > +       struct irq_work work;
> > +       struct work_struct *sched_work;
> > +};
> > +
> >  static inline
> >  void init_irq_work(struct irq_work *work, void (*func)(struct irq_work *))
> >  {
> >  {
> > @@ -39,6 +45,7 @@ void init_irq_work(struct irq_work *work, void
> > (*func)(struct irq_work *))
> >
> >  bool irq_work_queue(struct irq_work *work);
> >  bool irq_work_queue_on(struct irq_work *work, int cpu);
> > +bool irq_work_schedule(struct work_struct *sched_work);
> >
> >  void irq_work_tick(void);
> >  void irq_work_sync(struct irq_work *work);
> > diff --git a/kernel/irq_work.c b/kernel/irq_work.c
> > index eca8396..3880316 100644
> > --- a/kernel/irq_work.c
> > +++ b/kernel/irq_work.c
> > @@ -24,6 +24,8 @@
> >  static DEFINE_PER_CPU(struct llist_head, raised_list);
> >  static DEFINE_PER_CPU(struct llist_head, lazy_list);
> >
> > +static struct irq_work_schedule irq_work_sched;
> > +
> >  /*
> >   * Claim the entry so that no one else will poke at it.
> >   */
> > @@ -79,6 +81,25 @@ bool irq_work_queue(struct irq_work *work)
> >  }
> >  EXPORT_SYMBOL_GPL(irq_work_queue);
> >
> > +static void irq_work_schedule_fn(struct irq_work *work)
> > +{
> > +       struct irq_work_schedule *irq_work_sched =
> > +               container_of(work, struct irq_work_schedule, work);
> > +
> > +       if (irq_work_sched->sched_work)
> > +               schedule_work(irq_work_sched->sched_work);
> > +}
> > +
> > +/* Schedule work via irq work queue */
> > +bool irq_work_schedule(struct work_struct *sched_work)
> > +{
> > +       init_irq_work(&irq_work_sched.work, irq_work_schedule_fn);
> > +       irq_work_sched.sched_work = sched_work;
> > +
> > +       return irq_work_queue(&irq_work_sched.work);
> > +}
> > +EXPORT_SYMBOL_GPL(irq_work_schedule);
>
> Wait, howzat work?  There's a single global variable that you stash
> the "sched_work" into with no locking?  What if two people schedule
> work at the same time?

This API is intended to be invoked from NMI context only, so I think
there will be a single user at a time. And we can make that explicit
as well:

+/* Schedule work via irq work queue */
+bool irq_work_schedule(struct work_struct *sched_work)
+{
+       if (in_nmi()) {
+               init_irq_work(&irq_work_sched.work, irq_work_schedule_fn);
+               irq_work_sched.sched_work = sched_work;
+
+               return irq_work_queue(&irq_work_sched.work);
+       }
+
+       return false;
+}
+EXPORT_SYMBOL_GPL(irq_work_schedule);

-Sumit

>
> -Doug
