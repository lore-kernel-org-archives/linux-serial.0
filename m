Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C967C47082
	for <linux-serial@archiver.kernel.org>; Sat,  5 Jun 2021 15:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1869260C3F
	for <linux-serial@archiver.kernel.org>; Sat,  5 Jun 2021 15:27:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhFEP3U (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 5 Jun 2021 11:29:20 -0400
Received: from mail-ot1-f46.google.com ([209.85.210.46]:46826 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbhFEP3U (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 5 Jun 2021 11:29:20 -0400
Received: by mail-ot1-f46.google.com with SMTP id 66-20020a9d02c80000b02903615edf7c1aso12071400otl.13;
        Sat, 05 Jun 2021 08:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DSAXBIFY608M+ZvcjqaIQP81snTA88dzSnVRJksgNxw=;
        b=h5L5ffBv0Bv1mMMtb8cVW9Fw4QeacwLhERCCkPsBk+T7SFWjnNm3rq6vMfA+a8Dv+u
         1CLWFXClPcqOUMK+uX2D8IeF8LJxa8IcpIvJL/MqOGOxoSOHHIGrWU2ypPuKTfQuNfEK
         /AVt0L9//1Ao4beG39fukiZUDnadRmbQGKrBFwOzBhQJaTyeU1TU+RlUfZNWToz60bS6
         R1yILl6fCOeXHpY2mhMvicIZ4XeC7qqO7fiw07rhJDPbeL+IWU8l6lhFVzWnE3hzrVIi
         P4KHG9Hub1n9GjnPn+IeeCG1JGT6U8myGPVt9b+v01NG96pMuxskDar4l6ET97J1EasD
         4qEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DSAXBIFY608M+ZvcjqaIQP81snTA88dzSnVRJksgNxw=;
        b=L3KpRui8XsYp/gAXCtCqqGNgzoX+hcpk9X8dN2XCNNn4FxEgvUt0DaOUq0/BUOZHDF
         PlM342lDYmub86yOacNPsY0ltPaVquRbJ7d/OFskKMyqVpVqUmk1q84tLLNHgNfoh+ZW
         LKCd2ctj3zbF90CEiGdiCmcP9hchZ0SqPLnoM7jqC2RUtnsTFiuoKd2y21tvaKWj1qbq
         RKKK21PUBZVXvUrDH+7ipxEeVztb3jlzdWpqheOo+C/uBiXjZ+CiAPq3Hb5Z5GAHlmvw
         cqCg+7UWkjMNfSYDG0mnrEs5JHON3+VgEL454OjqLsBO+do7aPxefuukLL0TVGetgi3A
         cXhw==
X-Gm-Message-State: AOAM532bpdpXxTcgipyiGqd/nA9qmdvV6mJ8Q8UgNu1hinJ3F7qOwu/T
        N7xOcaRSHk3teu3l4HOGzAsQ3pwYwrLlimT9PQ==
X-Google-Smtp-Source: ABdhPJygdbjnM1Q2EtD8ixMF/qr24RRqOWy89xlF1vODzBTaocGEbLKx4XK6se1y2dwoSQfXjTAdWnFxal9VFMQFsyg=
X-Received: by 2002:a9d:4a8a:: with SMTP id i10mr7749479otf.282.1622906777094;
 Sat, 05 Jun 2021 08:26:17 -0700 (PDT)
MIME-Version: 1.0
References: <1622702480-32140-1-git-send-email-zheyuma97@gmail.com> <YLon5kSwPkOh7p/z@kroah.com>
In-Reply-To: <YLon5kSwPkOh7p/z@kroah.com>
From:   Zheyu Ma <zheyuma97@gmail.com>
Date:   Sat, 5 Jun 2021 23:26:04 +0800
Message-ID: <CAMhUBjkqRprZO1BHLo_z2d74BiW75csUKeBJ++2T-y7n4wmEnQ@mail.gmail.com>
Subject: Re: [PATCH] tty: serial: jsm: add checks against NULL pointer dereference
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     jirislaby@kernel.org, linux-serial@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Jun 4, 2021 at 9:17 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Thu, Jun 03, 2021 at 06:41:20AM +0000, Zheyu Ma wrote:
> > In function 'neo_intr', the driver uses 'ch->ch_equeue' and
> > 'ch->ch_reuque'. These two pointers are initialized in 'jsm_tty_open',
> > but the interrupt handler 'neo_intr' has been registered in the probe
> > progress. If 'jsm_tty_open' has not been called at this time, it will
> > cause null pointer dereference.
> >
> > Once the driver registers the interrupt handler, the driver should be
> > ready to handle it.
> >
> > Fix this by checking whether it is a null pointer.
> >
> > This log reveals it:
> >
> > [   50.934983] BUG: kernel NULL pointer dereference, address:
> > 0000000000000000
> > [   50.938297] #PF: supervisor write access in kernel mode
> > [   50.940075] #PF: error_code(0x0002) - not-present page
> > [   50.940460] PGD 0 P4D 0
> > [   50.940654] Oops: 0002 [#1] PREEMPT SMP PTI
> > [   50.940967] CPU: 2 PID: 0 Comm: swapper/2 Not tainted
> > 5.12.4-g70e7f0549188-dirty #97
> > [   50.941554] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
> > BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
> > [   50.942419] RIP: 0010:memcpy_fromio+0x75/0xa0
> > [   50.942759] Code: e9 02 f3 a5 41 f6 c5 02 74 02 66 a5 41 f6 c5 01 74
> > 01 a4 e8 5d 93 6b ff 5b 41 5c 41 5d 5d c3 e8 51 93 6b ff 4c 89 e7 48 89
> > de <a4> 49 89 fc 48 89 f3 49 83 ed 01 eb a4 e8 39 93 6b ff 4c 89 e7 48
> > [   50.944158] RSP: 0018:ffffc90000118df8 EFLAGS: 00010046
> > [   50.944559] RAX: ffff888100258000 RBX: ffffc90007f0030f
> > RCX: 0000000000000000
> > [   50.945114] RDX: 0000000000000000 RSI: ffffc90007f0030f
> > RDI: 0000000000000000
> > [   50.945652] RBP: ffffc90000118e10 R08: 0000000000000000
> > R09: 0000000000000000
> > [   50.946192] R10: 0000000000000000 R11: 0000000000000001
> > R12: 0000000000000000
> > [   50.946729] R13: 0000000000000001 R14: 0000000007f0021e
> > R15: 0000000000000000
> > [   50.947279] FS:  0000000000000000(0000) GS:ffff88817bc80000(0000)
> > knlGS:0000000000000000
> > [   50.947912] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [   50.948346] CR2: 0000000000000000 CR3: 0000000107950000
> > CR4: 00000000000006e0
> > [   50.948892] DR0: 0000000000000000 DR1: 0000000000000000
> > DR2: 0000000000000000
> > [   50.949429] DR3: 0000000000000000 DR6: 00000000fffe0ff0
> > DR7: 0000000000000400
> > [   50.949950] Call Trace:
> > [   50.950138]  <IRQ>
> > [   50.950292]  neo_copy_data_from_uart_to_queue+0x2f7/0x4e0
> > [   50.950694]  neo_intr+0x253/0x7a0
> > [   50.950975]  __handle_irq_event_percpu+0x53/0x3e0
> > [   50.951352]  handle_irq_event_percpu+0x35/0x90
> > [   50.951706]  handle_irq_event+0x39/0x60
> > [   50.951999]  handle_fasteoi_irq+0xc2/0x1d0
> > [   50.952319]  __common_interrupt+0x7f/0x150
> > [   50.952638]  common_interrupt+0xb4/0xd0
> > [   50.952954]  </IRQ>
> > [   50.953136]  asm_common_interrupt+0x1e/0x40
> > [   50.969513] Kernel panic - not syncing: Fatal exception in interrupt
> > [   50.970151] Dumping ftrace buffer:
> > [   50.970420]    (ftrace buffer empty)
> > [   50.970693] Kernel Offset: disabled
> > [   50.970968] Rebooting in 1 seconds..
> >
> > Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
> > ---
> >  drivers/tty/serial/jsm/jsm_neo.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/tty/serial/jsm/jsm_neo.c b/drivers/tty/serial/jsm/jsm_neo.c
> > index bf0e2a4cb0ce..46be0b53ab42 100644
> > --- a/drivers/tty/serial/jsm/jsm_neo.c
> > +++ b/drivers/tty/serial/jsm/jsm_neo.c
> > @@ -716,7 +716,7 @@ static void neo_parse_isr(struct jsm_board *brd, u32 port)
> >               return;
> >
> >       ch = brd->channels[port];
> > -     if (!ch)
> > +     if (!ch || !ch->ch_equeue || !ch->ch_rqueue)
> >               return;
>
> Why not just allocate the memory at probe time and not at open time?
> That would resolve this issue, and probably any other problems that are
> only caused by initializing things at open time.
>
> Once the interrupt is registered, it HAS to be able to be called,
> otherwise it is a driver bug.  This change keeps that broken logic still
> happening and just papers over the obvious crash.
>
> Can you fix this the correct way instead please?
>
> thanks,
>
> greg k-h

Thanks for your review, I have sent the second version of the patch.

Best regards,
Zheyu Ma
