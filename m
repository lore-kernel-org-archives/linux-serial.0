Return-Path: <SRS0=iWX9=B3=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD7FC433DF
	for <linux-serial@archiver.kernel.org>; Mon, 17 Aug 2020 14:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 085AA20729
	for <linux-serial@archiver.kernel.org>; Mon, 17 Aug 2020 14:12:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gMYUOdqd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbgHQOM2 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 17 Aug 2020 10:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728619AbgHQOM2 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 17 Aug 2020 10:12:28 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26542C061389
        for <linux-serial@vger.kernel.org>; Mon, 17 Aug 2020 07:12:27 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id m22so17620558ljj.5
        for <linux-serial@vger.kernel.org>; Mon, 17 Aug 2020 07:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q7d9pcUKbDGfUpE6Avug3GSgjxvOVpz7Xk0gMD0ttFI=;
        b=gMYUOdqdelXi5UQrg9TpMibqw1w8S+D7awDT/BVjaXw0fti06gTMWCpDjBZe1W3JuF
         8kvgIhZgJvl2rmVX9sEqiCzZuIFkC8nAmnRa1P9BdBrDlVfna7dmE4p4LsGXFIi84F1z
         Xwp39IbROt/uopEH0yzVyvloQrlb7SUdwdrSX54JKhlP7hSlH2Jlkb1FF+QZX1AnhtA6
         DG2/CggHeahPAYMXlvXPAmxz01X9bZ5KKSFsCKsVlv2fzk9Nr/6zHNDKFnM8m56OSV52
         Aut9y7m932gKz0zRZaps3FnIUKfRrzulUVC09X1S6VMJvradsQl61jIhQLcIitHOgmWa
         xynw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q7d9pcUKbDGfUpE6Avug3GSgjxvOVpz7Xk0gMD0ttFI=;
        b=HpI2D64DzVkyKB806CgItyqgHaqMuw3vkPkPEViV/cbnoKIkCQJS0S8jucHP1u96HH
         jBnTyD4NkilUuePXs2fmOAWEXriCk41tQDYep8mrYDsgF/54+TVaXrK6xEPUyFsaTG0g
         0fcSklSS0wKSeHv/rfgJjuNORH5n4qNQQIqp1f2NEcv2pJy/83qDacF8LM7uKUPVEbz+
         Kx7sWsmFtJAowviApxxLetOWi7M+0vD56ccnUKcLHe+LX0EiHFm+1f+HFsv7q9ry9g+i
         cawzu+FnODshQrJlqMcUHvADeyCFad4XRJ8OKICe6chPocklvhQ02Yx2MkgYbAYg20Sl
         KTQw==
X-Gm-Message-State: AOAM533N10Zpa/I2JDgNcudPZInd3b/uZrgnzFtCeSwEe0Jj1Gxn1xMX
        LUN5+cuyRpkEcFI2AMu+7rfKttRHLZ14pEcfipjahzCS09g=
X-Google-Smtp-Source: ABdhPJzZvNTsjJlCZRY46qgZ5XPfaIqBt+6PYchX+KcW7o6RJ0edJpORQWsb2GY8kITxV/aTPnf5HGKblVtJ7XlEV8w=
X-Received: by 2002:a2e:b6cc:: with SMTP id m12mr6743907ljo.256.1597673545599;
 Mon, 17 Aug 2020 07:12:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200811145816.GA424033@kroah.com> <CAD=FV=UD=cTn6jwpYS-C-=1ORd-4azZ8ZiBR6om++2sMS1nmMg@mail.gmail.com>
 <CAFA6WYPBdOiVsKR_hSLpigN_1b9jimXKaqyRZjvKSx3xpAmLjA@mail.gmail.com>
 <CAD=FV=WccmFRkV4UUTLSYR9+7210h00Si=nG4tRs3BBuweA6ng@mail.gmail.com>
 <CAD=FV=V8UhQVQvcAp6XCmT3=6FYM=_zPELy4FTj4kMKUswaR8Q@mail.gmail.com>
 <CAFA6WYPxieH6ZTa_BFdaLuiwbqAs6r7eKmxG7ci4XtyRONGN7g@mail.gmail.com>
 <20200813101703.566thqmnc2d7cb3n@holly.lan> <CAFA6WYPd-fcDkYNk1KrjYwD=FH3FBvjDGEoxCBBN9CRidoVXbw@mail.gmail.com>
 <20200814141822.opahh33nfc5yodkb@holly.lan> <CAFA6WYO3YmgCftr-hFdiHGHATeox9en_HZvgnAL=zhoa=OEi_w@mail.gmail.com>
 <20200817092830.xcl2gkyxoe5grgnz@holly.lan>
