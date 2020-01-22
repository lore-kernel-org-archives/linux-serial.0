Return-Path: <SRS0=aJ84=3L=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URI_HEX autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82DF0C2D0DB
	for <linux-serial@archiver.kernel.org>; Wed, 22 Jan 2020 19:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F04B24656
	for <linux-serial@archiver.kernel.org>; Wed, 22 Jan 2020 19:48:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbgAVTs1 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 22 Jan 2020 14:48:27 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:35924 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbgAVTs0 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 22 Jan 2020 14:48:26 -0500
Received: by mail-oi1-f194.google.com with SMTP id c16so595875oic.3;
        Wed, 22 Jan 2020 11:48:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FTYosi5E8b0UvT0IIJB49JTgYDLWPWJYw7Wd7KCpaU4=;
        b=lkdFNnJUneNQeHeIZa6xjBgStB9CG5BdXiHPDAAbsQww3dtKaxazr8lSyPLzmnEZyT
         mNp0I6bLNULM4H2i2NixK9B/7nm0QSWRIRm0MikLrQFsnbgCsaOSrDdjfdMkrwOWvK4L
         Hv4HDG6U82rhk6bjWJytuCAPh4LEj2cTh1smH5z/J1DDnUUv5HvOmVJTGtRV5H1vJZV3
         LLhIwbQ/RhkO0F9+qCd4eUVbtXxvJhh4lGkOG7dJtsmpat87F8Kg/MqeFuPdiukZAEqs
         9VAdsU4WkiGdZUFIdNZRYD27roJYrpFLkA3qw7t22hBA8sNKjScvsmfYzOzlrTvolLfi
         IERg==
X-Gm-Message-State: APjAAAWvlvPlgofOF1W2JFS9w/kzumhIoRf5/0IV0tpHPCY7xhjvd/vK
        YXrwnKi6bTNumrVOz4o8eFXINHY4lRjyAlsTBQ4=
X-Google-Smtp-Source: APXvYqzL6Zjs2GnkkVfslcTmqATM74cyT+fFAHdA4qJPTJkaotMtM+AaPNR12+mep+vfAHrT98V9Vamst6Rdu7njGJY=
X-Received: by 2002:aca:5905:: with SMTP id n5mr8201223oib.54.1579722505882;
 Wed, 22 Jan 2020 11:48:25 -0800 (PST)
MIME-Version: 1.0
References: <20190212143003.48446-1-john.ogness@linutronix.de>
 <20200120230522.GA23636@lxhi-065.adit-jv.com> <87v9p4mkhr.fsf@linutronix.de>
 <20200122023422.GA926@lxhi-065.adit-jv.com> <CAMuHMdXT9USuHw15nA1mLXsh7RKK68eN0phevC_Jauaa7FnW0Q@mail.gmail.com>
 <20200122165855.GA3485@lxhi-065.adit-jv.com>
In-Reply-To: <20200122165855.GA3485@lxhi-065.adit-jv.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 22 Jan 2020 20:48:12 +0100
Message-ID: <CAMuHMdWzapJ+5Jtf5fPQGP5edzCUfMeQA7v3GVWbKKvR=aXSsg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 00/25] printk: new implementation
To:     Eugeniu Rosca <erosca@de.adit-jv.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Eugeniu,

On Wed, Jan 22, 2020 at 5:59 PM Eugeniu Rosca <erosca@de.adit-jv.com> wrote:
> On Wed, Jan 22, 2020 at 08:31:44AM +0100, Geert Uytterhoeven wrote:
> > On Wed, Jan 22, 2020 at 3:34 AM Eugeniu Rosca <erosca@de.adit-jv.com> wrote:
> > > So, what's specific to R-Car3, based on my testing, is that the issue
> > > can only be reproduced if the printk storm originates on CPU0 (it does
> > > not matter if from interrupt or task context, both have been tested). If
> > > the printk storm is initiated on any other CPU (there are 7 secondary
> > > ones on R-Car H3), there is no regression in the audio quality/latency.
> >
> > The secure stuff is running on CPU0, isn't it?
> > Is that a coincidence?
>
> Nobody has ruled this out so far. As a side note, except for the ARMv8
> generic IPs, there seems to be quite poor IRQ balancing between the
> CPU cores of R-Car H3 (although this might be unrelated to the issue):
>
> $ cat /proc/interrupts | egrep -v "(0[ ]*){8}"
>          CPU0   CPU1   CPU2    CPU3 CPU4 CPU5  CPU6  CPU7
>   3:    55879  17835  14132   33882 6626 4331  6710  4532     GICv2  30 Level     arch_timer
>  16:        1      0      0       0    0    0     0     0     GICv2  38 Level     e6052000.gpio
>  32:      203      0      0       0    0    0     0     0     GICv2  51 Level     e66d8000.i2c
>  33:       95      0      0       0    0    0     0     0     GICv2 205 Level     e60b0000.i2c
>  94:    19339      0      0       0    0    0     0     0     GICv2  71 Level     eth0:ch0:rx_be
> 112:    20599      0      0       0    0    0     0     0     GICv2  89 Level     eth0:ch18:tx_be
> 118:        2      0      0       0    0    0     0     0     GICv2  95 Level     eth0:ch24:emac
> 122:   442092      0      0       0    0    0     0     0     GICv2 196 Level     e6e88000.serial:mux
> 124:  2776685      0      0       0    0    0     0     0     GICv2 352 Level     ec700000.dma-controller:0
> 160:     2896      0      0       0    0    0     0     0     GICv2 197 Level     ee100000.sd
> 161:     5652      0      0       0    0    0     0     0     GICv2 199 Level     ee140000.sd
> 162:      147      0      0       0    0    0     0     0     GICv2 200 Level     ee160000.sd
> 197:        5      0      0       0    0    0     0     0     GICv2 384 Level     ec500000.sound
> 208:        1      0      0       0    0    0     0     0  gpio-rcar  11 Level     e6800000.ethernet-ffffffff:00
> IPI0:   12701 366358 545059 1869017 9817 8065  9327 10644       Rescheduling interrupts
> IPI1:      21     34    111      86  238  191   149   161       Function call interrupts
> IPI5:   16422    709    509     637    0    0  3346     0       IRQ work interrupts

Yeah, cpu0 is always heavily loaded w.r.t. interrupts.
Can you reproduce the problem after forcing all interrupts to e.g. cpu1?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
