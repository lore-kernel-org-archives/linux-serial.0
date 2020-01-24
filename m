Return-Path: <SRS0=aYao=3N=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA3D6C2D0DB
	for <linux-serial@archiver.kernel.org>; Fri, 24 Jan 2020 16:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7BF520702
	for <linux-serial@archiver.kernel.org>; Fri, 24 Jan 2020 16:09:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387539AbgAXQJl (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 24 Jan 2020 11:09:41 -0500
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:56970 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387515AbgAXQJl (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 24 Jan 2020 11:09:41 -0500
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id 590CD3C00C5;
        Fri, 24 Jan 2020 17:09:37 +0100 (CET)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id tJXrfdc7WK_a; Fri, 24 Jan 2020 17:09:32 +0100 (CET)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id 3EFD53C009E;
        Fri, 24 Jan 2020 17:09:32 +0100 (CET)
Received: from lxhi-065.adit-jv.com (10.72.93.66) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.468.0; Fri, 24 Jan
 2020 17:09:31 +0100
Date:   Fri, 24 Jan 2020 17:09:29 +0100
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
Message-ID: <20200124160929.GA10863@lxhi-065.adit-jv.com>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
 <20200120230522.GA23636@lxhi-065.adit-jv.com>
 <87v9p4mkhr.fsf@linutronix.de>
 <20200122023422.GA926@lxhi-065.adit-jv.com>
 <CAMuHMdXT9USuHw15nA1mLXsh7RKK68eN0phevC_Jauaa7FnW0Q@mail.gmail.com>
 <20200122165855.GA3485@lxhi-065.adit-jv.com>
 <CAMuHMdWzapJ+5Jtf5fPQGP5edzCUfMeQA7v3GVWbKKvR=aXSsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAMuHMdWzapJ+5Jtf5fPQGP5edzCUfMeQA7v3GVWbKKvR=aXSsg@mail.gmail.com>
X-Originating-IP: [10.72.93.66]
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Geert,

On Wed, Jan 22, 2020 at 08:48:12PM +0100, Geert Uytterhoeven wrote:
> On Wed, Jan 22, 2020 at 5:59 PM Eugeniu Rosca <erosca@de.adit-jv.com> wrote:
> > On Wed, Jan 22, 2020 at 08:31:44AM +0100, Geert Uytterhoeven wrote:
> > > On Wed, Jan 22, 2020 at 3:34 AM Eugeniu Rosca <erosca@de.adit-jv.com> wrote:
> > > > So, what's specific to R-Car3, based on my testing, is that the issue
> > > > can only be reproduced if the printk storm originates on CPU0

Slight amendment the above statement. Below results are got on R-Car
H3ULCB running renesas-drivers-2020-01-14-v5.5-rc6 (cX stands for CPUx,
whitespace stands for clean audio, '!' stands for distorted audio):

                  printk @:
                  c0 c1 c2 c3 c4 c5 c6 c7
speaker-test @ c0 !
               c1 !  !
               c2 !     !
               c3 !        !
               c4 !           !
               c5 !              !
               c6 !                 !
               c7 !                    !

One can see two patterns in the chart. The audio has glitches whenever:
 - printk and the audio application run on the same CPU, or:
 - printk runs on CPU0

> Yeah, cpu0 is always heavily loaded w.r.t. interrupts.
> Can you reproduce the problem after forcing all interrupts to e.g. cpu1?

With instrumentation shown in [1], the chart suffers below changes:

                  printk @:
                  c0 c1 c2 c3 c4 c5 c6 c7
speaker+test @ c0 !  !
               c1    !
               c2    !  !
               c3    !     !
               c4    !        !
               c5    !           !
               c6    !              !
               c7    !                 !

Any comments on the above empirical results?

[1] IRQ affinity set to CPU1

diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
index f06016d38a05..40003a3af4e0 100644
--- a/drivers/dma/sh/rcar-dmac.c
+++ b/drivers/dma/sh/rcar-dmac.c
@@ -1786,6 +1786,12 @@ static int rcar_dmac_chan_probe(struct rcar_dmac *dmac,
 		return ret;
 	}
 
+	ret = irq_set_affinity(rchan->irq, cpumask_of(1));
+	if (ret) {
+		dev_err(dmac->dev, "failed to set IRQ affinity %u (%d)\n", rchan->irq, ret);
+		return ret;
+	}
+
 	return 0;
 }
 
diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 9b4ff872e297..c76b38626b6b 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1926,6 +1926,11 @@ static int sci_request_irq(struct sci_port *port)
 			dev_err(up->dev, "Can't allocate %s IRQ\n", desc->desc);
 			goto out_noirq;
 		}
+		ret = irq_set_affinity(irq, cpumask_of(1));
+		if (ret) {
+			dev_err(up->dev, "failed to set IRQ affinity %u (%d)\n", irq, ret);
+			return ret;
+		}
 	}
 
 	return 0;

-- 
Best Regards
Eugeniu Rosca