In-Reply-To: <20200817092830.xcl2gkyxoe5grgnz@holly.lan>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 17 Aug 2020 19:42:14 +0530
Message-ID: <CAFA6WYOX0VzSvCyNTPemNMBPmSY75Q8vKdyQLc9cuq2m5eBWLg@mail.gmail.com>
Subject: Re: [RFC 0/5] Introduce NMI aware serial drivers
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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

On Mon, 17 Aug 2020 at 14:58, Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Mon, Aug 17, 2020 at 10:42:43AM +0530, Sumit Garg wrote:
> > On Fri, 14 Aug 2020 at 19:48, Daniel Thompson
> > <daniel.thompson@linaro.org> wrote:
> > >
> > > On Fri, Aug 14, 2020 at 05:36:36PM +0530, Sumit Garg wrote:
> > > > On Thu, 13 Aug 2020 at 15:47, Daniel Thompson
> > > > <daniel.thompson@linaro.org> wrote:
> > > > >
> > > > > On Thu, Aug 13, 2020 at 02:55:12PM +0530, Sumit Garg wrote:
> > > > > > On Thu, 13 Aug 2020 at 05:38, Doug Anderson <dianders@chromium.org> wrote:
> > > > > > > On Wed, Aug 12, 2020 at 8:27 AM Doug Anderson <dianders@chromium.org> wrote:
> > > > > > > > One
> > > > > > > > last worry is that I assume that most people testing (and even
> > > > > > > > automated testing labs) will either always enable NMI or won't enable
> > > > > > > > NMI.  That means that everyone will be only testing one codepath or
> > > > > > > > the other and (given the complexity) the non-tested codepath will
> > > > > > > > break.
> > > > > > > >
> > > > > >
> > > > > > The current patch-set only makes this NMI to work when debugger (kgdb)
> > > > > > is enabled which I think is mostly suitable for development
> > > > > > environments. So most people testing will involve existing IRQ mode
> > > > > > only.
> > > > > >
> > > > > > However, it's very much possible to make NMI mode as default for a
> > > > > > particular serial driver if the underlying irqchip supports it but it
> > > > > > depends if we really see any production level usage of NMI debug
> > > > > > feature.
> > > > >
> > > > > The effect of this patch is not to make kgdb work from NMI it is to make
> > > > > (some) SysRqs work from NMI. I think that only allowing it to deploy for
> > > > > kgdb users is a mistake.
> > > > >
> > > > > Having it deploy automatically for kgdb users might be OK but it seems
> > > > > sensible to make this feature available for other users too.
> > > >
> > > > I think I wasn't clear enough in my prior reply. Actually I meant to
> > > > say that this patch-set enables NMI support for a particular serial
> > > > driver via ".poll_init()" interface and the only current user of that
> > > > interface is kgdb.
> > > >
> > > > So if there are other users interested in this feature, they can use
> > > > ".poll_init()" interface as well to enable it.
> > >
> > > Huh?
> > >
> > > We appear to speaking interchangably about users (people who sit in
> > > front of the machine and want a stack trace) and sub-systems ;-).
> > >
> > > I don't think other SysRq commands have quite such a direct relationship
> > > between the sub-system and the sysrq command. For example who are you
> > > expecting to call .poll_init() if a user wants to use the SysRq to
> > > provoke a stack trace?
> > >
> >
> > Ah, I see. So you meant to provide a user-space interface to
> > dynamically enable/disable NMI debug, correct? It will require IRQ <->
> > NMI switching at runtime which should be doable safely.
>
> I haven't given much thought to the exact mechanism, though I would
> perhaps have started by thinking about a module parameter).
>
> From an RFC point of view, I simple think this feature is potentially
> useful on systems without kgdb (which, let's be honest, are firmly in
> the majority) so making .poll_init() the only way to activate it is a
> mistake.
>

Makes sense, will add a module parameter to enable this feature during
boot as well.

-Sumit

>
> Daniel.
