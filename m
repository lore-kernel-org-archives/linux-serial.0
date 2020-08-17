Return-Path: <SRS0=iWX9=B3=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D8D0C433E1
	for <linux-serial@archiver.kernel.org>; Mon, 17 Aug 2020 14:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37F5220716
	for <linux-serial@archiver.kernel.org>; Mon, 17 Aug 2020 14:28:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oi/1F0No"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728949AbgHQO2w (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 17 Aug 2020 10:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728948AbgHQO2u (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 17 Aug 2020 10:28:50 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B601C061342
        for <linux-serial@vger.kernel.org>; Mon, 17 Aug 2020 07:28:50 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z18so15209557wrm.12
        for <linux-serial@vger.kernel.org>; Mon, 17 Aug 2020 07:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jZBiiEEprcZxIoS7kLgkj8BI5NaODguV/9YEt0JNbrs=;
        b=oi/1F0NoccxfISqtDM6MCAbKxX1wHsT+Slj0IB4Uht85/OVJZc4/mTtfWQlRQcucuQ
         tOl36e9Vrw9wpUkFo5sC/oUXQP6pw86tsAWPFs6z1WWJxNGsnjxmfih61u11BS2Pt9k3
         9gphW+/L2Cu14UEtt4gzsopSH3RoMARg3SSrnGYuaqs3dsHaGZLrXHVxVjPBLd78B9/+
         XFZliSYdHkwh/57J+ONt72l6BIJTAptctPtfnJeoe3K3Bx6+CDYoi2l/2OJJN55Nib+G
         FMQ7CDXrX4BYj61lntcDk3NF0tBC8Y2NEHW8jJE5elBDHA8YHQEprW5UAcSIY9UtT95t
         SG1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jZBiiEEprcZxIoS7kLgkj8BI5NaODguV/9YEt0JNbrs=;
        b=IlZrGRdISgbVn5ef8lG1DtZUqIYrbRNMhsIV862gQqSzlsI2NydkEizVyaOJximRQK
         +73WV1MMdDGK45BFg9aUDnJ8MiQR2cF4iUsEKXI7EN0c89VLzv8Y1O8tWhXYA6lc2Gcw
         GIKSy1gLg3wwDDZdRHAxDUC9f/uSKNOt33Nj17roVB1d3Q1M0+wnWmydyCzpueEtNDrn
         cc3qdvx21OrpIsM8GWRWvPhKz8oUOH3OBWIUu48OOcijHXm3I6TpKaZDYg9JN/0CcRPm
         qzml51W7Jm7nIn81uVzx1b3I9VxTNVY01M7jTKL/SYmfavp7hM48U+NYcHsTGu3WCGVu
         lEIQ==
X-Gm-Message-State: AOAM533vuhk4XWDWXcDOrc8I8sJ9wcwW4k/vdSV1IcRTNBUyzxYcM5Vb
        zI7QtNJeG7mX7fGKmVH9aCKFUw==
X-Google-Smtp-Source: ABdhPJx14fi62OgyZfj8zMYJ1zd8/0R74mqVq42SMxYWCi217PiFrf2gqQGokK2QCtnUYWulLtPC3w==
X-Received: by 2002:adf:f007:: with SMTP id j7mr14748884wro.195.1597674528714;
        Mon, 17 Aug 2020 07:28:48 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id n5sm30089028wrx.22.2020.08.17.07.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 07:28:48 -0700 (PDT)
Date:   Mon, 17 Aug 2020 15:28:46 +0100
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
Message-ID: <20200817142846.mm46yy62illrewbq@holly.lan>
References: <1595333413-30052-1-git-send-email-sumit.garg@linaro.org>
 <1595333413-30052-3-git-send-email-sumit.garg@linaro.org>
 <CAD=FV=XUNqun3d+C_7GpgntGWRXwLSLnXKStLUz8iqZoGKu8zg@mail.gmail.com>
 <CAFA6WYNq-Z5WD=AqJn2_DEg0F6G1CYte2y5Snc964vsgCnr0Bw@mail.gmail.com>
 <CAD=FV=Vu3PGSUzargD-6e2XOw=Eh7CZaQ_+a09dr8SR1T8eE2g@mail.gmail.com>
 <CAFA6WYPJ_w+R15NRKK5BzZtTxKq8Gh_mGswuYbW0cYZoBYLhxw@mail.gmail.com>
 <20200814141322.lffebtamfjt2qrym@holly.lan>
 <CAFA6WYNAdELYCoOVQokgLNKhOYF9QK85UidgvyFfo4wsSNwKXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFA6WYNAdELYCoOVQokgLNKhOYF9QK85UidgvyFfo4wsSNwKXw@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Aug 17, 2020 at 05:57:03PM +0530, Sumit Garg wrote:
