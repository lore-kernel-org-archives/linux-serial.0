Return-Path: <SRS0=xhGe=3J=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE5B6C32771
	for <linux-serial@archiver.kernel.org>; Mon, 20 Jan 2020 23:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EF7A22522
	for <linux-serial@archiver.kernel.org>; Mon, 20 Jan 2020 23:05:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbgATXFe (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 20 Jan 2020 18:05:34 -0500
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:57058 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbgATXFe (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 20 Jan 2020 18:05:34 -0500
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id 87A943C04C1;
        Tue, 21 Jan 2020 00:05:31 +0100 (CET)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 2kw2xE_nrUve; Tue, 21 Jan 2020 00:05:26 +0100 (CET)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id 4B12F3C00C5;
        Tue, 21 Jan 2020 00:05:26 +0100 (CET)
Received: from lxhi-065.adit-jv.com (10.72.93.66) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.468.0; Tue, 21 Jan
 2020 00:05:25 +0100
Date:   Tue, 21 Jan 2020 00:05:22 +0100
From:   Eugeniu Rosca <erosca@de.adit-jv.com>
To:     John Ogness <john.ogness@linutronix.de>
CC:     <linux-kernel@vger.kernel.org>,
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
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: Re: [RFC PATCH v1 00/25] printk: new implementation
Message-ID: <20200120230522.GA23636@lxhi-065.adit-jv.com>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190212143003.48446-1-john.ogness@linutronix.de>
X-Originating-IP: [10.72.93.66]
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hello John, all,

Cc: Geert, Morimoto-san,

On Tue, Feb 12, 2019 at 03:29:38PM +0100, John Ogness wrote:
> Hello,
> 
> As probably many of you are aware, the current printk implementation
> has some issues. This series (against 5.0-rc6) makes some fundamental
> changes in an attempt to address these issues. The particular issues I
> am referring to:
> 
> 1. The printk buffer is protected by a global raw spinlock for readers
>    and writers. This restricts the contexts that are allowed to
>    access the buffer.
> 
> 2. Because of #1, NMI and recursive contexts are handled by deferring
>    logging/printing to a spinlock-safe context. This means that
>    messages will not be visible if (for example) the kernel dies in
>    NMI context and the irq_work mechanism does not survive.
> 
> 3. Because of #1, when *not* using features such as PREEMPT_RT, large
>    latencies exist when printing to slow consoles.

This [1] is a fairly old thread, but I only recently stumbled upon it,
while co-investigating below audio distortions [2] on R-Car3 ARM64
boards, which can be reproduced by stressing [3] the serial console.

The investigation started a few months ago, when users reported
audio drops during the first seconds of system startup. Only after
a few weeks it became clear (thanks to some people in Cc) that the
distortions were contributed by the above-average serial console load
during the early boot. Once understood, we were able to come up with
a synthetic test [2-3].

I thought it would be interesting to share below reproduction matrix,
in order to contrast vanilla to linux-rt-devel [4], as well as to
compare various preemption models.
 
                           | Ser.console  Ser.console
                           | stressed     at rest or disabled
      --------------------------------------------
      v5.5-rc6 (PREEMPT=y) | distorted    clean
    v5.4.5-rt3 (PREEMPT=y) | distorted    clean
 v5.4.5-rt3 (PREEMPT_RT=y) | clean        clean

My feeling is that the results probably do not surprise linux-rt people.

My first question is, should there be any improvement in the case of
v5.4.5-rt3 (PREEMPT=y), which I do not sense? I would expect so, based
on the cover letter of this series (pointing out the advantages of the
redesigned printk mechanism).

And the other question is, how would you, generally speaking, tackle
the problem, given that backporting the linux-rt patches is *not* an
option and enabling serial console is a must?

[1] https://lore.kernel.org/lkml/20190212143003.48446-1-john.ogness@linutronix.de/
[2] H3ULCB> speaker-test -f24_LE -c2 -t wav -Dplughw:rcarsound -b 4000
    https://vocaroo.com/9NV98mMgdjX
[3] https://github.com/erosca/linux/tree/stress-serial
[4] https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/

-- 
Best Regards,
Eugeniu
