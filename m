From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: 8250 regression: infinite interrupts
Date: Sat, 28 Jan 2012 11:50:44 +0100
Message-ID: <CACRpkdZkwgZimCi_tH_CHd_JUi1YTKgSBK4VR9c5PPVq0Y+Ldg@mail.gmail.com>
References: <4F22B326.4060605@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:54626 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751875Ab2A1Kup (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 28 Jan 2012 05:50:45 -0500
In-Reply-To: <4F22B326.4060605@suse.cz>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: philippe.langlais@stericsson.com, Alan Cox <alan@lxorguk.ukuu.org.uk>, Greg KH <gregkh@suse.de>, Linux kernel mailing list <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org

2012/1/27 Jiri Slaby <jslaby@suse.cz>:

> The culprit is the added size_fifo call proper in autoconfig_16550a. It
> returns 16, but the chip is confused by what the function does at that
> point. It is yet to be investigated why. Any ideas at this stage why
> this could be a problem?

The header says the function sometimes fail :-/

What it does is set the UART in loopback mode and saturate it with
256 bytes to overflow the FIFO, then check how many chars
were in the FIFO to determine FIFO size.

Could it be that your variant does not clear the FIFO overflow
correctly and get stuck in some error state? Maybe try clearing
some error flags at the end of this function?

Yours,
Linus Walleij