> On Fri, 14 Aug 2020 at 19:43, Daniel Thompson
> <daniel.thompson@linaro.org> wrote:
> > On Fri, Aug 14, 2020 at 04:47:11PM +0530, Sumit Garg wrote:
> > Does it look better if you create a new type to map the two structures
> > together. Alternatively are there enough existing use-cases to want to
> > extend irq_work_queue() with irq_work_schedule() or something similar?
> >
> 
> Thanks for your suggestion, irq_work_schedule() looked even better
> without any overhead, see below:
> 
> diff --git a/include/linux/irq_work.h b/include/linux/irq_work.h
> index 3082378..1eade89 100644
> --- a/include/linux/irq_work.h
> +++ b/include/linux/irq_work.h
> @@ -3,6 +3,7 @@
>  #define _LINUX_IRQ_WORK_H
> 
>  #include <linux/smp_types.h>
> +#include <linux/workqueue.h>
> 
>  /*
>   * An entry can be in one of four states:
> @@ -24,6 +25,11 @@ struct irq_work {
>         void (*func)(struct irq_work *);
>  };
> 
> +struct irq_work_schedule {
> +       struct irq_work work;
> +       struct work_struct *sched_work;
> +};
> +
>  static inline
>  void init_irq_work(struct irq_work *work, void (*func)(struct irq_work *))
>  {
>  {
> @@ -39,6 +45,7 @@ void init_irq_work(struct irq_work *work, void
> (*func)(struct irq_work *))
> 
>  bool irq_work_queue(struct irq_work *work);
>  bool irq_work_queue_on(struct irq_work *work, int cpu);
> +bool irq_work_schedule(struct work_struct *sched_work);
> 
>  void irq_work_tick(void);
>  void irq_work_sync(struct irq_work *work);
> diff --git a/kernel/irq_work.c b/kernel/irq_work.c
> index eca8396..3880316 100644
> --- a/kernel/irq_work.c
> +++ b/kernel/irq_work.c
> @@ -24,6 +24,8 @@
>  static DEFINE_PER_CPU(struct llist_head, raised_list);
>  static DEFINE_PER_CPU(struct llist_head, lazy_list);
> 
> +static struct irq_work_schedule irq_work_sched;
> +
>  /*
>   * Claim the entry so that no one else will poke at it.
>   */
> @@ -79,6 +81,25 @@ bool irq_work_queue(struct irq_work *work)
>  }
>  EXPORT_SYMBOL_GPL(irq_work_queue);
> 
> +static void irq_work_schedule_fn(struct irq_work *work)
> +{
> +       struct irq_work_schedule *irq_work_sched =
> +               container_of(work, struct irq_work_schedule, work);
> +
> +       if (irq_work_sched->sched_work)
> +               schedule_work(irq_work_sched->sched_work);
> +}
> +
> +/* Schedule work via irq work queue */
> +bool irq_work_schedule(struct work_struct *sched_work)
> +{
> +       init_irq_work(&irq_work_sched.work, irq_work_schedule_fn);
> +       irq_work_sched.sched_work = sched_work;
> +
> +       return irq_work_queue(&irq_work_sched.work);
> +}
> +EXPORT_SYMBOL_GPL(irq_work_schedule);
> +

This is irredeemably broken.

Even if we didn't care about dropping events (which we do) then when you
overwrite irq_work_sched with a copy of another work_struct, either of
which could currently be enqueued somewhere, then you will cause some
very nasty corruption.


Daniel.
