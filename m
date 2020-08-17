Return-Path: <SRS0=iWX9=B3=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9521BC433DF
	for <linux-serial@archiver.kernel.org>; Mon, 17 Aug 2020 17:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5ECB020716
	for <linux-serial@archiver.kernel.org>; Mon, 17 Aug 2020 17:27:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="N1d/ga9O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389595AbgHQR1g (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 17 Aug 2020 13:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731252AbgHQRTY (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 17 Aug 2020 13:19:24 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131BBC061342
        for <linux-serial@vger.kernel.org>; Mon, 17 Aug 2020 10:19:24 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id s29so4970232uae.1
        for <linux-serial@vger.kernel.org>; Mon, 17 Aug 2020 10:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YX0oVXg///eNfopG9sTf6T12UxVkGpMS/IwW3JYhA54=;
        b=N1d/ga9OT+0QanElTMxw400OpuXd9TpqWN6PJ/UdsHFwIEFvOY7IKKpk4nYCjMszPJ
         oEJ08DMSjR+H8MFxGxmpacTJaYF+mEz7YmRPiPM+FAKHnUwiapBm2pOIJXxM2xyLMeZh
         VsGx3MHCDg8neQey2owQc+5WwYzWE8IQo5A2o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YX0oVXg///eNfopG9sTf6T12UxVkGpMS/IwW3JYhA54=;
        b=HhnpYYk6Mw5R2oL7J3/P7rTvHB/SeYo4Zgr5t1GTfKXjsZSg6X86F0IZJCQcBPjFws
         aMPu0i4fTI0yRprPj8UZ3bwxaj+0RcwEU6BZ7CSP9Q1PLEpoClEfiYMqEfJQKLOrVOA0
         LQKqpI4vmkmywNHRVeOtllWny7B2ic4DTm9cIH5AzDYwDzQrnV9bvduYk0RL3dT2+XHw
         5R9SxKA4Eob/0zHWONAsjC+GkfEFzUGnAXG904G27yIdEy29vMCewYWd/YtYlGwixN6g
         GZmOGZ51tYkIuktxEO3tE2V9KtIeT+jvwwJxCjWcZeDNvkwzKct/3PcMHv2BIfou5Nsa
         VUag==
X-Gm-Message-State: AOAM532ETBy3YuAFeJB9CLP36gALOw5f7fg9awMGZBbvEpSrEP4iWYmC
        yyPIB33CFPW2hg179hX0O1clDwXngcamuA==
X-Google-Smtp-Source: ABdhPJyzJov+np8tpukAaQ+TwDk8G7TAXLJZYv2C/11PwTi1OUmRkgXp7GZ8P45Ff3L1Vt25FLSykA==
X-Received: by 2002:ab0:70b6:: with SMTP id q22mr8498598ual.66.1597684762313;
        Mon, 17 Aug 2020 10:19:22 -0700 (PDT)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com. [209.85.217.47])
        by smtp.gmail.com with ESMTPSA id j195sm3582369vke.18.2020.08.17.10.19.21
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2020 10:19:21 -0700 (PDT)
Received: by mail-vs1-f47.google.com with SMTP id a1so8660279vsp.4
        for <linux-serial@vger.kernel.org>; Mon, 17 Aug 2020 10:19:21 -0700 (PDT)
X-Received: by 2002:a67:f44f:: with SMTP id r15mr8546380vsn.42.1597684760494;
 Mon, 17 Aug 2020 10:19:20 -0700 (PDT)
MIME-Version: 1.0
References: <1595333413-30052-1-git-send-email-sumit.garg@linaro.org>
 <1595333413-30052-2-git-send-email-sumit.garg@linaro.org> <CAD=FV=Uqi28A=sm5+JhAqBM2OtBM3_XwvvkaKyEDVL9uVEioog@mail.gmail.com>
 <CAFA6WYMy_+RdsPJekm7zmCrFUXHqjsfr3JvyD7L8A2X8+jB8Qw@mail.gmail.com>
 <CAD=FV=WJzdhqnztNtj7p5S365wVPcgs2Kya_4bVwqeDWFojUrQ@mail.gmail.com> <CAFA6WYPG1dApPhAL252nJJyi99qHFS+jMUP_mV9g0EqXBZTWWQ@mail.gmail.com>
