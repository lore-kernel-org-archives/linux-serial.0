Return-Path: <SRS0=iWX9=B3=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD84C433DF
	for <linux-serial@archiver.kernel.org>; Mon, 17 Aug 2020 13:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F406A2075B
	for <linux-serial@archiver.kernel.org>; Mon, 17 Aug 2020 13:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZKT/oHgX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728471AbgHQN5l (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 17 Aug 2020 09:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728489AbgHQN5i (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 17 Aug 2020 09:57:38 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8EEC061389
        for <linux-serial@vger.kernel.org>; Mon, 17 Aug 2020 06:57:37 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id d20so4746899ual.13
        for <linux-serial@vger.kernel.org>; Mon, 17 Aug 2020 06:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xdKYrohN8OlGDXEszWS+Ec7t39VpiibXfsuU/BXESmU=;
        b=ZKT/oHgXJeLaz2zSrpCOpcciOR4Mu1pqaSQj+Y449pXWXd5zG14b92RWlkzZCxWBO7
         yME6N7qJVHxW7bemEEpv63eiFnQiLjA0UKyEvL6CwHme89gvtDcenUq5X9ku6kYABH4m
         ad78O5beq8PPyCpELu1KKVgY+uZ0KpO9XYRLE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xdKYrohN8OlGDXEszWS+Ec7t39VpiibXfsuU/BXESmU=;
        b=Qa09/yd9FZUljMUNGPP6HWRRrkXGzpj63ijDYObxvGYCoCjYjtcyEUXFff7N+agLDI
         5QSJgjLhZQZ0EbQuZrdyqinzcE+CBz5x1bSRy02E9pcEyn5TU+xFIv1zP1cP5/9rdtBk
         WW+bG2UDnYGC+wQHz5OJzMuRh/AfipmZoRggHAiHlq1n2F0U4Jyc8HKP4pP2Ka6jjlKi
         V37CpanBjq4xZSsiKfj13EnI6zKGl5ubR2dI7tf628LiIGAFXEPMzqKNdiJmPml1m+Vy
         afQDukxMFh5S3EetSTQsSbD4318ii+K+Iatit13C2PR2G472DFSURfr21Xwbx6+BLEJw
         H20w==
X-Gm-Message-State: AOAM531SozbxrnUqSHFCe6jaoTP87J/ooko6amsvUZBeW/IU1j+1S12J
        ItDbOjhkJ/lBtMgbOX2Zhsjpc+EVFWAE3A==
X-Google-Smtp-Source: ABdhPJz5M/+9NkowSl2mubsLlyXdXm32QS/wEdIkFzlH5XQEhVm0sN8gLQi+Zu1cdTD5zNItPYA7ug==
X-Received: by 2002:ab0:6907:: with SMTP id b7mr7396077uas.127.1597672656660;
        Mon, 17 Aug 2020 06:57:36 -0700 (PDT)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com. [209.85.217.49])
        by smtp.gmail.com with ESMTPSA id u3sm3497519vkb.0.2020.08.17.06.57.34
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2020 06:57:34 -0700 (PDT)
Received: by mail-vs1-f49.google.com with SMTP id i129so8298370vsi.3
        for <linux-serial@vger.kernel.org>; Mon, 17 Aug 2020 06:57:34 -0700 (PDT)
X-Received: by 2002:a67:fd67:: with SMTP id h7mr7276952vsa.121.1597672654168;
 Mon, 17 Aug 2020 06:57:34 -0700 (PDT)
MIME-Version: 1.0
References: <1595333413-30052-1-git-send-email-sumit.garg@linaro.org>
 <1595333413-30052-3-git-send-email-sumit.garg@linaro.org> <CAD=FV=XUNqun3d+C_7GpgntGWRXwLSLnXKStLUz8iqZoGKu8zg@mail.gmail.com>
 <CAFA6WYNq-Z5WD=AqJn2_DEg0F6G1CYte2y5Snc964vsgCnr0Bw@mail.gmail.com>
 <CAD=FV=Vu3PGSUzargD-6e2XOw=Eh7CZaQ_+a09dr8SR1T8eE2g@mail.gmail.com>
 <CAFA6WYPJ_w+R15NRKK5BzZtTxKq8Gh_mGswuYbW0cYZoBYLhxw@mail.gmail.com>
 <20200814141322.lffebtamfjt2qrym@holly.lan> <CAFA6WYNAdELYCoOVQokgLNKhOYF9QK85UidgvyFfo4wsSNwKXw@mail.gmail.com>
In-Reply-To: <CAFA6WYNAdELYCoOVQokgLNKhOYF9QK85UidgvyFfo4wsSNwKXw@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 17 Aug 2020 06:57:22 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WiZi18zBwx9J0sKLdCqMCvxuQ=U0m21yNqhtaBfZEqzA@mail.gmail.com>
Message-ID: <CAD=FV=WiZi18zBwx9J0sKLdCqMCvxuQ=U0m21yNqhtaBfZEqzA@mail.gmail.com>
Subject: Re: [RFC 2/5] serial: core: Add framework to allow NMI aware serial drivers
To:     Sumit Garg <sumit.garg@linaro.org>
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

Hi,

On Mon, Aug 17, 2020 at 5:27 AM Sumit Garg <sumit.garg@linaro.org> wrote:
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

Wait, howzat work?  There's a single global variable that you stash
the "sched_work" into with no locking?  What if two people schedule
work at the same time?

-Doug
