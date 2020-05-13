Return-Path: <SRS0=7vif=63=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 392D0C2D0F8
	for <linux-serial@archiver.kernel.org>; Wed, 13 May 2020 06:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14B8E206F5
	for <linux-serial@archiver.kernel.org>; Wed, 13 May 2020 06:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589350675;
	bh=MzICw58ueTIcZPjAHA1rhxAPW7fC1iatHDfRyo1z5vE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2kPebBdT/zbMZvyCd3zHQkAtCY2usoPIfghDmBp4VSasldfEyUoo9BwSFYHKCHcdh
	 B+G0h6WPjl8ZynuPFlgQkqLT0DMwCzxjygPcSNGniAtowrWgxI+nrvn4gkzFYJLDYt
	 nqvXXW4mtcMTxisAtM7r8gJ+9iRi6SqFfunwBM30=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729201AbgEMGRy (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 13 May 2020 02:17:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:42830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728803AbgEMGRy (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 13 May 2020 02:17:54 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 265FA206B7;
        Wed, 13 May 2020 06:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589350673;
        bh=MzICw58ueTIcZPjAHA1rhxAPW7fC1iatHDfRyo1z5vE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hr/mqpP2SnBe6bfko189D9OZLbaZn2kNpTtaq0L1QMOc59QWkBDFGPsMR47i7Z8lD
         Fg5kVOp0tCi4w7QBCfhfzhGwqWLKyCKK1/pU5h5Arvyoqr43jzuxE3OpAsNn1BQ9SB
         /nVwh0/GHj1ZLwjRcTmxDMkfwQDA+/0NMipcG8kA=
Date:   Wed, 13 May 2020 07:17:46 +0100
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
Message-ID: <20200513061745.GB17433@willie-the-truck>
References: <20200428211351.85055-1-dianders@chromium.org>
 <20200428141218.v3.5.I22067ad43e77ddfd4b64c2d49030628480f9e8d9@changeid>
 <20200511145908.GA22040@willie-the-truck>
 <CAD=FV=W1F-B7SUwxebhhH2HS+fN4sYv4RHvvKud5a+00J0T=SA@mail.gmail.com>
 <20200512073552.GA1538@willie-the-truck>
 <CAD=FV=WuKS7c4WNiLKm+bjRF8Rd7wM1y7THWzJhVhUyExNiiVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=WuKS7c4WNiLKm+bjRF8Rd7wM1y7THWzJhVhUyExNiiVg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hey Doug,

On Tue, May 12, 2020 at 08:27:50AM -0700, Doug Anderson wrote:
> On Tue, May 12, 2020 at 12:36 AM Will Deacon <will@kernel.org> wrote:
> > On Mon, May 11, 2020 at 03:45:02PM -0700, Doug Anderson wrote:
> > > On Mon, May 11, 2020 at 7:59 AM Will Deacon <will@kernel.org> wrote:
> > > > On Tue, Apr 28, 2020 at 02:13:45PM -0700, Douglas Anderson wrote:
> > > > > diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> > > > > index cf402be5c573..a8173f0c1774 100644
> > > > > --- a/arch/arm64/kernel/traps.c
> > > > > +++ b/arch/arm64/kernel/traps.c
> > > > > @@ -1044,6 +1044,9 @@ int __init early_brk64(unsigned long addr, unsigned int esr,
> > > > >       if ((comment & ~KASAN_BRK_MASK) == KASAN_BRK_IMM)
> > > > >               return kasan_handler(regs, esr) != DBG_HOOK_HANDLED;
> > > > >  #endif
> > > > > +     if (call_break_hook(regs, esr) == DBG_HOOK_HANDLED)
> > > > > +             return 0;
> > > >
> > > > I think this just means we're not running debug_traps_init() early enough,
> > > > and actually the KASAN early handler is unnecessary too.
> > > >
> > > > If we call debug_traps_init() directly from setup_arch() and drop the
> > > > arch_initcall(), can we then drop early_brk64 entirely?
> > >
> > > It seems to work in my testing.  ...but the worry I have is the
> > > comment right before trap_init().  It says:
> > >
> > > /* This registration must happen early, before debug_traps_init(). */
> >
> > I /think/ the reason for this is because debug_traps_init() replaces the
> > BRK vector, so if that runs before the break hooks have been registered
> > for e.g. BUG() then BUG() won't work during that window. Hmm, so dropping
> > early_brk64 is problematic after all. Damn.
> >
> > Is trap_init() early enough for you? If so, we could call debug_traps_init()
> > from traps_init() after registering the break hooks.
> 
> "Early enough" is a subjective term, of course.  The earlier we can
> init, the earlier we can drop into the debugger.  ...but, of course,
> everyone thinks their feature is the most important and should be
> first, so let's see...
> 
> Certainly if we waited until trap_init() it wouldn't be early enough
> to set "ARCH_HAS_EARLY_DEBUG".  Setting that means that debugging is
> ready when early params are parsed and those happen at the start of
> setup_arch().  The call to trap_init() happens a bit later.
> 
> If we decide that we just don't care about getting
> "ARCH_HAS_EARLY_DEBUG" to work then the earliest we'll be able to
> break into the debugger (via kgdbwait) is dbg_late_init().  That
> _does_ happen after trap_init() so your solution would work.
> 
> As a person who spends most of his time in driver land, it wouldn't be
> the end of the world to wait for dbg_late_init().  That's still much
> earlier than most code I'd ever debug.  ...and, bonus points is that
> if we hit a crash any time after earlyparams we _will_ still drop into
> the debugger.  It's only breakpoints that won't be available until
> dbg_late_init().
> 
> 
> tl;dr:
> 
> * If we care about "kgdbwait" and breakpoints working as early as
> possible then we need my patch.
> 
> * If we are OK w/ a slightly later "kgdbwait" then I think we can move
> debug_traps_init() to trap_init() and get rid of the early version.
> 
> 
> Please let me know which way you'd like to proceed.

Let's go with the trap_init() approach for now, and we can revisit it later
if somebody has a compelling reason to initialise things earlier. However,
I don't think you can remove early_brk64(), as it's needed for BUG() to
work correctly.

Will
