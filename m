Return-Path: <SRS0=aYao=3N=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E17DAC2D0DB
	for <linux-serial@archiver.kernel.org>; Fri, 24 Jan 2020 12:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCEA2206D4
	for <linux-serial@archiver.kernel.org>; Fri, 24 Jan 2020 12:14:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729396AbgAXMOF (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 24 Jan 2020 07:14:05 -0500
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:55183 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731628AbgAXMOF (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 24 Jan 2020 07:14:05 -0500
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id 7DAD63C00C5;
        Fri, 24 Jan 2020 13:14:01 +0100 (CET)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 2nUthvKNpzTE; Fri, 24 Jan 2020 13:13:56 +0100 (CET)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id 457193C009E;
        Fri, 24 Jan 2020 13:13:56 +0100 (CET)
Received: from lxhi-065.adit-jv.com (10.72.93.66) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.468.0; Fri, 24 Jan
 2020 13:13:55 +0100
Date:   Fri, 24 Jan 2020 13:13:53 +0100
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
Message-ID: <20200124121353.GA22616@lxhi-065.adit-jv.com>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
 <20200120230522.GA23636@lxhi-065.adit-jv.com>
 <87v9p4mkhr.fsf@linutronix.de>
 <20200122023422.GA926@lxhi-065.adit-jv.com>
 <87zhefu6fr.fsf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87zhefu6fr.fsf@linutronix.de>
X-Originating-IP: [10.72.93.66]
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi John,

On Wed, Jan 22, 2020 at 11:33:12AM +0100, John Ogness wrote:
> On 2020-01-22, Eugeniu Rosca <erosca@de.adit-jv.com> wrote:
> > So, what's specific to R-Car3, based on my testing, is that the issue
> > can only be reproduced if the printk storm originates on CPU0 (it does
> > not matter if from interrupt or task context, both have been
> > tested). If the printk storm is initiated on any other CPU (there are
> > 7 secondary ones on R-Car H3), there is no regression in the audio
> > quality/latency.
> >
> > I cannot fully explain this empirical observation, but it directs my
> > mind to the following workaround, for which I have a PoC:
> >  - employ vprintk_safe() any time CPU0 is the owner/caller of printk
> >  - tie CPU0-private printk internal IRQ workers to another CPU
> >
> > The above makes sure nothing is printed to the serial console on
> > behalf of CPU0. I don't even hope this to be accepted by community,
> > but can you please share your opinion the idea itself is sane?
> 
> It is a problem-specific hack. You will need to be certain that CPU1-7
> will never have problems with console printing storms.
> 
> Be aware that vprintk_safe() is not particularly reliable in many crash
> scenarios. If seeing oops output on the console is important, this can
> be a risky hack.
> 
> Also, be aware that it has its own config option for the safe buffer
> size: PRINTK_SAFE_LOG_BUF_SHIFT

The warnings and pitfalls are much appreciated. Also, this whole
discussion has been referenced in the recently started communication
thread with Renesas, to raise the awareness of what looks to be not
only the limitation of Renesas BSP, but the mainline kernel in the
first place.

> >> The printk rework focusses on making printk non-interfering by
> >> decoupling console printing from printk() callers. However, the
> >> console printing itself will still do just as much interrupt
> >> disabling as before. That is driver-related, not printk-related.
> >
> > I didn't dive into the internals of this series, but decoupling the
> > execution context of the serial driver from the execution context of
> > the printk callers sounds very good to me (this is what i try to
> > achieve via vanilla vprintk_safe). I wonder if it's easier to remove
> > CPU0 from equation with this series applied.
> 
> Yes, it would be quite easy. The console printers run as dedicated
> kthreads. It is only a matter of setting the CPU affinity for the
> related kthread.

Confirmed. Below two lines do the job (v5.4.13-rt7+).

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 0605a74ad76b..7bc2cdabf516 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2733,11 +2733,12 @@ static int __init init_printk_kthread(void)
 {
        struct task_struct *thread;

-       thread = kthread_run(printk_kthread_func, NULL, "printk");
+       thread = kthread_create_on_cpu(printk_kthread_func, NULL, 7, "printk");
        if (IS_ERR(thread)) {
                pr_err("printk: unable to create printing thread\n");
                return PTR_ERR(thread);
        }
+       wake_up_process(thread);

        return 0;
 }

>
> >> The linux-rt patches (which include this printk rework) *are* being
> >> ported to mainline now. My recommendation is to continue using the
> >> linux-rt patches (with PREEMPT_RT=y) until PREEMPT_RT is available
> >> mainline.

This has been relayed to Renesas. Thanks.

> >
> > If there is any roadmap publicly available, I would appreciate a
> > reference.
> 
> I am only aware of the quilt "series" file [0] that is roughly
> documenting the status of the effort.
> 
> John Ogness
> 
> [0] https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/tree/patches/series?h=linux-5.4.y-rt-patches

Great.

-- 
Best Regards
Eugeniu Rosca
