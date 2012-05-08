From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2/3] pty: Lock the devpts bits privately
Date: Tue, 8 May 2012 21:43:09 +0100
Message-ID: <20120508214309.2d50e5f0@pyramind.ukuu.org.uk>
References: <20120503212151.568.91854.stgit@bob.linux.org.uk>
	<20120503212205.568.25804.stgit@bob.linux.org.uk>
	<4FA9637B.1060609@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:35214 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752458Ab2EHUkQ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 8 May 2012 16:40:16 -0400
In-Reply-To: <4FA9637B.1060609@zytor.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

On Tue, 08 May 2012 11:18:35 -0700
"H. Peter Anvin" <hpa@zytor.com> wrote:

> On 05/03/2012 02:22 PM, Alan Cox wrote:
> > From: Alan Cox <alan@linux.intel.com>
> > 
> > This is a private pty affair, we don't want to tangle it with the tty_lock
> > any more as we know all the other non tty locking is now handled by the vfs
> > so we too can move.
> > 
> > Signed-off-by: Alan Cox <alan@linux.intel.com>
> 
> > +		        mutex_lock(&devpts_mutex);
> >  			devpts_pty_kill(tty->link);
> > +		        mutex_unlock(&devpts_mutex);
> 
> > +	mutex_lock(&devpts_mutex);
> > +	tty = devpts_get_tty(pts_inode, idx);
> > +	mutex_unlock(&devpts_mutex);
> 
> > +	mutex_lock(&devpts_mutex);
> >  	tty = tty_init_dev(ptm_driver, index);
> > +	mutex_unlock(&devpts_mutex);
> 
> Conceptually this seems fine, but it would seem cleaner to me to push
> this mutex into the called functions in devpts; I suspect the lock could
> be eliminated or at least be made per instance there (which would make
> massive-container people happy...)

One step at a time. I agree entirely that the ideal case is that
devpts_foo is internally locked and coherent. That is an exercise for
someone who likes devpts 8)

Alan
