From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] ARM: PL011: Add support for Rx DMA buffer polling
Date: Mon, 14 Jan 2013 08:56:10 +0100
Message-ID: <CACRpkdaH7sNwwbEBVOGGHbUzGJ1SC9wdx+ULfwAc3FzCO=E-zQ@mail.gmail.com>
References: <50efad8d.84fc440a.589e.ffff9546SMTPIN_ADDED_BROKEN@mx.google.com>
	<CACRpkdYSaFsastx-WWC7sBu8NteAc2hCDZMz4-yMc8+=2dyBVw@mail.gmail.com>
	<50f107aa.894e420a.596a.ffffe3f6SMTPIN_ADDED_BROKEN@mx.google.com>
	<CACRpkdaJd48WOzP_iURATb=c+V6==2-AB2Y9oFyh=E3oe1eT0Q@mail.gmail.com>
	<20130114002608.GV23505@n2100.arm.linux.org.uk>
	<CACRpkdbVPeva08nL_FP7qw0MeKLz6h40kPHAz_W95ZBGraOnpg@mail.gmail.com>
	<CAOAMb1BgcvBb6KHaZbwbh0rq8r1WfAtdCeZJexfaYoOwGfU7Sg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAOAMb1BgcvBb6KHaZbwbh0rq8r1WfAtdCeZJexfaYoOwGfU7Sg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chanho Min <chanho.min@lge.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>
List-Id: linux-serial@vger.kernel.org

On Mon, Jan 14, 2013 at 8:27 AM, Chanho Min <chanho.min@lge.com> wrote:

> We just want to use this HW function even if SW support is needed.
> Anyway, It was very useful for megabyte rate chips.

So RX DMA will not be enabled for things like console, but
accelerators etc. OK that's perfectly valid.

Looking back at the patch, do you know if we can get rid of
some of the #ifdefs and have this like a runtime switch set in
struct amba_pl011_data or Device Tree?

Yours,
Linus Walleij
