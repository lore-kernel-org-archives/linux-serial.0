From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 1/6] Revert "drivers/tty/serial: make 8250/8250_mtk.c explicitly non-modular"
Date: Thu, 11 Feb 2016 17:32:17 +0100
Message-ID: <2425581.FEKcoTMtxH@wuerfel>
References: <1455205297-1021302-1-git-send-email-arnd@arndb.de> <3873766.I9XIY0R8gT@wuerfel> <20160211162852.GJ28452@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160211162852.GJ28452@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Matthias Brugger <matthias.bgg@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, linux-mediatek@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Thursday 11 February 2016 11:28:52 Paul Gortmaker wrote:
> [Re: [PATCH v2 1/6] Revert "drivers/tty/serial: make 8250/8250_mtk.c explicitly non-modular"] On 11/02/2016 (Thu 17:06) Arnd Bergmann wrote:
> 
> > On Thursday 11 February 2016 11:00:22 Paul Gortmaker wrote:
> > > [[PATCH v2 1/6] Revert "drivers/tty/serial: make 8250/8250_mtk.c explicitly non-modular"] On 11/02/2016 (Thu 16:41) Arnd Bergmann wrote:
> > > 
> > > > This reverts commit d72d391c126e, which tried to remove dead code but
> > > > left the driver in a useless state when the main 8250 driver is a
> > > 
> > > Am I misunderstanding something?  The commit didn't cause the driver to
> > > be in a useless state for 8250=m.  But rather isn't that it was a
> > > pre-existing condition, independent of the change to 8250_mtk.c to
> > > remove the dead code in d72d391c126e?
> > > 
> > > Since the commit did not touch Kconfig or Makefile, I can't see how it
> > > could cause some new useless state that did not already exist, and hence
> > > the "Fixes:" tag is invalid as well.
> > 
> > My wording may have been bad here. What I meant to say is that it
> > was broken before the patch, and still broken after the patch.
> 
> OK, no problem. I just didn't want Greg/Jiri to think I was sending them
> broken commits.   Will need a v3 to get rid of the extra module.h
> anyway, so that gives you a chance to reword.

Sure.

> > 
> > The Fixes tag was meant to just be a reference to the commit I'm
> > reverting.
> 
> Yeah, but since the stable people trigger off of that, and since the
> revert doesn't really fix anything, that is probably best removed.
> The stable trees don't need the revert.

Yes, good point.

	Arnd
