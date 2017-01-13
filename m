From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 2/9] tty_port: allow a port to be opened with a tty that
 has no file handle
Date: Fri, 13 Jan 2017 10:46:05 -0600
Message-ID: <CAL_JsqLE_QRtoFPOsMgG+mumb=+zf1JFR4F7u4fuoBb+2on3VQ@mail.gmail.com>
References: <20170106162635.19677-1-robh@kernel.org> <20170106162635.19677-3-robh@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170106162635.19677-3-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Pavel Machek <pavel@ucw.cz>, Linus Walleij <linus.walleij@linaro.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alan Cox <alan@linux.intel.com>, NeilBrown <neil@brown.name>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Peter Hurley <peter@hurleysoftware.com>, Sebastian Reichel <sre@kernel.org>, Jiri Slaby <jslaby@suse.com>, Marcel Holtmann <marcel@holtmann.org>
List-Id: linux-serial@vger.kernel.org

On Fri, Jan 6, 2017 at 10:26 AM, Rob Herring <robh@kernel.org> wrote:
> From: Alan Cox <alan@linux.intel.com>
>
> Let us create tty objects entirely in kernel space. Untested proposal to
> show why all the ideas around rewriting half the uart stack are not needed.
>
> With this a kernel created non file backed tty object could be used to handle
> data, and set terminal modes. Not all ldiscs can cope with this as N_TTY in
> particular has to work back to the fs/tty layer.
>
> The tty_port code is however otherwise clean of file handles as far as I can
> tell as is the low level tty port write path used by the ldisc, the
> configuration low level interfaces and most of the ldiscs.
>
> Currently you don't have any exposure to see tty hangups because those are
> built around the file layer. However a) it's a fixed port so you probably
> don't care about that b) if you do we can add a callback and c) you almost
> certainly don't want the userspace tear down/rebuild behaviour anyway.
>
> This should however be sufficient if we wanted for example to enumerate all
> the bluetooth bound fixed ports via ACPI and make them directly available.
> It doesn't deal with the case of a user opening a port that's also kernel
> opened and that would need some locking out (so it returned EBUSY if bound
> to a kernel device of some kind). That needs resolving along with how you
> "up" or "down" your new bluetooth device, or enumerate it while providing
> the existing tty API to avoid regressions (and to debug).
>
> Alan
> ---
>
> Alan, I need a proper patch with your S-O-B for this one.

Alan, can I get your S-o-B on this? Any comments on patches 1-5 in
particular (mostly #5) before I send out updated series?

Rob
