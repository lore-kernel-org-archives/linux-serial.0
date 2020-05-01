Return-Path: <SRS0=20mg=6P=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D61C4724C
	for <linux-serial@archiver.kernel.org>; Fri,  1 May 2020 17:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABBA12166E
	for <linux-serial@archiver.kernel.org>; Fri,  1 May 2020 17:36:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Pn28gEGG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729474AbgEARgK (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 1 May 2020 13:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728951AbgEARgJ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 1 May 2020 13:36:09 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 333F3C061A0E
        for <linux-serial@vger.kernel.org>; Fri,  1 May 2020 10:36:09 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id l25so6715748vso.6
        for <linux-serial@vger.kernel.org>; Fri, 01 May 2020 10:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JmsK3I+QQ1jUjjKc6FqaRkKw2p+mN6s7yBv1CCt+9NU=;
        b=Pn28gEGGnVNlWhBqU4ctoJJsxbfCxDyVFe4hXI/k5poWhig1Eu5EfctfcqE9tWf2zA
         JixurROYNoCAGTck3Oo/7rv1b4EFjBWfjUmsmMZvfkE1LiDnSNu6y0lMpleDMqgKKT/U
         jtt6OvYZ9b3fp7E+i/grqmPghlKQo0NFfXQZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JmsK3I+QQ1jUjjKc6FqaRkKw2p+mN6s7yBv1CCt+9NU=;
        b=o3GqgNUY5qYv8hIC+aUIX9hCAxnbikkaHHhbVoNmLNX6G+eSPIUzrmnVipZlQ5TZaH
         i2JZwaQ+43EdwE/sUNjtSKwX7hTLfLDfeOlsKRYFyiI4hcqMd6kMlMRRyd5Lu3Nzx+QI
         Tear4z7M0eHwvkta9gkZ+qaFHULW+W0t409cuVOBFrpf+eyaa8g1xMGIcGjAg7gjLnhR
         D2s8avnG+jox3IloxwN0qspbytqkCiHFliFZrWUrlVMBcuul2gL8Z9Y2oIxUJhR6vIlk
         3qpRZRX4EXHq3ElfTXcwMLD2uHO1rRkTvbfghsbCIfpjs/RFPHASnnEtmJyy6+gbqxEK
         qTgw==
X-Gm-Message-State: AGi0PuZ1bCyJQgcHubNeCq/p6P/gJHvFatWEo0QyFGRSPLz8n083EXPS
        VvANbMma/hAfg4geqmcWhyzDoJCtCQI=
X-Google-Smtp-Source: APiQypLrv+eYWCu4yzcMMJdemGZQMEv/RWQlb5SV5Xu8+hjjyqTjdYX9LmprSH5jGoAo45GiXpjIVQ==
X-Received: by 2002:a05:6102:208a:: with SMTP id h10mr4185194vsr.13.1588354567636;
        Fri, 01 May 2020 10:36:07 -0700 (PDT)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com. [209.85.222.43])
        by smtp.gmail.com with ESMTPSA id l197sm937253vke.30.2020.05.01.10.36.06
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2020 10:36:06 -0700 (PDT)
Received: by mail-ua1-f43.google.com with SMTP id y10so3971334uao.8
        for <linux-serial@vger.kernel.org>; Fri, 01 May 2020 10:36:06 -0700 (PDT)
X-Received: by 2002:ab0:b13:: with SMTP id b19mr3764969uak.91.1588354566196;
 Fri, 01 May 2020 10:36:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200430095819.1.Id37f71c69eb21747b9d9e2c7c242be130814b362@changeid>
 <20200501114943.ioetuxe24gi27bll@holly.lan>
In-Reply-To: <20200501114943.ioetuxe24gi27bll@holly.lan>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 1 May 2020 10:35:54 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V72b8UaQBst3UHBURXbFne0dmuGgN6vSc2dajELJFNew@mail.gmail.com>
Message-ID: <CAD=FV=V72b8UaQBst3UHBURXbFne0dmuGgN6vSc2dajELJFNew@mail.gmail.com>
Subject: Re: [PATCH] kgdboc: Be a bit more robust about handling earlycon leaving
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        kgdb-bugreport@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

On Fri, May 1, 2020 at 4:49 AM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Thu, Apr 30, 2020 at 09:59:09AM -0700, Douglas Anderson wrote:
> > The original implementation of kgdboc_earlycon included a comment
> > about how it was impossible to get notified about the boot console
> > going away without making changes to the Linux core.  Since folks
> > often don't want to change the Linux core for kgdb's purposes, the
> > kgdboc_earlycon implementation did a bit of polling to figure out when
> > the boot console went away.
> >
> > It turns out, though, that it is possible to get notified about the
> > boot console going away.  The solution is either clever or a hack
> > depending on your viewpoint.  ...or, perhaps, a clever hack.  All we
> > need to do is head-patch the "exit" routine of the boot console.  We
> > know that "struct console" must be writable because it has a "next"
> > pointer in it, so we can just put our own exit routine in, do our
> > stuff, and then call back to the original.
>
> I think I'm in the hack camp on this one!

LOL.  We can drop it if need be and wait to see if someone actually
ends up in the dead-zone.  Though I gotta earn the name "kernel
hacker" somehow, no?  ;-)


> > This works great to get notified about the boot console going away.
> > The (slight) problem is that in the context of the boot console's exit
> > routine we can't call tty_find_polling_driver().
>
> I presume this is something to do with the tty_mutex?

Actually, no.

trying to acquire lock:
ffffff81b34436a8 (&port->mutex){+.+.}-{3:3}, at: uart_poll_init+0x70/0x164
but task is already holding lock:
ffffff81b34436a8 (&port->mutex){+.+.}-{3:3}, at: uart_add_one_port+0x84/0x49c

