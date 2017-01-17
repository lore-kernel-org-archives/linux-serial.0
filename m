From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH v2 2/9] tty_port: allow a port to be opened with a tty
 that has no file handle
Date: Tue, 17 Jan 2017 14:57:29 +0000
Message-ID: <20170117145729.6c3a9413@lxorguk.ukuu.org.uk>
References: <20170116225436.17505-1-robh@kernel.org>
        <20170116225436.17505-3-robh@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170116225436.17505-3-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marcel Holtmann <marcel@holtmann.org>, Jiri Slaby <jslaby@suse.com>, Sebastian Reichel <sre@kernel.org>, Arnd Bergmann <arnd@arndb.de>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Peter Hurley <peter@hurleysoftware.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Loic Poulain <loic.poulain@intel.com>, Pavel Machek <pavel@ucw.cz>, NeilBrown <neil@brown.name>, Linus Walleij <linus.walleij@linaro.org>, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Alan Cox <alan@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

On Mon, 16 Jan 2017 16:54:29 -0600
Rob Herring <robh@kernel.org> wrote:

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
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-By: Sebastian Reichel <sre@kernel.org>
> ---
> Alan, Need your SoB here.

Signed-off-by: Alan Cox <alan@linux.intel.com>

Alan
