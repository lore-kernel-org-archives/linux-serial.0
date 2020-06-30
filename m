Return-Path: <SRS0=da9C=AL=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE029C433DF
	for <linux-serial@archiver.kernel.org>; Tue, 30 Jun 2020 06:09:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1D3B20768
	for <linux-serial@archiver.kernel.org>; Tue, 30 Jun 2020 06:09:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iAxzF4vB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729835AbgF3GJg (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 30 Jun 2020 02:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729799AbgF3GJg (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 30 Jun 2020 02:09:36 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB48C03E979
        for <linux-serial@vger.kernel.org>; Mon, 29 Jun 2020 23:09:35 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id e4so21058904ljn.4
        for <linux-serial@vger.kernel.org>; Mon, 29 Jun 2020 23:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oXdK77lNUDusP4FRYvdXH3nYySFezAr/kCJUG+LcUW0=;
        b=iAxzF4vBzuBy0/QV3Nn58POBTjf+maM2qt0XPp0Y6h50d25HA4S9XvpIUfJiPPhbhV
         D+uMUz/PcSm9lSCHw1/o2uqHnEwe8wPi4R1SVYqgaJ7azdV6deOAbn/7JtebqwMrXjLx
         8gciILyd77r8Yu4p2rL7WWrYX2ER6TW7hG8lmqyYJKNtBO9y3MSroxZ5spO/KDHfkE8E
         Gu61IplfvgRt1qmiHql3GAjY3x7WfLhGmyy8xWGEcqD7TmMRDAGTL7bL3/G7i1i0s5iI
         Q8yFph+iocF9bL2ACgKCh6vIhFFJ6Zqe1NIIwIayP1h1n7fCYdzXK5XgxWdnW3fGmbLk
         WC9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oXdK77lNUDusP4FRYvdXH3nYySFezAr/kCJUG+LcUW0=;
        b=GEL96ajb8k897UPSr3hWU0YBjaKtMIyPNDeW80tWQ/Sk3/t2DZ9nLW3/AnXy1ZL4jH
         ESaxPrWbY7avhZaxQLFIs2Ds2KkQZNkkUsKrwmJedWxg4EBNwp6y1Pu09Iek2jMeroQ2
         aRA6lRfV++ce+zPYxpq4GgvFrBZmpss/RDyujRQ/qwkFYkoQvJ2WXS0Hyx027YVxurxR
         xyylHhLnNeSAM/52CVcsZEEVmdrQzPJ3dwlFUhfMclRmDwO7G+VFd6KAkM+tDEFpRtyE
         6eA1aFWSucT8ieOvjjeXF9Tia4ZK66n8vTUtIHWM9q/gr0o337w3Uvl9SGqsqmmVx4Yy
         tMnw==
X-Gm-Message-State: AOAM532nsQApD+K9TWObk5jmRghchXPkhHtBb/NWpgkqllYTkaGnT053
        of/DUdq6nwmUVUrueQfo1s/zD5euHDewCFaOLGywxg==
X-Google-Smtp-Source: ABdhPJxWXOrxS/lf4Xen8LBgZNkcQ0tSmdYWmZef4sjTUy3Y+VbgDi2Tel4l2BAvFo3ICLI2Ypj8KLp0sHCPWQ0rdbg=
X-Received: by 2002:a2e:740d:: with SMTP id p13mr9129454ljc.372.1593497373796;
 Mon, 29 Jun 2020 23:09:33 -0700 (PDT)
MIME-Version: 1.0
References: <1592835984-28613-1-git-send-email-sumit.garg@linaro.org>
 <1592835984-28613-4-git-send-email-sumit.garg@linaro.org> <20200622160300.avgfhnfkpqzqqtsr@holly.lan>
 <CAFA6WYOmQT-OQvjpy1pVPq2mx5S264bJPd-XfwnDY2BjeoWekg@mail.gmail.com>
 <20200623105934.wvyidi3xgqgd35af@holly.lan> <CAD=FV=XHZT9ud0Ze1pDvz-kQy7FMFzd9T6+jM5URt1k5BwQ15g@mail.gmail.com>
 <20200629114501.7aq547dzo6o2abrt@holly.lan>
In-Reply-To: <20200629114501.7aq547dzo6o2abrt@holly.lan>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 30 Jun 2020 11:39:21 +0530
Message-ID: <CAFA6WYN3iAON1m9RMVs6W8Vi0bw0=2az-czLo+6QeavFKdDD-w@mail.gmail.com>
Subject: Re: [PATCH 3/7] kgdb: Add request_nmi() to the io ops table for kgdboc
To:     Daniel Thompson <daniel.thompson@linaro.org>,
        Doug Anderson <dianders@chromium.org>
Cc:     kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org,
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

On Mon, 29 Jun 2020 at 17:15, Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Fri, Jun 26, 2020 at 12:44:15PM -0700, Doug Anderson wrote:
> > Hi,
> >
> > On Tue, Jun 23, 2020 at 3:59 AM Daniel Thompson
> > <daniel.thompson@linaro.org> wrote:
> > >
> > > On Tue, Jun 23, 2020 at 02:07:47PM +0530, Sumit Garg wrote:
> > > > On Mon, 22 Jun 2020 at 21:33, Daniel Thompson
> > > > <daniel.thompson@linaro.org> wrote:
> > > > > > +     irq_set_status_flags(irq, IRQ_NOAUTOEN);
> > > > > > +     res = request_nmi(irq, fn, IRQF_PERCPU, "kgdboc", dev_id);
> > > > >
> > > > > Why do we need IRQF_PERCPU here. A UART interrupt is not normally
> > > > > per-cpu?
> > > > >
> > > >
> > > > Have a look at this comment [1] and corresponding check in
> > > > request_nmi(). So essentially yes UART interrupt is not normally
> > > > per-cpu but in order to make it an NMI, we need to request it in
> > > > per-cpu mode.
> > > >
> > > > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/irq/manage.c#n2112
> > >
> > > Thanks! This is clear.
> > >
> > > > > > +     if (res) {
> > > > > > +             res = request_irq(irq, fn, IRQF_SHARED, "kgdboc", dev_id);
> > > > >
> > > > > IRQF_SHARED?
> > > > >
> > > > > Currrently there is nothing that prevents concurrent activation of
> > > > > ttyNMI0 and the underlying serial driver. Using IRQF_SHARED means it
> > > > > becomes possible for both drivers to try to service the same interrupt.
> > > > > That risks some rather "interesting" problems.
> > > > >
> > > >
> > > > Could you elaborate more on "interesting" problems?
> > >
> > > Er... one of the serial drivers we have allowed the userspace to open
> > > will, at best, be stone dead and not passing any characters.
> > >
> > >
> > > > BTW, I noticed one more problem with this patch that is IRQF_SHARED
> > > > doesn't go well with IRQ_NOAUTOEN status flag. Earlier I tested it
> > > > with auto enable set.
> > > >
> > > > But if we agree that both shouldn't be active at the same time due to
> > > > some real problems(?) then I can rid of IRQF_SHARED as well. Also, I
> > > > think we should unregister underlying tty driver (eg. /dev/ttyAMA0) as
> > > > well as otherwise it would provide a broken interface to user-space.
> > >
> > > I don't have a particular strong opinion on whether IRQF_SHARED is
> > > correct or not correct since I think that misses the point.
> > >
> > > Firstly, using IRQF_SHARED shows us that there is no interlocking
> > > between kgdb_nmi and the underlying serial driver. That probably tells
> > > us about the importance of the interlock than about IRQF_SHARED.
> > >
> > > To some extent I'm also unsure that kgdb_nmi could ever actually know
> > > the correct flags to use in all cases (that was another reason for the
> > > TODO comment about poll_get_irq() being a bogus API).
> >
> > I do wonder a little bit if the architecture of the "kgdb_nmi_console"
> > should change.  I remember looking at it in the past and thinking it a
> > little weird that if I wanted to get it to work I'd need to change my
> > "console=" command line to go through this new driver and (I guess)
> > change the agetty I have running on my serial port to point to
> > ttyNMI0.  Is that how it's supposed to work?  Then if I want to do a
> > build without kgdb then I need to go in and change my agetty to point
> > back at my normal serial port?
> >
> > It kinda feels like a better way to much of what the driver does would be to:
> >
> > 1. Allow kgdb to sniff incoming serial bytes on a port and look for
> > its characters.  We already have this feature in the kernel to a small
> > extent for sniffing a break / sysrq character.
> >
> > 2. If userspace doesn't happen to have the serial port open then
> > ideally we could open the port (using all the standard APIs that
> > already exist) from in the kernel and just throw away all the bytes
> > (since we already sniffed them).  As soon as userspace tried to open
> > the port when it would get ownership and if userspace ever closed the
> > port then we'd start reading / throwing away bytes again.
> >
> > If we had a solution like that:
> >
> > a) No serial drivers would need to change.
> >
> > b) No kernel command line parameters would need to change.
> >
> > Obviously that solution wouldn't magically get you an NMI, though.
> > For that I'd presume the right answer would be to add a parameter for
> > each serial driver that can support it to run its rx interrupt in NMI
> > mode.
>

Thanks Doug for the suggestions.

> ... or allow modal changes to the uart driver when kgdboc comes up?
>
> We already allow UART drivers to de-optimize themselves and use
> different code paths when polling is enabled so its not totally crazy
> ;-).
>
>
> > Of course, perhaps I'm just confused and crazy and the above is a
> > really bad idea.
>
> Thanks for bringing this up.
>
> Sumit and I were chatting last week and our discussion went in a similar
> direction (I think not exactly the same which is why it is good to
> see your thoughts too).
>
> Personally I think it comes down to how intrusive adding NMI support is
> to serial drivers. kgdb_nmi is rather hacky and feels a bit odd to
> enable. It is clearly intended to avoid almost all changes to the UART
> driver. On our side we have been wondering whether the serial core can
> add helpers to make it easy for a serial driver to implement an simple,
> safe but not optimal NMI implementation. Making it easy to have
> safety-first might make NMI more palatable.
>

I am currently working on a PoC in this direction and hopeful to come
up with least intrusive NMI support to serial drivers.

>
> > Speaking of confused: is there actually any way to use the existing
> > kgdb NMI driver (CONFIG_SERIAL_KGDB_NMI) in mainline without out of
> > tree patches?  When I looked before I assumed it was just me that was
> > outta luck because I didn't have NMI at the time, but I just did some
> > grepping and I can't find anyplace in mainline where
> > "arch_kgdb_ops.enable_nmi" would not be NULL.  Did I miss it, or do we
> > need out-of-tree patches to enable this?
>
> Out-of-tree...

Yeah and this patch-set derived from Daniel's work was one of them.

>
> If, after looking at other approaches, we do all agree to nuke kgdb_nmi
> then there shouldn't be much impediment (nor that many tears).
>

Makes sense.

-Sumit

>
> Daniel.
