Return-Path: <SRS0=ZZst=AN=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C9AC433E0
	for <linux-serial@archiver.kernel.org>; Thu,  2 Jul 2020 20:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26F4D20890
	for <linux-serial@archiver.kernel.org>; Thu,  2 Jul 2020 20:39:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725994AbgGBUjN (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 2 Jul 2020 16:39:13 -0400
Received: from muru.com ([72.249.23.125]:60534 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725937AbgGBUjN (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 2 Jul 2020 16:39:13 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id C80958062;
        Thu,  2 Jul 2020 20:40:05 +0000 (UTC)
Date:   Thu, 2 Jul 2020 13:39:10 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v3 2/6] serial: core: Allow detach and attach serial
 device for console
Message-ID: <20200702203910.GO53169@atomide.com>
References: <20200217114016.49856-1-andriy.shevchenko@linux.intel.com>
 <20200217114016.49856-3-andriy.shevchenko@linux.intel.com>
 <20200524171032.GA218301@roeck-us.net>
 <CAMuHMdXvummZiDBu72WJmdanyP2r4dab8SbVLZaTRNrBfnRmTw@mail.gmail.com>
 <20200702193553.GN53169@atomide.com>
 <CAMuHMdUn5MK6tTd6ohFxa=K9NNHRbDp9P7gvPD52fCp2OsLnYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdUn5MK6tTd6ohFxa=K9NNHRbDp9P7gvPD52fCp2OsLnYA@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

* Geert Uytterhoeven <geert@linux-m68k.org> [200702 20:04]:
> Hi Tony,
> 
> On Thu, Jul 2, 2020 at 9:35 PM Tony Lindgren <tony@atomide.com> wrote:
> > * Geert Uytterhoeven <geert@linux-m68k.org> [200702 14:50]:
> > > On Sun, May 24, 2020 at 7:11 PM Guenter Roeck <linux@roeck-us.net> wrote:
> > > > any special reason for this change ? It is not really explained in the
> > > > commit description.
> > >
> > > Indeed. Why this change?
> >
> > For a kernel console, we want it to work for important oopses
> > etc without trying to enable DMA or power on regulators for example.
> 
> [...]
> 
> Thanks for the explanation about irqsafe consoles!
> I think I cannot disagree with that ;-)

You're welcome..

> Sorry for being a bit unclear, but my question (and I guess Günter's
> question, too) was about this particular change:
> 
>      static inline void uart_port_spin_lock_init(struct uart_port *port)
>      {
>     -     if (uart_console_enabled(port))
>     +     if (uart_console(port))
> 
> This change seems to be completely unrelated, is not explained in the
> commit description, and is the cause of the regression we're seeing.

..sorry looks I missed the context a bit then :) Hmm yeah not sure about
this change above.

Regards,

Tony