Here's the stack (I just put a call to kgdboc_earlycon_exit_work_fn()
straight into kgdboc_earlycon_trap_exit() to reproduce which is why it
still looks like there's a worker:

uart_poll_init+0x70/0x164
tty_find_polling_driver+0x130/0x18c
configure_kgdboc+0x9c/0x164
kgdboc_earlycon_exit_work_fn+0x30/0x5c
kgdboc_earlycon_trap_exit+0x1c/0x4c
unregister_console+0xd4/0x100
register_console+0x374/0x39c
uart_add_one_port+0x418/0x49c
qcom_geni_serial_probe+0x230/0x330

If we continue on this patch I'll add it to the commit message.


> > We solve this by
> > kicking off some work on the system_wq when we get notified and this
> > works pretty well.
>
> There are some problems with the workqueue approach.
>
> Firstly, its runs too early on many systems (esp. those that register
> the console from a console initcall. kgdboc cannot find the tty, I think
> because the console is registered a long time before the corresponding
> tty comes up.

Ah, I see.  So the normal console comes along an inits and kicks the
boot console out but the tty isn't there yet.  :(  I guess my solution
only works if uart_add_one_port() is used and we hit this case in
uart_configure_port():

/*
 * If this driver supports console, and it hasn't been
 * successfully registered yet, try to re-register it.
 * It may be that the port was not available.
 */

...if you've done something to register the console earlier then
you're outta luck.  I'm not sure there's a ton we can do here.  I
don't think we can really transition over to running kgdb on the main
console because, if nothing else, the write() function for those tend
to grab "uport->lock" which doesn't seem like it's always safe.  Then
there'd be the problem of adding read() to all these consoles and
assuming it's non-blocking.

I feel like maybe the best that can be done is, now that earlycon
works as well as it does, to suggest that people _stop_ trying to
register their main console so early.  ;-)

(OK, now that I've read your 2nd message I guess there is something we
can do: keep using the boot console).


In general, though, my patch shouldn't necessarily make anything
_worse_ for you.  When the boot console's exit() routine is called
then you really can't use it any more.  It shouldn't hurt to check if
the TTY is available so we can switch right away.  I guess if your
case is common, though, we'd maybe want to get rid of the
cleanup_earlycon() in kgdboc_earlycon_exit_work_fn() because if you
attached gdb in kgdb_earlycon the debug_core will throw its hissyfit.
We can just cross our fingers and hope the TTY comes along before we
end up in the debugger again.


> Secondly I am seeing warnings related to the tty_mutex where the
> might_sleep() machinery ends up flushing the active workqueue.
>
> [   39.298332] ------------[ cut here ]------------
> [   39.298332] WARNING: CPU: 0 PID: 5 at kernel/workqueue.c:3033 __flush_work+00
> [   39.298332] Modules linked in:
> [   39.298332] CPU: 0 PID: 5 Comm: kworker/0:0 Not tainted 5.7.0-rc3+ #47
> [   39.298332] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ?-204
> [   39.298332] Workqueue: events kgdboc_earlycon_exit_work_fn
> [   39.298332] RIP: 0010:__flush_work+0x19c/0x1c0
> [   39.298332] Code: 4c 8b 6d 20 e9 06 ff ff ff 41 c6 04 24 00 fb 45 31 f6 eb 8f
> [   39.298332] RSP: 0018:ffff993500033dd0 EFLAGS: 00010246
> [   39.298332] RAX: 0000000000000000 RBX: ffffffffadcd0720 RCX: 0000000000000001
> [   39.298332] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffffadcd0820
> [   39.298332] RBP: ffff8a633ec299c0 R08: 0000000000000000 R09: 0000000000000001
> [   39.298332] R10: 000000000000000a R11: f000000000000000 R12: 00000000ffffffed
> [   39.298332] R13: ffff8a633e408840 R14: 0000000000000000 R15: ffff8a633e408840
> [   39.298332] FS:  0000000000000000(0000) GS:ffff8a633ec00000(0000) knlGS:00000
> [   39.298332] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   39.298332] CR2: ffff8a6333201000 CR3: 0000000032a0a000 CR4: 00000000000006f0
> [   39.298332] Call Trace:
> [   39.298332]  ? _cond_resched+0x10/0x20
> [   39.298332]  ? mutex_lock+0x9/0x30
> [   39.298332]  ? tty_find_polling_driver+0x134/0x1a0
> [   39.298332]  configure_kgdboc+0x12d/0x1c0
> [   39.298332]  kgdboc_earlycon_exit_work_fn+0x1a/0x40
> [   39.298332]  process_one_work+0x1d3/0x380
> [   39.298332]  worker_thread+0x45/0x3c0
> [   39.298332]  kthread+0xf6/0x130
> [   39.298332]  ? process_one_work+0x380/0x380
> [   39.298332]  ? kthread_park+0x80/0x80
> [   39.298332]  ret_from_fork+0x22/0x40
> [   39.298332] ---[ end trace 1190f578d6e11204 ]---
> [   39.298338] KGDB: Unregistered I/O driver kgdboc_earlycon, debugger disabled

This is weird.  Why don't I see this?  Oh, I see.  It's because your
console is replacing the boot console so early so "workqueue_init"
hasn't run yet.  Mine happens much, much later.

...I can try to dig more if we want to continue going down this path,
but in general it should be fine to grab a mutex on a worker, right?
...and the workers shouldn't start running until it's safe to run?  Is
this just a race where we don't set "wq_online = true" early enough
and pending work has run or something?  Maybe if you drop into the
debugger at the time of this warning you'll find that some other task
is running and somewhere midway though workqueue_init()?

-Doug
