Return-Path: <SRS0=mx0D=6J=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD97C2BA19
	for <linux-serial@archiver.kernel.org>; Sat, 25 Apr 2020 04:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B8942076C
	for <linux-serial@archiver.kernel.org>; Sat, 25 Apr 2020 04:05:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xsmyrmaP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbgDYEFG (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 25 Apr 2020 00:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725909AbgDYEFF (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 25 Apr 2020 00:05:05 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E53AC09B049
        for <linux-serial@vger.kernel.org>; Fri, 24 Apr 2020 21:05:04 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id m18so16227301otq.9
        for <linux-serial@vger.kernel.org>; Fri, 24 Apr 2020 21:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5Ky0eyr9lLThTQVUeFvCBClSKtV93JYH6d8kHWt9AbY=;
        b=xsmyrmaPpckFzclp7L+uXkwIuEQPI0AkgTZpagovbHJzVpyzvl7xsdYmVYyYlEd4cE
         AjiV8KyC6Ha79JNisdzpuGRwzhZDpJXvfgeFJuewUZPJkxFcXxCnpGtwPjwdxZGk/71c
         MhbiUOkwdbLhYOuWso0i8s+l+VBZ14EpWPC0/99g+6smIEjGvGvR8os79N2J+lzBtGbR
         s3WnThEwyPG/GrvoUiJvodTdyImCxcINnatR+Ccr/k0wy7rU+6t5f/3q5oiOM8dhPEt4
         OvMoxj3DtqdxI5smzsaTPVQ34HTBrcqo0Qud1AjDjgTzOBI3qqofJIk5n977BDQ7JWP7
         Ve9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5Ky0eyr9lLThTQVUeFvCBClSKtV93JYH6d8kHWt9AbY=;
        b=LVbMVez8GRDfuSSuMiEzvHNGHcT2L5SpSD2EkL/6eGpDTWab6wAlkUYVRru8q++y5H
         vRXP9U9CuhAStryy4q9aMfik50ra3kBuh51FteGXqVzw407gab+v+mVxMNgRV9leeyI9
         /xOHnZFLLxxNuYNuu6RC9prTAvQASAvRiRSnvh0HnAtkGGOVhN01FDMmuwHjOVP7l1b5
         wiD7CLvezoBuTmmDfp+nRuKYQwobMpoQOAT8/Tn+YVP6bYtjdc51nD6DHt4OcXSz7I6s
         whAZQz3FHzOnkx4jAXfkXX/5ZQVggfOt8UqM5u1VwuOxAkVNygWBD+Xqnjq8ZYSacsCC
         BuLg==
X-Gm-Message-State: AGi0PuZmN+VEL4eKT+YmU/dVjJ74ARNxf9DufhIw17V5C1OvNEdDooEh
        lXLSSRLY58GdH8MGpeH4t9V3HMpVwXyAC7Fh/9phbg==
X-Google-Smtp-Source: APiQypJRrNuc6s4TK5Hy1LsXQFO4dVFdba3u8LGcLKEkJWGWHwnmvoiMEq4flU4dqofCtu9E0FvesLWDRf2qIs8Ff5g=
X-Received: by 2002:aca:c311:: with SMTP id t17mr9055910oif.169.1587787503419;
 Fri, 24 Apr 2020 21:05:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200423220056.29450-1-john.stultz@linaro.org> <jhj1rodyeu1.mognet@arm.com>
In-Reply-To: <jhj1rodyeu1.mognet@arm.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Fri, 24 Apr 2020 21:04:50 -0700
Message-ID: <CALAqxLW+CBMxj_5gCF5yLcX8dhM7Fg6oOL-zot0ZZT6PW6R04g@mail.gmail.com>
Subject: Re: [RFC][PATCH] serial: amba-pl011: Make sure we initialize the
 port.lock spinlock
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Apr 23, 2020 at 4:14 PM Valentin Schneider
<valentin.schneider@arm.com> wrote:
> On 23/04/20 23:00, John Stultz wrote:
> > Which seems to be due to the fact that after allocating the uap
> > structure, the pl011 code doesn't initialize the spinlock.
> >
> > This patch fixes it by initializing the spinlock and the warning
> > has gone away.
> >
>
> Thanks for having a look. It does seem like the reasonable thing to do, and
> I no longer get the warning on h960.
>
> That said, I got more curious as this doesn't show up on my Juno (same
> Image). Digging into it I see that uart_add_one_port() has a call to
> uart_port_spin_lock_init() a few lines before uart_configure_port() (in
> which the above warning gets triggered). That thing says:
>
>  * Ensure that the serial console lock is initialised early.
>  * If this port is a console, then the spinlock is already initialised.
>
> Which requires me to ask: are we doing the right thing here?

So I got a little bit of time to look at this before I got pulled off
to other things (and now its Friday night, so I figured I'd reply
before I forget it on Monday).

I did check and lockdep is tripping when we add ttyAMA6 which is the
serial console on the board. I wasn't able to trace back to why we
hadn't already called spin_lock_init() in the console code, but it
seems we haven't.

Also I checked on HiKey as well, and there I'm seeing the same lockdep
splat and this fix seems to resolve it. So more digging is needed. If
anyone has a better idea of what might be awry or if the lock does
need to be initialized in the driver (it's a bit inconsistent, I see
some drivers do but others don't), let me know.

thanks
-john
