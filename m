From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2] TTY: serial, add pm function
Date: Thu, 17 Jan 2013 01:36:48 +0100
Message-ID: <CACRpkdax3znJg_8W-B=1mHTiZwtbiqx1B6hMrxVk4UXEK2NpGw@mail.gmail.com>
References: <1355316051-2425-1-git-send-email-rickard.andersson@stericsson.com>
	<20130116070521.GB2527@kroah.com>
	<50F65C5E.9090804@stericsson.com>
	<20130116075813.GA30819@kroah.com>
	<50F665C5.9020603@stericsson.com>
	<20130116152440.GA1101@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:60111 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757965Ab3AQAgt (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 16 Jan 2013 19:36:49 -0500
Received: by mail-ie0-f176.google.com with SMTP id 13so3808828iea.21
        for <linux-serial@vger.kernel.org>; Wed, 16 Jan 2013 16:36:48 -0800 (PST)
In-Reply-To: <20130116152440.GA1101@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Rickard Andersson <rickard.andersson@stericsson.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Linus WALLEIJ <linus.walleij@stericsson.com>, "alan@linux.intel.com" <alan@linux.intel.com>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>

On Wed, Jan 16, 2013 at 4:24 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Wed, Jan 16, 2013 at 09:33:09AM +0100, Rickard Andersson wrote:

>> The bluetooth cg2900 driver is on its way towards "staging".
>
> Really?  I've never heard of it before, nor seen it, so how would I know
> this?

It's been posted twice, here is the last time:
http://marc.info/?l=linux-kernel&m=134873373526049&w=2

You commented several times on it, but I know a lot of code
pass by your console.

>  And we really never want to change core kernel code for staging
> drivers, it's one of the requirements of staging code.

Hm OK but it's a quite straight-forward thing for anything
connected on a UART in an embedded system that is not just a
serial cable or something and wants to save power.

Maybe we can augment some other driver for something sitting
on a uart as a proof-of-concept then.

Thanks,
Linus Walleij
