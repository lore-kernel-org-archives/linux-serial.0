Return-Path: <SRS0=hLv5=BX=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 253EBC433DF
	for <linux-serial@archiver.kernel.org>; Thu, 13 Aug 2020 00:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7B742087C
	for <linux-serial@archiver.kernel.org>; Thu, 13 Aug 2020 00:00:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cADRa2L+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgHMAAG (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 12 Aug 2020 20:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbgHMAAD (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 12 Aug 2020 20:00:03 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B10CC061383
        for <linux-serial@vger.kernel.org>; Wed, 12 Aug 2020 17:00:02 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id k25so2007849vsm.11
        for <linux-serial@vger.kernel.org>; Wed, 12 Aug 2020 17:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YZ0DPU+7FEgTW1kdKvFkaE475aoyAvXltQCD2JpTtaU=;
        b=cADRa2L+LNtmOC8nGDW4NEBh1LKPUNQBVbSJ2lRlPO7/ex575XERs6bkt8ye0WQ36q
         nKfPHAfk093ngCTZeIOX3r4GXkJbFYEonLHqKYPfvuBmjEDniJ+DDci92BugIbisNdPp
         AwJF9BUpjxQHhED+vrE0T9EHVEbtGvjX8N8kc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YZ0DPU+7FEgTW1kdKvFkaE475aoyAvXltQCD2JpTtaU=;
        b=XArhXP1JlGW6Um0xtrfR0tgvHrk5YssynO0wzCNkxx4VXywx7XJfKjodFZEYvB+Cvq
         39z9DHADlj4l0lb2p6eMEmSWo4iOvJtXAVM5wSBVWpHEElWrkKPmdfhh0C/RnAsjNY5b
         A0A7SFNSSeWINQ0ETf3SwM9Kn2bdhLQv+RzI1SDCweOk6nXICflfQEoFtyagyZgQn0vg
         yhCBel8z5kektm4sMUv/zDrznPiBRJu09Sbw2cPKIYWBy/Un3clLJcfc/s/kwWWM19wx
         okhS1jFSKVcC3gNrpfCl90Pp/eJhLxXrblpCQ/1zdUnolnDyXb68sXKhg2T5mi7bDVXU
         EOrw==
X-Gm-Message-State: AOAM533SO6CdBNBkaQRxilD4rY0C7j/PKvugjbVNp2xBMmFF2smkKE6+
        Nt/Zc/uUVIe0iSlsBwSUWw0yrgZb0Zs=
X-Google-Smtp-Source: ABdhPJw078HREfJGsw2NND9qj2G4aZKDbupJsUS1m+U+ntuAp6XDB9bD/5IuPB51R3vf2xNZ/mieOQ==
X-Received: by 2002:a67:43c7:: with SMTP id q190mr1271450vsa.193.1597276801291;
        Wed, 12 Aug 2020 17:00:01 -0700 (PDT)
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com. [209.85.221.169])
        by smtp.gmail.com with ESMTPSA id 1sm356528uaq.1.2020.08.12.17.00.00
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2020 17:00:00 -0700 (PDT)
Received: by mail-vk1-f169.google.com with SMTP id s81so896609vkb.3
        for <linux-serial@vger.kernel.org>; Wed, 12 Aug 2020 17:00:00 -0700 (PDT)
X-Received: by 2002:a1f:fc02:: with SMTP id a2mr1543414vki.65.1597276799887;
 Wed, 12 Aug 2020 16:59:59 -0700 (PDT)
MIME-Version: 1.0
References: <1595333413-30052-1-git-send-email-sumit.garg@linaro.org> <1595333413-30052-2-git-send-email-sumit.garg@linaro.org>
In-Reply-To: <1595333413-30052-2-git-send-email-sumit.garg@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 12 Aug 2020 16:59:48 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Uqi28A=sm5+JhAqBM2OtBM3_XwvvkaKyEDVL9uVEioog@mail.gmail.com>
Message-ID: <CAD=FV=Uqi28A=sm5+JhAqBM2OtBM3_XwvvkaKyEDVL9uVEioog@mail.gmail.com>
Subject: Re: [RFC 1/5] tty/sysrq: Make sysrq handler NMI aware
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

On Tue, Jul 21, 2020 at 5:10 AM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> In a future patch we will add support to the serial core to make it
> possible to trigger a magic sysrq from an NMI context. Prepare for this
> by marking some sysrq actions as NMI safe. Safe actions will be allowed
> to run from NMI context whilst that cannot run from an NMI will be queued
> as irq_work for later processing.
>
> A particular sysrq handler is only marked as NMI safe in case the handler
> isn't contending for any synchronization primitives as in NMI context
> they are expected to cause deadlocks. Note that the debug sysrq do not
> contend for any synchronization primitives. It does call kgdb_breakpoint()
> to provoke a trap but that trap handler should be NMI safe on
> architectures that implement an NMI.
>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>  drivers/tty/sysrq.c       | 33 ++++++++++++++++++++++++++++++++-
>  include/linux/sysrq.h     |  1 +
>  kernel/debug/debug_core.c |  1 +
>  3 files changed, 34 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
> index 7c95afa9..8017e33 100644
> --- a/drivers/tty/sysrq.c
> +++ b/drivers/tty/sysrq.c
> @@ -50,6 +50,8 @@
>  #include <linux/syscalls.h>
>  #include <linux/of.h>
>  #include <linux/rcupdate.h>
> +#include <linux/irq_work.h>
> +#include <linux/kfifo.h>
>
>  #include <asm/ptrace.h>
>  #include <asm/irq_regs.h>
> @@ -111,6 +113,7 @@ static const struct sysrq_key_op sysrq_loglevel_op = {
>         .help_msg       = "loglevel(0-9)",
>         .action_msg     = "Changing Loglevel",
>         .enable_mask    = SYSRQ_ENABLE_LOG,
> +       .nmi_safe       = true,
>  };
>
>  #ifdef CONFIG_VT
> @@ -157,6 +160,7 @@ static const struct sysrq_key_op sysrq_crash_op = {
>         .help_msg       = "crash(c)",
>         .action_msg     = "Trigger a crash",
>         .enable_mask    = SYSRQ_ENABLE_DUMP,
> +       .nmi_safe       = true,
>  };
>
>  static void sysrq_handle_reboot(int key)
> @@ -170,6 +174,7 @@ static const struct sysrq_key_op sysrq_reboot_op = {
>         .help_msg       = "reboot(b)",
>         .action_msg     = "Resetting",
>         .enable_mask    = SYSRQ_ENABLE_BOOT,
> +       .nmi_safe       = true,
>  };
>
>  const struct sysrq_key_op *__sysrq_reboot_op = &sysrq_reboot_op;
> @@ -217,6 +222,7 @@ static const struct sysrq_key_op sysrq_showlocks_op = {
>         .handler        = sysrq_handle_showlocks,
>         .help_msg       = "show-all-locks(d)",
>         .action_msg     = "Show Locks Held",
> +       .nmi_safe       = true,
>  };
>  #else
>  #define sysrq_showlocks_op (*(const struct sysrq_key_op *)NULL)
> @@ -289,6 +295,7 @@ static const struct sysrq_key_op sysrq_showregs_op = {
>         .help_msg       = "show-registers(p)",
>         .action_msg     = "Show Regs",
>         .enable_mask    = SYSRQ_ENABLE_DUMP,
> +       .nmi_safe       = true,
>  };
>
>  static void sysrq_handle_showstate(int key)
> @@ -326,6 +333,7 @@ static const struct sysrq_key_op sysrq_ftrace_dump_op = {
>         .help_msg       = "dump-ftrace-buffer(z)",
>         .action_msg     = "Dump ftrace buffer",
>         .enable_mask    = SYSRQ_ENABLE_DUMP,
> +       .nmi_safe       = true,
>  };
>  #else
>  #define sysrq_ftrace_dump_op (*(const struct sysrq_key_op *)NULL)
> @@ -538,6 +546,23 @@ static void __sysrq_put_key_op(int key, const struct sysrq_key_op *op_p)
>                  sysrq_key_table[i] = op_p;
>  }
>
> +#define SYSRQ_NMI_FIFO_SIZE    64
> +static DEFINE_KFIFO(sysrq_nmi_fifo, int, SYSRQ_NMI_FIFO_SIZE);

