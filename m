Return-Path: <SRS0=eb60=62=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB6AC54E4B
	for <linux-serial@archiver.kernel.org>; Tue, 12 May 2020 07:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8255B207FF
	for <linux-serial@archiver.kernel.org>; Tue, 12 May 2020 07:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589268962;
	bh=mwdUCDRsQcd4tBUSrGY2SY7Tr80S7IIqcEq7gM+QFyo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DjW6KJBXNuFEN9R1Hl1xDw6fIO162KF9D73yD2tUpzKLf+/7Xuhbui4m2epzc0YeD
	 Znih3lzOUdsz6pBrzRq8lvXBmY0Su17FeYOxIlY31C/4tp0EgOILRkU1U/jfrw2tui
	 /XykK3+ARiMLJAhNVdpQGTi2JjH2eyoNiYgzvTog=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728990AbgELHgB (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 12 May 2020 03:36:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:42314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728949AbgELHgB (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 12 May 2020 03:36:01 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5F32206B7;
        Tue, 12 May 2020 07:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589268960;
        bh=mwdUCDRsQcd4tBUSrGY2SY7Tr80S7IIqcEq7gM+QFyo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t5R7cSJlDsOP/Rq15vISPrYY6nRgt0EcIH9XTuDyRC2GPJ6DWnRnmhKdfTiy4a30Y
         VJDL7O2w+OjJd6KbOlyAT9++Kn8lwIjNjkC+57eIGAzvYLg5+3SymfzalRlvTKRmLj
         Akz/XtkhIvyCU63jhozKZ3BdSOgowTXCmGBDg64I=
Date:   Tue, 12 May 2020 08:35:53 +0100
From:   Will Deacon <will@kernel.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-serial@vger.kernel.org, Sumit Garg <sumit.garg@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Frank Rowand <frowand.list@gmail.com>, bp@alien8.de,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jiri Slaby <jslaby@suse.com>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Allison Randal <allison@lohutok.net>,
        Dave Martin <Dave.Martin@arm.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        James Morse <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        jinho lim <jordan.lim@samsung.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 05/11] arm64: Add call_break_hook() to early_brk64()
 for early kgdb
Message-ID: <20200512073552.GA1538@willie-the-truck>
References: <20200428211351.85055-1-dianders@chromium.org>
 <20200428141218.v3.5.I22067ad43e77ddfd4b64c2d49030628480f9e8d9@changeid>
 <20200511145908.GA22040@willie-the-truck>
 <CAD=FV=W1F-B7SUwxebhhH2HS+fN4sYv4RHvvKud5a+00J0T=SA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=W1F-B7SUwxebhhH2HS+fN4sYv4RHvvKud5a+00J0T=SA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, May 11, 2020 at 03:45:02PM -0700, Doug Anderson wrote:
> On Mon, May 11, 2020 at 7:59 AM Will Deacon <will@kernel.org> wrote:
> > On Tue, Apr 28, 2020 at 02:13:45PM -0700, Douglas Anderson wrote:
> > > diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
> > > index 48222a4760c2..59c353dfc8e9 100644
> > > --- a/arch/arm64/kernel/debug-monitors.c
> > > +++ b/arch/arm64/kernel/debug-monitors.c
> > > @@ -297,7 +297,7 @@ void unregister_kernel_break_hook(struct break_hook *hook)
> > >       unregister_debug_hook(&hook->node);
> > >  }
> > >
> > > -static int call_break_hook(struct pt_regs *regs, unsigned int esr)
> > > +int call_break_hook(struct pt_regs *regs, unsigned int esr)
> > >  {
> > >       struct break_hook *hook;
> > >       struct list_head *list;
> > > diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> > > index cf402be5c573..a8173f0c1774 100644
> > > --- a/arch/arm64/kernel/traps.c
> > > +++ b/arch/arm64/kernel/traps.c
> > > @@ -1044,6 +1044,9 @@ int __init early_brk64(unsigned long addr, unsigned int esr,
> > >       if ((comment & ~KASAN_BRK_MASK) == KASAN_BRK_IMM)
> > >               return kasan_handler(regs, esr) != DBG_HOOK_HANDLED;
> > >  #endif
> > > +     if (call_break_hook(regs, esr) == DBG_HOOK_HANDLED)
> > > +             return 0;
> >
> > I think this just means we're not running debug_traps_init() early enough,
> > and actually the KASAN early handler is unnecessary too.
> >
> > If we call debug_traps_init() directly from setup_arch() and drop the
> > arch_initcall(), can we then drop early_brk64 entirely?
> 
> It seems to work in my testing.  ...but the worry I have is the
> comment right before trap_init().  It says:
> 
> /* This registration must happen early, before debug_traps_init(). */

I /think/ the reason for this is because debug_traps_init() replaces the
BRK vector, so if that runs before the break hooks have been registered
for e.g. BUG() then BUG() won't work during that window. Hmm, so dropping
early_brk64 is problematic after all. Damn.

Is trap_init() early enough for you? If so, we could call debug_traps_init()
from traps_init() after registering the break hooks.

Will