In-Reply-To: <CAFA6WYPG1dApPhAL252nJJyi99qHFS+jMUP_mV9g0EqXBZTWWQ@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 17 Aug 2020 10:19:08 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U8d86CPUfeA-S_Hd726otEMQpv6sz=c72PoLKgtHiW2w@mail.gmail.com>
Message-ID: <CAD=FV=U8d86CPUfeA-S_Hd726otEMQpv6sz=c72PoLKgtHiW2w@mail.gmail.com>
Subject: Re: [RFC 1/5] tty/sysrq: Make sysrq handler NMI aware
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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

On Mon, Aug 17, 2020 at 7:08 AM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> On Fri, 14 Aug 2020 at 20:27, Doug Anderson <dianders@chromium.org> wrote:
> >
> > Hi,
> >
> > On Fri, Aug 14, 2020 at 12:24 AM Sumit Garg <sumit.garg@linaro.org> wrote:
> > >
> > > + Peter (author of irq_work.c)
> > >
> > > On Thu, 13 Aug 2020 at 05:30, Doug Anderson <dianders@chromium.org> wrote:
> > > >
> > > > Hi,
> > > >
> > > > On Tue, Jul 21, 2020 at 5:10 AM Sumit Garg <sumit.garg@linaro.org> wrote:
> > > > >
> > > > > In a future patch we will add support to the serial core to make it
> > > > > possible to trigger a magic sysrq from an NMI context. Prepare for this
> > > > > by marking some sysrq actions as NMI safe. Safe actions will be allowed
> > > > > to run from NMI context whilst that cannot run from an NMI will be queued
> > > > > as irq_work for later processing.
> > > > >
> > > > > A particular sysrq handler is only marked as NMI safe in case the handler
> > > > > isn't contending for any synchronization primitives as in NMI context
> > > > > they are expected to cause deadlocks. Note that the debug sysrq do not
> > > > > contend for any synchronization primitives. It does call kgdb_breakpoint()
> > > > > to provoke a trap but that trap handler should be NMI safe on
> > > > > architectures that implement an NMI.
> > > > >
> > > > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > > > ---
> > > > >  drivers/tty/sysrq.c       | 33 ++++++++++++++++++++++++++++++++-
> > > > >  include/linux/sysrq.h     |  1 +
> > > > >  kernel/debug/debug_core.c |  1 +
> > > > >  3 files changed, 34 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
> > > > > index 7c95afa9..8017e33 100644
> > > > > --- a/drivers/tty/sysrq.c
> > > > > +++ b/drivers/tty/sysrq.c
> > > > > @@ -50,6 +50,8 @@
> > > > >  #include <linux/syscalls.h>
> > > > >  #include <linux/of.h>
> > > > >  #include <linux/rcupdate.h>
> > > > > +#include <linux/irq_work.h>
> > > > > +#include <linux/kfifo.h>
> > > > >
> > > > >  #include <asm/ptrace.h>
> > > > >  #include <asm/irq_regs.h>
> > > > > @@ -111,6 +113,7 @@ static const struct sysrq_key_op sysrq_loglevel_op = {
> > > > >         .help_msg       = "loglevel(0-9)",
> > > > >         .action_msg     = "Changing Loglevel",
> > > > >         .enable_mask    = SYSRQ_ENABLE_LOG,
> > > > > +       .nmi_safe       = true,
> > > > >  };
> > > > >
> > > > >  #ifdef CONFIG_VT
> > > > > @@ -157,6 +160,7 @@ static const struct sysrq_key_op sysrq_crash_op = {
> > > > >         .help_msg       = "crash(c)",
> > > > >         .action_msg     = "Trigger a crash",
> > > > >         .enable_mask    = SYSRQ_ENABLE_DUMP,
> > > > > +       .nmi_safe       = true,
> > > > >  };
> > > > >
> > > > >  static void sysrq_handle_reboot(int key)
> > > > > @@ -170,6 +174,7 @@ static const struct sysrq_key_op sysrq_reboot_op = {
> > > > >         .help_msg       = "reboot(b)",
> > > > >         .action_msg     = "Resetting",
> > > > >         .enable_mask    = SYSRQ_ENABLE_BOOT,
> > > > > +       .nmi_safe       = true,
> > > > >  };
> > > > >
> > > > >  const struct sysrq_key_op *__sysrq_reboot_op = &sysrq_reboot_op;
> > > > > @@ -217,6 +222,7 @@ static const struct sysrq_key_op sysrq_showlocks_op = {
> > > > >         .handler        = sysrq_handle_showlocks,
> > > > >         .help_msg       = "show-all-locks(d)",
> > > > >         .action_msg     = "Show Locks Held",
> > > > > +       .nmi_safe       = true,
> > > > >  };
> > > > >  #else
> > > > >  #define sysrq_showlocks_op (*(const struct sysrq_key_op *)NULL)
> > > > > @@ -289,6 +295,7 @@ static const struct sysrq_key_op sysrq_showregs_op = {
> > > > >         .help_msg       = "show-registers(p)",
> > > > >         .action_msg     = "Show Regs",
> > > > >         .enable_mask    = SYSRQ_ENABLE_DUMP,
> > > > > +       .nmi_safe       = true,
> > > > >  };
> > > > >
> > > > >  static void sysrq_handle_showstate(int key)
> > > > > @@ -326,6 +333,7 @@ static const struct sysrq_key_op sysrq_ftrace_dump_op = {
> > > > >         .help_msg       = "dump-ftrace-buffer(z)",
> > > > >         .action_msg     = "Dump ftrace buffer",
> > > > >         .enable_mask    = SYSRQ_ENABLE_DUMP,
> > > > > +       .nmi_safe       = true,
> > > > >  };
> > > > >  #else
> > > > >  #define sysrq_ftrace_dump_op (*(const struct sysrq_key_op *)NULL)
> > > > > @@ -538,6 +546,23 @@ static void __sysrq_put_key_op(int key, const struct sysrq_key_op *op_p)
> > > > >                  sysrq_key_table[i] = op_p;
> > > > >  }
> > > > >
> > > > > +#define SYSRQ_NMI_FIFO_SIZE    64
> > > > > +static DEFINE_KFIFO(sysrq_nmi_fifo, int, SYSRQ_NMI_FIFO_SIZE);
> > > >
> > > > A 64-entry FIFO seems excessive. Quite honestly even a FIFO seems a
> > > > bit excessive and it feels like if two sysrqs were received in super
> > > > quick succession that it would be OK to just process the first one.  I
> > > > guess if it simplifies the processing to have a FIFO then it shouldn't
> > > > hurt, but no need for 64 entries.
> > > >
> > >
> > > Okay, would a 2-entry FIFO work here? As here we need a FIFO to pass
> > > on the key parameter.
> >
> > ...or even a 1-entry FIFO if that makes sense?
> >
>
> Yes it would make sense but unfortunately not supported by kfifo
> (size: power of 2).

