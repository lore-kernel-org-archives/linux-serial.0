Return-Path: <SRS0=sLvH=AH=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C324DC433DF
	for <linux-serial@archiver.kernel.org>; Fri, 26 Jun 2020 19:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96223206C3
	for <linux-serial@archiver.kernel.org>; Fri, 26 Jun 2020 19:44:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FyVtaRhf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725780AbgFZToa (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 26 Jun 2020 15:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbgFZTo3 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 26 Jun 2020 15:44:29 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC17C03E979
        for <linux-serial@vger.kernel.org>; Fri, 26 Jun 2020 12:44:29 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id y3so2173641vkg.11
        for <linux-serial@vger.kernel.org>; Fri, 26 Jun 2020 12:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZxCu8SUtTTq6IWvcU9y1tae9qoEzl+cmaMnWtYkj1ug=;
        b=FyVtaRhfzIsKg7jZ07AzYnwr5VUuxLTVfnVYe5LnXFub33erDF0CZaKVMd1unmElsE
         5fmQA14BWPbB08mSY8qFuh7EY2+J884coTp9Nnkkvvscpm/Gcp3RxCgsNh1yePGm4cWo
         TFBW9Ne3rGrNGMCFT0jn+41OvQCAvZQ7WnH+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZxCu8SUtTTq6IWvcU9y1tae9qoEzl+cmaMnWtYkj1ug=;
        b=cHXyyCGejJ6JePbWLijHzYjvAoClfbnCkm7ZRNkioQ6fLJuRvtfK1zy5GUZN0k9YM2
         ZHJxVz1DwnvNnifmKM0SzWmUWAVKXws1Q+9U2B2AeAj432tn5MQMZ/CMDn4dDQ0pduLf
         +57sXDLbjrDLlj9vpJe1QFulzAlXq02VuuFEfjHtfEC+4npe8CqeALE8NOwPrTRuVWOf
         V0oKR6pSxU9vLZZ8L8o2/coxcpgeG7wR0w6Fxh3joHuNgQyzxrkTXXpQabwAGpXnkY46
         fpg6TOPZZ04dc1LRu144mRCJHPMmRhW6ql7gtEhR+N9ee9z56rpWwPfpL4Asq+Ywqwi3
         v+sg==
X-Gm-Message-State: AOAM533xu7+q5U2XbrcyHx6p2cYQYlwgoirmu9RyJQxIGcG3o9OToDuz
        0wy6YUeyM8SNzgFq7esLbDxL/nxl7LQ=
X-Google-Smtp-Source: ABdhPJwNuG64mqaW71UmZtp0U/Oafzual9i+N4tXV5PwNZwgEbf9m4t/GDs6UJX9Zb0xE/9rSCfzBw==
X-Received: by 2002:a05:6122:130b:: with SMTP id e11mr3739477vkp.20.1593200668396;
        Fri, 26 Jun 2020 12:44:28 -0700 (PDT)
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com. [209.85.221.173])
        by smtp.gmail.com with ESMTPSA id m143sm2613604vkm.1.2020.06.26.12.44.27
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jun 2020 12:44:27 -0700 (PDT)
Received: by mail-vk1-f173.google.com with SMTP id h1so2380785vkn.12
        for <linux-serial@vger.kernel.org>; Fri, 26 Jun 2020 12:44:27 -0700 (PDT)
X-Received: by 2002:a1f:280c:: with SMTP id o12mr3115075vko.92.1593200666737;
 Fri, 26 Jun 2020 12:44:26 -0700 (PDT)
MIME-Version: 1.0
References: <1592835984-28613-1-git-send-email-sumit.garg@linaro.org>
 <1592835984-28613-4-git-send-email-sumit.garg@linaro.org> <20200622160300.avgfhnfkpqzqqtsr@holly.lan>
 <CAFA6WYOmQT-OQvjpy1pVPq2mx5S264bJPd-XfwnDY2BjeoWekg@mail.gmail.com> <20200623105934.wvyidi3xgqgd35af@holly.lan>
In-Reply-To: <20200623105934.wvyidi3xgqgd35af@holly.lan>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 26 Jun 2020 12:44:15 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XHZT9ud0Ze1pDvz-kQy7FMFzd9T6+jM5URt1k5BwQ15g@mail.gmail.com>
Message-ID: <CAD=FV=XHZT9ud0Ze1pDvz-kQy7FMFzd9T6+jM5URt1k5BwQ15g@mail.gmail.com>
Subject: Re: [PATCH 3/7] kgdb: Add request_nmi() to the io ops table for kgdboc
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Jiri Slaby <jslaby@suse.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

