From: Chanho Min <chanho0207@gmail.com>
Subject: Re: [PATCH v3] serial: PL011: clear pending interrupts
Date: Wed, 14 Mar 2012 10:47:37 +0900
Message-ID: <CAOAMb1AKmsNQbmVAaYq5G8cdafCVpRyA=5xgocqYfLsQ6BLXMw@mail.gmail.com>
References: <1331641643-25929-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:58139 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932334Ab2CNBrk (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 13 Mar 2012 21:47:40 -0400
Received: by iagz16 with SMTP id z16so1589573iag.19
        for <linux-serial@vger.kernel.org>; Tue, 13 Mar 2012 18:47:37 -0700 (PDT)
In-Reply-To: <1331641643-25929-1-git-send-email-linus.walleij@stericsson.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Linus Walleij <linus.walleij@stericsson.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>, Jong-Sung Kim <neidhard.kim@lge.com>, Linus Walleij <linus.walleij@linaro.org>, stable@kernel.org, Shreshtha Kumar Sahu <shreshthakumar.sahu@stericsson.com>

On Tue, Mar 13, 2012 at 9:27 PM, Linus Walleij
<linus.walleij@stericsson.com> wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
>
> Chanho Min reported that when the boot loader transfers
> control to the kernel, there may be pending interrupts
> causing the UART to lock up in an eternal loop trying to
> pick tokens from the FIFO (since the RX interrupt flag
> indicates there are tokens) while in practice there are
> no tokens - in fact there is only a pending IRQ flag.
>
> This patch address the issue with a combination of two
> patches suggested by Russell King that clears and mask
> all interrupts at probe() and clears any pending error
> and RX interrupts at port startup time.
>
> We suspect the spurious interrupts are a side-effect of
> switching the UART from FIFO to non-FIFO mode.
I've tested this patch, and have confirmed that the issue is resolved
on our CA9 platform.
In addition, May I ask to change the tag as follows.

Reported-by: Chanho Min <chanho.min@lge.com>
Reviewed-by: Jong-Sung Kim <neidhard.kim@lge.com>

Thanks a lot !
Chanho Min
