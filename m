From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] serial: ifx6x60: avoid uninitialized variable use
Date: Fri, 26 Feb 2016 14:54:49 +0100
Message-ID: <11867118.gBQtPfGrif@wuerfel>
References: <1456433283-3761559-1-git-send-email-arnd@arndb.de> <20160226000651.628e28fe@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160226000651.628e28fe@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Russ Gorby <richardx.r.gorby@intel.com>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, Alan Cox <alan@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

On Friday 26 February 2016 00:06:51 One Thousand Gnomes wrote:
> On Thu, 25 Feb 2016 21:47:57 +0100
> Arnd Bergmann <arnd@arndb.de> wrote:
> 
> > gcc warns about a potential use of an uninitialized variable in this driver:
> > 
> > drivers/tty/serial/ifx6x60.c: In function 'ifx_spi_complete':
> > drivers/tty/serial/ifx6x60.c:713:6: warning: 'more' may be used uninitialized in this function [-Wmaybe-uninitialized]
> >    if (more || ifx_dev->spi_more || queue_length > 0 ||
> > 
> > Unlike a lot of other such warnings, this one is correct and describes
> > an actual problem in the handling of the "IFX_SPI_HEADER_F" result code.
> > 
> > This appears to be a result from a restructuring of the driver that
> > dates back to before it was merged in the kernel, so it's impossible
> > to know where it went wrong. I also don't know what that result code
> > means, so I have no idea if setting 'more' to zero is the correct
> > solution, but at least it makes the behavior reproducible rather than
> > depending on whatever happens to be on the kernel stack.
> 
> Would it not be far simpler just to set more = 0 at the top of
> ifx_spi_complete ?
> 
> 

That would be simpler, but I generally don't like to do that, because it
makes it less obvious where the value is coming from.

In this case, it's still not obvious, as I was just guessing what the
original intention might have been.

	Arnd
