From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] serial/mxs-auart: increase time to wait for transmitter
 to become idle
Date: Thu, 4 Jul 2013 09:16:10 -0700
Message-ID: <20130704161610.GA20907@kroah.com>
References: <1372413017-23252-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20130704092716.GC17454@pengutronix.de>
 <20130704155836.GA13897@kroah.com>
 <20130704160250.GC32260@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130704160250.GC32260@pengutronix.de>
Sender: stable-owner@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, kernel@pengutronix.de, stable@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thu, Jul 04, 2013 at 06:02:50PM +0200, Uwe Kleine-K=F6nig wrote:
> Hi Greg,
>=20
> On Thu, Jul 04, 2013 at 08:58:36AM -0700, Greg Kroah-Hartman wrote:
> > On Thu, Jul 04, 2013 at 11:27:16AM +0200, Uwe Kleine-K=F6nig wrote:
> > > On Fri, Jun 28, 2013 at 11:49:41AM +0200, Uwe Kleine-K=F6nig wrot=
e:
> > > > Without this patch the driver waits ~1 ms for the UART to becom=
e idle. At
> > > > 115200n8 this time is (theoretically) enough to transfer 11.5 c=
haracters
> > > > (=3D 115200 bits/s / (10 Bits/char) * 1ms). As the mxs-auart ha=
s a fifo size
> > > > of 16 characters the clock is gated too early. The problem is w=
orse for
> > > > lower baud rates.
> > > >=20
> > > > This only happens to really shut down the transmitter in the mi=
ddle of a
> > > > transfer if /dev/ttyAPPx isn't opened in userspace (e.g. by a g=
etty) but
> > > > was at least once (because the bootloader doesn't disable the t=
ransmitter).
> > > >=20
> > > > So increase the timeout to 20 ms which should be enough for 960=
0n8, too.
> > > > Moreover skip gating the clock if the timeout is elapsed.
> > > >=20
> > > > Cc: stable@vger.kernel.org # v2.6.39+
> > > > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.=
de>
> > > Any comments on this. I hoped this patch would make it in for 3.1=
0 :-(
> >=20
> > You sent it after my tree closed for 3.11, 3.10 is a stretch :)
> You close your tree for fixes?

2 days before the kernel is to be released?  Yes, I do.  This will get
into 3.11-rc2 or -rc3, and backported to 3.10 and others, so please jus=
t
give it a bit of time.  It's just a driver issue, nothing keeping
machines from booting properly :)

thanks,

greg k-h
