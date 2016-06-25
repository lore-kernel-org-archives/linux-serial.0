From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 2/4] serial: sh-sci: Stop transfers in sci_shutdown()
Date: Sat, 25 Jun 2016 10:01:53 -0700
Message-ID: <20160625170153.GA9544@kroah.com>
References: <1466780356-12623-1-git-send-email-geert+renesas@glider.be>
 <1466780356-12623-3-git-send-email-geert+renesas@glider.be>
 <20160625160939.GA29593@kroah.com>
 <20160625161051.GA30995@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160625161051.GA30995@kroah.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Jiri Slaby <jslaby@suse.com>, Magnus Damm <damm+renesas@opensource.se>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, uclinux-h8-devel@lists.sourceforge.jp
List-Id: linux-serial@vger.kernel.org

On Sat, Jun 25, 2016 at 09:10:51AM -0700, Greg Kroah-Hartman wrote:
> On Sat, Jun 25, 2016 at 09:09:39AM -0700, Greg Kroah-Hartman wrote:
> > On Fri, Jun 24, 2016 at 04:59:14PM +0200, Geert Uytterhoeven wrote:
> > > Make sure the transmitter and receiver are stopped when shutting down
> > > the port, and related interrupts are disabled.
> > > 
> > > Without this:
> > >   - New input data may be received into the RX FIFO, possibly
> > >     triggering a new RX DMA completion,
> > >   - Transfers will still be enabled on a subsequent startup of the UART,
> > >     before the UART's FIFOs have been reset, causing reading of stale
> > >     data.
> > > 
> > > Inspired by a patch in the BSP by Koji Matsuoka
> > > <koji.matsuoka.xm@renesas.com>.
> > > 
> > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > ---
> > > v2:
> > >   - Do not clear clock source bits, since the serial console relies on
> > >     them, as reported by Shimoda-san.
> > > 
> > > v1 was extracted from "[PATCH/RFC v3 0/4] serial: sh-sci: Add DT DMA
> > > support".  The issues with the serial console seen before on
> > > r8a7740/armadillo and sh73a0/kzm9g seem to be gone.  Changes after
> > > resurrection:
> > >   - Write zero to also disable related interrupts, as suggested by
> > >     Laurent Pinchart,
> > >   - Enhanced patch description.
> > > ---
> > >  drivers/tty/serial/sh-sci.c | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > 
> > This patch does not apply to my tree :(
> 
> But I don't have access to my 2-factor token for about 24 hours, so my
> tree will not be public until after then, sorry about that, I'll email
> you when it gets synced up to kernel.org...

It's synced now, sorry for the noise.

greg k-h
