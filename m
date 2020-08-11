Return-Path: <SRS0=7S4r=BV=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD38DC433E0
	for <linux-serial@archiver.kernel.org>; Tue, 11 Aug 2020 14:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDA422078E
	for <linux-serial@archiver.kernel.org>; Tue, 11 Aug 2020 14:29:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cm1Tcc1Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbgHKO3j (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 11 Aug 2020 10:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728768AbgHKO3i (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 11 Aug 2020 10:29:38 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C90C061787
        for <linux-serial@vger.kernel.org>; Tue, 11 Aug 2020 07:29:37 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id g6so13717295ljn.11
        for <linux-serial@vger.kernel.org>; Tue, 11 Aug 2020 07:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KkzFrtv0c+qoPAhI6jwpG+PydA17UzEovGlcuGw1Sps=;
        b=Cm1Tcc1QCdLhQB+oaKcHVbnlYt9sGsmFejuHFLKrI9QqSNl/Fse5iGu3VtFfWFDsVL
         LaJZoICnAbnedb4SGXu5bdSED6k8LU8weTlxSQm2ZytW13SCmEDyW1aF2vQhRchu2b4X
         QBa3FW9LTHR+lUp5HrNWKHC/u0rBwDQ1P24vRBZ79SRIMNPtOH6SnBB2JRla7wM1kFwM
         M+2EfwC0j1xm+UOwmmQnQGMEwen81gnf482PeXuBfVRq0EmYU/uVd3M+ZShUxlhp5I//
         Ctly+qbkrF0UN6hELmWq3OJKqAtfI2KN8HJTPxm8okIeDGWmXQ24pfW0E/JePUuaRLFW
         Mi1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KkzFrtv0c+qoPAhI6jwpG+PydA17UzEovGlcuGw1Sps=;
        b=bSDA6HA6EaSttAHBEZO+cSd11QFA8mUdsXpYtGpi4DDBZeYKZo5cwnWZt3XB0MNVxG
         A1WLAMLAeeBPy6hMi/fRG1rRTJ9gYlac9S8cQxQEojQ1EcIB155jCMFcGawDDe4FZNfb
         6k8A/4hIbYl/GF2cuNFdAT9YiitH6K9L1WLXq244amLiIDT+beMmzex43SHplLbhcib+
         PwxlH+inXmZmnm8YrG6xyY6bcZ6XP0IWOk0WETuleN04FqfEDQQKIzfA/HMrf/c1ic8G
         DB3SB9RhqHyYby665EMk3K6OoleflxEM/zUg6OXB8VjH4TQraSRp8gle8vlhely8QdRo
         RnoQ==
X-Gm-Message-State: AOAM531fGWIOYvmBH02ok7SArgYulhQzXR5Cg0hGSmWURV2DIDfUDzlI
        sjvEDIHQ/VQ8f3ZprMGHospW32VnjUKWcBWvgi0I5A==
X-Google-Smtp-Source: ABdhPJyJ1wnqNF5YPIO4kRwCd++xZfKyweClk+mQLcH6eO5yxlF+xzvevF4oQwGopn5tNZ3LQcm2T7AN3pLnJ1s2+Hs=
X-Received: by 2002:a05:651c:1293:: with SMTP id 19mr3003077ljc.427.1597156176182;
 Tue, 11 Aug 2020 07:29:36 -0700 (PDT)
MIME-Version: 1.0
References: <1595333413-30052-1-git-send-email-sumit.garg@linaro.org>
 <CAFA6WYMN=na4Pxnu1LYRVAAZRdV==5EwU-Vcq-QkRb_jaLiPmw@mail.gmail.com> <20200811135801.GA416071@kroah.com>
In-Reply-To: <20200811135801.GA416071@kroah.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 11 Aug 2020 19:59:24 +0530
Message-ID: <CAFA6WYMN8i96rEZuHLnskB+4k0o=K9vF1_we83P04h2BSoGjmQ@mail.gmail.com>
Subject: Re: [RFC 0/5] Introduce NMI aware serial drivers
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
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

Hi Greg,

Thanks for your comments.

On Tue, 11 Aug 2020 at 19:27, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Aug 11, 2020 at 07:20:26PM +0530, Sumit Garg wrote:
> > On Tue, 21 Jul 2020 at 17:40, Sumit Garg <sumit.garg@linaro.org> wrote:
> > >
> > > Make it possible for UARTs to trigger magic sysrq from an NMI. With the
> > > advent of pseudo NMIs on arm64 it became quite generic to request serial
> > > device interrupt as an NMI rather than IRQ. And having NMI driven serial
> > > RX will allow us to trigger magic sysrq as an NMI and hence drop into
> > > kernel debugger in NMI context.
> > >
> > > The major use-case is to add NMI debugging capabilities to the kernel
> > > in order to debug scenarios such as:
> > > - Primary CPU is stuck in deadlock with interrupts disabled and hence
> > >   doesn't honor serial device interrupt. So having magic sysrq triggered
> > >   as an NMI is helpful for debugging.
> > > - Always enabled NMI based magic sysrq irrespective of whether the serial
> > >   TTY port is active or not.
> > >
> > > Currently there is an existing kgdb NMI serial driver which provides
> > > partial implementation in upstream to have a separate ttyNMI0 port but
> > > that remained in silos with the serial core/drivers which made it a bit
> > > odd to enable using serial device interrupt and hence remained unused. It
> > > seems to be clearly intended to avoid almost all custom NMI changes to
> > > the UART driver.
> > >
> > > But this patch-set allows the serial core/drivers to be NMI aware which
> > > in turn provides NMI debugging capabilities via magic sysrq and hence
> > > there is no specific reason to keep this special driver. So remove it
> > > instead.
> > >
> > > Approach:
> > > ---------
> > >
> > > The overall idea is to intercept serial RX characters in NMI context, if
> > > those are specific to magic sysrq then allow corresponding handler to run
> > > in NMI context. Otherwise, defer all other RX and TX operations onto IRQ
> > > work queue in order to run those in normal interrupt context.
> > >
> > > This approach is demonstrated using amba-pl011 driver.
> > >
> > > Patch-wise description:
> > > -----------------------
> > >
> > > Patch #1 prepares magic sysrq handler to be NMI aware.
> > > Patch #2 adds NMI framework to serial core.
> > > Patch #3 and #4 demonstrates NMI aware uart port using amba-pl011 driver.
> > > Patch #5 removes kgdb NMI serial driver.
> > >
> > > Goal of this RFC:
> > > -----------------
> > >
> > > My main reason for sharing this as an RFC is to help decide whether or
> > > not to continue with this approach. The next step for me would to port
> > > the work to a system with an 8250 UART.
> > >
> >
> > A gentle reminder to seek feedback on this series.
>
> It's the middle of the merge window, and I can't do anything.
>
> Also, I almost never review RFC patches as I have have way too many
> patches that people think are "right" to review first...
>

Okay, I understand and I can definitely wait for your feedback.

> I suggest you work to flesh this out first and submit something that you
> feels works properly.
>

IIUC, in order to make this approach substantial I need to make it
work with 8250 UART (major serial driver), correct? As currently it
works properly for amba-pl011 driver.

> good luck!
>

Thanks.

-Sumit

> greg k-h
