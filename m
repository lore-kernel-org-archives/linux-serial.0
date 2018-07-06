From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] uart: fix race between uart_put_char() and
 uart_shutdown()
Date: Fri, 6 Jul 2018 16:39:19 +0200
Message-ID: <20180706143919.GA2344@kroah.com>
References: <20180628120542.GA4065@kroah.com>
 <20180629102446.11189-1-tycho@tycho.ws>
 <20180629164330.GL27027@cisco.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180629164330.GL27027@cisco.cisco.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tycho Andersen <tycho@tycho.ws>
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, "Serge E . Hallyn" <serge@hallyn.com>
List-Id: linux-serial@vger.kernel.org

On Fri, Jun 29, 2018 at 10:43:30AM -0600, Tycho Andersen wrote:
> On Fri, Jun 29, 2018 at 04:24:46AM -0600, Tycho Andersen wrote:
> > v2: switch to locking uport->lock on allocation/deallocation instead of
> >     locking the per-port mutex in uart_put_char. Note that since
> >     uport->lock is a spin lock, we have to switch the allocation to
> >     GFP_ATOMIC.
> 
> Serge pointed out off-list that we may want to do the allocation
> before the lock so that it's more likely to be successful. I'm happy
> to send that change to this if it's what we want to do, I don't have a
> strong preference.

That sounds like a much better thing to do.

thanks,

greg k-h
