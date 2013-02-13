From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/2] tty: serial: remove __init on pl011 console ops
Date: Wed, 13 Feb 2013 21:21:08 +0000
Message-ID: <20130213212109.099AE3E3557@localhost>
References: <1360151235-11980-1-git-send-email-haojian.zhuang@linaro.org> <20130206115219.GE17833@n2100.arm.linux.org.uk> <CAD6h2NSpo74UXUgH2OJniW=wzkxGeshta05AGgCpn26SCUSjYg@mail.gmail.com> <CACRpkdZX-YF+jzg453Vmfxo_2LLuASvZyQqLommaM4Xd3LpwfQ@mail.gmail.com> <20130206163811.GI17833@n2100.arm.linux.org.uk> <CAD6h2NS6bJS1KZfZ-3SGy6AR68Vn4fkR=TgwTEu50G_edfCP1w@mail.gmail.com> <CACxGe6t94S=kkfCkasO+ze35M-H06+WCA-J93BZaJfCzhWfoEQ@mail.gmail.com> <20130209224138.GI17833@n2100.arm.linux.org.uk> <CAD6h2NQbpH4KrDA7_-WYx+gzrA60fRHCk8D=-Je2fsEC-+z79Q@mail.gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-we0-f173.google.com ([74.125.82.173]:58936 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752066Ab3BMVVN (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 13 Feb 2013 16:21:13 -0500
Received: by mail-we0-f173.google.com with SMTP id r5so1385232wey.32
        for <linux-serial@vger.kernel.org>; Wed, 13 Feb 2013 13:21:11 -0800 (PST)
In-Reply-To: <CAD6h2NQbpH4KrDA7_-WYx+gzrA60fRHCk8D=-Je2fsEC-+z79Q@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Haojian Zhuang <haojian.zhuang@linaro.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Linus Walleij <linus.walleij@linaro.org>, jslaby@suse.cz, Anton Vorontsov <anton.vorontsov@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Patch Tracking <patches@linaro.org>

On Sun, 10 Feb 2013 11:31:53 +0800, Haojian Zhuang <haojian.zhuang@linaro.org> wrote:
> I agree on Russell. And console isn't the only one device.
> In kernel_init_freeable(), we can find that we have an
> assumption that all initial calls are already finished, and
> we need to discard them & start the user-mode stuff.
> But at that time, deferred probe may still not run since
> they're in another kernel thread. It's very dangerous that
> user mode stuff start running but device driver isn't ready
> yet.

Linux has been moving in that direction for quite a while now. Userspace
can start before a lot of devices are ready. Mass storage for instance.
An initramfs can start userspace, but if the real rootfs is on rotating
storage, then it will have to wait for it to become ready before
mounting the real root. Distributions ran into this problem quite a
while ago.

That said, console is pretty important, and it isn't good that the
fallout of deferred probe is that console gets initialized even later.

Linus, we should get some engineers around a whiteboard at connect and
map out the initialization order issues. I've been pushing for moving as
much as possible to device_initcall() time, which in general I think is
the right thing to do, but this is the downside.

> Then let's move to my error case. Serial driver fails to
> bind pinctrl, and it's moved into deferred probe list. And
> kernel_init_freeable() in kernel_init thread keeps working
> on CPU, the deferred probe doesn't have chances to be
> scheduled yet. So two issues happen.
> 1. /dev/console is accessed before serial driver is ready.
> Since it fails, user can't input anything on console any
> more.

This is a fair point and is a better argument for me to having a pass
over the deferred drivers before exiting the device initcalls.

> 2. __init memory section is released before serial driver
> is ready. It results in system hang while deferred probe
> runs.

The __init section in a .probe() path is a problem in and of itself. I
do think that the __init annotations either need to be removed or the
hooks into them need to be cleared when the init sections are
discarded.

g.
