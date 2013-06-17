From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 0/2] serial: sh-sci: HSCIF support
Date: Mon, 17 Jun 2013 12:15:05 +0900
Message-ID: <20130617031505.GB27933@verge.net.au>
References: <1371436934-27744-1-git-send-email-horms+renesas@verge.net.au>
 <20130617030023.GD12522@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130617030023.GD12522@kroah.com>
Sender: linux-sh-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Ulrich Hecht <ulrich.hecht@gmail.com>, Magnus Damm <magnus.damm@gmail.com>, Paul Mundt <lethal@linux-sh.org>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Sun, Jun 16, 2013 at 08:00:23PM -0700, Greg Kroah-Hartman wrote:
> On Mon, Jun 17, 2013 at 11:42:12AM +0900, Simon Horman wrote:
> > Hi Greg, Hi All,
> > 
> > this short series adds HSCIF support to the sh-sci driver
> > and enhances the r8a7790 SoC to not use external clocks for SCIF.
> > 
> > I have included these two patches in a single series as the second
> > patch has a build-time dependency on the first.
> > 
> > Greg, would it be possible for you to review at least the first patch and
> > if it is ok either:
> > * Ack the first patch so I can merge it through the renesas tree or;
> 
> I've done this now, feel free to take this through the renesas tree.

Thanks Greg, much appreciated.
