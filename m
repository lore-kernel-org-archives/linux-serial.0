From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 4/5] serial: pch_uart: remove reference to .set_wake()
Date: Fri, 18 Oct 2013 16:37:35 +0200
Message-ID: <CACRpkdZMs28qGfwfUmtgWGn3SojgRo6rotn0qbws9sYMMouYeg@mail.gmail.com>
References: <1381821643-19528-1-git-send-email-linus.walleij@linaro.org>
	<1381851107.23041.35.camel@dvhart-mobl4.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:42200 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751159Ab3JROhh (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 18 Oct 2013 10:37:37 -0400
Received: by mail-ie0-f170.google.com with SMTP id at1so6893143iec.29
        for <linux-serial@vger.kernel.org>; Fri, 18 Oct 2013 07:37:36 -0700 (PDT)
In-Reply-To: <1381851107.23041.35.camel@dvhart-mobl4.amr.corp.intel.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Darren Hart <dvhart@linux.intel.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Johan Hovold <jhovold@gmail.com>

On Tue, Oct 15, 2013 at 5:31 PM, Darren Hart <dvhart@linux.intel.com> wrote:
> On Tue, 2013-10-15 at 09:20 +0200, Linus Walleij wrote:

>> -/*   .set_wake       = pch_uart_set_wake,    Not supported yet */
>
> From what I can tell with "git log -S", this callback never existed for
> this driver. I am curious what prompted the removal of this comment
> (since the set_wake field still exists in the structure)

It is removed from the structure in patch 5/5, so I wanted to first
get rid of anything referencing it.

> and .pm was
> left alone, which seems to have the same history within this driver
> as .set_wake.

I don't know of this callback (yet) maybe I will look at it for the
next kernel cycle...

Yours,
Linus Walleij
