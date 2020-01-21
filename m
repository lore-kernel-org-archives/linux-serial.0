Return-Path: <SRS0=m7Km=3K=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8180DC2D0CE
	for <linux-serial@archiver.kernel.org>; Tue, 21 Jan 2020 23:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D5BE20882
	for <linux-serial@archiver.kernel.org>; Tue, 21 Jan 2020 23:57:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgAUX5Y (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 21 Jan 2020 18:57:24 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36365 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgAUX5X (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 21 Jan 2020 18:57:23 -0500
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1iu3O9-0006uj-7Y; Wed, 22 Jan 2020 00:56:53 +0100
From:   John Ogness <john.ogness@linutronix.de>
To:     Eugeniu Rosca <erosca@de.adit-jv.com>
Cc:     <linux-kernel@vger.kernel.org>,
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
References: <20190212143003.48446-1-john.ogness@linutronix.de>
        <20200120230522.GA23636@lxhi-065.adit-jv.com>
Date:   Wed, 22 Jan 2020 00:56:48 +0100
In-Reply-To: <20200120230522.GA23636@lxhi-065.adit-jv.com> (Eugeniu Rosca's
        message of "Tue, 21 Jan 2020 00:05:22 +0100")
Message-ID: <87v9p4mkhr.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hello Eugeniu,

On 2020-01-21, Eugeniu Rosca <erosca@de.adit-jv.com> wrote:
> This [1] is a fairly old thread, but I only recently stumbled upon it,
> while co-investigating below audio distortions [2] on R-Car3 ARM64
> boards, which can be reproduced by stressing [3] the serial console.
>
> The investigation started a few months ago, when users reported audio
> drops during the first seconds of system startup. Only after a few
> weeks it became clear (thanks to some people in Cc) that the
> distortions were contributed by the above-average serial console load
> during the early boot. Once understood, we were able to come up with a
> synthetic test [2-3].
>
> I thought it would be interesting to share below reproduction matrix,
> in order to contrast vanilla to linux-rt-devel [4], as well as to
> compare various preemption models.
>  
>                            | Ser.console  Ser.console
>                            | stressed     at rest or disabled
>       --------------------------------------------
>       v5.5-rc6 (PREEMPT=y) | distorted    clean
>     v5.4.5-rt3 (PREEMPT=y) | distorted    clean
>  v5.4.5-rt3 (PREEMPT_RT=y) | clean        clean
>
> My feeling is that the results probably do not surprise linux-rt
> people.
>
> My first question is, should there be any improvement in the case of
> v5.4.5-rt3 (PREEMPT=y), which I do not sense? I would expect so, based
> on the cover letter of this series (pointing out the advantages of the
> redesigned printk mechanism).

The problem you are reporting is not the problem that the printk rework
is trying to solve.

In your chart, v5.4.5-rt3 (PREEMPT_RT=y) is the only configuration that
is _not_ disabling hardware interrupts during UART activity. I would
guess your problem is due to interrupts being disabled for unacceptable
lengths of time. You need a low-latency system, so PREEMPT_RT=y _is_ the
correct (and only) solution if a verbose serial console is a must.

The printk rework focusses on making printk non-interfering by
decoupling console printing from printk() callers. However, the console
printing itself will still do just as much interrupt disabling as
before. That is driver-related, not printk-related.

> And the other question is, how would you, generally speaking, tackle
> the problem, given that backporting the linux-rt patches is *not* an
> option and enabling serial console is a must?

The linux-rt patches (which include this printk rework) *are* being
ported to mainline now. My recommendation is to continue using the
linux-rt patches (with PREEMPT_RT=y) until PREEMPT_RT is available
mainline.

John Ogness

> [1] https://lore.kernel.org/lkml/20190212143003.48446-1-john.ogness@linutronix.de/
> [2] H3ULCB> speaker-test -f24_LE -c2 -t wav -Dplughw:rcarsound -b 4000
>     https://vocaroo.com/9NV98mMgdjX
> [3] https://github.com/erosca/linux/tree/stress-serial
> [4] https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/
