Return-Path: <SRS0=NYZD=3Q=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B4AC2D0DB
	for <linux-serial@archiver.kernel.org>; Mon, 27 Jan 2020 13:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33E7D20716
	for <linux-serial@archiver.kernel.org>; Mon, 27 Jan 2020 13:45:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726164AbgA0Npr (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 27 Jan 2020 08:45:47 -0500
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:36180 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgA0Npr (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 27 Jan 2020 08:45:47 -0500
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id C153C3C00C5;
        Mon, 27 Jan 2020 14:45:43 +0100 (CET)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 736QoBKuGmnG; Mon, 27 Jan 2020 14:45:38 +0100 (CET)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id 862CA3C009E;
        Mon, 27 Jan 2020 14:45:38 +0100 (CET)
Received: from lxhi-065.adit-jv.com (10.72.93.66) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.468.0; Mon, 27 Jan
 2020 14:45:38 +0100
Date:   Mon, 27 Jan 2020 14:45:35 +0100
From:   Eugeniu Rosca <erosca@de.adit-jv.com>
To:     Petr Mladek <pmladek@suse.com>
CC:     Eugeniu Rosca <erosca@de.adit-jv.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        John Ogness <john.ogness@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Andrew Gabbasov <andrew_gabbasov@mentor.com>,
        Sanjeev Chugh <sanjeev_chugh@mentor.com>,
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
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: Re: [RFC PATCH v1 00/25] printk: new implementation
Message-ID: <20200127134535.GA4439@lxhi-065.adit-jv.com>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
 <20200120230522.GA23636@lxhi-065.adit-jv.com>
 <87v9p4mkhr.fsf@linutronix.de>
 <20200122023422.GA926@lxhi-065.adit-jv.com>
 <CAMuHMdXT9USuHw15nA1mLXsh7RKK68eN0phevC_Jauaa7FnW0Q@mail.gmail.com>
 <20200122165855.GA3485@lxhi-065.adit-jv.com>
 <CAMuHMdWzapJ+5Jtf5fPQGP5edzCUfMeQA7v3GVWbKKvR=aXSsg@mail.gmail.com>
 <20200124160929.GA10863@lxhi-065.adit-jv.com>
 <20200127123249.t7agkht3ddgetfhf@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200127123249.t7agkht3ddgetfhf@pathway.suse.cz>
X-Originating-IP: [10.72.93.66]
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Petr,

Thank you for your insights.

On Mon, Jan 27, 2020 at 01:32:49PM +0100, Petr Mladek wrote:
> On Fri 2020-01-24 17:09:29, Eugeniu Rosca wrote:
> > On Wed, Jan 22, 2020 at 08:48:12PM +0100, Geert Uytterhoeven wrote:
> > > On Wed, Jan 22, 2020 at 5:59 PM Eugeniu Rosca <erosca@de.adit-jv.com> wrote:
> > > > On Wed, Jan 22, 2020 at 08:31:44AM +0100, Geert Uytterhoeven wrote:
> > > > > On Wed, Jan 22, 2020 at 3:34 AM Eugeniu Rosca <erosca@de.adit-jv.com> wrote:
> > > > > > So, what's specific to R-Car3, based on my testing, is that the issue
> > > > > > can only be reproduced if the printk storm originates on CPU0
> > 
> > Slight amendment the above statement. Below results are got on R-Car
> > H3ULCB running renesas-drivers-2020-01-14-v5.5-rc6 (cX stands for CPUx,
> > whitespace stands for clean audio, '!' stands for distorted audio):
> > 
> >                   printk @:
> >                   c0 c1 c2 c3 c4 c5 c6 c7
> > speaker-test @ c0 !
> >                c1 !  !
> >                c2 !     !
> >                c3 !        !
> >                c4 !           !
> >                c5 !              !
> >                c6 !                 !
> >                c7 !                    !
> > 
> > One can see two patterns in the chart. The audio has glitches whenever:
> >  - printk and the audio application run on the same CPU, or:
> >  - printk runs on CPU0
> 
> The proper longterm solution seems to be offloading printk console
> handling to a kthread so that it can be bound to a particular CPU
> and does not block audio.

Same understanding here. I don't think this is possible w/o the full
switch to the kthread-based concept proposed in this series (I sought
an easier way out, but failed).

Even after pinning the printk kthread to CPUn, we still accept living
with the huge latencies of the console drivers on CPUn. To avoid audio
glitches being caused by the serial console, userspace would need to
additionally blacklist CPUn from any RT workloads by setting the core
affinity of audio applications appropriately.

The above imposes certain constraints on the CPU partitioning in the
system, but that's the most mainline-friendly solution I can think of.
Any alternative views would be appreciated.

> 
> Anyway, there is a question whether you really need to send all messages
> via the serial console. It might make sense to filter less important
> messages using "loglevel=" or "quiet" kernel parameters. The full
> log can be read later from userspace (dmesg, syslog, /dev/kmsg).
> Filtering can get disabled when debugging non-booting kernel.
> In this case, a distorted audio is the least problem.

This has been discussed in detail with the reporters of the issue.
Yes, it might be an infrequent requirement in general, but the goal
is to achieve clean audio even (and specifically) with verbose
serial console output.

-- 
Best Regards
Eugeniu Rosca
