From: Kevin Cernekee <cernekee@gmail.com>
Subject: Re: [PATCH V2 01/10] tty: Fallback to use dynamic major number
Date: Tue, 25 Nov 2014 15:37:16 -0800
Message-ID: <CAJiQ=7DOxK2NzmC9gGsnARxGMN8wRQyGX+5u5YC_vt00ADVsDg@mail.gmail.com>
References: <1415825647-6024-1-git-send-email-cernekee@gmail.com>
 <1415825647-6024-2-git-send-email-cernekee@gmail.com> <20141125203431.GA9385@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-qa0-f43.google.com ([209.85.216.43]:44234 "EHLO
	mail-qa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751712AbaKYXhh (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 25 Nov 2014 18:37:37 -0500
In-Reply-To: <20141125203431.GA9385@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>, daniel@zonque.org, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Grant Likely <grant.likely@linaro.org>, Florian Fainelli <f.fainelli@gmail.com>, Maxime Bizon <mbizon@freebox.fr>, Jonas Gorski <jogo@openwrt.org>, Linux MIPS Mailing List <linux-mips@linux-mips.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, tushar.b@samsung.com

On Tue, Nov 25, 2014 at 12:34 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Wed, Nov 12, 2014 at 12:53:58PM -0800, Kevin Cernekee wrote:
>> From: Tushar Behera <tushar.behera@linaro.org>
>
> This email bounces, so I'm going to have to reject this patch.  I can't
> accept a patch from a "fake" person, let alone something that touches
> core code like this.
>
> Sorry, I can't accept anything in this series then.

Oops, guess I probably should have updated his address after the V1
emails bounced...

Before I send a new version, what do you think about the overall
approach?  Should we try to make serial8250 coexist with the other
"ttyS / major 4 / minor 64" drivers (possibly at the expense of
compatibility) or is it better to start with a simpler, cleaner driver
like serial/pxa?
