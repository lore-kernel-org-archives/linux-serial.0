From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2] TTY: serial, add pm function
Date: Fri, 18 Jan 2013 13:43:04 +0100
Message-ID: <CACRpkdYzG3AWn5L-06_uyfK6qCKnX1CZuG_on3hqF1qzamGScQ@mail.gmail.com>
References: <1355316051-2425-1-git-send-email-rickard.andersson@stericsson.com>
	<20130116070521.GB2527@kroah.com>
	<50F65C5E.9090804@stericsson.com>
	<20130116075813.GA30819@kroah.com>
	<50F665C5.9020603@stericsson.com>
	<20130116152440.GA1101@kroah.com>
	<CACRpkdax3znJg_8W-B=1mHTiZwtbiqx1B6hMrxVk4UXEK2NpGw@mail.gmail.com>
	<20130117023214.GB20928@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:48210 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751137Ab3ARMsz (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 18 Jan 2013 07:48:55 -0500
Received: by mail-ie0-f178.google.com with SMTP id c12so6092170ieb.23
        for <linux-serial@vger.kernel.org>; Fri, 18 Jan 2013 04:48:55 -0800 (PST)
In-Reply-To: <20130117023214.GB20928@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Rickard Andersson <rickard.andersson@stericsson.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Linus WALLEIJ <linus.walleij@stericsson.com>, "alan@linux.intel.com" <alan@linux.intel.com>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>

On Thu, Jan 17, 2013 at 3:32 AM, Greg KH <gregkh@linuxfoundation.org> wrote:

> Also, why does this driver need something that the hundreds of other
> serial drivers we have in-kernel today do not?  What makes it special
> over everything else?

So (and I think Alan just seconded this) I think several vendors
already have different ugly out-of-tree hacks to solve exactly this.

The reason you haven't seen it before is that there is no AT
command to power save a US Robotics 33k8 modem.
And these are handled from userspace.

The embedded systems have:

- In-kernel driver using the TTY

- Control over both ends of the link (we have the equivalent
  of an AT command setting the 33k8 into retention).

- Critical (as in really critical) power requirements.

Blueetooth chips on megabit serial links seem to be pretty
common actually. Maybe people even have modems on these.

I think the reason you haven't seen it before is that either
people are scared of the TTY layer (whyyyy would they be that)
or that they are in the out-of-tree business. We're trying to be
in the in-tree business, so to be there we need to put the
infrastructure in place to be able to be there.

But I'm looking around for a *simple* UART-connected device
with a low-power/retention state to use as example in
question, so we don't have to conflate the CG2900 upstreaming
issue with the TTY/UART PM issue. Anyone have hints
on a suitable device?

Linus Walleij
