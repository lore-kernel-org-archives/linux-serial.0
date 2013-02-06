From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/2] tty: serial: remove __init on pl011 console ops
Date: Wed, 6 Feb 2013 17:46:50 +0100
Message-ID: <CACRpkdZDks681kDBrNcztWw_vr-5azWxsuDQaDa36Ze=0+B2Kg@mail.gmail.com>
References: <1360151235-11980-1-git-send-email-haojian.zhuang@linaro.org>
	<20130206115219.GE17833@n2100.arm.linux.org.uk>
	<CAD6h2NSpo74UXUgH2OJniW=wzkxGeshta05AGgCpn26SCUSjYg@mail.gmail.com>
	<CACRpkdZX-YF+jzg453Vmfxo_2LLuASvZyQqLommaM4Xd3LpwfQ@mail.gmail.com>
	<20130206163811.GI17833@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ia0-f179.google.com ([209.85.210.179]:59015 "EHLO
	mail-ia0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756532Ab3BFQqv (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 6 Feb 2013 11:46:51 -0500
Received: by mail-ia0-f179.google.com with SMTP id x24so1778201iak.38
        for <linux-serial@vger.kernel.org>; Wed, 06 Feb 2013 08:46:51 -0800 (PST)
In-Reply-To: <20130206163811.GI17833@n2100.arm.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Haojian Zhuang <haojian.zhuang@linaro.org>, Grant Likely <grant.likely@secretlab.ca>, jslaby@suse.cz, anton.vorontsov@linaro.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org, Patch Tracking <patches@linaro.org>

On Wed, Feb 6, 2013 at 5:38 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

> However, I'm just wondering if this shows that we _do_ need to get rid
> of a pile of __init marked functions as well as fixing this, thanks to
> the deferred probing we now have (maybe the whole __init thing becomes
> useless with deferred probing?)

And all __initdata and __initconst as well.

> There's nothing really to guarantee
> that the pinctrl stuff will be available by the time the init sections
> are discarded (it could be in a loadable module?) or indeed any other
> resources that might be necessary.

I don't dare to guess how deferred probing is supposed to work
with loadable modules. When I start to think of it my mind
boggles. But I think maybe all drivers that support module loading
are tagging things wrong. Shouldn't they all be using
__init_or_module, __initdata_or_module, __initconst_or_module
so they only get discarded unless compiled as modules?

As far as I can tell from <linux/init.h> that is the intention.

Talk about can of worms :-(

> I think in this regard, deferred probing has opened a similar can of
> worms which hotplug devices created (which eventually ended up with
> killing the __dev* marking).

I'm afraid you're right.

Pinctrl core grabbing of pins seems to trigger the problem more
often on platforms that are using it.

Yours,
Linus Walleij
