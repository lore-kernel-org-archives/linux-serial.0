Return-Path: <SRS0=aJ84=3L=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55FFFC32771
	for <linux-serial@archiver.kernel.org>; Wed, 22 Jan 2020 07:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F4452253D
	for <linux-serial@archiver.kernel.org>; Wed, 22 Jan 2020 07:31:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725911AbgAVHb5 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 22 Jan 2020 02:31:57 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:44355 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgAVHb5 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 22 Jan 2020 02:31:57 -0500
Received: by mail-oi1-f193.google.com with SMTP id d62so5187162oia.11;
        Tue, 21 Jan 2020 23:31:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RqVNk/s/kihSN6HM/Xmr4Y73WPhhKATV/QFQjnujpGg=;
        b=nJRSl2fSm18QROdiFpbHUDOaYyDmK8vbbYkRZUGkbHC9Ybn7U22QmcJrsPYOfZhM1F
         U18hf5/hAtdgeHh7x/+jb6Af7u431VGhT+/KH7FYrYcPAu3BooWbMxESMYcSo/2FkiXY
         nSKFNPEBWO+oudG6FG6qINt0DXzQqFsILmnOvw5GNt+HmeY/H5nnKUSjhBtjlOL9VWxI
         UiIyIq0RBMDGfbE13o5FeUMj75hv7WYB+HjkERu43AcyZHNgeKDvaK6FUV+HqGbMPq+Z
         lLeN74uwKQ4qia7kmeK06JGw9KZNIQr0eXqs2n7gwhI/bzJfZMqkWMhympN+7uXN6iiN
         Q1oA==
X-Gm-Message-State: APjAAAULh8+p3VgMlXxQtQBTn/nXuTAuxah7uDSwWoyvOoHw2sP3uJrh
        CBfjnqnqqNOvrevyl1vfCZ6IicKi7jKVFN62Rqo=
X-Google-Smtp-Source: APXvYqy6HgiLyUhCyYc9fYH8fE1+mOcTDNClquSwMdkOlnTVa3GkzPfrnfP2otxXLIHVLiOx/a+6DUa2KS2lgphvxTs=
X-Received: by 2002:a05:6808:292:: with SMTP id z18mr5610666oic.131.1579678316554;
 Tue, 21 Jan 2020 23:31:56 -0800 (PST)
MIME-Version: 1.0
References: <20190212143003.48446-1-john.ogness@linutronix.de>
 <20200120230522.GA23636@lxhi-065.adit-jv.com> <87v9p4mkhr.fsf@linutronix.de> <20200122023422.GA926@lxhi-065.adit-jv.com>
In-Reply-To: <20200122023422.GA926@lxhi-065.adit-jv.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 22 Jan 2020 08:31:44 +0100
Message-ID: <CAMuHMdXT9USuHw15nA1mLXsh7RKK68eN0phevC_Jauaa7FnW0Q@mail.gmail.com>
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

On Wed, Jan 22, 2020 at 3:34 AM Eugeniu Rosca <erosca@de.adit-jv.com> wrote:
> On Wed, Jan 22, 2020 at 12:56:48AM +0100, John Ogness wrote:
> > On 2020-01-21, Eugeniu Rosca <erosca@de.adit-jv.com> wrote:
> > > This [1] is a fairly old thread, but I only recently stumbled upon it,
> > > while co-investigating below audio distortions [2] on R-Car3 ARM64
> > > boards, which can be reproduced by stressing [3] the serial console.
> > >
> > > The investigation started a few months ago, when users reported audio
> > > drops during the first seconds of system startup. Only after a few
> > > weeks it became clear (thanks to some people in Cc) that the
> > > distortions were contributed by the above-average serial console load
> > > during the early boot. Once understood, we were able to come up with a
> > > synthetic test [2-3].
> > >
> > > I thought it would be interesting to share below reproduction matrix,
> > > in order to contrast vanilla to linux-rt-devel [4], as well as to
> > > compare various preemption models.
> > >
> > >                            | Ser.console  Ser.console
> > >                            | stressed     at rest or disabled
> > >       --------------------------------------------
> > >       v5.5-rc6 (PREEMPT=y) | distorted    clean
> > >     v5.4.5-rt3 (PREEMPT=y) | distorted    clean
> > >  v5.4.5-rt3 (PREEMPT_RT=y) | clean        clean
> > >
> > > My feeling is that the results probably do not surprise linux-rt
> > > people.
> > >
> > > My first question is, should there be any improvement in the case of
> > > v5.4.5-rt3 (PREEMPT=y), which I do not sense? I would expect so, based
> > > on the cover letter of this series (pointing out the advantages of the
> > > redesigned printk mechanism).
> >
> > The problem you are reporting is not the problem that the printk rework
> > is trying to solve.
>
> In general, agreed. But there are some quirks and peculiarities in how
> the issue (increased audio latency) manifests itself on R-Car3, which
> might create some room for a (relatively simple) loophole solution in
> the printk mechanism.
>
> With that said, I need to diverge a bit from the platform-agnostic
> scope of this series.
>
> So, what's specific to R-Car3, based on my testing, is that the issue
> can only be reproduced if the printk storm originates on CPU0 (it does
> not matter if from interrupt or task context, both have been tested). If
> the printk storm is initiated on any other CPU (there are 7 secondary
> ones on R-Car H3), there is no regression in the audio quality/latency.

The secure stuff is running on CPU0, isn't it?
Is that a coincidence?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
