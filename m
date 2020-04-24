Return-Path: <SRS0=qPbX=6I=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7475C5518A
	for <linux-serial@archiver.kernel.org>; Fri, 24 Apr 2020 04:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D4F12075A
	for <linux-serial@archiver.kernel.org>; Fri, 24 Apr 2020 04:00:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M2gDZ0zk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725852AbgDXEAQ (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 24 Apr 2020 00:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725816AbgDXEAP (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 24 Apr 2020 00:00:15 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861D3C09B045
        for <linux-serial@vger.kernel.org>; Thu, 23 Apr 2020 21:00:15 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id i27so10166730ota.7
        for <linux-serial@vger.kernel.org>; Thu, 23 Apr 2020 21:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OQlQ+wnlPPSwWGxz5tXdlEB85veCyI0bjca+7B/4SpM=;
        b=M2gDZ0zkPA29rkaYlXI6Liui/LoGfVGgSS0fUKnxBaYab9Gifu73xEteUfQhLeYWot
         fP2OqHtPfht6HZ3iP8vaDS6HFv04SU6XWD/7pGcXQkgNZneClfR5YuGmsy7gjbegawww
         C/VJi4mUjdTuQFY9vSfaueDrZXnG4cbKLeCAotSM1RmSn+xXmWODtE/F+8sG7sgp6zt3
         FvFp2wkOEDgPG1mndoKBLTGYetNFgasY1rnuGZZHrH4+hZ7HnSiS9OClZVnx32HcPGut
         RmEPtvmToC7A5Nwi/Cfv9MbiRQBByqC/7oD3OihOJLYPn5mi3epfi3y4X3qWp+blCunL
         471g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OQlQ+wnlPPSwWGxz5tXdlEB85veCyI0bjca+7B/4SpM=;
        b=mDMySk2vp9Yuz1e5s4U8YOiHbEqARZEQZYW17bx9VTiTAMZr4CfSexSq8WV6fvwgGE
         nu/nbCDfKDd3RJJ4PwN6nvHEaFwriZuY8EGt+Kp3STPlULXQWO5MnGQ727KPwEaYjJ3A
         QOB85qukpnGG3PfJVcko44Xxkfe2u8GiQBhpNVmq1r0+5x3qhsFrEK9u6OxgzpQM8hu6
         jCDgWkqf+qW7fVeGIiPVkPYkse3sCbNPXtkKiy2w7LGH/LYWu3iApL7MmxttuV6OxJUW
         S8mGMlU4MsdktleosvcEnovx0f/xR5DmlVaDbTdPU9ukGhJBX4CGiw6rxgzsKXU/sYSK
         tCdQ==
X-Gm-Message-State: AGi0PuaBRrCMWcr8ndFEH/vO8wQUyYFl+h6Xkqz1BQcDrOP6HuH97JK5
        UfXP6qaaT83FpXWL3KXrgY0StQFJSWys4pLYu+fbtw==
X-Google-Smtp-Source: APiQypIxX1kzvQHlXAr2nzrZpN0ZouDGuzk2aruej4bW/gXfibDVkHVn2aj+k7p5tHa0hlFYNzGUq/3IQNt5/Uj+5Rg=
X-Received: by 2002:a9d:3988:: with SMTP id y8mr5916871otb.352.1587700814858;
 Thu, 23 Apr 2020 21:00:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200423220056.29450-1-john.stultz@linaro.org> <jhj1rodyeu1.mognet@arm.com>
In-Reply-To: <jhj1rodyeu1.mognet@arm.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Thu, 23 Apr 2020 21:00:04 -0700
Message-ID: <CALAqxLWxKfebXTy+p=sbUq3wz8Hx1zMctnuO4H2H2e9LMpcoeA@mail.gmail.com>
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

Hrm. All good points. Obviously from the details above the port->lock
initialization shouldn't be done in the way this patch proposes, but
I'm at a loss as to why we're hitting the issue. My guess is it is
tripping over the console case, but didn't get initialized there
properly?

I'll try to trace through the code to see more about what's going on.

thanks
-john