On Tue, Jun 23, 2020 at 3:59 AM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Tue, Jun 23, 2020 at 02:07:47PM +0530, Sumit Garg wrote:
> > On Mon, 22 Jun 2020 at 21:33, Daniel Thompson
> > <daniel.thompson@linaro.org> wrote:
> > > > +     irq_set_status_flags(irq, IRQ_NOAUTOEN);
> > > > +     res = request_nmi(irq, fn, IRQF_PERCPU, "kgdboc", dev_id);
> > >
> > > Why do we need IRQF_PERCPU here. A UART interrupt is not normally
> > > per-cpu?
> > >
> >
> > Have a look at this comment [1] and corresponding check in
> > request_nmi(). So essentially yes UART interrupt is not normally
> > per-cpu but in order to make it an NMI, we need to request it in
> > per-cpu mode.
> >
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/irq/manage.c#n2112
>
> Thanks! This is clear.
>
> > > > +     if (res) {
> > > > +             res = request_irq(irq, fn, IRQF_SHARED, "kgdboc", dev_id);
> > >
> > > IRQF_SHARED?
> > >
> > > Currrently there is nothing that prevents concurrent activation of
> > > ttyNMI0 and the underlying serial driver. Using IRQF_SHARED means it
> > > becomes possible for both drivers to try to service the same interrupt.
> > > That risks some rather "interesting" problems.
> > >
> >
> > Could you elaborate more on "interesting" problems?
>
> Er... one of the serial drivers we have allowed the userspace to open
> will, at best, be stone dead and not passing any characters.
>
>
> > BTW, I noticed one more problem with this patch that is IRQF_SHARED
> > doesn't go well with IRQ_NOAUTOEN status flag. Earlier I tested it
> > with auto enable set.
> >
> > But if we agree that both shouldn't be active at the same time due to
> > some real problems(?) then I can rid of IRQF_SHARED as well. Also, I
> > think we should unregister underlying tty driver (eg. /dev/ttyAMA0) as
> > well as otherwise it would provide a broken interface to user-space.
>
> I don't have a particular strong opinion on whether IRQF_SHARED is
> correct or not correct since I think that misses the point.
>
> Firstly, using IRQF_SHARED shows us that there is no interlocking
> between kgdb_nmi and the underlying serial driver. That probably tells
> us about the importance of the interlock than about IRQF_SHARED.
>
> To some extent I'm also unsure that kgdb_nmi could ever actually know
> the correct flags to use in all cases (that was another reason for the
> TODO comment about poll_get_irq() being a bogus API).

I do wonder a little bit if the architecture of the "kgdb_nmi_console"
should change.  I remember looking at it in the past and thinking it a
little weird that if I wanted to get it to work I'd need to change my
"console=" command line to go through this new driver and (I guess)
change the agetty I have running on my serial port to point to
ttyNMI0.  Is that how it's supposed to work?  Then if I want to do a
build without kgdb then I need to go in and change my agetty to point
back at my normal serial port?

It kinda feels like a better way to much of what the driver does would be to:

1. Allow kgdb to sniff incoming serial bytes on a port and look for
its characters.  We already have this feature in the kernel to a small
extent for sniffing a break / sysrq character.

2. If userspace doesn't happen to have the serial port open then
ideally we could open the port (using all the standard APIs that
already exist) from in the kernel and just throw away all the bytes
(since we already sniffed them).  As soon as userspace tried to open
the port when it would get ownership and if userspace ever closed the
port then we'd start reading / throwing away bytes again.

If we had a solution like that:

a) No serial drivers would need to change.

b) No kernel command line parameters would need to change.

Obviously that solution wouldn't magically get you an NMI, though.
For that I'd presume the right answer would be to add a parameter for
each serial driver that can support it to run its rx interrupt in NMI
mode.

Of course, perhaps I'm just confused and crazy and the above is a
really bad idea.


Speaking of confused: is there actually any way to use the existing
kgdb NMI driver (CONFIG_SERIAL_KGDB_NMI) in mainline without out of
tree patches?  When I looked before I assumed it was just me that was
outta luck because I didn't have NMI at the time, but I just did some
grepping and I can't find anyplace in mainline where
"arch_kgdb_ops.enable_nmi" would not be NULL.  Did I miss it, or do we
need out-of-tree patches to enable this?


-Doug
