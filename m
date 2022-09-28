Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F91C32771
	for <linux-serial@archiver.kernel.org>; Wed, 28 Sep 2022 23:32:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbiI1Xcc (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 28 Sep 2022 19:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbiI1Xcb (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 28 Sep 2022 19:32:31 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF10B40CE
        for <linux-serial@vger.kernel.org>; Wed, 28 Sep 2022 16:32:30 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id a13so4107530edj.0
        for <linux-serial@vger.kernel.org>; Wed, 28 Sep 2022 16:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=uF9IrSBXhJ+NafdWEMQpitf+4MrXaPHD4le+kTGx+O4=;
        b=k/egANteamWGvHzZM6mSJU1J5xWS4JtZDELXcUYdNowutMFA1UGF/zdvxudAvPaQjE
         rIL3SCaxtxnYeK5c3aFB85eyNiwCBjCMjCE3iFvwyGzUxqznkaept8L4E3FW+/MbfoKA
         U4oH7wwnSNsLQ8/UgPcwe2Ww31SwjsY9bpQRI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=uF9IrSBXhJ+NafdWEMQpitf+4MrXaPHD4le+kTGx+O4=;
        b=ODBmqYmLkIpcwxfeuRX6ikkGKP4JGtlxFJgZfxi9uSYJOVOwkT0sTbptNUp/EtLPLv
         Ofz9deU0OGgNbbPIlFz4RpIibfipgaBIX0kRMniMopFR0d9frCE178KedYA+bE6pM0hG
         +ZrTVpexufhyu7BGPK0djfTFG0M99rrATHpCgfcgGCGmYorouX9ZHYTqaLyENsuUI/EA
         zw7/0y1sKO/MxMCAEZDv1bdEeRtaRniVrGOEOvR0ZYuxTWstO9OkickwfHwqpvc1nyP6
         GQbp3J/H5l30+71/xbyaFf8DHN9++CviWYS4PmHbeipdyVgQXatjT1p16gcMStVFB6IR
         TIfQ==
X-Gm-Message-State: ACrzQf2/dzbQC1s303FvfJvRIv1Ai9kWjmcgynfATFW8MFuoSs1R+lHS
        8D0ryee0PsrICw3NpAaGPJxQGwDrWt9xuSKN
X-Google-Smtp-Source: AMsMyM7ehPh3IK3fP6pqI15aab/uNlNQXW9SksBfg12YBplT6XuS4s6t8sGI35F3tYDZ//Rp1mTyMQ==
X-Received: by 2002:a05:6402:2748:b0:454:762b:154b with SMTP id z8-20020a056402274800b00454762b154bmr453124edd.27.1664407948515;
        Wed, 28 Sep 2022 16:32:28 -0700 (PDT)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com. [209.85.128.51])
        by smtp.gmail.com with ESMTPSA id h7-20020a1709066d8700b0073dbaeb50f6sm3061865ejt.169.2022.09.28.16.32.26
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 16:32:27 -0700 (PDT)
Received: by mail-wm1-f51.google.com with SMTP id fn7-20020a05600c688700b003b4fb113b86so1815464wmb.0
        for <linux-serial@vger.kernel.org>; Wed, 28 Sep 2022 16:32:26 -0700 (PDT)
X-Received: by 2002:a05:600c:1e18:b0:3b3:b9f8:2186 with SMTP id
 ay24-20020a05600c1e1800b003b3b9f82186mr255936wmb.151.1664407946407; Wed, 28
 Sep 2022 16:32:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220924000454.3319186-1-john.ogness@linutronix.de> <20220924000454.3319186-11-john.ogness@linutronix.de>
In-Reply-To: <20220924000454.3319186-11-john.ogness@linutronix.de>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 28 Sep 2022 16:32:15 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U3m_mVLpWna3pgi4=b7OCzUxmKh666g62zPNaB+6QHUA@mail.gmail.com>
Message-ID: <CAD=FV=U3m_mVLpWna3pgi4=b7OCzUxmKh666g62zPNaB+6QHUA@mail.gmail.com>
Subject: Re: [PATCH printk 10/18] kgbd: Pretend that console list walk is safe
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Aaron Tomlin <atomlin@redhat.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

On Fri, Sep 23, 2022 at 5:05 PM John Ogness <john.ogness@linutronix.de> wrote:
>
> From: Thomas Gleixner <tglx@linutronix.de>
>
> Provide a special list iterator macro for KGDB to allow unprotected list
> walks and add a few comments to explain the hope based approach.
>
> Preperatory change for changing the console list to hlist and adding

s/Preperatory/Preparatory

> lockdep asserts to regular list walks.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> ---
>  drivers/tty/serial/kgdboc.c |  5 ++++-
>  include/linux/console.h     | 10 ++++++++++
>  kernel/debug/kdb/kdb_io.c   |  7 ++++++-
>  3 files changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
> index af2aa76bae15..57a5fd27dffe 100644
> --- a/drivers/tty/serial/kgdboc.c
> +++ b/drivers/tty/serial/kgdboc.c
> @@ -462,10 +462,13 @@ static void kgdboc_earlycon_pre_exp_handler(void)
>          * we have no other choice so we keep using it.  Since not all
>          * serial drivers might be OK with this, print a warning once per
>          * boot if we detect this case.
> +        *
> +        * Pretend that walking the console list is safe...

To be fair, this is not quite as unsafe as your comment makes it
sound. kgdb is a "stop the world" debugger and when this function is
executing then all of the other CPUs in the system should have been
rounded up and idle (or, perhaps, busy looping). Essentially as long
as console list manipulation is always made in a way that each
instruction keeps the list in a reasonable state then what kgdb is
doing is actually "safe". Said another way: we could drop into the
debugger at any point when a task is manipulating the console list,
but once we're in the debugger and are executing the "pre_exp_handler"
then all the other CPUs have been frozen in time.


>          */
> -       for_each_console(con)
> +       for_each_console_kgdb(con) {
>                 if (con == kgdboc_earlycon_io_ops.cons)
>                         return;
> +       }
>
>         already_warned = true;
>         pr_warn("kgdboc_earlycon is still using bootconsole\n");
> diff --git a/include/linux/console.h b/include/linux/console.h
> index 24344f9b0bc1..86a6125512b9 100644
> --- a/include/linux/console.h
> +++ b/include/linux/console.h
> @@ -187,6 +187,16 @@ extern void console_list_unlock(void) __releases(console_mutex);
>  #define for_each_console(con)                                          \
>         for (con = console_drivers; con != NULL; con = con->next)
>
> +/**
> + * for_each_console_kgdb() - Iterator over registered consoles for KGDB
> + * @con:       struct console pointer used as loop cursor
> + *
> + * Has no serialization requirements and KGDB pretends that this is safe.
> + * Don't use outside of the KGDB fairy tale land!
> + */
> +#define for_each_console_kgdb(con)                                     \
> +       for (con = console_drivers; con != NULL; con = con->next)
> +
>  extern int console_set_on_cmdline;
>  extern struct console *early_console;
>
> diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
> index 67d3c48a1522..fb3775e61a3b 100644
> --- a/kernel/debug/kdb/kdb_io.c
> +++ b/kernel/debug/kdb/kdb_io.c
> @@ -558,7 +558,12 @@ static void kdb_msg_write(const char *msg, int msg_len)
>                 cp++;
>         }
>
> -       for_each_console(c) {
> +       /*
> +        * This is a completely unprotected list walk designed by the
> +        * wishful thinking department. See the oops_in_progress comment
> +        * below - especially the encourage section...

The reality is also a little less dire here than the comment suggests.
IMO this is actually not the same as the "oops_in_progress" case that
the comment refers to.

Specifically, the "oops_in_progress" is referring to the fact that
it's not uncommon to drop into the debugger when a serial driver (the
same one you're using for kgdb) is holding its lock. Possibly it's
printing something to the tty running on the UART dumping stuff out
from the kernel's console. That's not great and I won't pretend that
the kgdb design is amazing here, but...

Just like above, I don't feel like iterating through the console list
here without holding the lock is necessarily unsafe. Just like above,
all the rest of the CPUs in the system are in a holding pattern and
aren't actively executing any code. While we may have interrupted them
at any given instruction, they won't execute any more instruction
until we leave kgdb and resume running.
