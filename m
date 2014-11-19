From: Kevin Cernekee <cernekee@gmail.com>
Subject: Re: [PATCH V2 06/10] serial: pxa: Add fifo-size and
 {big,native}-endian properties
Date: Wed, 19 Nov 2014 08:23:35 -0800
Message-ID: <CAJiQ=7BpOzAFTCmhER=ZVJgtQwoDKf3xPYKR8u+g-d1RQzhUKw@mail.gmail.com>
References: <1415825647-6024-1-git-send-email-cernekee@gmail.com>
 <1415825647-6024-7-git-send-email-cernekee@gmail.com> <20141119144911.9CA5FC40D73@trevor.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-qa0-f50.google.com ([209.85.216.50]:39384 "EHLO
	mail-qa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754350AbaKSQX7 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 19 Nov 2014 11:23:59 -0500
In-Reply-To: <20141119144911.9CA5FC40D73@trevor.secretlab.ca>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Grant Likely <grant.likely@linaro.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>, daniel@zonque.org, Haojian Zhuang <haojian.zhuang@gmail.com>, robert.jarzmik@free.fr, Florian Fainelli <f.fainelli@gmail.com>, Maxime Bizon <mbizon@freebox.fr>, Jonas Gorski <jogo@openwrt.org>, Linux MIPS Mailing List <linux-mips@linux-mips.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Wed, Nov 19, 2014 at 6:49 AM, Grant Likely <grant.likely@linaro.org> wrote:
> On Wed, 12 Nov 2014 12:54:03 -0800
> , Kevin Cernekee <cernekee@gmail.com>
>  wrote:
>> With a few tweaks, the PXA serial driver can handle other 16550A clones.
>> Add a fifo-size DT property to override the FIFO depth (BCM7xxx uses 32),
>> and {native,big}-endian properties similar to regmap to support SoCs that
>> have BE or "automagic endian" registers.
>
> Hold the phone, if these are 16550A clone ports, then why is the pxa
> driver being adapted to drive them? I would expect the of_serial.c
> driver to be used. It's already got support for multiple variants of the
> 16550.

Merely building serial8250 into a multiplatform kernel breaks every
other serial driver that uses "ttyS" and major/minor 4/64.  Even if an
8250/16550A device is never probed.

More discussion in this thread:

http://www.spinics.net/lists/linux-serial/msg14811.html
