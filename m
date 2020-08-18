Return-Path: <SRS0=mq3J=B4=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 154A5C433E1
	for <linux-serial@archiver.kernel.org>; Tue, 18 Aug 2020 13:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E093C20825
	for <linux-serial@archiver.kernel.org>; Tue, 18 Aug 2020 13:06:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PIGPhufE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbgHRNGW (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 18 Aug 2020 09:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbgHRNGS (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 18 Aug 2020 09:06:18 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C11DC061389
        for <linux-serial@vger.kernel.org>; Tue, 18 Aug 2020 06:06:18 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id d2so10186346lfj.1
        for <linux-serial@vger.kernel.org>; Tue, 18 Aug 2020 06:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IhGt4f9jByBxwiS5kZbnVsZb64Dpn4S8Zrl+tXBABko=;
        b=PIGPhufEWcQqajAr9EkyMc04aTgLdkSS0SFgGl+mr7c09WYImutC9/kVv/NW1WYO9u
         t0j9aC1fUyT0tLB+/4rwao9XGGpMZYNDwQgd9bh2J2lB5mIvKnxtxubZl3113WG1o0bU
         Cf0+cB35X6H/TCOYi5aTF4x9OshcbUZMf0VNplQRedQpYfxQzjX4fPkTU9YKpINiGQSA
         87TKCNoY9QA8uzYiFI4VygCo2EsFFYVDQTOFV7uRJwuSrDNpd3nj9+1R+qFMu7g0KOXH
         LwnfDVY2oN1dFLbIijBZxqSJan4TwqGS6Og70I7lSjgR2lfzV9gJBaqwIn2nDf6czUe9
         pHPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IhGt4f9jByBxwiS5kZbnVsZb64Dpn4S8Zrl+tXBABko=;
        b=IQAJcYdic7vvqLxYoBl+xPViwInec7MTe5BRSFZHG3ZZeZZsHJoTCOwkTXTZpVDsKj
         7jYguKdwY1Lr5yR31mn3ZEK4qCEV7Gczg4tbNaq7axzxRttZpN0KClmqXSwgH4fVn25W
         xnILBzneeeprruBxfZdpaZGgDGLwQgsp+c/eQKUwLHLX9gdGJcFhBVKV9Bz89VRggayN
         Kzv1ntPuKtz7HoWxssv6j4zFNi75p5FJEz6N8y6C+7Fg6ASCTaUnBAv0klW7hRfA1nF7
         llBi1Dcz4qXpm7YF+ZNcecShJM46hk6Vho/gO5w9qky2ZdMgcWMPu4BbfrJwkPpag9T+
         LlIg==
X-Gm-Message-State: AOAM533En+Qj/8s3Lnrv2fbbpukBHeP8xqk0OvYlbNSeK+uSgiQz6I3P
        vXOwfh1YGo+osUC0AWZUBTKsJQZoSdH7xscG7dFbMWFl8/M4Ew==
X-Google-Smtp-Source: ABdhPJwoM8HXLERjKwax9uz3rzah+nFl76bythIgAGWCLdMJLlIoYib4VNFwjf2uK+BA0fDXa3JcGGhLUUXCgT4XDuQ=
X-Received: by 2002:a19:803:: with SMTP id 3mr9802322lfi.15.1597755976518;
 Tue, 18 Aug 2020 06:06:16 -0700 (PDT)
MIME-Version: 1.0
References: <1595333413-30052-1-git-send-email-sumit.garg@linaro.org>
 <1595333413-30052-3-git-send-email-sumit.garg@linaro.org> <CAD=FV=XUNqun3d+C_7GpgntGWRXwLSLnXKStLUz8iqZoGKu8zg@mail.gmail.com>
 <CAFA6WYNq-Z5WD=AqJn2_DEg0F6G1CYte2y5Snc964vsgCnr0Bw@mail.gmail.com>
 <CAD=FV=Vu3PGSUzargD-6e2XOw=Eh7CZaQ_+a09dr8SR1T8eE2g@mail.gmail.com>
 <CAFA6WYPJ_w+R15NRKK5BzZtTxKq8Gh_mGswuYbW0cYZoBYLhxw@mail.gmail.com>
 <20200814141322.lffebtamfjt2qrym@holly.lan> <CAFA6WYNAdELYCoOVQokgLNKhOYF9QK85UidgvyFfo4wsSNwKXw@mail.gmail.com>
 <20200817142846.mm46yy62illrewbq@holly.lan>
In-Reply-To: <20200817142846.mm46yy62illrewbq@holly.lan>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 18 Aug 2020 18:36:04 +0530
Message-ID: <CAFA6WYOWHgmYYt=KGXDh2hKiuy_rQbJfi279ev0+s-Qh7L21kA@mail.gmail.com>
Subject: Re: [RFC 2/5] serial: core: Add framework to allow NMI aware serial drivers
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Doug Anderson <dianders@chromium.org>,
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

On Mon, 17 Aug 2020 at 19:58, Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Mon, Aug 17, 2020 at 05:57:03PM +0530, Sumit Garg wrote:
> > On Fri, 14 Aug 2020 at 19:43, Daniel Thompson
> > <daniel.thompson@linaro.org> wrote:
> > > On Fri, Aug 14, 2020 at 04:47:11PM +0530, Sumit Garg wrote:
> > > Does it look better if you create a new type to map the two structures
> > > together. Alternatively are there enough existing use-cases to want to
> > > extend irq_work_queue() with irq_work_schedule() or something similar?
> > >
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
> > +
>
> This is irredeemably broken.
>
> Even if we didn't care about dropping events (which we do) then when you
> overwrite irq_work_sched with a copy of another work_struct, either of
> which could currently be enqueued somewhere, then you will cause some
> very nasty corruption.
>

Okay, I see your point. I think there isn't a way to avoid caller
specific struct such as:

struct nmi_queuable_work_struct {
  struct work_struct work;
  struct irq_work iw;
};

So in that case will shift to approach as suggested by Doug to rather
have a new nmi_schedule_work() API.

-Sumit

>
> Daniel.
