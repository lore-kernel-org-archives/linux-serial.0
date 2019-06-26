From: Mark Greer <mgreer@animalcreek.com>
Subject: Re: DMA coherency in drivers/tty/serial/mpsc.c
Date: Wed, 26 Jun 2019 09:09:33 -0700
Message-ID: <20190626160933.GA28939@animalcreek.com>
References: <20190625122641.GA4421@lst.de>
 <20190625163722.GA18626@animalcreek.com>
 <20190626064837.GA24531@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190626064837.GA24531@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Mark Greer <mgreer@animalcreek.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Dale Farnsworth <dale@farnsworth.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: linux-serial@vger.kernel.org

On Wed, Jun 26, 2019 at 08:48:37AM +0200, Christoph Hellwig wrote:
> On Tue, Jun 25, 2019 at 09:37:22AM -0700, Mark Greer wrote:
> > Yeah, the mpsc driver had lots of ugly cache related hacks because of
> > cache coherency bugs in the early version of the MV64x60 bridge chips
> > that it was embedded in.  That chip is pretty much dead now and I've
> > removed core support for it from the powerpc tree.  Removing the mpsc
> > driver is on my todo list but I've been busy and lazy.  So, to sum it
> > up, don't spend any more time worrying about it as it should be removed.
> > 
> > I'll post a patch to do that tonight and I'm sorry for any time you've
> > spent looking at it so far.
> 
> No problem.  And if future such broken chips show up we now have
> support for per-device DMA coherency settings and could actually
> handle it in a reaѕonably clean way.

Ah, good to know - thanks.

BTW, I just submitted a patch to remove the driver.

Mark
--
