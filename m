From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v4] uart: fix race between uart_put_char() and
 uart_shutdown()
Date: Thu, 12 Jul 2018 17:40:15 +0200
Message-ID: <20180712154015.GC13114@kroah.com>
References: <20180706212220.GC3583@cisco.lan>
 <20180711160744.32074-1-tycho@tycho.ws>
 <20180712150438.GF22502@kroah.com>
 <20180712150822.GC13192@cisco.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180712150822.GC13192@cisco.cisco.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tycho Andersen <tycho@tycho.ws>
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, "Serge E . Hallyn" <serge@hallyn.com>
List-Id: linux-serial@vger.kernel.org

On Thu, Jul 12, 2018 at 09:08:22AM -0600, Tycho Andersen wrote:
> On Thu, Jul 12, 2018 at 05:04:38PM +0200, Greg Kroah-Hartman wrote:
> > On Wed, Jul 11, 2018 at 10:07:44AM -0600, Tycho Andersen wrote:
> > > +	if (uport)
> > > +		spin_lock_irqsave(&uport->lock, flags);
> > 
> > That's the same thing as just calling uart_port_lock(), why aren't you
> > doing that?
> 
> Because the compiler can't seem to "see" through the macros/ref calls,
> and I get the warning I mentioned here if I use them:
> 
> https://lkml.org/lkml/2018/7/6/840

What horrible version of gcc are you using that give you that?  Don't
open-code things just because of a broken compiler.

thanks,

greg k-h
