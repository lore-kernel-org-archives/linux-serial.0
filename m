From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] RFC: serial: core: Dynamic minor support
Date: Tue, 25 Apr 2017 20:43:15 +0100
Message-ID: <20170425204315.36ac56f2@lxorguk.ukuu.org.uk>
References: <20170420120357.18317-1-sjoerd.simons@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170420120357.18317-1-sjoerd.simons@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

> Furthermore some other drivers rely upon the usage of a dynamic major
> e.g. the tegra serial port driver. However as there is only a block of
> 20 major numbers reserved for dynamic assignment that isn't going to
> scale either for multiplatform kernels (I can already easily build 18
> different serial drivers on an arm64 kernel today).

The patch makes sense to me - we really don't need the static minors any
more.

> This does not try to address device naming by making all serial ports be
> ttyS<value> as that would first need a better way of deterministically
> specifying serial console devices. While it would be an option to move
> to consistent serial device naming while keeping the current console
> names, having both not aligned would probably confuse everyone
> massively.

The existing ttyS being 8250 is ABI and there are lots of things that
know far too much about what each type of ttyFOO is to ever fix that.

What could certainly be done is to do what some other classes of device
do and start also registering

/dev/ttyport/bus-information/0 /1 /2 .. etc

in parallel.

Alan
