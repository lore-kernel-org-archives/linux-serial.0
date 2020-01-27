Return-Path: <SRS0=NYZD=3Q=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AFE0C2D0DB
	for <linux-serial@archiver.kernel.org>; Mon, 27 Jan 2020 12:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC793206F0
	for <linux-serial@archiver.kernel.org>; Mon, 27 Jan 2020 12:32:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729800AbgA0Mcy (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 27 Jan 2020 07:32:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:56856 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727326AbgA0Mcy (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 27 Jan 2020 07:32:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 32B08AAD0;
        Mon, 27 Jan 2020 12:32:50 +0000 (UTC)
Date:   Mon, 27 Jan 2020 13:32:49 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Eugeniu Rosca <erosca@de.adit-jv.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
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
Message-ID: <20200127123249.t7agkht3ddgetfhf@pathway.suse.cz>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
 <20200120230522.GA23636@lxhi-065.adit-jv.com>
 <87v9p4mkhr.fsf@linutronix.de>
 <20200122023422.GA926@lxhi-065.adit-jv.com>
 <CAMuHMdXT9USuHw15nA1mLXsh7RKK68eN0phevC_Jauaa7FnW0Q@mail.gmail.com>
 <20200122165855.GA3485@lxhi-065.adit-jv.com>
 <CAMuHMdWzapJ+5Jtf5fPQGP5edzCUfMeQA7v3GVWbKKvR=aXSsg@mail.gmail.com>
 <20200124160929.GA10863@lxhi-065.adit-jv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200124160929.GA10863@lxhi-065.adit-jv.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri 2020-01-24 17:09:29, Eugeniu Rosca wrote:
> Hi Geert,
> 
> On Wed, Jan 22, 2020 at 08:48:12PM +0100, Geert Uytterhoeven wrote:
> > On Wed, Jan 22, 2020 at 5:59 PM Eugeniu Rosca <erosca@de.adit-jv.com> wrote:
> > > On Wed, Jan 22, 2020 at 08:31:44AM +0100, Geert Uytterhoeven wrote:
> > > > On Wed, Jan 22, 2020 at 3:34 AM Eugeniu Rosca <erosca@de.adit-jv.com> wrote:
> > > > > So, what's specific to R-Car3, based on my testing, is that the issue
> > > > > can only be reproduced if the printk storm originates on CPU0
> 
> Slight amendment the above statement. Below results are got on R-Car
> H3ULCB running renesas-drivers-2020-01-14-v5.5-rc6 (cX stands for CPUx,
> whitespace stands for clean audio, '!' stands for distorted audio):
> 
>                   printk @:
>                   c0 c1 c2 c3 c4 c5 c6 c7
> speaker-test @ c0 !
>                c1 !  !
>                c2 !     !
>                c3 !        !
>                c4 !           !
>                c5 !              !
>                c6 !                 !
>                c7 !                    !
> 
> One can see two patterns in the chart. The audio has glitches whenever:
>  - printk and the audio application run on the same CPU, or:
>  - printk runs on CPU0

The proper longterm solution seems to be offloading printk console
handling to a kthread so that it can be bound to a particular CPU
and does not block audio.

Anyway, there is a question whether you really need to send all messages
via the serial console. It might make sense to filter less important
messages using "loglevel=" or "quiet" kernel parameters. The full
log can be read later from userspace (dmesg, syslog, /dev/kmsg).
Filtering can get disabled when debugging non-booting kernel.
In this case, a distorted audio is the least problem.

Best Regards,
Petr
