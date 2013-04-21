From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RESEND][PATCH] ARM: PL011: add support for extended FIFO-size
	of PL011-r1p5
Date: Sun, 21 Apr 2013 09:54:42 +0100
Message-ID: <20130421085442.GE14496@n2100.arm.linux.org.uk>
References: <201304151445.25151.neidhard.kim@lge.com> <CACRpkdbG4q54=j6nbxPmuSOG77zato5StSHdNQ1bSkCmvuQUvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:35649 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752525Ab3DUIzg (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 21 Apr 2013 04:55:36 -0400
Content-Disposition: inline
In-Reply-To: <CACRpkdbG4q54=j6nbxPmuSOG77zato5StSHdNQ1bSkCmvuQUvQ@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Jongsung Kim <neidhard.kim@lge.com>, Greg KH <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Sat, Apr 20, 2013 at 03:31:39PM +0200, Linus Walleij wrote:
> static struct amba_id pl011_ids[] = {
>         {
>                 .id     = 0x00341011,
>                 .mask   = 0x00ffffff,
>                 .data   = &vendor_arm_deepfifo,
>         },
> (...)
> };
> 
> As you can see in amba_lookup() in
> drivers/amba/bus.c the table is traversed from the top,
> so for the new "3" variant this entry will match, while the
> next entry will match all older versions.

This isn't equivalent - this will only match variant 3, not any later
ones.  The original patch uses the deep fifo for variant 3 or larger.
