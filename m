Return-Path: <SRS0=20mg=6P=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D1CC47257
	for <linux-serial@archiver.kernel.org>; Fri,  1 May 2020 17:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 013112166E
	for <linux-serial@archiver.kernel.org>; Fri,  1 May 2020 17:36:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KBM/6NPc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729917AbgEARg3 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 1 May 2020 13:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729725AbgEARg2 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 1 May 2020 13:36:28 -0400
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFCABC061A0E
        for <linux-serial@vger.kernel.org>; Fri,  1 May 2020 10:36:28 -0700 (PDT)
Received: by mail-vk1-xa41.google.com with SMTP id 10so2862401vkr.7
        for <linux-serial@vger.kernel.org>; Fri, 01 May 2020 10:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TA6stwlQtMs0s5sdi3+tZ1ygYla8dV/bmC8ohmequGA=;
        b=KBM/6NPcoPyp2XNp6JUEX0Xt3PKjJ4OeWDSYAI2ClnarZon9yxFPFl0VQ1Z9H+zyGX
         7H7FRh2pe/8P19+PEzHcCgj2mDQkmWTZTnHkastnytPBWT6e2Zv/spgFa23CPQY0iA4z
         tkPgdfzL0pxE3paW1H2UbOMPQjNB308rhBS6E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TA6stwlQtMs0s5sdi3+tZ1ygYla8dV/bmC8ohmequGA=;
        b=mkaPbepFSbB0nWuui63KgaKRxZn9PqrKSQSC3IGqyJZMWQvxS3cCQpabNQBN2IUkSL
         l8eWa40fGtGtY1TvpZMHOyZRvf3wU2Gegz2F6sZyiDetsCN9gMRby9PrqOThIzJa1HC6
         STc1oqGXe1xoIPrDZqbu1PAHTpe34eOi9uf1OlUknDjx3FcIIMddFlKcAUx+OVhPG61v
         +e+qfYi29SRLIOZ67d1z21EPS8k8ugCvCl7D6FH+Wfp7PMPxSdtZ7FN1URmY/1GdyLK/
         9q4EewXc7ZbXn/0VKuZQ1qe8FgrfrDxjOnt1ra8QGmVHm0qx0hPKSMwjPDHnNahAZQ7v
         yeqQ==
X-Gm-Message-State: AGi0PuY8687M+Gdl8SubzyKAJpaNAbigUis2DTxl/7eztustV+hUfQ3a
        Q3Jv7I5LWtWkMKB9exQhPE6kxUZL3x0=
X-Google-Smtp-Source: APiQypIhu7k8rhqQWljO49jRqnPe1KYnmunXTQwq7P/Vx71kgjwnKCMvf2MkbJgG5zmPT39qngglFA==
X-Received: by 2002:a1f:2142:: with SMTP id h63mr3442298vkh.85.1588354587494;
        Fri, 01 May 2020 10:36:27 -0700 (PDT)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id r136sm959872vkf.35.2020.05.01.10.36.26
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2020 10:36:26 -0700 (PDT)
Received: by mail-ua1-f41.google.com with SMTP id m9so3936631uaq.12
        for <linux-serial@vger.kernel.org>; Fri, 01 May 2020 10:36:26 -0700 (PDT)
X-Received: by 2002:a9f:27ca:: with SMTP id b68mr3831812uab.8.1588354586095;
 Fri, 01 May 2020 10:36:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200430095819.1.Id37f71c69eb21747b9d9e2c7c242be130814b362@changeid>
 <20200501114943.ioetuxe24gi27bll@holly.lan> <20200501133202.GA2402281@wychelm.lan>
In-Reply-To: <20200501133202.GA2402281@wychelm.lan>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 1 May 2020 10:36:14 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WKKCkr1va9S+ygL7XuOvSm12-qw4dCSo=FBtyXx4JvhQ@mail.gmail.com>
Message-ID: <CAD=FV=WKKCkr1va9S+ygL7XuOvSm12-qw4dCSo=FBtyXx4JvhQ@mail.gmail.com>
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

On Fri, May 1, 2020 at 6:32 AM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Fri, May 01, 2020 at 12:49:43PM +0100, Daniel Thompson wrote:
> > On Thu, Apr 30, 2020 at 09:59:09AM -0700, Douglas Anderson wrote:
> > > The original implementation of kgdboc_earlycon included a comment
> > > about how it was impossible to get notified about the boot console
> > > going away without making changes to the Linux core.  Since folks
> > > often don't want to change the Linux core for kgdb's purposes, the
> > > kgdboc_earlycon implementation did a bit of polling to figure out when
> > > the boot console went away.
> > >
> > > It turns out, though, that it is possible to get notified about the
> > > boot console going away.  The solution is either clever or a hack
> > > depending on your viewpoint.  ...or, perhaps, a clever hack.  All we
> > > need to do is head-patch the "exit" routine of the boot console.  We
> > > know that "struct console" must be writable because it has a "next"
> > > pointer in it, so we can just put our own exit routine in, do our
> > > stuff, and then call back to the original.
> >
> > I think I'm in the hack camp on this one!
> >
> >
> > > This works great to get notified about the boot console going away.
> > > The (slight) problem is that in the context of the boot console's exit
> > > routine we can't call tty_find_polling_driver().
> >
> > I presume this is something to do with the tty_mutex?
> > > We solve this by
> > > kicking off some work on the system_wq when we get notified and this
> > > works pretty well.
> >
> > There are some problems with the workqueue approach.
>
> ... so did a couple of experiments to avoid the workqueue.
>
> It occured to me that, since we have interfered with deinit() then the
> console hasn't actually been uninitialized meaning we could still use it.
> This does exposes us to risks similar to keep_bootcon but in exchange
> there is no window where kgdb is broken (and no need to panic).
>
> My prototype is minimal but I did wonder about ripping out all the
> code to defend against removal of the earlycon and simply keep the
> earlycon around until a new kgdbio handler is installed.

It took me a little while, but I finally see what you're saying.
You're saying that we keep calling into the boot console even though
it's no longer in the list of consoles.  Then we temporarily disable
the boot console's exit routine until kgdb_earlycon() is done.  (side
note: the exit routine was recently added and probably most consoles
don't use it).

OK, that doesn't seem totally insane.  It actually works OK for you?

It's probably at least worth a warning in the log if we detect that
we're using the boot console and it's not in the console list anymore.
Then if kgdb starts misbehaving someone might have a clue.

If your solution is OK we might also want to remove the call to
cleanup_earlycon_if_invalid() in configure_kgdboc() too.

I think you might win the "hackiest solution" prize, but your solution
definitely does seem better because I can't think of any other good
way to handle people whose consoles register a long time before their
tty.  ;-)


-Doug
