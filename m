Return-Path: <SRS0=aJ84=3L=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URI_HEX autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00901C2D0DB
	for <linux-serial@archiver.kernel.org>; Wed, 22 Jan 2020 16:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1DA921569
	for <linux-serial@archiver.kernel.org>; Wed, 22 Jan 2020 16:59:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbgAVQ7I (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 22 Jan 2020 11:59:08 -0500
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:43452 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbgAVQ7I (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 22 Jan 2020 11:59:08 -0500
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id 3CBC73C04C1;
        Wed, 22 Jan 2020 17:59:04 +0100 (CET)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id nI6eqQzdtFkL; Wed, 22 Jan 2020 17:58:59 +0100 (CET)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id 05F543C00C5;
        Wed, 22 Jan 2020 17:58:59 +0100 (CET)
Received: from lxhi-065.adit-jv.com (10.72.93.66) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.468.0; Wed, 22 Jan
 2020 17:58:58 +0100
Date:   Wed, 22 Jan 2020 17:58:55 +0100
From:   Eugeniu Rosca <erosca@de.adit-jv.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Eugeniu Rosca <erosca@de.adit-jv.com>,
        John Ogness <john.ogness@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: Re: [RFC PATCH v1 00/25] printk: new implementation
Message-ID: <20200122165855.GA3485@lxhi-065.adit-jv.com>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
 <20200120230522.GA23636@lxhi-065.adit-jv.com>
 <87v9p4mkhr.fsf@linutronix.de>
 <20200122023422.GA926@lxhi-065.adit-jv.com>
 <CAMuHMdXT9USuHw15nA1mLXsh7RKK68eN0phevC_Jauaa7FnW0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAMuHMdXT9USuHw15nA1mLXsh7RKK68eN0phevC_Jauaa7FnW0Q@mail.gmail.com>
X-Originating-IP: [10.72.93.66]
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Geert,

On Wed, Jan 22, 2020 at 08:31:44AM +0100, Geert Uytterhoeven wrote:
> On Wed, Jan 22, 2020 at 3:34 AM Eugeniu Rosca <erosca@de.adit-jv.com> wrote:
> >
> > So, what's specific to R-Car3, based on my testing, is that the issue
> > can only be reproduced if the printk storm originates on CPU0 (it does
> > not matter if from interrupt or task context, both have been tested). If
> > the printk storm is initiated on any other CPU (there are 7 secondary
> > ones on R-Car H3), there is no regression in the audio quality/latency.
> 
> The secure stuff is running on CPU0, isn't it?
> Is that a coincidence?

Nobody has ruled this out so far. As a side note, except for the ARMv8
generic IPs, there seems to be quite poor IRQ balancing between the
CPU cores of R-Car H3 (although this might be unrelated to the issue):

$ cat /proc/interrupts | egrep -v "(0[ ]*){8}"
         CPU0   CPU1   CPU2    CPU3 CPU4 CPU5  CPU6  CPU7       
  3:    55879  17835  14132   33882 6626 4331  6710  4532     GICv2  30 Level     arch_timer
 16:        1      0      0       0    0    0     0     0     GICv2  38 Level     e6052000.gpio
 32:      203      0      0       0    0    0     0     0     GICv2  51 Level     e66d8000.i2c
 33:       95      0      0       0    0    0     0     0     GICv2 205 Level     e60b0000.i2c
 94:    19339      0      0       0    0    0     0     0     GICv2  71 Level     eth0:ch0:rx_be
112:    20599      0      0       0    0    0     0     0     GICv2  89 Level     eth0:ch18:tx_be
118:        2      0      0       0    0    0     0     0     GICv2  95 Level     eth0:ch24:emac
122:   442092      0      0       0    0    0     0     0     GICv2 196 Level     e6e88000.serial:mux
124:  2776685      0      0       0    0    0     0     0     GICv2 352 Level     ec700000.dma-controller:0
160:     2896      0      0       0    0    0     0     0     GICv2 197 Level     ee100000.sd
161:     5652      0      0       0    0    0     0     0     GICv2 199 Level     ee140000.sd
162:      147      0      0       0    0    0     0     0     GICv2 200 Level     ee160000.sd
197:        5      0      0       0    0    0     0     0     GICv2 384 Level     ec500000.sound
208:        1      0      0       0    0    0     0     0  gpio-rcar  11 Level     e6800000.ethernet-ffffffff:00
IPI0:   12701 366358 545059 1869017 9817 8065  9327 10644       Rescheduling interrupts
IPI1:      21     34    111      86  238  191   149   161       Function call interrupts
IPI5:   16422    709    509     637    0    0  3346     0       IRQ work interrupts

BTW/FYI, I raised a bug report to Renesas and specifically asked them
to approach you, hoping that your massive experience in the serial
drivers will help. If you arrive to any conclusions in that context,
we would be delighted to hear from you.

-- 
Best Regards
Eugeniu Rosca