Typically 1 is considered to be a power of 2 since 2^0 = 1.

...ah, but it appears that size < 2 is not allowed.  Oh well.


> > > > > +static void sysrq_do_nmi_work(struct irq_work *work)
> > > > > +{
> > > > > +       const struct sysrq_key_op *op_p;
> > > > > +       int key;
> > > > > +
> > > > > +       while (kfifo_out(&sysrq_nmi_fifo, &key, 1)) {
> > > > > +               op_p = __sysrq_get_key_op(key);
> > > > > +               if (op_p)
> > > > > +                       op_p->handler(key);
> > > > > +       }
> > > >
> > > > Do you need to manage "suppress_printk" in this function?  Do you need
> > > > to call rcu_sysrq_start() and rcu_read_lock()?
> > >
> > > Ah I missed those. Will add them here instead.
> > >
> > > >
> > > > If so, how do you prevent racing between the mucking we're doing with
> > > > these things and the mucking that the NMI does with them?
> > >
> > > IIUC, here you meant to highlight the race while scheduled sysrq is
> > > executing in IRQ context and we receive a new sysrq in NMI context,
> > > correct? If yes, this seems to be a trickier situation. I think the
> > > appropriate way to handle it would be to deny any further sysrq
> > > handling until the prior sysrq handling is complete, your views?
> >
> > The problem is that in some cases you're running NMIs directly at FIQ
> > time and other cases you're running them at IRQ time.  So you
> > definitely can't just move it to NMI.
> >
> > Skipping looking for other SYSRQs until the old one is complete sounds
> > good to me.  Again my ignorance will make me sound like a fool,
> > probably, but can you use the kfifo as a form of mutual exclusion?  If
> > you have a 1-entry kfifo, maybe:
> >
> > 1. First try to add to the "FIFO".  If it fails (out of space) then a
> > sysrq is in progress.  Ignore this one.
> > 2. Decide if you're NMI-safe or not.
> > 3. If NMI safe, modify "suppress_printk", call rcu functions, then
> > call the handler.  Restore suppress_printk and then dequeue from FIFO.
> > 4. If not-NMI safe, the irq worker would "peek" into the FIFO, do its
> > work (wrapped with "suppress_printk" and the like), and not dequeue
> > until it's done.
> >
> > In the above you'd use the FIFO as a locking mechanism.  I don't know
> > if that's a valid use of it or if there is a better NMI-safe mechanism
> > for this.  I think the kfifo docs talk about only one reader and one
> > writer and here we have two readers, so maybe it's illegal.  It also
> > seems weird to have a 1-entry "FIFO" and feels like there's probably a
> > better data structure for this.
>
> Thanks for your suggestions. Have a look at below implementation, I
> have used 2-entry fifo but only single entry used for locking
> mechanism:
>
> @@ -538,6 +546,39 @@ static void __sysrq_put_key_op(int key, const
> struct sysrq_key_op *op_p)
>                  sysrq_key_table[i] = op_p;
>  }
>
> +#define SYSRQ_NMI_FIFO_SIZE    2
> +static DEFINE_KFIFO(sysrq_nmi_fifo, int, SYSRQ_NMI_FIFO_SIZE);
> +
> +static void sysrq_do_nmi_work(struct irq_work *work)
> +{
> +       const struct sysrq_key_op *op_p;
> +       int orig_suppress_printk;
> +       int key;
> +
> +       orig_suppress_printk = suppress_printk;
> +       suppress_printk = 0;
> +
> +       rcu_sysrq_start();
> +       rcu_read_lock();
> +
> +       if (kfifo_peek(&sysrq_nmi_fifo, &key)) {
> +               op_p = __sysrq_get_key_op(key);
> +               if (op_p)
> +                       op_p->handler(key);
> +       }
> +
> +       rcu_read_unlock();
> +       rcu_sysrq_end();
> +
> +       suppress_printk = orig_suppress_printk;
> +
> +       /* Pop contents from fifo if any */
> +       while (kfifo_get(&sysrq_nmi_fifo, &key))
> +               ;

I think you can use kfifo_reset_out().


> +}
> +
> +static DEFINE_IRQ_WORK(sysrq_nmi_work, sysrq_do_nmi_work);
> +
>  void __handle_sysrq(int key, bool check_mask)
>  {
>         const struct sysrq_key_op *op_p;
> +}
> +
> +static DEFINE_IRQ_WORK(sysrq_nmi_work, sysrq_do_nmi_work);
> +
>  void __handle_sysrq(int key, bool check_mask)
>  {
>         const struct sysrq_key_op *op_p;
> @@ -545,6 +586,10 @@ void __handle_sysrq(int key, bool check_mask)
>         int orig_suppress_printk;
>         int i;
>
> +       /* Skip sysrq handling if one already in progress */
> +       if (!kfifo_is_empty(&sysrq_nmi_fifo))
> +               return;

This _seems_ OK to me since I'd imagine kfifo_is_empty() is as safe
for the writer to do as kfifo_is_full() is and kfifo_is_full() is part
of kfifo_put().

I guess there's no better synchronism mechanism that we can use?


> +
>         orig_suppress_printk = suppress_printk;
>         suppress_printk = 0;
>
> @@ -568,7 +613,13 @@ void __handle_sysrq(int key, bool check_mask)
>                 if (!check_mask || sysrq_on_mask(op_p->enable_mask)) {
>                         pr_info("%s\n", op_p->action_msg);
>                         console_loglevel = orig_log_level;
> -                       op_p->handler(key);
> +
> +                       if (in_nmi() && !op_p->nmi_safe) {
> +                               kfifo_put(&sysrq_nmi_fifo, key);
> +                               irq_work_queue(&sysrq_nmi_work);
> +                       } else {
> +                               op_p->handler(key);
> +                       }
>                 } else {
>                         pr_info("This sysrq operation is disabled.\n");
>                         console_loglevel = orig_log_level;
>
> -Sumit
