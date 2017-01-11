From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 00/19] sh-sci: Platform data simplification
Date: Wed, 11 Jan 2017 21:31:45 +0100
Message-ID: <20170111203145.GA18261@kroah.com>
References: <20170103230639.19660-1-laurent.pinchart+renesas@ideasonboard.com>
 <CAMuHMdU1EqrSXrBsgej0r1TqUYn2QQd3v5RqxOs73iG3YeSG0g@mail.gmail.com>
 <20170111104330.GA26128@kroah.com>
 <5841958.hiJOh53K3Y@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5841958.hiJOh53K3Y@avalon>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

On Wed, Jan 11, 2017 at 01:06:04PM +0200, Laurent Pinchart wrote:
> Hi Greg,
> 
> On Wednesday 11 Jan 2017 11:43:30 Greg KH wrote:
> > On Wed, Jan 11, 2017 at 11:38:15AM +0100, Geert Uytterhoeven wrote:
> > > On Wed, Jan 11, 2017 at 9:04 AM, Greg KH <greg@kroah.com> wrote:
> > >> On Wed, Jan 04, 2017 at 01:06:20AM +0200, Laurent Pinchart wrote:
> > >>> Most of the patches in this series have been sitting in my development
> > >>> tree for three years now. While rebasing all my development branches I
> > >>> decided it was time to send them out in case they're considered
> > >>> useful. I've then thrown a few additional patches in to move the
> > >>> driver further in the right direction (or at least the direction I
> > >>> consider right).
> > >>> 
> > >>> The idea behind this series is to move towards removal of the sh-sci
> > >>> platform data. This won't be possible until SH platforms move to DT
> > >>> (and I won't hold my breath), but we can get rid of most of the
> > >>> platform data fields already and cleanup the sh-sci driver at the same
> > >>> time.
> > >> 
> > >> I've merged patches 1, 2, 12, 13, 14, 15, 16, 17, and 18 in my tty tree.
> > >> 
> > >> If I should take any others there as well, please let me know.
> > >
> > > As reported by the kbuild test robot, patch 17 ("serial: sh-sci: Remove
> > > manual break debouncing") depends on patch 7 ("sh: Don't set sh-sci
> > > port_reg").
> > 
> > Ugh, ok, I can't take all of these.
> > 
> > What do you all suggest?
> 
> There are two patches still missing acks from Geert. I'll repost the whole 
> series when he will be done with reviewing them, and you could take it all in 
> your tree. The arch/sh/ parts won't conflict, they only touch Renesas platform 
> code that nobody has modified for a long time.

Ok, I'll drop these and then take your new series after the acks.

thanks,

greg k-h
