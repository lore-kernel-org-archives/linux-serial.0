Return-Path: <SRS0=xWBg=BY=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3DD1C433E1
	for <linux-serial@archiver.kernel.org>; Fri, 14 Aug 2020 12:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABFF72087D
	for <linux-serial@archiver.kernel.org>; Fri, 14 Aug 2020 12:50:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dRkTj42r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbgHNMuU (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 14 Aug 2020 08:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726209AbgHNMuS (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 14 Aug 2020 08:50:18 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7545AC061384
        for <linux-serial@vger.kernel.org>; Fri, 14 Aug 2020 05:50:18 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id y2so781077ljc.1
        for <linux-serial@vger.kernel.org>; Fri, 14 Aug 2020 05:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oNrJofI4VSIM1YMzNApXQ6u0hlAa3YOeI7FwPv0W0xo=;
        b=dRkTj42r1ORWNCi0KwgABypOpxNH2YfxXSplKDrbKISe72oY7nKYANmkrXI7TtKY3n
         FWkBYRoaG+R3/7Eh6gST6LtxiWqxoQ1nnN/qdQ9Knst1jUzHDduf2/YG0bhDHTtvLjkS
         DBtUfpz7eYBCI85lLB3Rw7TkYRda85x+si9K8QaSMd4wEoLUDF/zI32+bvFkkArZLn2b
         lZ0LOGC3YD0UVakzKaVLrc7hDjHoQc8aEgGCpfrRHGeL+cc/bztqeYVArmzbPYRg/pBR
         wmtPaXdqENs54CoXQf69SlfWc9fyGj+wCEIJ0Ft9yWLyfQq98qCaRGUS6iUCHvOBLvZY
         YI2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oNrJofI4VSIM1YMzNApXQ6u0hlAa3YOeI7FwPv0W0xo=;
        b=Ki4eSozzjYn3HHfsxy8mg9ioipdAUh1KhSU8eilNEFpb/Bz3XpMHtuT3LV0p7kvGnp
         fJqr0neH5uoiu1LGqaxvOuoXZsS1Z3Z0sYBLNRMZtDCTEDD5ud3ymLvzBd+LbOjYJivq
         7C1uuN+KRTIfXyKzvlM/kF9dAm8QGG1eAuY2FUqzrSnoVov1CfTP6AlAQNjkdLNpmJVd
         S+4fCxDjwapaTg0d1PMfwYl14P8QXCy1wD3zuV8UkZHMcdyO3uVV+RZa0UxsYo/Hepas
         twx2hRfcwrrkVqYU4Kh+siCamq8Qr9Vbqzpb1FBdBvSxkVjmuBjs/f4GptRWV65e11Lr
         niQQ==
X-Gm-Message-State: AOAM5329qJ6l5jNh6aUtWhEC50GQLLRyhClkkoYjWs14/1yUcetHKLZ9
        Xjz67GT4C++C2dEfRk7aYqSG4JFKkUW/Extcl8vmKQ==
X-Google-Smtp-Source: ABdhPJx+l2dECJh1QpeXm78A5+o8DyQZpif8ELQbqtHLPbnrx54NFZfHtESmhBFMjh1+R+HViwIbf0fFv25NmToqJpU=
X-Received: by 2002:a2e:b8cb:: with SMTP id s11mr1353447ljp.110.1597409416937;
 Fri, 14 Aug 2020 05:50:16 -0700 (PDT)
MIME-Version: 1.0
References: <1595333413-30052-1-git-send-email-sumit.garg@linaro.org>
 <CAFA6WYMN=na4Pxnu1LYRVAAZRdV==5EwU-Vcq-QkRb_jaLiPmw@mail.gmail.com>
 <20200811135801.GA416071@kroah.com> <CAFA6WYMN8i96rEZuHLnskB+4k0o=K9vF1_we83P04h2BSoGjmQ@mail.gmail.com>
 <20200811145816.GA424033@kroah.com> <CAD=FV=UD=cTn6jwpYS-C-=1ORd-4azZ8ZiBR6om++2sMS1nmMg@mail.gmail.com>
 <CAFA6WYPBdOiVsKR_hSLpigN_1b9jimXKaqyRZjvKSx3xpAmLjA@mail.gmail.com>
 <CAD=FV=WccmFRkV4UUTLSYR9+7210h00Si=nG4tRs3BBuweA6ng@mail.gmail.com>
 <CAD=FV=V8UhQVQvcAp6XCmT3=6FYM=_zPELy4FTj4kMKUswaR8Q@mail.gmail.com>
 <CAFA6WYPxieH6ZTa_BFdaLuiwbqAs6r7eKmxG7ci4XtyRONGN7g@mail.gmail.com> <CAD=FV=WGh-+GTsg3-UDr-Ht48n3sRqAJ76PJVFcFuJ1ruFEqOw@mail.gmail.com>
In-Reply-To: <CAD=FV=WGh-+GTsg3-UDr-Ht48n3sRqAJ76PJVFcFuJ1ruFEqOw@mail.gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Fri, 14 Aug 2020 18:20:05 +0530
Message-ID: <CAFA6WYPOF6_+jxG+PCtUS1BHPsnzYtAHmcWRMpMnvorQQ+M3wg@mail.gmail.com>
Subject: Re: [RFC 0/5] Introduce NMI aware serial drivers
To:     Doug Anderson <dianders@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linux-serial@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net,
        Jiri Slaby <jslaby@suse.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Jason Wessel <jason.wessel@windriver.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, 13 Aug 2020 at 20:56, Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Thu, Aug 13, 2020 at 2:25 AM Sumit Garg <sumit.garg@linaro.org> wrote:
> >
> > > One other idea occurred to me that's maybe simpler.  You could in
> > > theory just poll the serial port periodically to accomplish.  It would
> > > actually probably even work to call the normal serial port interrupt
> > > routine from any random CPU.  On many serial drivers the entire
> > > interrupt handler is wrapped with:
> > >
> > > spin_lock_irqsave(&uap->port.lock, flags);
> > > ...
> > > spin_unlock_irqrestore(&uap->port.lock, flags);
> > >
> > > And a few (the ones I was involved in fixing) have the similar pattern
> > > of using uart_unlock_and_check_sysrq().
> > >
> > > Any serial drivers following this pattern could have their interrupt
> > > routine called periodically just to poll for characters and it'd be
> > > fine, right?  ...and having it take a second before a sysrq comes in
> > > this case is probably not the end of the world?
> > >
> >
> > Are you proposing to have complete RX operation in polling mode with
> > RX interrupt disabled (eg. using a kernel thread)?
>
> No, I'm suggesting a hybrid approach.  Leave the interrupts enabled as
> usual, but _also_ poll every 500 ms or 1 second (maybe make it
> configurable?).  In some serial drivers (ones that hold the lock for
> the whole interrupt routine) this polling function could actually be
> the same as the normal interrupt handler so it'd be trivially easy to
> implement and maintain.
>
> NOTE: This is not the same type of polling that kgdb does today.  The
> existing polling is really only intended to work when we're dropped
> into the debugger.  This would be more like a "poll_irq" type function
> that would do all the normal work the interrupt did and is really just
> there in the case that the CPU that the interrupt is routed to is
> locked up.
>

Your idea sounds interesting. I think where we are reaching is to have
an ever active listener to serial port that can be scheduled to any
random active CPU. And to keep its CPU overhead negligible, it can
sleep and only wake-up and listen once every 500 ms or 1 second
(configurable).

I will try to think more about it and probably give it a try with a PoC.

-Sumit

>
> > > One nice benefit of this is that it would actually work _better_ on
> > > SMP systems for any sysrqs that aren't NMI safe.  Specifically with
> > > your patch series those would be queued with irq_work_queue() which
> > > means they'd be blocked if the CPU processing the NMI is stuck with
> > > IRQs disabled.
> >
> > Yes, the sysrq handlers which aren't NMI safe will behave similarly to
> > existing IRQ based sysrq handlers.
> >
> > > With the polling mechanism they'd nicely just run on a
> > > different CPU.
> >
> > It looks like polling would cause much CPU overhead. So I am not sure
> > if that is the preferred approach.
>
> Maybe now it's clearer that there should be almost no overhead.  When
> dealing with a SYSRQ it's fine if there's a bit of a delay before it's
> processed, so polling every 1 second is probably fine.
>
> -Doug
