Return-Path: <SRS0=Q4yL=AE=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B432C433E0
	for <linux-serial@archiver.kernel.org>; Tue, 23 Jun 2020 08:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E66BE20738
	for <linux-serial@archiver.kernel.org>; Tue, 23 Jun 2020 08:38:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NI3za5Eg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731744AbgFWIiB (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 23 Jun 2020 04:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731691AbgFWIiB (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 23 Jun 2020 04:38:01 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F46C061573
        for <linux-serial@vger.kernel.org>; Tue, 23 Jun 2020 01:38:00 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id s9so2226313ljm.11
        for <linux-serial@vger.kernel.org>; Tue, 23 Jun 2020 01:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KiVJjoaQorxf1aimFNd74dt122rnXcG+vxwmqCOHMDo=;
        b=NI3za5EgJxLvzW9m9oQ9YVc3q0wPCrYkmih73lGIBguvYIpizIxfepdV7BYBfzaPhl
         4KPVqFcernSjy0QxCidSqUecThjjNBWJ12EKGqru80AVzKZpFwhoCiTSjx68HaAVGn7N
         cAXOsi0uMsqhE0nsOry8VkDDxKb2To1rtR/uKzrbzPz5n6e3JjOQezlrggK5iolSifPX
         BJvj8lg3HlFZSPTi+dRz4v4dzVI+QB83BIXk+hvemBGusElDDayQcTcFU9tNU8ZOBOF5
         u/vnr9WhI2p+6YhtRu3pnY/FNb+RYS4Rk3SzjeVEsX/LQGw0wS9CHb+A+WmlL5q54xOY
         4r/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KiVJjoaQorxf1aimFNd74dt122rnXcG+vxwmqCOHMDo=;
        b=FVIwnTba0Iiz879gDfcnZhUQCnlxB1YwL6uo5Di9gAVdgMmFfeZ+WtC11QgOMFZduD
         l3qQAAVoHgn2eFUiAgiUZqdwHI5EV5q3uzQjR/hJ4ye3vGDEu7AIeqZRjTWb4m5Sy0ST
         bu3z49+C5BTd40sXd9V0G6ZPbfDS0ZkJEEErwXhwFOQDFVUGZDih0lPn+4uVNppJAbFD
         qGVT6PPJidvxBtbgCHmKaGMfGFMEfnZhhvPzvI54weFx9zz2m4o/2Ft3suEE/bYEVHft
         OeGatXAiRV6H0gW3mMOjuK3DKlyM54zsTdVPWxoIB1fZf4J9JZLrPFBaqT41hr7miXY9
         BgFA==
X-Gm-Message-State: AOAM533M15qTArV75YwWkqiYUL7I7hkgVyZ6ti+eqkvpRuY6kP7M46h6
        qmqV40GnTJREsnvFwGTh9S96X55SWahPT2mVlYDsgw==
X-Google-Smtp-Source: ABdhPJyuMMGSafHUAwWJ7+9HsMPCEIVgc/PDX+AxQAiWFjsyrhwkg+FlZqfo0SvQI1JF0ffeLccNL3RpEJ0fnTVRjr0=
X-Received: by 2002:a2e:b4e6:: with SMTP id s6mr2099464ljm.372.1592901479193;
 Tue, 23 Jun 2020 01:37:59 -0700 (PDT)
MIME-Version: 1.0
References: <1592835984-28613-1-git-send-email-sumit.garg@linaro.org>
 <1592835984-28613-4-git-send-email-sumit.garg@linaro.org> <20200622160300.avgfhnfkpqzqqtsr@holly.lan>
In-Reply-To: <20200622160300.avgfhnfkpqzqqtsr@holly.lan>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 23 Jun 2020 14:07:47 +0530
Message-ID: <CAFA6WYOmQT-OQvjpy1pVPq2mx5S264bJPd-XfwnDY2BjeoWekg@mail.gmail.com>
Subject: Re: [PATCH 3/7] kgdb: Add request_nmi() to the io ops table for kgdboc
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>,
        Jiri Slaby <jslaby@suse.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, 22 Jun 2020 at 21:33, Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Mon, Jun 22, 2020 at 07:56:20PM +0530, Sumit Garg wrote:
> > From: Daniel Thompson <daniel.thompson@linaro.org>
> >
> > Add request_nmi() callback to install a non-maskable interrupt handler
> > corresponding to IRQ retrieved from polling interface. If NMI handler
> > installation fails due to missing support from underlying irqchip driver
> > then fallback to install it as normal interrupt handler.
> >
> > Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> > Co-developed-by: Sumit Garg <sumit.garg@linaro.org>
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > ---
> >  drivers/tty/serial/kgdboc.c | 35 +++++++++++++++++++++++++++++++++++
> >  include/linux/kgdb.h        |  7 +++++++
> >  2 files changed, 42 insertions(+)
> >
> > diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
> > index 84ffede..263afae 100644
> > --- a/drivers/tty/serial/kgdboc.c
> > +++ b/drivers/tty/serial/kgdboc.c
> > @@ -19,6 +19,9 @@
> >  #include <linux/console.h>
> >  #include <linux/vt_kern.h>
> >  #include <linux/input.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/irq.h>
> > +#include <linux/irqdesc.h>
> >  #include <linux/module.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/serial_core.h>
> > @@ -390,12 +393,44 @@ static void kgdboc_post_exp_handler(void)
> >       kgdboc_restore_input();
> >  }
> >
> > +static int kgdb_tty_irq;
> > +
> > +static int kgdboc_request_nmi(irq_handler_t fn, void *dev_id)
> > +{
> > +     int irq, res;
> > +
> > +     /* Better to avoid double allocation in the tty driver! */
> > +     if (kgdb_tty_irq)
> > +             return 0;
> > +
> > +     if (!kgdb_tty_driver->ops->poll_get_irq)
> > +             return -ENODEV;
> > +
> > +     irq =
> > +         kgdb_tty_driver->ops->poll_get_irq(kgdb_tty_driver, kgdb_tty_line);
> > +     if (irq <= 0)
> > +             return irq ? irq : -ENODEV;
> > +
> > +     irq_set_status_flags(irq, IRQ_NOAUTOEN);
> > +     res = request_nmi(irq, fn, IRQF_PERCPU, "kgdboc", dev_id);
>
> Why do we need IRQF_PERCPU here. A UART interrupt is not normally
> per-cpu?
>

Have a look at this comment [1] and corresponding check in
request_nmi(). So essentially yes UART interrupt is not normally
per-cpu but in order to make it an NMI, we need to request it in
per-cpu mode.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/irq/manage.c#n2112

>
> > +     if (res) {
> > +             res = request_irq(irq, fn, IRQF_SHARED, "kgdboc", dev_id);
>
> IRQF_SHARED?
>
> Currrently there is nothing that prevents concurrent activation of
> ttyNMI0 and the underlying serial driver. Using IRQF_SHARED means it
> becomes possible for both drivers to try to service the same interrupt.
> That risks some rather "interesting" problems.
>

Could you elaborate more on "interesting" problems?

BTW, I noticed one more problem with this patch that is IRQF_SHARED
doesn't go well with IRQ_NOAUTOEN status flag. Earlier I tested it
with auto enable set.

But if we agree that both shouldn't be active at the same time due to
some real problems(?) then I can rid of IRQF_SHARED as well. Also, I
think we should unregister underlying tty driver (eg. /dev/ttyAMA0) as
well as otherwise it would provide a broken interface to user-space.

-Sumit

>
> Daniel.
>
>
> > +             WARN_ON(res);
> > +     }
> > +
> > +     enable_irq(irq);
> > +
> > +     kgdb_tty_irq = irq;
> > +     return 0;
> > +}
> > +
> >  static struct kgdb_io kgdboc_io_ops = {
> >       .name                   = "kgdboc",
> >       .read_char              = kgdboc_get_char,
> >       .write_char             = kgdboc_put_char,
> >       .pre_exception          = kgdboc_pre_exp_handler,
> >       .post_exception         = kgdboc_post_exp_handler,
> > +     .request_nmi            = kgdboc_request_nmi,
> >  };
> >
> >  #if IS_BUILTIN(CONFIG_KGDB_SERIAL_CONSOLE)
> > diff --git a/include/linux/kgdb.h b/include/linux/kgdb.h
> > index 529116b..b32b044 100644
> > --- a/include/linux/kgdb.h
> > +++ b/include/linux/kgdb.h
> > @@ -16,6 +16,7 @@
> >  #include <linux/linkage.h>
> >  #include <linux/init.h>
> >  #include <linux/atomic.h>
> > +#include <linux/interrupt.h>
> >  #ifdef CONFIG_HAVE_ARCH_KGDB
> >  #include <asm/kgdb.h>
> >  #endif
> > @@ -276,6 +277,10 @@ struct kgdb_arch {
> >   * the I/O driver.
> >   * @post_exception: Pointer to a function that will do any cleanup work
> >   * for the I/O driver.
> > + * @request_nmi: Pointer to a function that can install an non-maskable
> > + * interrupt handler that will be called when a character is pending and that
> > + * can be cleared by calling @read_char until it returns NO_POLL_CHAR. If NMI
> > + * installation fails then fallback to install normal interrupt handler.
> >   * @cons: valid if the I/O device is a console; else NULL.
> >   */
> >  struct kgdb_io {
> > @@ -287,6 +292,8 @@ struct kgdb_io {
> >       void                    (*deinit) (void);
> >       void                    (*pre_exception) (void);
> >       void                    (*post_exception) (void);
> > +     int                     (*request_nmi)(irq_handler_t nmi_handler,
> > +                                            void *dev_id);
> >       struct console          *cons;
> >  };
> >
> > --
> > 2.7.4
> >