A 64-entry FIFO seems excessive. Quite honestly even a FIFO seems a
bit excessive and it feels like if two sysrqs were received in super
quick succession that it would be OK to just process the first one.  I
guess if it simplifies the processing to have a FIFO then it shouldn't
hurt, but no need for 64 entries.


> +static void sysrq_do_nmi_work(struct irq_work *work)
> +{
> +       const struct sysrq_key_op *op_p;
> +       int key;
> +
> +       while (kfifo_out(&sysrq_nmi_fifo, &key, 1)) {
> +               op_p = __sysrq_get_key_op(key);
> +               if (op_p)
> +                       op_p->handler(key);
> +       }

Do you need to manage "suppress_printk" in this function?  Do you need
to call rcu_sysrq_start() and rcu_read_lock()?

If so, how do you prevent racing between the mucking we're doing with
these things and the mucking that the NMI does with them?


> +}
> +
> +static DEFINE_IRQ_WORK(sysrq_nmi_work, sysrq_do_nmi_work);
> +
>  void __handle_sysrq(int key, bool check_mask)
>  {
>         const struct sysrq_key_op *op_p;
> @@ -568,7 +593,13 @@ void __handle_sysrq(int key, bool check_mask)
>                 if (!check_mask || sysrq_on_mask(op_p->enable_mask)) {
>                         pr_info("%s\n", op_p->action_msg);
>                         console_loglevel = orig_log_level;
> -                       op_p->handler(key);
> +
> +                       if (in_nmi() && !op_p->nmi_safe) {
> +                               kfifo_in(&sysrq_nmi_fifo, &key, 1);

Rather than kfifo_in() and kfifo_out(), I think you can use
kfifo_put() and kfifo_get().  As I understand it those just get/put
one element which is what you want.


> +                               irq_work_queue(&sysrq_nmi_work);

Wishful thinking, but (as far as I can tell) irq_work_queue() only
queues work on the CPU running the NMI.  I don't have lots of NMI
experience, but any chance there is a variant that will queue work on
any CPU?  Then sysrq handlers that aren't NMI aware will be more
likely to work.




> +                       } else {
> +                               op_p->handler(key);
> +                       }
>                 } else {
>                         pr_info("This sysrq operation is disabled.\n");
>                         console_loglevel = orig_log_level;
> diff --git a/include/linux/sysrq.h b/include/linux/sysrq.h
> index 3a582ec..630b5b9 100644
> --- a/include/linux/sysrq.h
> +++ b/include/linux/sysrq.h
> @@ -34,6 +34,7 @@ struct sysrq_key_op {
>         const char * const help_msg;
>         const char * const action_msg;
>         const int enable_mask;
> +       const bool nmi_safe;
>  };
>
>  #ifdef CONFIG_MAGIC_SYSRQ
> diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
> index 9e59347..2b51173 100644
> --- a/kernel/debug/debug_core.c
> +++ b/kernel/debug/debug_core.c
> @@ -943,6 +943,7 @@ static const struct sysrq_key_op sysrq_dbg_op = {
>         .handler        = sysrq_handle_dbg,
>         .help_msg       = "debug(g)",
>         .action_msg     = "DEBUG",
> +       .nmi_safe       = true,
>  };
>  #endif
>
> --
> 2.7.4
>
