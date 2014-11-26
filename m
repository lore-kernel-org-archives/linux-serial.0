From: Grant Likely <grant.likely@linaro.org>
Subject: Re: [PATCH V2 01/10] tty: Fallback to use dynamic major number
Date: Wed, 26 Nov 2014 13:33:06 +0000
Message-ID: <20141126133306.659E9C4099B@trevor.secretlab.ca>
References: <1415825647-6024-1-git-send-email-cernekee@gmail.com>
	<1415825647-6024-2-git-send-email-cernekee@gmail.com>
	<20141125203431.GA9385@kroah.com>
	<CAJiQ=7DOxK2NzmC9gGsnARxGMN8wRQyGX+5u5YC_vt00ADVsDg@mail.gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-wg0-f46.google.com ([74.125.82.46]:61542 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750947AbaKZNdK (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 26 Nov 2014 08:33:10 -0500
Received: by mail-wg0-f46.google.com with SMTP id x12so3749737wgg.33
        for <linux-serial@vger.kernel.org>; Wed, 26 Nov 2014 05:33:09 -0800 (PST)
In-Reply-To: <CAJiQ=7DOxK2NzmC9gGsnARxGMN8wRQyGX+5u5YC_vt00ADVsDg@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Kevin Cernekee <cernekee@gmail.com>, Greg KH <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>, daniel@zonque.org, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Florian Fainelli <f.fainelli@gmail.com>, Maxime Bizon <mbizon@freebox.fr>, Jonas Gorski <jogo@openwrt.org>, Linux MIPS Mailing List <linux-mips@linux-mips.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, tushar.b@samsung.com

On Tue, 25 Nov 2014 15:37:16 -0800
, Kevin Cernekee <cernekee@gmail.com>
 wrote:
> On Tue, Nov 25, 2014 at 12:34 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
> > On Wed, Nov 12, 2014 at 12:53:58PM -0800, Kevin Cernekee wrote:
> >> From: Tushar Behera <tushar.behera@linaro.org>
> >
> > This email bounces, so I'm going to have to reject this patch.  I can't
> > accept a patch from a "fake" person, let alone something that touches
> > core code like this.
> >
> > Sorry, I can't accept anything in this series then.
> 
> Oops, guess I probably should have updated his address after the V1
> emails bounced...
> 
> Before I send a new version, what do you think about the overall
> approach?  Should we try to make serial8250 coexist with the other
> "ttyS / major 4 / minor 64" drivers (possibly at the expense of
> compatibility) or is it better to start with a simpler, cleaner driver
> like serial/pxa?

Co-existing really needs to be fixed. The way to handle this might be to
blacklist the creation of the first 4 8250 devices on certain platforms.
It's going to be painful unfortunately.

g.

