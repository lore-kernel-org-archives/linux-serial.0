From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] TTY: serial, add pm function
Date: Wed, 16 Jan 2013 18:32:14 -0800
Message-ID: <20130117023214.GB20928@kroah.com>
References: <1355316051-2425-1-git-send-email-rickard.andersson@stericsson.com>
 <20130116070521.GB2527@kroah.com>
 <50F65C5E.9090804@stericsson.com>
 <20130116075813.GA30819@kroah.com>
 <50F665C5.9020603@stericsson.com>
 <20130116152440.GA1101@kroah.com>
 <CACRpkdax3znJg_8W-B=1mHTiZwtbiqx1B6hMrxVk4UXEK2NpGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:42812 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755928Ab3AQCb1 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 16 Jan 2013 21:31:27 -0500
Content-Disposition: inline
In-Reply-To: <CACRpkdax3znJg_8W-B=1mHTiZwtbiqx1B6hMrxVk4UXEK2NpGw@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Rickard Andersson <rickard.andersson@stericsson.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Linus WALLEIJ <linus.walleij@stericsson.com>, "alan@linux.intel.com" <alan@linux.intel.com>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>

On Thu, Jan 17, 2013 at 01:36:48AM +0100, Linus Walleij wrote:
> On Wed, Jan 16, 2013 at 4:24 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
> > On Wed, Jan 16, 2013 at 09:33:09AM +0100, Rickard Andersson wrote:
> 
> >> The bluetooth cg2900 driver is on its way towards "staging".
> >
> > Really?  I've never heard of it before, nor seen it, so how would I know
> > this?
> 
> It's been posted twice, here is the last time:
> http://marc.info/?l=linux-kernel&m=134873373526049&w=2
> 
> You commented several times on it, but I know a lot of code
> pass by your console.

Heh, that's funny, I don't remember that at all, I think I now
officially have no long-term memory about patches I review :)

> >  And we really never want to change core kernel code for staging
> > drivers, it's one of the requirements of staging code.
> 
> Hm OK but it's a quite straight-forward thing for anything
> connected on a UART in an embedded system that is not just a
> serial cable or something and wants to save power.
> 
> Maybe we can augment some other driver for something sitting
> on a uart as a proof-of-concept then.

You know we don't add infrastructure if there is no in-kernel user, and
some random patch that was sent months ago doesn't really count as a
"user" given that it's not even being submitted here, and it wasn't
referenced in the patch itself that added the api.

Also, why does this driver need something that the hundreds of other
serial drivers we have in-kernel today do not?  What makes it special
over everything else?

thanks,

greg "I will not remember writing this email" k-h
