Return-Path: <SRS0=aJ84=3L=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ADD3C2D0DB
	for <linux-serial@archiver.kernel.org>; Wed, 22 Jan 2020 10:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBB1924683
	for <linux-serial@archiver.kernel.org>; Wed, 22 Jan 2020 10:33:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729277AbgAVKdn (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 22 Jan 2020 05:33:43 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:37255 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728931AbgAVKdn (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 22 Jan 2020 05:33:43 -0500
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1iuDJy-00005h-JH; Wed, 22 Jan 2020 11:33:14 +0100
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
        <87v9p4mkhr.fsf@linutronix.de>
        <20200122023422.GA926@lxhi-065.adit-jv.com>
Date:   Wed, 22 Jan 2020 11:33:12 +0100
In-Reply-To: <20200122023422.GA926@lxhi-065.adit-jv.com> (Eugeniu Rosca's
        message of "Wed, 22 Jan 2020 03:34:22 +0100")
Message-ID: <87zhefu6fr.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 2020-01-22, Eugeniu Rosca <erosca@de.adit-jv.com> wrote:
> So, what's specific to R-Car3, based on my testing, is that the issue
> can only be reproduced if the printk storm originates on CPU0 (it does
> not matter if from interrupt or task context, both have been
> tested). If the printk storm is initiated on any other CPU (there are
> 7 secondary ones on R-Car H3), there is no regression in the audio
> quality/latency.
>
> I cannot fully explain this empirical observation, but it directs my
> mind to the following workaround, for which I have a PoC:
>  - employ vprintk_safe() any time CPU0 is the owner/caller of printk
>  - tie CPU0-private printk internal IRQ workers to another CPU
>
> The above makes sure nothing is printed to the serial console on
> behalf of CPU0. I don't even hope this to be accepted by community,
> but can you please share your opinion the idea itself is sane?

It is a problem-specific hack. You will need to be certain that CPU1-7
will never have problems with console printing storms.

Be aware that vprintk_safe() is not particularly reliable in many crash
scenarios. If seeing oops output on the console is important, this can
be a risky hack.

Also, be aware that it has its own config option for the safe buffer
size: PRINTK_SAFE_LOG_BUF_SHIFT

>> The printk rework focusses on making printk non-interfering by
>> decoupling console printing from printk() callers. However, the
>> console printing itself will still do just as much interrupt
>> disabling as before. That is driver-related, not printk-related.
>
> I didn't dive into the internals of this series, but decoupling the
> execution context of the serial driver from the execution context of
> the printk callers sounds very good to me (this is what i try to
> achieve via vanilla vprintk_safe). I wonder if it's easier to remove
> CPU0 from equation with this series applied.

Yes, it would be quite easy. The console printers run as dedicated
kthreads. It is only a matter of setting the CPU affinity for the
related kthread.

>> The linux-rt patches (which include this printk rework) *are* being
>> ported to mainline now. My recommendation is to continue using the
>> linux-rt patches (with PREEMPT_RT=y) until PREEMPT_RT is available
>> mainline.
>
> If there is any roadmap publicly available, I would appreciate a
> reference.

I am only aware of the quilt "series" file [0] that is roughly
documenting the status of the effort.

John Ogness

[0] https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/tree/patches/series?h=linux-5.4.y-rt-patches
