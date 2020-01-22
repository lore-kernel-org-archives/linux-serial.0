Return-Path: <SRS0=aJ84=3L=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E306AC2D0CE
	for <linux-serial@archiver.kernel.org>; Wed, 22 Jan 2020 02:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B78572465A
	for <linux-serial@archiver.kernel.org>; Wed, 22 Jan 2020 02:34:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbgAVCef (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 21 Jan 2020 21:34:35 -0500
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:37239 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726407AbgAVCef (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 21 Jan 2020 21:34:35 -0500
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id 620103C04C1;
        Wed, 22 Jan 2020 03:34:31 +0100 (CET)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ROXVjIdSijnT; Wed, 22 Jan 2020 03:34:26 +0100 (CET)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id 180073C00C5;
        Wed, 22 Jan 2020 03:34:26 +0100 (CET)
Received: from lxhi-065.adit-jv.com (10.72.93.66) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.468.0; Wed, 22 Jan
 2020 03:34:25 +0100
Date:   Wed, 22 Jan 2020 03:34:22 +0100
From:   Eugeniu Rosca <erosca@de.adit-jv.com>
To:     John Ogness <john.ogness@linutronix.de>
CC:     Eugeniu Rosca <erosca@de.adit-jv.com>,
        <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Andrew Gabbasov <andrew_gabbasov@mentor.com>,
        Sanjeev Chugh <sanjeev_chugh@mentor.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Wang <wonderfly@google.com>,
        Dean Jenkins <dean_jenkins@mentor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dirk Behme <dirk.behme@de.bosch.com>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Jiri Slaby <jslaby@suse.com>,
        Peter Feiner <pfeiner@google.com>,
        <linux-serial@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: Re: [RFC PATCH v1 00/25] printk: new implementation
Message-ID: <20200122023422.GA926@lxhi-065.adit-jv.com>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
 <20200120230522.GA23636@lxhi-065.adit-jv.com>
 <87v9p4mkhr.fsf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87v9p4mkhr.fsf@linutronix.de>
X-Originating-IP: [10.72.93.66]
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi John,

Thank you for the comprehensive feedback. Some replies below.

On Wed, Jan 22, 2020 at 12:56:48AM +0100, John Ogness wrote:
> On 2020-01-21, Eugeniu Rosca <erosca@de.adit-jv.com> wrote:
> > This [1] is a fairly old thread, but I only recently stumbled upon it,
> > while co-investigating below audio distortions [2] on R-Car3 ARM64
> > boards, which can be reproduced by stressing [3] the serial console.
> >
> > The investigation started a few months ago, when users reported audio
> > drops during the first seconds of system startup. Only after a few
> > weeks it became clear (thanks to some people in Cc) that the
> > distortions were contributed by the above-average serial console load
> > during the early boot. Once understood, we were able to come up with a
> > synthetic test [2-3].
> >
> > I thought it would be interesting to share below reproduction matrix,
> > in order to contrast vanilla to linux-rt-devel [4], as well as to
> > compare various preemption models.
> >  
> >                            | Ser.console  Ser.console
> >                            | stressed     at rest or disabled
> >       --------------------------------------------
> >       v5.5-rc6 (PREEMPT=y) | distorted    clean
> >     v5.4.5-rt3 (PREEMPT=y) | distorted    clean
> >  v5.4.5-rt3 (PREEMPT_RT=y) | clean        clean
> >
> > My feeling is that the results probably do not surprise linux-rt
> > people.
> >
> > My first question is, should there be any improvement in the case of
> > v5.4.5-rt3 (PREEMPT=y), which I do not sense? I would expect so, based
> > on the cover letter of this series (pointing out the advantages of the
> > redesigned printk mechanism).
> 
> The problem you are reporting is not the problem that the printk rework
> is trying to solve.

In general, agreed. But there are some quirks and peculiarities in how
the issue (increased audio latency) manifests itself on R-Car3, which
might create some room for a (relatively simple) loophole solution in
the printk mechanism.

With that said, I need to diverge a bit from the platform-agnostic
scope of this series.

So, what's specific to R-Car3, based on my testing, is that the issue
can only be reproduced if the printk storm originates on CPU0 (it does
not matter if from interrupt or task context, both have been tested). If
the printk storm is initiated on any other CPU (there are 7 secondary
ones on R-Car H3), there is no regression in the audio quality/latency.

I cannot fully explain this empirical observation, but it directs my
mind to the following workaround, for which I have a PoC:
 - employ vprintk_safe() any time CPU0 is the owner/caller of printk
 - tie CPU0-private printk internal IRQ workers to another CPU

The above makes sure nothing is printed to the serial console on behalf
of CPU0. I don't even hope this to be accepted by community, but can you
please share your opinion the idea itself is sane?

> 
> In your chart, v5.4.5-rt3 (PREEMPT_RT=y) is the only configuration that
> is _not_ disabling hardware interrupts during UART activity. I would
> guess your problem is due to interrupts being disabled for unacceptable
> lengths of time.

This confirms the internally established view on the issue.

> You need a low-latency system, so PREEMPT_RT=y _is_ the
> correct (and only) solution if a verbose serial console is a must.

It's helpful to have your feedback on this.

> 
> The printk rework focusses on making printk non-interfering by
> decoupling console printing from printk() callers. However, the console
> printing itself will still do just as much interrupt disabling as
> before. That is driver-related, not printk-related.

I didn't dive into the internals of this series, but decoupling the
execution context of the serial driver from the execution context of
the printk callers sounds very good to me (this is what i try to achieve
via vanilla vprintk_safe). I wonder if it's easier to remove CPU0 from
equation with this series applied.

> 
> > And the other question is, how would you, generally speaking, tackle
> > the problem, given that backporting the linux-rt patches is *not* an
> > option and enabling serial console is a must?
> 
> The linux-rt patches (which include this printk rework) *are* being
> ported to mainline now. My recommendation is to continue using the
> linux-rt patches (with PREEMPT_RT=y) until PREEMPT_RT is available
> mainline.

That's an extremely useful feedback. However, I still see non-trivial
differences between mainline and linux-rt-devel:

$ git diff --shortstat v5.4.13..v5.4.13-rt7
  401 files changed, 9577 insertions(+), 3616 deletions(-)

I would be happy to see this slimming down over time. If there is any
roadmap publicly available, I would appreciate a reference.

> 
> John Ogness

Thanks again!

> 
> > [1] https://lore.kernel.org/lkml/20190212143003.48446-1-john.ogness@linutronix.de/
> > [2] H3ULCB> speaker-test -f24_LE -c2 -t wav -Dplughw:rcarsound -b 4000
> >     https://vocaroo.com/9NV98mMgdjX
> > [3] https://github.com/erosca/linux/tree/stress-serial
> > [4] https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/

-- 
Best Regards
Eugeniu Rosca
